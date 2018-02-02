Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBBPC3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:02:29 -0500
Received: from mout.web.de ([212.227.15.14]:63061 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752180AbeBBPCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:02:19 -0500
Subject: [PATCH 2/2] i2c-puv3: Improve a size determination in
 puv3_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Message-ID: <ab401452-cf6c-e4b0-eb8c-f9daf20c981c@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Ua2G3WRqNVqnD+k/zqkJsE+0L/zoo4dGxKxZg9y6LuZVsGAUvPu
 Va6Kb3o4/yF5+Hd5AD30KXB4ifXHzFNqPJ/3o1w721PT2JtPGHMo23z4CfYjWWCn0sLQDZs
 DS3sNwc97JOeO8nzIP5Gu049o+ZF/nVZMbLyF5z5EJF06pksF2WdUQyNMSX7WZBFg9LSk2/
 z0/31FzMY9nk5Keh8PD2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3nJjAmos3kE=:/NdtjFMYvbFMoIgtQaIg7u
 zFzeD8ks/0Ua/avMvrTeiAC0LRa0DWwoHa5YbT0a3VKw7jkYwNQ7duc/8H9L6Zx6ipvCWxLau
 ldojKkCnEwej4t+8Y/JStP37nf3EDXme0xD8x5Vvslrf5n5jbzj34fWtZFLAi8U2Ca7J+GyYw
 c4Hlfkio80EULkpITr57GiTyVLeYnbKEOc4lAFXX3z0RDZE1gAybcR1+IH+L3I+ZPkZTTwclb
 Z/bkiUBtnJ4LP/YqIKFn0XWtQ3tnaJI6PpcUfOV5nQ2rtG25wOqfGzPyXDx2UStmwF9C/xAcB
 qI7HCG315qEEUipudIF6v/8ylYpf3C7id8BpCKtU81puaZ4958XRis+nqwkUK69cE3NIoYnJw
 1iMlX5J0TUFnMCcONNj67MuoFZbkds0wpwdQzlnUIhM2zMlRPZoTzK0zvWWN6MAJ+pkSIoGwE
 nea76gkZys38OWAUxz1cGXjbDsrsNfC6OGP0ZD3duE1xMM7qq4XmgmgcicCVYmXFILeBrwgUa
 /uyHtqvsi/8V1jRgH8n5NI/CVLz6DXsQxjhJP9LetzkqpKyJWgiwUq4Q+GO+uQGgljPUFp5zb
 KthvtI6a2W+LvrwZsZPmk/jfZFpstd8rsEIVz/xccuIdjQXgEVa/zCChNzrVB/FUbTBm/c2QI
 ZICMP3YA92gZhQtr/BMtzdTpo9jhGACI6wIo+FmJB6lB50QW4/hHparZ7AbUBOf1mPZ3d0K9J
 /p3AmKX+9nWnHlv+tYcnZbpVCNDg6sd7W3kK95t7WiaMC6bvhJefrVZktDoACtp1hvsAJp35O
 SAnSj9JKUGAT8DzeVfe5L9fAfyLwd3xqU7A4UhUDlAqi5kgumA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:43:21 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-puv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index 5bd001d01bef..929fd12b92de 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -196,7 +196,7 @@ static int puv3_i2c_probe(struct platform_device *pdev)
 	if (!request_mem_region(mem->start, resource_size(mem), "puv3_i2c"))
 		return -EBUSY;
 
-	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
 	if (adapter == NULL) {
 		rc = -ENOMEM;
 		goto fail_nomem;
-- 
2.16.1
