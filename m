Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELvkmRy7Toa3Ju1OYisQ3fGlH3vd5Mck85pI8cdzgNL6KbwjnYNheYRPUyr6lHZIdvCRVY2F
ARC-Seal: i=1; a=rsa-sha256; t=1520621064; cv=none;
        d=google.com; s=arc-20160816;
        b=ngJL9HgcaWU/Z4mVdmB1Hb0liVwH7PHCJVoAscGMBo7HCs8mtt9IEUHHtjIzLt8ttO
         xLPy0TxUSvhQ2cxQ3bQdKuR8FSatCXrxCube5FIy4yJ6c6D7XwpP7OcfZ11akzjMqxh5
         tuXILCy2iG8ojHjbn9n0vVcUmZ9fUbuOOyDMimaBExFzJac/29ZNn1rhEjEG0E+sfOoc
         yxCxT6fOaXBqe7BMaK8VNXcU3LFbq5STXXkZsgFXUGsG6wqhgX8Ul0pC9HOkXd3AEiN9
         U/IwDq0qt+kbRNji+vy+C95U0ag9nr2o3x7oJ9BU9yXiQP1GWrawd//ikWNPt5gzCQQk
         eLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=x50WZFJHU8CpKdr1x33KyrFHjA/fq626h/J1IF+q9rE=;
        b=roXM0geWyQiOHszCcgA+vVUQd6nehzZgNo48H6iEeTcYt+8Uonh9fuycjSyfldEVkW
         0DuWC2k2MJNwdL7DZ4aFkvgU8obHLRHbzZVrJ2hCaxVuFFjYIFlzSax8Xdq9WPdPSwMI
         6IGe78nhBXAIkHRRVrhY65ocA0LDS3AZx7A8OAtSxC6UGZ8FWXRAUIz1yqVfz+8ksikB
         GxjwgAEoFsxkVAfU4H445/MI9PxRcqNFXbqb2u48pmEHV45kMzNI3gDwZ6OXe2MQF9ye
         93WAkMmE3I6i9lk19nloP08/0A9OOWJO9E8Q4hZd3RlB4d5OvQxWubuJTP0W6O1zILXb
         a1IQ==
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
Subject: [PATCH v3 1/6] staging: vc04_services: Replace "firmware" node with a compatible lookup.
Date: Fri,  9 Mar 2018 10:44:12 -0800
Message-Id: <20180309184417.23368-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486752656066290?=
X-GMAIL-MSGID: =?utf-8?q?1594486752656066290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This was requested by Rob Herring in DT bindings review.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---

v2: new patch
v3: no changes

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
