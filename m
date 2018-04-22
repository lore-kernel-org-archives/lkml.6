Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/56XojjsRy4Rrui4c5bUZFQKVR+WvAPSJ2j5TLd6BarFinVq0g/2s5oYRhPxnqanNmT9mg
ARC-Seal: i=1; a=rsa-sha256; t=1524406278; cv=none;
        d=google.com; s=arc-20160816;
        b=aL5GzJMk3Flcs19usJhJASjlLT/coGogf8QfE7k8e19mL5FdyJJ4wP+OPPlWHA3OMS
         48KQbpGHidmScs0oyzGmCKJfdDMXHDcwlIE1+pCH6h1SCySQaJ9426Vk1vI0tOHLEg9g
         7b/ZO6eRPM8pP2nc4EKdK3YGAzABosHuprXU5D2VMqP98mI7HwX0wWdDe81xrpqP6zZg
         mHsIGY/Do7X3VcRneGv6lBBsP1sq0qMLVuCeneGcaArDGHTeW59dUQgqUZ1z9YBCWaq+
         x3nJLP4PE79CEvjmVnpFN1kkxkmBYzMhJPfdA9AUgNLstJ2u7iy3BUrBYgAo5S0css25
         7YzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xAaCyEHxRe+MPzlvbcCM33UzG1Zlg2R9CEqtC0HgyCE=;
        b=0sIx00oUYXdwCbxdt0jsrGa5uEKs3W4TVsEgTS3NEYXcx98N5HaKT4j5qDZfmzUiqe
         vCtwQErubn0iBVVcE74FivJkM9FD6G3alsKr3AfQUOKs0hPF0hJS59FiTq2yxWiMQFvg
         DdKGDfi0dM8LiSP0aPvRgGAur3z/++1Ll9TUdXQeGz+IkyRPjGkmL3kdLzMNNlS5P9L5
         1SsMxgTwpcMBjic1dh41+mkA2CaspXeU8JS3ogvi6bMBHSmTWxq0nLLKprNKt77nZYCm
         8lx8m9DGi+JpQwhSeDxDRr09CSU4Ijz6ANWIygEXWwd1D9pNHPLOWG99dbMtRcHMdq2t
         LwnA==
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
Subject: [PATCH 4.9 13/95] ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250
Date: Sun, 22 Apr 2018 15:52:42 +0200
Message-Id: <20180422135210.967739968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454839935570670?=
X-GMAIL-MSGID: =?utf-8?q?1598455838302969870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -640,7 +640,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc0>;
+			iommus = <&sysmmu_gsc0>;
 		};
 
 		gsc_1:  gsc@13e10000 {
@@ -650,7 +650,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc1>;
+			iommus = <&sysmmu_gsc1>;
 		};
 
 		gsc_2:  gsc@13e20000 {
@@ -660,7 +660,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL2>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc2>;
+			iommus = <&sysmmu_gsc2>;
 		};
 
 		gsc_3:  gsc@13e30000 {
@@ -670,7 +670,7 @@
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL3>;
 			clock-names = "gscl";
-			iommu = <&sysmmu_gsc3>;
+			iommus = <&sysmmu_gsc3>;
 		};
 
 		hdmi: hdmi@14530000 {
