Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227POetfsXU8IMvxqPnuPebDaVfYmPeylN9NwjsHMG3sr/qM+0ag3RIkCjkOfKliddbhbJoD
ARC-Seal: i=1; a=rsa-sha256; t=1519410869; cv=none;
        d=google.com; s=arc-20160816;
        b=ZhFWDbvDmuFKI5k5ugnL3k0BV+v2CDZCdLkL3JahHAKWhv5aNrC/6zumxWZSO/+txu
         n4OXCUd/G6g2zbH9/F3d73cCqhNM7aTBV+rSj2dIIdOC3JVgKPGn9JASwDTWe6dQ5BrL
         FbqX53gHHDILQJZczNfWpr8/F1lYOubVzuk4SfG/ff3ApauHDbEN9UI/ZTlc+ry8yWBl
         vYT7kSP+St03EkBHwOD5SFGOy8WWd7hC6Rs0D+ccmX0Q3gOASuDBlmv1Sna/vH4I84l2
         aQlHRlUS2Swi78NMN5CqJbV8YHPRCrbfikSpkyTYBmiMS0DiA58vaI/MEMYMl5YwXWfp
         7wdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IaqoL/HV9ZitikmS168hiUEkaWBd4lWWFnIGYIvqHlg=;
        b=J8KwUBdCMcIvNfgz7sVh1v/2HA2HlZ4gZMyO/Whqgc8B6ctj+0uyeW7KbZqwOMqOG/
         4blOhZMvFZsF3w8hqwyGOzEiK0piazuqt6L0IDjkt38BiXSKCdqHnfrrUT5JPwhVRg0A
         PuvRxnxAXdiHAW82JeBYj1cNkRyMU5IyP0tKURswgpcr0KaHbjFDfv/3T3B5smRP99Ye
         ulV+pxnFpcwfwZFgqsISRdhujs7vf4yNUxTW15Lj3DTuq2Oo/6XDhxVWvMzb9bNWuty9
         jVLEKTDO6WcaOtg6IvTK/Lh29kA2Hn3pXe/3T15zUVSESsyRxcrwBUtTqgOH8TaYebIn
         4Rkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 034/193] ARM: dts: am4372: Correct the interrupts_properties of McASP
Date: Fri, 23 Feb 2018 19:24:27 +0100
Message-Id: <20180223170331.432970109@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217581492927668?=
X-GMAIL-MSGID: =?utf-8?q?1593217772480887454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit 627395a6f8091c0aa18f49dca7df59ba3ec147ef ]

Fixes the following warnings:

arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property):
interrupts size is (8), expected multiple of 12 in
/ocp@44000000/mcasp@48038000

arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property):
interrupts size is (8), expected multiple of 12 in
/ocp@44000000/mcasp@4803C000

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am4372.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -807,7 +807,8 @@
 			reg = <0x48038000 0x2000>,
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <80>, <81>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 8>,
@@ -821,7 +822,8 @@
 			reg = <0x4803C000 0x2000>,
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <82>, <83>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 10>,
