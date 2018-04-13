Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637540; cv=none;
        d=google.com; s=arc-20160816;
        b=oii4hkZr/KENOMWd/MUPUm68ag/86ZNpV8Ynir3Hw3divL2HONZrfhI+E9QQos05yY
         MnZvdWlkhFRSviPMshBSfq0nPgYLiMDc03REkY12uXDXqpLcg9u7qANOa46b0WoSRCI7
         XGy78krQtiIghejJOxR8YfLHBKPTiTnpTDGvIyiOGJMvH6fNcVcPu5SGMZBzyIrYRVbs
         EcU6GHcrPwnnkZNAQPFbjelDJzJtEawQ3MajlYi0H2j2D4Im2CH5TweruGbwU875bnmu
         fB+FWRtscXU/pIxywdX+WO95K7t6R5DqBmrltvqRX4FC72fI14aBp/di8cXUUbTNEAsn
         169g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UDdekwCEVHwVHb39AdxM698lqP7kSlOsWZhdP4/SteA=;
        b=POpc1QFjW7i15MOA1Uq6WTgXVzk/ItNtiPNEa51T71cRipyIPT2rh7sJvAi9RD4K1d
         VzBsLOupiyEyZ0/iQ+JPRUYd4g5aAhLVd1JwaN1WcUpsKLE8VDqnMu4cz89+xQ8bBPFD
         4iK2Fip82tFXIokQqm8165rnRFCP+K9+yMsh746JVrAOSsA5+agEpKF1DleTvH2aKS2o
         W4VItnb/R327EGKF7t8b9xTLRDg+bzKx7Pt7AbJ8pJ9iFMMzEK/ht1Sc/ID/IASPN9Qw
         is0tcJ5FC9o7zR2UzX2roe+YYnnCC+0ZQYgoWf9L/x+bnwuvOeI0wNTl1ZHK2oUIvMBp
         fOAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=j/E9ui2s;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=j/E9ui2s;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx489bocmG662lDZYeuDUriOaL83M+35DI2X6bPjNjwGNeLGCHT+/Aac/GyBGShECFmQr+FIwUw==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 12/14] staging: iio: ad7746: Add ABI documentation
Date: Fri, 13 Apr 2018 13:36:49 -0300
Message-Id: <1523637411-8531-13-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649757521827236?=
X-GMAIL-MSGID: =?utf-8?q?1597649757521827236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The use cases for this driver don't comply with the current ABI. The
ad7746 and ad7152 need an external capacitance or voltage reference to
automatically calibrate themselves which is not the normal use case of
the calibscale and calibbias ABIs, a new ABI was needed.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 Documentation/ABI/testing/sysfs-bus-iio-ad7746 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad7746

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad7746 b/Documentation/ABI/testing/sysfs-bus-iio-ad7746
new file mode 100644
index 0000000..96a41b7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ad7746
@@ -0,0 +1,17 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibscale_calibration
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_calibscale_calibration
+KernelVersion:	4.17.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enter gain calibration mode, in which a full-scale
+		{capacitance, voltage reference} must be connected to the
+		{capacitance, voltage} input beforehand to automatically
+		calibrate the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibbias_calibration
+KernelVersion:	4.17.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enter offset calibration mode, in which a zero-scale
+		capacitance must be connected to the capacitance input
+		beforehand to automatically calibrate the device.
-- 
2.7.4
