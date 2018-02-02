Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeBBUqz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:46:55 -0500
Received: from mout.web.de ([212.227.15.14]:50635 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbeBBUqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:46:46 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-zydacron: Delete an error message for a failed memory
 allocation in zc_probe()
Message-ID: <4064fe6c-18d1-1a82-ea46-9c2d86cdbf69@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:z3YtuYhm99lvH1fMrD+rquJyKdm5hKtYMdXFeX1lrRwwOTbxC5u
 NF106o2Ypq06Jn/d7kRxaKV5CFG5mUwZuuDxxdZC7dp1J2DsIYfcsseUgIP9pIKNklsbSHn
 dphoACUENTrFqpCexAwi+kLWgbTsf2z+wHlaIsOrxltSRn6mdlKHciwPO3KAY5R/5iUMDUL
 4IUZxMkLMogdJB8dIUY4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ms69xFhuJw4=:YHge7BhCcq+sotsTK6hT9H
 M7+nwNIxlWArxHzk2PTvful+4lBJ+5ASPVKhD47tGwY1L0Ry+Xd3gJ2N2FNfDVbdyJO3Wwvd6
 y/PgodNSOckoih4IUcCCvSTBmzhZdV25GuhN9perXWaK35z/XcYmFVTGAZtQt2r3dPChNmff6
 bd6Y514ClCnQEmwwMYOV9QdVm1reMbQAfxk1ubVcsa4wzfHyTaSVsP4pVupfs6PiP/SRdCBss
 T3VAIRcclI5/Wy9laVMc1YjPNlWAudLIXw0igENp3GRPuC5T/5cJG3ZYgMaeOvCLhCGbl5RxJ
 a5DXiKuQZtJXuxw90mLCzIEXeikLQ2ti2MxeIZFK9egrb26BQQgJMcHX5r+xS0pDs6YGQ49vH
 Z1X8qyLcOt0gwFxpNmLF1EaeFwNQ+dsC0dOidvkdB92WcEhDQl1/1cDkuR9kZKvQ5WKy1khQs
 K9+51cpwsLG4XUsOUenR+ywE9P0rfCZ8oIbICY5XUGCd9mUsTXc+MTXIwWspLh6Q87hwLpkwZ
 Wr7u8svGdc9CWHBpa5T78yujBorwjKPxJIuo3VmCWdgl3/cPjn6r5bvQqdo0mc7HVwjq1M4TW
 HNbrMDNZ/G43rk7psZ2lcRVHCxOd/q7HUWchgu0HDUnt62uLV8PJ0SheSyQyH6OJ0+wx9lL6N
 L8gCzVDEN9uUjSh2/RsephgRzGHRxxwK/TV0nqBNTJJC4tWrT1LrmV/LgndSyba82l51XhAi5
 4rtkqMN9tQj4thtknFiueHDcwl+KGoxy9EP/CVQ0BmGbKQ++PFOZUUKQUJnjF7xDtkFwDQ0y0
 gPfBST4YvzFD5rYzoMU9kUsVZ+YzLBJrWQcBXcDomlMD+Cvpfs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:41:37 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-zydacron.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1a660bd97ab2..3e8afaea2ab3 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -170,10 +170,8 @@ static int zc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct zc_device *zc;
 
 	zc = devm_kzalloc(&hdev->dev, sizeof(*zc), GFP_KERNEL);
-	if (zc == NULL) {
-		hid_err(hdev, "can't alloc descriptor\n");
+	if (!zc)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, zc);
 
-- 
2.16.1
