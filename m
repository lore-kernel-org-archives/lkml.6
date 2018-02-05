Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBEV1n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:27:43 -0500
Received: from mout.web.de ([212.227.15.4]:63847 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbeBEV1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:27:33 -0500
Subject: [PATCH 2/4] HID: logitech-dj: Improve a size determination in four
 functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Message-ID: <59f8d1c6-c282-b521-9472-990038862052@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:27:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CgTyOjhZzhgLmx6BasyHqyAPD2JDSYAAKfR+hSkHsHo1IgBmcUl
 Vh4lW6frQ+08HRo+Pq62PU3odG4F7PLwU5nOoJLzOk3dBmxBo+tjClfKqZFTlHzM2/sfz0M
 Gcf/B/8sgoNxN6UaHnXFWjF4BSG2qqNuwyEhqP0kg6D5K8z8N4Bsk26d05FmmRvz0sz7S+S
 UXO6Z/3/M4dtA+dWq0qWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FEE3qX9+sf8=:NMWl2VezvzzGZk23oc9y2X
 mPWt10uMBogphisRl1DJFQ7YC+tvkFxR8e56OkFQzagkv7h5WRraZAVLi3TXdLNK5uP2YIQPP
 JAghf+MiupFslA0v2WInLtgUWOQAMAOFeBWwqKGtnNnOVo2RWELjMcxnKuiezGl4Uy957lii1
 UaCG4Nt7No/TICpTk2pqI27tf6E3TMQS4l7l5ubhIkJFnDoOdOMd1wjxk2NlGOm75mBx1k1IX
 qL6NV7bJeIoxjO/h6AYjBB+Kekfgi+8nKQY3sUrYZFIXWc0+kwalOoWudIVYdL7TrSgVTO9+X
 puk51OyPA72E64+ViqXOn8FDYk/GPz8fbgd5Aaqjie1hxwQF5tk3Hkx/6JRA1LeDz5OsgZHoJ
 /kqoImke/NWIcKVf3GWFiJ8hBliPY59X8jMn9WTy3ORpIcBMVE7toeh/I025P7If9/g2FCHf5
 fK8ZbuWAychSraox6w7L5IQHDl/QPRQWU88kQTx2w9vn4hY5X4Fut/P22TUex3q6YFmDnZbpX
 A3RX1hbid7Eg4rh36YmZr4kH9uFssVS/x564rsa346zzoT+PW80dekLasfARt+sLxsGfp2Qz1
 sa2MhlUJw25eGbc7tBwW0nNlWRqVZBzeR8Ciu/UklyMxTs53xnoD5n5Y17Z2FFQX9BzaWzqO3
 iz8DlUKNNZmWcj9moUktWN6XjuivZZ0bmwfOOtY3lOMHmcoA6B7j/ky4tOb0AXZ3y6+nAXIZb
 lMkrL5O1mRFSU9x52RhTHH5ooegVUVK82RzZpsMXM8eRPUqF9URkbFnBGsMvJKKBtmsVNUi+f
 g4Xihi1nyDX8va8/ddVK1WGk20CB/a/mB7URQxJPwLPV9Y5RbY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 21:47:45 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 4c92b2cb5768..0da00d256ca7 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -417,7 +417,7 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	snprintf(tmpstr, sizeof(tmpstr), ":%d", dj_report->device_index);
 	strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys));
 
-	dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
+	dj_dev = kzalloc(sizeof(*dj_dev), GFP_KERNEL);
 	if (!dj_dev)
 		goto dj_device_allocate_fail;
 
@@ -611,7 +611,7 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 	if (djrcv_dev->querying_devices)
 		return 0;
 
-	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
+	dj_report = kzalloc(sizeof(*dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;
@@ -627,11 +627,10 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 					  unsigned timeout)
 {
 	struct hid_device *hdev = djrcv_dev->hdev;
-	struct dj_report *dj_report;
 	u8 *buf;
 	int retval;
+	struct dj_report *dj_report = kzalloc(sizeof(*dj_report), GFP_KERNEL);
 
-	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;
@@ -1005,8 +1004,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	}
 
 	/* Treat interface 2 */
-
-	djrcv_dev = kzalloc(sizeof(struct dj_receiver_dev), GFP_KERNEL);
+	djrcv_dev = kzalloc(sizeof(*djrcv_dev), GFP_KERNEL);
 	if (!djrcv_dev)
 		return -ENOMEM;
 
-- 
2.16.1
