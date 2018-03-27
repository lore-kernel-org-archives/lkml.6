Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Q6JBmmexpcxSUuzzRZBxuOBDgzFq0GUSiwkz1vQm3iz1n3etoExHqgrno9jWTGgwJTKZ3
ARC-Seal: i=1; a=rsa-sha256; t=1522168797; cv=none;
        d=google.com; s=arc-20160816;
        b=0HymdvGgd54CrAfXr6p6eUaFbUcinAJVNt5XPrDF7gk5kfaPOHqrvY6pJ4U8BCuLXn
         upw5wkc+OUa3Sc7wKExJ3JAfbh2zopgJkgm/IKnM8hROw3H+sbxHONmdOe4o02eF8OgH
         vvYhnE5hVXD4kg934aQ1f6aiNyvMs6VvU0MO5nzaKcDRZKxHKh3Xuw/bRnHWSk7+Fubb
         M6TNQpkeSMCi7DrZ0QrxyKlmTDCbgREGrmoq6Vp+/A20KFaL/2zs8Kr+RtUEakutyY52
         BSlsy7Bp4Q168mbCllCX5S4xKC3eUMW6sGF2ycF9XFnwgy45zCaaK5/TuifPzMbvbxmj
         s44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TwC3phkF9ULdLCGVOQ4kA+EP2Y8FM+RiAA9dijuyrYY=;
        b=wMkVmhaGBLY7Oy30iwBorTzf0iU0T+W0hXGM9HraM+MtRUlYPXT9kEmvpCZYeB/SKd
         e65UFr8Z5Z1aJPfsualW00a+TQOTdIp8FHJCuBRJ6t/3+7+3IGSB27/hVYc4LdnlZ7xb
         Bk863jbjYl5E1U5FIz4pEkafg7r0v7gM2IDzdld1P7LU8DJHBr9YSi0I647tIBeF+F5T
         n+Ik18szELUluP3nk3WiZkreB2+87l982EdsAvd5qWdDh/qCDvw2Cqcf6cbQLiZNlXn9
         cuh8Bb5/mipB/dHOKeeaXWO8wDn3/9cdaXwBwPf3uKrt3VsPBRhFYx56vfEq4F6oJqyJ
         EnMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Kresin <dev@kresin.me>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	John Crispin <john@phrozen.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 004/105] MIPS: lantiq: Enable AHB Bus for USB
Date: Tue, 27 Mar 2018 18:26:44 +0200
Message-Id: <20180327162758.010063910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109321211007016?=
X-GMAIL-MSGID: =?utf-8?q?1596109669169486253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit 3223a5a7d3a606dcb7d9190a788b9544a45441ee upstream.

On Danube and AR9 the USB core is connected though a AHB bus to the main
system cross bar, hence we need to enable the gating clock of the AHB
Bus as well to make the USB controller work.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18814/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/xway/sysctrl.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
-		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
 		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
-		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
+		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1 | PMU_AHBM);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
@@ -560,7 +560,7 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
