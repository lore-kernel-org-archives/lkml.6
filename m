Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBEV0c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:26:32 -0500
Received: from mout.web.de ([212.227.15.14]:57787 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeBEV0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:26:25 -0500
Subject: [PATCH 1/4] HID: logitech-dj: Delete an error message for a failed
 memory allocation in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Message-ID: <8c8c6986-9f72-4dfd-12f6-a530c4788398@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KdZuRL/JUCKKfER/M+Gr4DtbbyYBBNSLXwxIv8EVh9o8dfvnCKF
 eaYyHTMtV+I9PJbykjRg5BGgOHIv4Ptkh81wqO3WmnS0TL6vK6/AKfAXxJfgMmA6Gyfgi2O
 2xLTxeGcgdXquxgWarEUpB5p9Xw7O1h5YWf+96IEcmhH7kRUTcr4+HdX0OY8QuV/HgdHs9Z
 1FscSi2d7eBIo1NYkFbzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zqbTRk1D4Uc=:DOEi8xu2202fIhao3pxu0z
 n+QMETl+JpWGu3onRWBt/MYQwzRkdzO5IZkgOl34UeTVeT4PhkLm/fTbCRBjmQjZc5S2ytBzS
 HQKlgI5WFEHsbIl2FwXyO85wT1zG/5F5EDoykctgrjxfdXk5LIHRtHqxDq+8IpmL1W4YCQMry
 8LhaboiYAYQGOpGNnEolX1ixC42om5RvYVIySl7tAh6I2SmSpg80zj6ZwP21TesCjYKqk/nTv
 UZlZbCF6m/RlFjTk1zh3ZJgH5odFMz6aLINzDwsm3Vs+UBgprL4LJ/B3UfK4nfy9XpfEKG58U
 6KMcWg4pROtvYExWh9qiv399ejVesiwDReYyRSXjJ5LCUN1ZMCYHRhZ2aw50bEqb0z0aYGo0Z
 z2oqGkbS6OhZcz7/2hNWjlvxcgg/s6oUQpkY8jXUdETQdXzO5O5Dz6eM5SO4BFbNBo8FcjPd1
 utoEIGdHvLENCzbaqGiC2weMjggtGIjR+cgfHXuUb3C2ATUE2ufY/OvJVCSsEQB6qyyWo1HZe
 XvyKHt1zKHLAyJ0Gl0/DBJbq/DwsYx+caJCdamD6TnG/pqVoLT0GkRFDDefqtabcvGtlM6GkA
 SpmeQDLB56D1pk4C6gSI8FuwRIEjSBSBzpQHWLsh/v4v96N/VwwG8+41eKPTnMPi5C5+EEV8j
 Gh68OSxR+Q+kPwa7g1cIq/YARwTiyiQeP+Pmqgi53TAL/se/HYk9+vvmI/t0tfBO2EeSDY6TE
 ICKcvzZ3bpjDnBzVIveYmsyWTm1OhSTePP6/0fDbyldYqrKxTy/CGKR6dkzWRs/F1+zCVjbqf
 8LLXSgr4dgDkQUWhvYuug2EiG7eSbi4PAlWldz90cCUel3GhEo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 21:36:18 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 826fa1e1c8d9..4c92b2cb5768 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -418,12 +418,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys));
 
 	dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
-
-	if (!dj_dev) {
-		dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
-			__func__);
+	if (!dj_dev)
 		goto dj_device_allocate_fail;
-	}
 
 	dj_dev->reports_supported = get_unaligned_le32(
 		dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
@@ -1011,11 +1007,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 	/* Treat interface 2 */
 
 	djrcv_dev = kzalloc(sizeof(struct dj_receiver_dev), GFP_KERNEL);
-	if (!djrcv_dev) {
-		dev_err(&hdev->dev,
-			"%s:failed allocating dj_receiver_dev\n", __func__);
+	if (!djrcv_dev)
 		return -ENOMEM;
-	}
+
 	djrcv_dev->hdev = hdev;
 	INIT_WORK(&djrcv_dev->work, delayedwork_callback);
 	spin_lock_init(&djrcv_dev->lock);
-- 
2.16.1
