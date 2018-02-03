Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeBCRkO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:40:14 -0500
Received: from mout.web.de ([212.227.17.11]:47175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbeBCRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:40:05 -0500
Subject: [PATCH 3/6] hid-prodikeys: Move an assignment in pk_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Message-ID: <44c2767f-c66c-3b36-4bd1-059d5d2f4461@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:h3jvNAV47FYrnofI/3q7mApIqEJNE2mzaf93PhY1W+QjZ9YFJGO
 cLUY+PYt0t5DOnA2I4kM4tWYOYic+La3s4dkJ8agsKT29h2s6RrQ64TyGBwa0APYbx9E+8M
 gKIksFqE7Kj0fTIGLvC6WvYJIwefLSJ/GjQ1xJscHSKbdLbUIUz6jBuTcbtOc/QykjYfYwN
 f1RehE+qoaTB1l23doFJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oj/x0T0zxBQ=:jkUt7t8MFzPbm3sFscReW8
 9s747qqGvdrpbeZT5VDXLdOQHR7m3pBO0qUk3DTztq4i591zm6rulnwqhNanFyQQJ9/CY1f5C
 MAZxlC/4VswQYFRDn3tjJTYVK++p+WK88/Y2yFllGqx6ytaq/UOPq4DKkTK3+RY8x3k067fBX
 a9F7yleoSh0d5PrgtstYE25qtoonJNOqecei2tOg2cRRNEWJ5jUaJ4XFsQHoGMzKN1AxP4hTg
 OxK6aiOpV6noRbxGMamPJEhm4TT10cifVos6TF7/vHNA2p2pIeLmuZ9UFW1Q4fwGXZXnDFYqj
 T/QvDBx+AYe0vtfMWWqE+j135/Nh+18VBEy71aXsRSj565ZWlpOxRM8BHSjn1STRjbiHibPyB
 WXZ8+9P+X3H39tP9VerUcb89LKpJe2dkKXJ6umurGKVaq4hB0RuvsdceBgQUjzAQSc9F98Tjh
 eV0gmkbf8oV0I+qxzrvk9ygKukmJTAYZ/B+BlIUkrtziees3qSRPGOcCT9vFfYfvQIBj2z4C7
 a9HBYvkcmcJKx5ncNI7Iyj6vJ18iVRiRlwdlNkXoCQ86QWSdGgX/svFnwNbyAUukXL68SwRrF
 pkQ517eJLJnV6p01qjo9oclv50cwXfX7gfXORdmwMKYH5BlqManrgR3oEZizolzR+mBcoI2J/
 OfuLAP6AUJ+r994ohs2DqQMQ+Bxm6cLsIE+7ehHyjet775td92eEf2a3wFT4aNXtdgJShdfHW
 v3ivyFcSjLmIbZpyyTBBUA3aMFw+w1zmQrxcS8rjux1uPMxu9oW/frMitnSXB34mTuoc5KQkW
 Xt1CNM8qDjgB3Ex3IZjj5DHnmjOSDqMkIZfqoyUH50IujO44Pg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 17:20:01 +0100

Move one assignment for a data structure member in one local variable
so that its setting will only be performed after a corresponding memory
allocation succeeded by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 2e79dfc92162..7672f723b268 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -804,8 +804,6 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!pk)
 		return -ENOMEM;
 
-	pk->hdev = hdev;
-
 	pm = kzalloc(sizeof(*pm), GFP_KERNEL);
 	if (pm == NULL) {
 		ret = -ENOMEM;
@@ -814,6 +812,7 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	pm->pk = pk;
 	pk->pm = pm;
+	pk->hdev = hdev;
 	pm->ifnum = ifnum;
 
 	hid_set_drvdata(hdev, pk);
-- 
2.16.1
