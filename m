Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2417162-1524741696-2-2703616202804798478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524741695; b=lWPbRbVPEvSx6qCI+TnfIw+5oF2/N/Y2ERVvAo0gPLJ5PQnkyo
    UQwFv6POVFyK77xanDKYSa+1zHw4fgDpL/5WbE3KpZ9qnMy8qwGJdvlXSPSmy0cw
    TvwH6iNAIzn+zYnvrCCGap/FE5HPBV+/mxvzmH6NnWDM0J5bEUAlI0EakFL93egc
    fqtF8UbF++dMWuyQOkk5+BR2mJSPoW6alTm+u7E2yjMYHfdkefwSjzNepf5M2LKX
    ICJJTFuT+T4csp7+TE9vEQ+5Vbzh7QYPqHhUfwQTGxGJ6zHfzKM5ybO0oeRcvvO8
    7FHzhAoiTvAsaXzqUBH1iwnqAo4z6KDn1+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:mime-version:content-transfer-encoding:content-type
    :references:sender:list-id; s=fm2; t=1524741695; bh=LLu0OiwtMFjr
    bKnUzYOQZSEi89Q2M8+H77JyfCYtd8Q=; b=AOtQp3agY5ayZogD1OW5DyQDJE9W
    zDILYJGmP5UTq1YXsTemqZear+a5jxpKBJ0XqspAO7aIbConvQ5XT/ON++W4l1hw
    +lNB/IqD8k0+AeCbN4emtpo+PGzZy7fdkRi5nlVWhyXY2z5bylJmRGWSaTORtVao
    RZRx4iRAQ15g3NM1P4uWTHvCuFJSI379J9ZfNZfQTyyd6HNr/Khm1LjfqKxL2/Kb
    6b3bcSbh6wK4Z4Vcf+PQzHYRY3DI/igpsfyJ+n1ei0NnqNzFjSmDQQ5qAduKOyuP
    fPq6gIcSBkmV4JLwBEJP4hmFKa6Nykb79jJPuwNQiQcnEifmI+6erHNLvg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=uAcXY851 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=uAcXY851 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDK/mTxYNGxiBBmmxcfCAc4J8PAoMX4P0NrOuvNjwJOnzu3aC79gsa87OPI0MLAwE3r540S7zc1eKXXeb9x6FXQ2s3+8Ht8FsDdwF6OY5nLD3zuDyDfW
    +41dRo+DPs7YZlsu9zMzH3/bJ2G9P18Z+dV/CZ1iHzbCmJ0Ye2tH7IHRb4E6YcEDJjJrac2oKDaYQCb5rjlfJIY7RRWI2u5FQA/O/nEUxbs4eDTWeBkc3nCl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xQMrlssy50Kn4cZdMiUU9ANOUCQ=:19
    a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8
    a=D19gQVrFAAAA:8 a=HPvd_-TfsUAZvKwMZ5EA:9 a=2tTou0c6VA4wPbBq:21
    a=Nb0SL6ywBHyk4pqR:21 a=3ITi0uT_K7dohNvc:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755722AbeDZLVa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 07:21:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58938 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755029AbeDZLVS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 26 Apr 2018 07:21:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426112114euoutp018efc6e33a01603abed979786fe3b8ac6~o_HmO5byw1593615936euoutp01V
