Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/pO+ZG3xcyWP1ypILr1QbtLZZpOIu/TCcyRv+WvS9R6nzuvkvRtI1tlU96WeAuLu1+wN5H
ARC-Seal: i=1; a=rsa-sha256; t=1523021794; cv=none;
        d=google.com; s=arc-20160816;
        b=uZ9FaYHCBR/caxIpGSPhs25FXRpIGGJFkZ68QB1kdP+D1gTOh3lV6LoAlCVko2oPpn
         b2cxiEeCcZB8R3lK7DxlgoB7wCHnYUOuvuAqSsoa5su1N4pjKXJHcTNIRZ7PrXDTeiKF
         LM+3b9wETrmbQseOXaH9uQ9o3XdboXUQiccpl43pXn2Mi10S8w2m5hVAfy9XDeTNFEk7
         kbnC+8ZSlXwFpqjmEgDJ0vv0hxarWLV9JEiyL/34gJPXwrGpABUpw7fnQ7OMofrraEAW
         An/WGJixCyR9lHrTYT0JnWKtNuu915z19DGq1EqzxQyz7/0vPpKtUN7XnqImGpJcN7lk
         3ZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5tdiELTXjO7CcoabX2dYk11rbrDrq4Xirq4ouVougY0=;
        b=A9gs/CX2FPaaJpbhPNzJmRTZbtaMsSNPfARn+BNHu4HBiNYJBHbZyN5fwOKO3X4fGH
         G1HRgu+Rv6xLOtRNXDNOipjXHF2ZREcN3FU1c9Ub/1C7etjACuYKDOP+JIHVKpW1DDPr
         px5dvtD9QPq9n0UvOyjFaRJ1psHoWAiXVkkRcnk543TZ3MOpu1Xz3WZ8c6rCmv8TsNA1
         sjKeM2NoutLPJ7yaT4cpeg8Rwau9aHx1Ir+YLGLLT4hLpT0aLWKwzN2Qil0RTAA5su+t
         CUU3LsiwRgHlmBMFiJfsUWKjO1dcaGoUZfl5wOEwZosV/iq8qVWf3JHLZy8Er5NBn14f
         ILCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 093/102] ARM: dts: am57xx-idk-common: Add overide powerhold property
Date: Fri,  6 Apr 2018 15:24:14 +0200
Message-Id: <20180406084344.588915872@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004100685242312?=
X-GMAIL-MSGID: =?utf-8?q?1597004100685242312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit 8804755bfb1f3cbc003e4ebe99eac491672f354c upstream.

The PMICs have POWERHOLD set by default which prevents PMIC shutdown
even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
So to enable pmic power off this property lets one over ride the default
value and enable pmic power off.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am57xx-idk-common.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -57,6 +57,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		ti,system-power-controller;
+		ti,palmas-override-powerhold;
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
