Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeBCVBC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 16:01:02 -0500
Received: from mout.web.de ([217.72.192.78]:58471 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbeBCVAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 16:00:53 -0500
Subject: [PATCH 2/2] HID: ntrig: Improve a size determination in ntrig_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Message-ID: <cdf13343-71ff-1ebe-d90e-f480febbe45f@users.sourceforge.net>
Date: Sat, 3 Feb 2018 22:00:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BEi5p9+0ED5s4pKXQhA0kBJ7XRhm03knBtgC0mHkzU4P6SYz2t7
 ZHze6U2fUvFr3JPrmjsO/hFU7Cgw1LXQ8SlXaZu2yF1l+61U4oonIvVwWaeVeYNEKbQBDKT
 mZUNXCxUtwagizV9GbFJ/Ujuvn0w+bbQ7AlEssekfpNGSEHcBLZgge7A+Ogv8P5tA6LYUM2
 EiTz7gdafbIv3hnf08pXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hg9kai8q09E=:jcQZOm8QBCtBfSq0oGgpD2
 GBxlwBF/ZAsmV/apyHAb+5t70vorchmHG4PQy1VXcv1QsCCT/O+/dlsg8EAwYT1r4ly3kzAXe
 P+YctjVLVlCsZ1+XwHtwxmIlONT3nNGAoOJA8GB1a/5oBSDdN4Aq9nFk4P10QhX8Lf9/DYaM7
 45VCsFzruTtHeeltUVHWn0/IJJL/dDXgM962r3Qkl/PD/5TWz1OKqUdzC16A14r9ga3uiLP7e
 oLtpGfI9enBGvyW95zGNGCEyy3+kFfzUBYUcIocDIcKQIt5I33xzFUmSIB5+au2828Vh2WLRp
 mozvqfxTAon0mWcIr7Hw96k4TGaMe5U0IFuXij8Dk7QmdjOTWJni7cGEoBn2JLumRS7NCVNoj
 NpuOEq0mGgupq8zdE2/5LzOQxjauxPXcWX6w2H232h87nidK/DX+7THeB++6SrJTTCEZ/7o4t
 PBQSs4lftT16blS+Fw4Z0ezFG7gz10RETbnBkA+ct2+FPHEIvRVrCZA01Tjv5mEQKxDZ4om0u
 NguPnLbD9G7qO8aiLUujlKR6ErzTdudlvpCeY56drh+zOuUCT6b5mLDAA/RErBDZPeMV+o3GE
 giaqv46+1Im2OhDPCH0a6jqPrYs4SJ+2KLYzZnI812WWypAAU4/s2WH5kH5OYirOul2gY8FlJ
 ESwQgnUu/UN5auwlLuS2YoxgaoBl9wN7Yt+Z+M9obuLggbHb/90MQ9Arsgrrluspg8QjFz4GW
 iyAdj28fL2ot1inCWznqvfqIBbOXGuaKMWxdYKeA+xFJ+vzkEbapBbHSaDyHlqIbaDbqHEhIg
 dqpC5ZRcLucM3aRVCS3kGEKeIepiYjMZwfafqMelHzRE3Xzbg4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:48:39 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-ntrig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 2a8dafaea2f0..c6878a6a147c 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -904,7 +904,7 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT
 				| HID_QUIRK_NO_INIT_REPORTS;
 
-	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
+	nd = kmalloc(sizeof(*nd), GFP_KERNEL);
 	if (!nd)
 		return -ENOMEM;
 
-- 
2.16.1
