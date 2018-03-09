Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCIQDY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:03:24 -0500
Received: from mout.web.de ([212.227.17.11]:53821 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIQDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:03:22 -0500
Subject: [PATCH v2 02/17 2/3] mfd: abx500-core: Improve two size
 determinations in abx500_register_ops()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Message-ID: <f91a55b5-c915-2fa2-6aba-b24c3950092e@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kkBA5WO2vLtleggucBzZ4/Lz2igcPNT++1gfwDYDiCQsS8GpNw/
 vaaMZo7fHiWk+UM1/hHjp6O+H8HgSscn/ntgwd3QD9KpwY/4c6/eHcqKaRQzpnTdjM+t/tF
 ZAsdylCXaotiLwu1FXuld/rp8CB6u+pZo0xYjdsx4nUdlhrhuf6BZO8B9fTD4KXDi3kFic1
 o+0pxTmqoIdrJ20Gde9uQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aOxZlWtCkec=:opStOHHlRg/mjN8mOUtV8T
 sl3UcJT5JuXJKdp5O4fJMej7nlr+OBrrDQJowkd5Wn/o9b8TH+nwiRFD+Aa3UAzBm3eL/TIFn
 WCZNuZZaYTrPOcRKMI8DLtboBjgzqnz1C+TUZUIV2C+4/fH9sg2FuDYfFv5lEQyZxUw6EW2ry
 dOHY7jZrvjd/4XI9OvdLZ6OPoqq7mUflpiF5PDZA4S93a1FZDCzmXzBQW+kKT19M/5m+gUbCJ
 fsLWHvRPxd7HLg6+vID2eH/z8k9N4RDUGnL7dFtqf5ikvEPprdu+FPYIeRhrH25oazzBEjPhi
 3GuVM8QXalbqt550G52w6yDTPX/c9OUcGwG+UTYEdBjF/UbxqyNg24y0p2hhPFlEaaq+84oOf
 KfapcPLvqUfc3FKRm1v5KgQDLkZvtOuy9s5bcF7vDTrc7JQXapFkw+y145ena+8HlPKvOxIHB
 INgP4XuzL7G2/hV5Q9fWpndhLB2z9rMLmY5fIdce9OiSAGr24h6x587/TG3Bok7MUny29we+C
 qfq+LUA1hZzTegkHTEmGON65Rk2q1g5hEAxfj9setdeSZwRJIQIev3fbJfPsviyuy2AL/JccR
 cVFMNq9HgNM3d58RMxMr0rwSQ0fLIYUJEsC9zK9dt5sYvkTMDr3/od4sic3mrFvvzw9z7gYh5
 CB8cv2es0Kt76Ax71I/HQdafToFW551IooYHNZwHxuNH1u+4lYbOAfyZJktL7RL8LTPBSyiGa
 sLgfnndc0sZFrfOMV5tckK4wj6Ayq46nVmLNFV2O+SMy5hzuaJXtGlGJLQ5QV+9pB4dKxotLL
 KBLLP6PgvT6JLHKyMlgmpmp+rUlETk6LYxX5iwYh8tkziS9D4s=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 12:46:47 +0100

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/abx500-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index c8c9d41abcaa..17176e91cbd0 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -37,14 +37,12 @@ int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 {
 	struct abx500_device_entry *dev_entry;
 
-	dev_entry = devm_kzalloc(dev,
-				 sizeof(struct abx500_device_entry),
-				 GFP_KERNEL);
+	dev_entry = devm_kzalloc(dev, sizeof(*dev_entry), GFP_KERNEL);
 	if (!dev_entry)
 		return -ENOMEM;
 
 	dev_entry->dev = dev;
-	memcpy(&dev_entry->ops, ops, sizeof(struct abx500_ops));
+	memcpy(&dev_entry->ops, ops, sizeof(*ops));
 
 	list_add_tail(&dev_entry->list, &abx500_list);
 	return 0;
-- 
2.16.2
