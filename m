Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELsJHU7OMbpU/yziYwTkLhoFvBDemhsKdGdhVUutJwih8kF8O29QvFpU9N7QHvQVbf6UIeKx
ARC-Seal: i=1; a=rsa-sha256; t=1520449040; cv=none;
        d=google.com; s=arc-20160816;
        b=kJAe8DG/f0b0Zdwbowh3TOpOjwbNJ3P3anzhheQ/Zc8g+F/h1X/J8tu5VgldG5EHcD
         0ptx3nInk9LqCg79wVwL1IjoYM5Xv37bDaYOwpiFHUgd0HCDn3Gh3enE0A8WnFR1a7TX
         Q1gUt12lc2nvEFTlTpX/tuL+7oisHHKYWviS/HcdYH5vm1ezv0us6J4Xv0BaLJZ+nbZd
         Hi8JnOu2AitM9qec5k5QyDk26VxBY8M7NgJM3rgrAQOSgnwEFL6GZC+A6RZsEXXGDagI
         XtpIRk7yPLL5pkfNot/9BDp0OAKh+ie9M+YM0lRpDMBJsgMr4atHjF3e814MsWiQjHGZ
         DWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=a/un8+JXQ7imVklbPrkc4bwYYoc1sYLsn/u1lgf5KU0=;
        b=boVXbkUS8U/8KkMK78l/3dyqKwLZyIOtV56wjlsDJ0G8HnYQyqhTSpb1J3ZJRgYFbS
         wAp0QbO0903BBUs3ct4PQREnU0AEbYMVC6h2JLkefGWFKMYw1f5diZMnsgO/2vfQT4RZ
         lTjqI64IhcwaRBRb9PdQ0bzpiZHEYxdxP5i4lkcqdAluDc/C/oPEWN3FV0Hwn7AiRFnC
         kM21aXDJZmGZSpQLROsroqo5CSBO5tifTon1/Rx3SJxEyqDbzppc4RHcuW/R2g0gxVjg
         X+JzPuw2ALBis2LHucE60RzrHpVJiACuJEr3t/CRBUd0XRjbXnPpeo3vuta5hbtmePb/
         EkZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/6] staging: vc04_services: Replace "firmware" node with a compatible lookup.
Date: Wed,  7 Mar 2018 10:57:11 -0800
Message-Id: <20180307185716.17449-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306372971918175?=
X-GMAIL-MSGID: =?utf-8?q?1594306372971918175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This was requested by Rob Herring in DT bindings review.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
v2: new patch

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f5cefda49b22..8068c0308b34 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -3594,7 +3594,8 @@ static int vchiq_probe(struct platform_device *pdev)
 	struct rpi_firmware *fw;
 	int err;
 
-	fw_node = of_parse_phandle(pdev->dev.of_node, "firmware", 0);
+	fw_node = of_find_compatible_node(NULL, NULL,
+					  "raspberrypi,bcm2835-firmware");
 	if (!fw_node) {
 		dev_err(&pdev->dev, "Missing firmware node\n");
 		return -ENOENT;
-- 
2.16.2
