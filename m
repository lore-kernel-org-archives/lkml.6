Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELvn/bJ1LpFQ0JG2USHI1DDpZNKeFfPAmBkI/UCZaCcCDky2QLJVxf1ERF7Pd72YdqDF1tRm
ARC-Seal: i=1; a=rsa-sha256; t=1520621061; cv=none;
        d=google.com; s=arc-20160816;
        b=uwU7z3GxBtZaCC24pKFUHJMvS9hVRkL5qAbsWJrgg/ci6SU5c/cGobItKZUtql8soE
         fnHY/tKQPQ0baWKDpGu7/kfdlaczwSN82bJ/cLoOLGbzwL1InHnA1QRjCyHAh+vWjeZT
         R9jsSI7mEwAdLHhI8+R9wqb57RGKdiRpvNIob94uROkX+KpfIfdLqyf6jkUnLDDQE+yO
         N4DQIWs84hoQMlfPkkJnxkyuMI5rNGFXZvy4+pm1fdQQaXEZsOn9OgxPFy7pAhUieylV
         GhB3h5k2343k/YORPh633jf2/Jy43s9w5tXAtutYwVveCeG8fbwuQUNoGOu5TEZFHmyn
         Qmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8+0dVQgblOeauTct+Q+xVwExG+9nRHpKrMCJtLSoGXE=;
        b=UvTkza0sYyEpEPzLVI22F7gfzgfD3jtQmnvCB6+/yQ0VP1AvV8XV8kqbsiM6uXUgvj
         WmFvwUI/sHxS81xkjb+YtcmITnnmDfWaLqJyt8OWYjQLJrccYZ/BkpkZHUvs138AjZVX
         27aVFFpjQ9a1COYuypCduwSlgNJ5iN17UGv83LpEzWfERdGcqamD7UpzOfvpPbJ7QWnz
         SFJuVigZhklq3LofbK7F8nQwN0Ca+/zRa7FN1I6vOAJpXf31SQKIq3i/vYpXDQgvDk51
         0Jo3VVkiNSqDFgVdK8E2XNm+nrZ6yf1RXTvK8D/RSBYJTfbq76v3B8nst5XZ5Zi6Hhps
         o+jw==
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
Subject: [PATCH v3 5/6] staging: vc04_services: Mark the "DT bindings" job done.
Date: Fri,  9 Mar 2018 10:44:16 -0800
Message-Id: <20180309184417.23368-5-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309184417.23368-1-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486749345994309?=
X-GMAIL-MSGID: =?utf-8?q?1594486749345994309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now we just need to get the other drivers merged and finish the style
cleanups/garbage collecting so we can get out of staging.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---

v2-3: no changes

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