X-AuditID: cbfec7f5-b45ff700000028a9-13-5ae1b629605f
Sun-Java-System-SMTP-Warning: Lines longer than SMTP allows found and
        wrapped.
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] thermal: samsung: Remove support for Exynos5440
Date: Thu, 26 Apr 2018 13:21:12 +0200
Message-id: <2734003.UHSMxVLybj@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1951102.VLysaozMLK@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yTVxjGc747xC4fRecZEpY1M1M3mTqyvHNm02RbzvyDkLho0uigk29A
        xsX0Exgmc2ys4hhzUCWYzktjEbB2otgQdLV1pRaBQanlooyLFZXMkTCGbqyAW9sPE/45+Z33
        fZ7zPufkCLTaxyUIOfn7JX2+LlfDxTIt3n971q9tCWo3BF2bwDI7QcGC0ctDTfA+B4OPJ1g4
        7ekJL30DLJRZmjiYbK+l4HboEAs/jP9Bg893kYdj8w0UNI+HJdOVoyxcPj2P4PDCYwTe1nsU
        BK6e4GDmew+C4z4nBV9N3+HhTL2BBnfNNQQ/eUZ4ODvop8Df+T50Ds5w8GvXLRYM1zw83A8e
        4aBtspyFpwOXGKia6+Ug1HADgfVqeMSlJ2Try8R2yoZIYMBPk7mQEZGp2waeDNb9RZMrphGe
        WBy/U6TZ+i1HhgccHHGdtPHkct2XpO/m1yyZcvZzxN5fzpAfR2YROWK3orQ4beyWTCk3p0jS
        v/5ORmy2scPJ7Ova9bnbPMyVoklSgWIELKbgQIsZRVgtNiL8dyi7AsWGeQbhMVc/9Uw09KCH
        Uxr1CA/dPcYrmzmEp4bL6IgqXkzDxt766FGcuBlXl1ujvFzcgX9++AsdMdDi9Rjc0XmSUwxb
        ccfCVNTMiKvx0PxvTIRV4lo87mqM1leI27HdWR6NESOuwxU+J61o4vDs0dGonhZfxE5XDavw
        a7jbewFFhmGxT8AXfcrlsPgenjjezSscjx+12xc5EQeOfscohrLwA7Q6aKVRhbCjSa3w27it
        3b844TlsbKkNa4RwXYUPH1qUEFzR4GGU8jYc+meT8kJ+hB+caUNVKMm0JLdpSW7TktxmRFvR
        SqlQzsuS5DfypeJkWZcnF+ZnJe8tyGtG4W/e9bT9SStyzn/iRqKANMtUs6fuatWsrkguyXMj
        LNCa5ap0Q1CrVmXqSg5I+oJ0fWGuJLvRKoHRrFR9vOagVi1m6fZLn0nSPkn/rEsJMQmlyEKl
        Tn+avrp0R0rqzrr4O3H2nHddN15ac3OvuftgcrE9Z+7C9cYSVm0+N/nmlZreVVQ1EwrWPtqY
        +fx/hsSi0XMP/9y2WRiTv/gwuFCsr771SpLf8cK9t2w2y65hI9X0QeX5ZVZL20cHUk07UxK3
        bzBl7NkSSHg1rSCpMtmr/mYsNWO3hpGzdRvX0XpZ9z/PcwjE4gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed7bLjZ8W0ZPRhSjkkaaScQhIvwSPPQhigXRomzYi0ZObXOR
        SaTVvKzsYomySk1NbWimDVHLWWtqZbrMdGYqLTWTpmZpmJfIKYFfDr9zzu/P+XLEtDyf9Ref
        jI4TdNGaKAUnZZr/NrUHbq5yq4NHyiVQMDVEwVxGowgy3QMcuCaGWMh1tM6XD50sXCoo58DT
        lEVB13QyC9f7v9PgdD4Wwe3ZYgoq++eV8at9LDzJnUWQOjeBoLH6CwXttXc5+JXuQJDttFGQ
        NP5RBPlFRhrsmXUIyhy9InjgaqOg7c0eeOP6xcHb5vcsGOscIhhwX+PgpSeFhb+dFQzcmHnH
        wXRxAwJL7fyJikkSuoGU5pQi0t7ZRpOZ6QxExrqMIuIq/EmTGnOviBQ8G6ZIpSWNIz2dzzhS
        f69URJ4UXiAfXl1kyZitgyPWjhSG3OmdQuSa1YL2L1dLd50Qok6eEXRbdx+XRma8tjGxzYfO
        2vN6uETkISYkEWN+O+4ebOVMSCqW84UIW59b6cVmDuHBzKes11rB78MX72bQXub4nfhmigV5
        2Y9X4cQrFsYboHm7BJsnPWgxEIpfz40tBBh+I+6e/cR4WcZvxv31JQvzlfxebLWlUF6W8Eps
        ctoW5nL+PH75080u+svx1K2+hSzNr8O2+kx2kZW4vKaJuoF48xLNvEQzL9HyEG1BfoJBr43Q
        6kOC9Bqt3hAdERQeo61E859T1fjHWo1Moyo74sVIsUw2lfNZLWc1Z/TxWjvCYlrhJwszutVy
        2QlN/DlBFxOmM0QJejtaI2YUq2TO4Hi1nI/QxAmnBCFW0P3fUmKJfyLSBufE7xjNrun+USTv
        SSaesPSKA4GOEeOR2vX5X4dUZQafvrxjaxOyN7W7h6u6V6zyM91Ps+54FCzxDzmoOV3U0qT6
        Hd6QGujbl6BUfkcu1Te8uqQuXZ179PCXpNyWibiWjheyvKwtBW99DL6XDw+/D9BWVZ8vxJXS
        yIetVpczQMHoIzXblLROr/kH4oxn+zUDAAA=
