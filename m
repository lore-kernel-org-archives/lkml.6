Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELsbL5Z8tM2m1OzBmvldBVkJkJodY+ZwOmh5ukoImDtNKq8T29ze9A17+nS+uG5paRjsEMNS
ARC-Seal: i=1; a=rsa-sha256; t=1520449041; cv=none;
        d=google.com; s=arc-20160816;
        b=TyZKBxAVj11HUZ932oa9BH3JdEw8NHfkBOVpUD9ZyzahQXvyUVboB41x8vq/Sk0Ilo
         pSd6ODoZecLsuvgjyOvrJsY9e7G4KpjqW0bcpxUAg6ewmRiXiGEoZuQB5ffxQCbwJuxm
         jpCpWA581S/G1YKyuevAoHWBYkK1LHvDl4D6qBzj3WwFZEpUXyXYxZiiYnnOtZz4YwvP
         LjYXmKSYAOxDrW6WzjrSW2pAyj52zIMaEcm+P34umNkGRRcL8te80sPMA/x6qZjDYHpz
         XaY+9bvmPjUwBoYis5mxRdmVn19utB8rsnx3BS9ZqWY7KJrM8GFanbZuIi7G2pktvzFh
         RSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gX7PIiK7lwyENrTBDgc+bVXrNoMD3REiLiT7lErjh7k=;
        b=q0tWeQB2bYORTUh0sHhh1tVV+/ET1vS0DIdsuLrhxEf0ajieyfEDDi07z/K8QbM99A
         BeJRgZ1yOMtlL37HfffoIHQ+4f+k52wd/vCd/JZQC0rGWxc+dIv9WePHYgLCfqnSRTtV
         qdItoqySQOgHB7qM6zOvvXbhgsmU6EbLzgtkZoDkGgEUosVdGplU9SPJFQdsGnnNgfD2
         orUJYxFKxyginXRfD+MvUogX4Y+JWcLd819s3S7zPF4OyjBG49E+MqMxw7cKKEmx/uPR
         Vbyv4dBz9LCxItNil6OaBoojJKIE64W9jXqaDQNuwS4XureBeNqU7kDlDaXOjc5chxh1
         dBhA==
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
Subject: [PATCH v2 5/6] staging: vc04_services: Mark the "DT bindings" job done.
Date: Wed,  7 Mar 2018 10:57:15 -0800
Message-Id: <20180307185716.17449-5-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306374316499352?=
X-GMAIL-MSGID: =?utf-8?q?1594306374316499352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now we just need to get the other drivers merged and finish the style
cleanups/garbage collecting so we can get out of staging.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: no changes

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
