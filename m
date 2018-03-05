Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELugMdaWlJDJzowUOoDMBMUYv3vz0tC8Xj0+TVk+DRDA0Fw9Lj0FMOUFT6cjiL/qa4SPwTfz
ARC-Seal: i=1; a=rsa-sha256; t=1520281694; cv=none;
        d=google.com; s=arc-20160816;
        b=ffGNmkarQtY4OF83DhOyPRUtBsuFEweN3NNhIsM5RZ5W0iQismTMOLBvZkX4zxE+3m
         IVKD30iDzfIhFCKqYV7+Mr5UMygmaM12OcyITWls33xOAxCswQEfrPzDXss6kGx0LM8h
         0pHpRKqbtziKEqitY07YmiDeT/hvisxTlHumX2VDAsTYr9dg98JDdVLoAzHl7g8DLkpf
         xY0e5S808PhURXBRpPK4hjhkl785U0R9ZfXft5xaaafMzQs/wkRiSYLULV8obhp3Vp7d
         pSM2Z02kdho3yYH75DCTyvbC0WeRk1Oi7nk9NZbpih7LzUpMxNBwYFNwOEeGty9KPtJR
         EsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=yLaHXlitgISKk110tyuY1am4/VcskbnQDVTrkk6uXXw=;
        b=oemXpB1W6MgGf9TfyOAjX9fEmfc+FIz4U/OcHPEpJzf1wZA0yE3RZ/EBpfOZRy3q1R
         PJgEC5LBRLswG5WhpF2g6q/RBDY3HinNTz1VTFdPL5Sz5omspO9dqJa/70PJEzxoH//8
         oERyVKuidc93Cmk+Qxkp3c3mKMX1hAIvZ2UNRFxHiJ62bPN5HKTU2A60ddpx+PY8GIvs
         99pDw6CT62F3Nz6S9pWVrFv0/MAQ/NR/gUg9kTwjr9KSIIRPCDthm++XxVxc7YFchJdV
         +3U5qfsJGaR4BMQ28XbhIx6TC2W9ez0NuONsRELFEnLPVWPtKTbOqQLNumnnjELW1j9+
         lX0Q==
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
Subject: [PATCH 5/5] staging: vc04_services: Mark the "DT bindings" job done.
Date: Mon,  5 Mar 2018 12:28:06 -0800
Message-Id: <20180305202806.21219-6-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305202806.21219-1-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130897655112970?=
X-GMAIL-MSGID: =?utf-8?q?1594130897655112970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now we just need to get the other drivers merged and finish the style
cleanups/garbage collecting so we can get out of staging.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/interface/vchi/TODO | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/TODO b/drivers/staging/vc04_services/interface/vchi/TODO
index df93154b1aa6..46b20a1961a2 100644
--- a/drivers/staging/vc04_services/interface/vchi/TODO
+++ b/drivers/staging/vc04_services/interface/vchi/TODO
@@ -1,9 +1,4 @@
-1) Write a DT binding doc and get the corresponding DT node merged to
-   bcm2835.
-
-This will let the driver probe when enabled.
-
-2) Import drivers using VCHI.
+1) Import drivers using VCHI.
 
 VCHI is just a tool to let drivers talk to the firmware.  Here are
 some of the ones we want:
@@ -26,7 +21,7 @@ some of the ones we want:
   to manage these buffers as dmabufs so that we can zero-copy import
   camera images into vc4 for rendering/display.
 
-3) Garbage-collect unused code
+2) Garbage-collect unused code
 
 One of the reasons this driver wasn't upstreamed previously was that
 there's a lot code that got built that's probably unnecessary these
-- 
2.16.2