X-CMS-MailID: 20180426112113eucas1p1b5bf6f093442154e29f5541b4aba6b00
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180426112113eucas1p1b5bf6f093442154e29f5541b4aba6b00
X-RootMTR: 20180426112113eucas1p1b5bf6f093442154e29f5541b4aba6b00
References: <20180424203239.21885-1-krzk@kernel.org>
        <20180424203239.21885-7-krzk@kernel.org> <1951102.VLysaozMLK@amdc3058>
        <CGME20180426112113eucas1p1b5bf6f093442154e29f5541b4aba6b00@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] thermal: samsung: Remove support for Exynos5440

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
[b.zolnierkie: ported over driver changes]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Eduardo, here is a version which applies on top of pending Exynos
thermal changes (https://lkml.org/lkml/2018/4/16/256).

 Documentation/devicetree/bindings/thermal/exynos-thermal.txt |   14 
 drivers/thermal/samsung/exynos_tmu.c                         |  161 -----------
 2 files changed, 4 insertions(+), 171 deletions(-)

Index: b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
===================================================================
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt	2018-04-26 12:29:42.716294204 +0200
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt	2018-04-26 12:29:42.716294204 +0200
@@ -12,7 +12,6 @@
 	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
 			Exynos5420 (Must pass triminfo base and triminfo clock)
                "samsung,exynos5433-tmu"
-	       "samsung,exynos5440-tmu"
 	       "samsung,exynos7-tmu"
 - interrupt-parent : The phandle for the interrupt controller
 - reg : Address range of the thermal registers. For soc's which has multiple
@@ -68,18 +67,7 @@ Example 1):
 		#thermal-sensor-cells = <0>;
 	};
 
-Example 2):
-
-	tmuctrl_0: tmuctrl@160118 {
-		compatible = "samsung,exynos5440-tmu";
-		reg = <0x160118 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 0>;
-		clocks = <&clock 21>;
-		clock-names = "tmu_apbif";
-		#thermal-sensor-cells = <0>;
-	};
-
-Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
+Example 2): (In case of Exynos5420 "with misplaced TRIMINFO register")
 	tmu_cpu2: tmu@10068000 {
 		compatible = "samsung,exynos5420-tmu-ext-triminfo";
 		reg = <0x10068000 0x100>, <0x1006c000 0x4>;
Index: b/drivers/thermal/samsung/exynos_tmu.c
===================================================================
--- a/drivers/thermal/samsung/exynos_tmu.c	2018-04-26 12:29:42.716294204 +0200
+++ b/drivers/thermal/samsung/exynos_tmu.c	2018-04-26 12:30:52.648295965 +0200
@@ -126,28 +126,6 @@
 
 #define EXYNOS5433_G3D_BASE			0x10070000
 
-/*exynos5440 specific registers*/
-#define EXYNOS5440_TMU_S0_7_TRIM		0x000
-#define EXYNOS5440_TMU_S0_7_CTRL		0x020
-#define EXYNOS5440_TMU_S0_7_DEBUG		0x040
-#define EXYNOS5440_TMU_S0_7_TEMP		0x0f0
-#define EXYNOS5440_TMU_S0_7_TH0			0x110
-#define EXYNOS5440_TMU_S0_7_TH1			0x130
-#define EXYNOS5440_TMU_S0_7_TH2			0x150
-#define EXYNOS5440_TMU_S0_7_IRQEN		0x210
-#define EXYNOS5440_TMU_S0_7_IRQ			0x230
-/* exynos5440 common registers */
-#define EXYNOS5440_TMU_IRQ_STATUS		0x000
-#define EXYNOS5440_TMU_PMIN			0x004
-
-#define EXYNOS5440_TMU_INTEN_RISE0_SHIFT	0
-#define EXYNOS5440_TMU_INTEN_RISE1_SHIFT	1
-#define EXYNOS5440_TMU_INTEN_RISE2_SHIFT	2
-#define EXYNOS5440_TMU_INTEN_RISE3_SHIFT	3
-#define EXYNOS5440_TMU_INTEN_FALL0_SHIFT	4
-#define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
-#define EXYNOS5440_EFUSE_SWAP_OFFSET		8
-
 /* Exynos7 specific registers */
 #define EXYNOS7_THD_TEMP_RISE7_6		0x50
 #define EXYNOS7_THD_TEMP_FALL7_6		0x60
@@ -184,7 +162,6 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420,
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5433,
-	SOC_ARCH_EXYNOS5440,
 	SOC_ARCH_EXYNOS7,
 };
 
