Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeBCUUq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:20:46 -0500
Received: from mout.web.de ([212.227.17.12]:53266 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752777AbeBCUUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:20:37 -0500
Subject: [PATCH 2/2] HID: picoLCD: Improve a size determination in
 picolcd_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1ef884c9-9fbe-b95f-d318-b806639e6065@users.sourceforge.net>
Message-ID: <2dd7d4d6-b4d4-b1fe-5ce2-974eb64d8c40@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:20:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1ef884c9-9fbe-b95f-d318-b806639e6065@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WEWraFERtioIWM+1tjhARAtvnvlRV43jflue0VuzsJ/l/E3A4L4
 KAjPJ55TypmnMqpyGuz35oTwYxUFnbbhIVDho2xn257Mc8yJbtkD7JoGvrNEqpSoij6QeaQ
 +mXqSPHRKHTTahXFDy+si9N2txtX5uVebhV4ljxMuhKjmxvixIZVEGNEW+mNLTeEPnGRFGg
 vx6BPRLyFIy9XyF/3oiLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eTOI7BbN2K4=:WLrJDtSQWgKLvnud/eDmLr
 aCcAwkZSbOQuPMuQP2eq3MFrj1/0OCurF3o5FIJt6eNpZvVVm+D6R5vj+N0gc2x6M5ulqA7oO
 3dGBOAUOqh+8+18Q85TX69jFMg8qG9u7zDQi0Kb/OiePGveXRQ+HLsj7/XzIYv11cT0KXnvDm
 tBXWwbyY77tvFkZ8kbgKZsA+kw0/x8Zb7P6DSPcQxgUYBkbsJLYUW/iij7wAnnuB3n2xfyY4s
 OZQDF5uIhPyA+NuyAFyDo02M9I/n2OayaKk3IL1ICS7aNaFZ+dOYqPsMsjtDTFwAg9Z4jgFux
 0DAC56mhFNidvTMt9nEmaOtnkmVqwIP6/ukQK/crVmEscaAUIDhH420pZVYjSDrmmesRKy4b5
 etJsR7+YU8tMUQ6HgQCHsnKao2ZFC7R46EL/XPIv4nNfrKRUp6fTGTXNqO9xclk6KwUP7RkcN
 gpOiKe+dwtQ6mhnMfSdnkUnIOY/LkuphcrpesmvwPqaYxWLggNMLWMJ7BPGSzfZhnkRKaXo7r
 KtCXWJZP5d/48JESY5ReIjnNdaFE4ZsNy+s4r1ptKXsMltNhwLy9d9gCMCsIGgj0KoRwLJx9B
 3dcYF2agMj7XPRagFaemTlvnQBFlGu9l14tizgEcI2SkhdkV70s7BE9S+s2XNy8BGxm11NN0+
 wUVb9Lhkg6DPegchTVLRWGP0p1VJaATGepI8TE+sinqjabceAtrjYixvcQn3o/eUZ964ySE9W
 89AsejyCYI2rijryuIqiQsFw7qIbgrPnLQbclqeyJ8uNHAfn9LsglMQCg+8h0/TyGC2cr8Rhg
 lPvyPfOS5TLZuNvASozZFSWlSdMk0la6tlR3s1zG7EUQzGCd84=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:05:55 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-picolcd_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index 5dc48ecc1b98..ff38016be6fb 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -547,7 +547,7 @@ static int picolcd_probe(struct hid_device *hdev,
 	 * Let's allocate the picolcd data structure, set some reasonable
 	 * defaults, and associate it with the device
 	 */
-	data = kzalloc(sizeof(struct picolcd_data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL) {
 		error = -ENOMEM;
 		goto err_no_cleanup;
-- 
2.16.1
