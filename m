Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fiEvceSFYI8iqTCACILoqQ6X5noQx9+ocd2NesrZNhpSQnJDEgJgHaTqltwU3N1FjR35h
ARC-Seal: i=1; a=rsa-sha256; t=1524405326; cv=none;
        d=google.com; s=arc-20160816;
        b=yfQX9SY2qA5u+b6iURT5mlHIrb6LLG3Rkdxw1oF12qTJtSlYpy2MeDbda9/gUP2e5u
         5bQ4aMRpUTcGFitWzt5bNX1cLgXcB2a0xyrxQ0fd7YPOGViM4ofvdMEaWFSmGcVOsHbD
         cG3L2/ZjNa+75LxEffXhy09UfVKk5NDgCt7wOVGd8FQM7jJb/Zl9l6MHSUDFXxyqR6b+
         doGI2oG+QiTZF2S4C6aUfDppw+QghYGYAg7LMS7WJ8+uotR/iR9TLGxouAUIU+MIB9Q+
         UaWxaKQS3E8yuc0FlaIRPerHVSjf1hXlsGSLcz2Ou/VrijiEJYMyAQ1d8tIjpFjyZDRb
         3NVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VkUPci0+dxi12ATtEX3Zb9W6ALNAQCJf5n9r6S9lu2g=;
        b=HhcEgMigYszwz0J5a24svGS9vD0xwuN+2H5rDsYYVYvU+Q9PIxb0iy3zvxiEtoxGg4
         fhDFBbQtgadaD7IVqjHVcbNhstRfMCrSKe4BwkBAt/A46lFr4rD4Ob5g204vMJZe7x7U
         wkqAAZoNNCHDYdtlBKXe4tm2xVFETJjrc809X/zUSo4JE2zcWJIk/b1+ECGfSUEnA/xm
         u9OOfigL9mW2ypSyU9rs+YkwYo49kb6xd8NF6ojUQIBpquBBK49ppBAwMtG0UCAmxDC3
         +dpN35uNNMfQ9CJWRFddAuYHowLtsgJ0bfUWjWnCUY9UG5OiXwo49WT7xiiuWMGdnZL3
         mV7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrzej Hajda <a.hajda@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.16 025/196] ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250
Date: Sun, 22 Apr 2018 15:50:45 +0200
Message-Id: <20180422135105.407446974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454839935570670?=
X-GMAIL-MSGID: =?utf-8?q?1598454839935570670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 6f4870753f29edf7dc39444246f9e39987b8b158 upstream.

The proper name for the property, which assign given device to IOMMU is
'iommus', not 'iommu'. Fix incorrect name and let all GScaler devices
to be properly handled when IOMMU support is enabled.

Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 6cbfdd73a94f ("ARM: dts: add sysmmu nodes for exynos5250")
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5250.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -655,7 +655,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc0>;
+			iommus = <&sysmmu_gsc0>;
 		};
 
 		gsc_1:  gsc@13e10000 {
@@ -665,7 +665,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc1>;
+			iommus = <&sysmmu_gsc1>;
 		};
 
 		gsc_2:  gsc@13e20000 {
@@ -675,7 +675,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL2>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc2>;
+			iommus = <&sysmmu_gsc2>;
 		};
 
 		gsc_3:  gsc@13e30000 {
@@ -685,7 +685,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL3>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc3>;
+			iommus = <&sysmmu_gsc3>;
 		};
 
 		hdmi: hdmi@14530000 {