@@ -619,57 +596,6 @@ out:
 	return ret;
 }
 
-static int exynos5440_tmu_initialize(struct platform_device *pdev)
-{
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	unsigned int trim_info = 0, con, rising_threshold;
-	int threshold_code;
-	int crit_temp = 0;
-
-	/*
-	 * For exynos5440 soc triminfo value is swapped between TMU0 and
-	 * TMU2, so the below logic is needed.
-	 */
-	switch (data->id) {
-	case 0:
-		trim_info = readl(data->base + EXYNOS5440_EFUSE_SWAP_OFFSET +
-				 EXYNOS5440_TMU_S0_7_TRIM);
-		break;
-	case 1:
-		trim_info = readl(data->base + EXYNOS5440_TMU_S0_7_TRIM);
-		break;
-	case 2:
-		trim_info = readl(data->base - EXYNOS5440_EFUSE_SWAP_OFFSET +
-				  EXYNOS5440_TMU_S0_7_TRIM);
-	}
-	sanitize_temp_error(data, trim_info);
-
-	/* Write temperature code for rising and falling threshold */
-	rising_threshold = readl(data->base + EXYNOS5440_TMU_S0_7_TH0);
-	rising_threshold = get_th_reg(data, rising_threshold, false);
-	writel(rising_threshold, data->base + EXYNOS5440_TMU_S0_7_TH0);
-	writel(0, data->base + EXYNOS5440_TMU_S0_7_TH1);
-
-	data->tmu_clear_irqs(data);
-
-	/* if last threshold limit is also present */
-	if (!data->tzd->ops->get_crit_temp(data->tzd, &crit_temp)) {
-		threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
-		/* 5th level to be assigned in th2 reg */
-		rising_threshold =
-			threshold_code << EXYNOS5440_TMU_TH_RISE4_SHIFT;
-		writel(rising_threshold, data->base + EXYNOS5440_TMU_S0_7_TH2);
-		con = readl(data->base + EXYNOS5440_TMU_S0_7_CTRL);
-		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
-		writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
-	}
-	/* Clear the PMIN in the common TMU register */
-	if (!data->id)
-		writel(0, data->base_second + EXYNOS5440_TMU_PMIN);
-
-	return 0;
-}
-
 static int exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -820,35 +746,6 @@ static void exynos5433_tmu_control(struc
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
-static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
-{
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en;
-
-	con = get_con_reg(data, readl(data->base + EXYNOS5440_TMU_S0_7_CTRL));
-
-	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 3)
-			 << EXYNOS5440_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			 << EXYNOS5440_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			 << EXYNOS5440_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			 << EXYNOS5440_TMU_INTEN_RISE0_SHIFT);
-		interrupt_en |=
-			interrupt_en << EXYNOS5440_TMU_INTEN_FALL0_SHIFT;
-	} else {
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
-	}
-	writel(interrupt_en, data->base + EXYNOS5440_TMU_S0_7_IRQEN);
-	writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
-}
-
 static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -920,10 +817,8 @@ static u32 get_emul_con_reg(struct exyno
 	if (temp) {
 		temp /= MCELSIUS;
 
-		if (data->soc != SOC_ARCH_EXYNOS5440) {
-			val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
-			val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		}
+		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
+		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
 		if (data->soc == SOC_ARCH_EXYNOS7) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
@@ -964,16 +859,6 @@ static void exynos4412_tmu_set_emulation
 	writel(val, data->base + emul_con);
 }
 
-static void exynos5440_tmu_set_emulation(struct exynos_tmu_data *data,
-					 int temp)
-{
-	unsigned int val;
-
-	val = readl(data->base + EXYNOS5440_TMU_S0_7_DEBUG);
-	val = get_emul_con_reg(data, val, temp);
-	writel(val, data->base + EXYNOS5440_TMU_S0_7_DEBUG);
-}
-
 static int exynos_tmu_set_emulation(void *drv_data, int temp)
 {
 	struct exynos_tmu_data *data = drv_data;
@@ -996,7 +881,6 @@ out:
 }
 #else
 #define exynos4412_tmu_set_emulation NULL
-#define exynos5440_tmu_set_emulation NULL
 static int exynos_tmu_set_emulation(void *drv_data, int temp)
 	{ return -EINVAL; }
 #endif /* CONFIG_THERMAL_EMULATION */
@@ -1014,11 +898,6 @@ static int exynos4412_tmu_read(struct ex
 	return readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
 }
 
-static int exynos5440_tmu_read(struct exynos_tmu_data *data)
-{
-	return readb(data->base + EXYNOS5440_TMU_S0_7_TEMP);
-}
-
 static int exynos7_tmu_read(struct exynos_tmu_data *data)
 {
 	return readw(data->base + EXYNOS_TMU_REG_CURRENT_TEMP) &
@@ -1029,16 +908,9 @@ static void exynos_tmu_work(struct work_
 {
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
-	unsigned int val_type;
 
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
-	/* Find which sensor generated this interrupt */
-	if (data->soc == SOC_ARCH_EXYNOS5440) {
-		val_type = readl(data->base_second + EXYNOS5440_TMU_IRQ_STATUS);
-		if (!((val_type >> data->id) & 0x1))
-			goto out;
-	}
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
 
@@ -1051,7 +923,6 @@ static void exynos_tmu_work(struct work_
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-out:
 	enable_irq(data->irq);
 }
 
@@ -1086,15 +957,6 @@ static void exynos4210_tmu_clear_irqs(st
 	writel(val_irq, data->base + tmu_intclear);
 }
 
-static void exynos5440_tmu_clear_irqs(struct exynos_tmu_data *data)
-{
-	unsigned int val_irq;
-
-	val_irq = readl(data->base + EXYNOS5440_TMU_S0_7_IRQ);
-	/* clear the interrupts */
-	writel(val_irq, data->base + EXYNOS5440_TMU_S0_7_IRQ);
-}
-
 static irqreturn_t exynos_tmu_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
@@ -1131,9 +993,6 @@ static const struct of_device_id exynos_
 		.compatible = "samsung,exynos5433-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS5433,
 	}, {
-		.compatible = "samsung,exynos5440-tmu",
-		.data = (const void *)SOC_ARCH_EXYNOS5440,
-	}, {
 		.compatible = "samsung,exynos7-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS7,
 	},
@@ -1223,19 +1082,6 @@ static int exynos_map_dt_data(struct pla
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 150;
 		break;
-	case SOC_ARCH_EXYNOS5440:
-		data->tmu_initialize = exynos5440_tmu_initialize;
-		data->tmu_control = exynos5440_tmu_control;
-		data->tmu_read = exynos5440_tmu_read;
-		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
-		data->ntrip = 4;
-		data->gain = 5;
-		data->reference_voltage = 16;
-		data->efuse_value = 0x5d2d;
-		data->min_efuse_value = 16;
-		data->max_efuse_value = 76;
-		break;
 	case SOC_ARCH_EXYNOS7:
 		data->tmu_initialize = exynos7_tmu_initialize;
 		data->tmu_control = exynos7_tmu_control;
@@ -1260,8 +1106,7 @@ static int exynos_map_dt_data(struct pla
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
 	 */
-	if (data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO &&
-	    data->soc != SOC_ARCH_EXYNOS5440)
+	if (data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
 		return 0;
 
 	if (of_address_to_resource(pdev->dev.of_node, 1, &res)) {

