Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeBFOp3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:45:29 -0500
Received: from mout.web.de ([212.227.15.4]:65393 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeBFOpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:45:22 -0500
Subject: [PATCH 1/3] hid-lg: Delete an error message for a failed memory
 allocation in lg_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Message-ID: <14c9b364-5a38-88f3-0cd4-913ca95dfc31@users.sourceforge.net>
Date: Tue, 6 Feb 2018 15:45:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/J/jIv4doQ5Hs2H3n8xhmtO5EJOqt7AIRQC5iDLhfk4G7LVX8u9
 aE5ICEM1ys4FlZQtbDtx9UhbRc7/kZMUPKpAc+BLSPsHcmXlq+8U8eXUurht3HCPctGaBf6
 olEzAfkQ16Ux1atgoEKkz02J0JoytGkAy13rVLIdRfK3hvGiROE+YZ5SWWCA2Mt+RP+Pprq
 4vSoK2pEb2vO9KSXJdA6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AR0DzQMELo0=:ejN9luKEfim8NevHeuzhcz
 XYVWH1a1X61AY1FvwoWvEArz5TmJFkqPoGB3xeNBn1T/K0AKYucvug7mRYx2cgSxY0fRbjNT7
 cSjUoiAxHT5F5f2gB3uNBie3GfWqaTE5251DEqdO5fFla8w73Q25t5Kv9wsgS+tNcQxSrVI5Y
 Gff66864HOc+OsIR1enMp73Ip/WvA5/pqihR9Dc+cwpFProzVRnoV7noUW9gIw0SdXAASdQCE
 5HO8I7MKY6IeSwGS7ek1KjLxQiWAPKNBQqvD/z5s6XYi2foBuH9VVeAK6KAWXXxFPXRWZJBVT
 mtzWzPs+FZ2ZTRe66QeVEb4d74l5KnJBksP4JiP4IWTfShyVuCi4RmpByXPSPAeZJDHtKe/0H
 JRJJPpJc+El4+Xtj0xdt1IOMwb/Ow04pxKn4XTGLdfNgsHQ0u6W/reZfsh2oF0jqZRCsUiDKm
 i0zpIBYqSKcOH4RAcp3XxkMtFFSXH54ZmfXG+TrNIf5PBYkE+G9xQJh3lrfIVbyezWLBx03pw
 2w041Ku2SiZVzrVRaqVWopQdw2PI5GSLo8B4p/xDyXf1QA/vzapgfh9e4TQuV38Frgl+tJA8J
 zHbtWgtcivt+pztHHB921tvxChcqQeLUaL9eNPWOA51qhV++8uVX1/zlXQfuS1Ccy61VdW2G/
 uXSjYYBkl74wNEGbwWGUsL9ISNgene7HHfoHEiLUrAd2NMO65cZQ30FTMRnjPYw62tTQQCd6H
 RCxUmsbA5Y6vZorHNCYzvAJWRkCNlL0oM3zEg6lhwoRomNZ3NSMGKwyWcdvrx35mP+GsgkgJd
 HEDUcdy9lB9Qdp0nFd+S6C/bYCnRB+SplZLtwIZ6AvV6m7qYl8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 14:25:32 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 596227ddb6e0..f4439dc64497 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -728,10 +728,9 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	drv_data = kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
-	if (!drv_data) {
-		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
+	if (!drv_data)
 		return -ENOMEM;
-	}
+
 	drv_data->quirks = id->driver_data;
 
 	hid_set_drvdata(hdev, (void *)drv_data);
-- 
2.16.1
