Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs18sGS8zJoNgjsYJ04qS2XtL4fNxWTDwE4rYHqBayJ/3sGaJcSY1ic+fteRVohvmKILy3a
ARC-Seal: i=1; a=rsa-sha256; t=1521214617; cv=none;
        d=google.com; s=arc-20160816;
        b=kLvBTGgvXdJaUpOy4Q3DKvZuMSQ/3DNgABalASTAMu03VYBp0JJDulhh+h4WdvM964
         M78JbbdggBDh+9X4rBCtWFO5FGtQauIVM9TNnL5Ztbz4y82Lecb607WeP3YVMsx1y+/a
         4OWW8MRYuVIhzd9dXE7FYsdwuPSRXtBPuSJ+KEaam5HJM79ZKSrEnuwHZQ1bseJlmsch
         7GiTrnOe9aJ3tHo13bz0fpsLqqZYCAHuWxHru0/+z5KT4vySCfqQTHWil4cTMKR/V1Ol
         KRnhulMFbKJpHk1bvig6QVJBs5PUQil1bE/3HRA+/3bJD0SlKB8k8615bxQgxMKOF8gE
         X0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZgFGNKXTeo/kw3RYWr1fGGQgtwNpEHMhwfrdNqYyOWY=;
        b=WDG/Zx88MkP4KYYhunI+ViDwgRaTMq5jVvh+KdnqVs8MEZ3GhjuSmT48w4uYN/UE0I
         Q2UmHtGi9VtciID7DeeKnC4We3b1hW2q8fGGLl177jOZ01t1wuuQ6bYUT002WwDTEsgZ
         sRIdHY5HcsMhK7+H940VrKFouc8e8SLqPms55jbh3ElQKFB07SGwfdv1iR1wmpLbnN/I
         OZbjqUzGFUWThE5rYbn9lVF8T/DK61jIDuN5C3bTKKqavClNMqS6Tegcm+8543mL3Zto
         wrMw5d+i7/wFadT0059PFmRZYNmamUO1eNHO0yujjo4sIciNV3G8Y3HqUZ7TvQG3dqut
         YHLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Simon Shields <simon@lineageos.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 035/109] ARM: dts: exynos: Correct Trats2 panel reset line
Date: Fri, 16 Mar 2018 16:23:04 +0100
Message-Id: <20180316152331.866155894@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109138099806367?=
X-GMAIL-MSGID: =?utf-8?q?1595109138099806367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Shields <simon@lineageos.org>


[ Upstream commit 1b377924841df1e13ab5b225be3a83f807a92b52 ]

Trats2 uses gpf2-1 as the panel reset GPIO. gpy4-5 was only used
on early revisions of the board.

Fixes: 420ae8451a22 ("ARM: dts: exynos4412-trats2: add panel node")
Signed-off-by: Simon Shields <simon@lineageos.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/exynos4412-trats2.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -395,7 +395,7 @@
 		reg = <0>;
 		vdd3-supply = <&lcd_vdd3_reg>;
 		vci-supply = <&ldo25_reg>;
-		reset-gpios = <&gpy4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpf2 1 GPIO_ACTIVE_HIGH>;
 		power-on-delay= <50>;
 		reset-delay = <100>;
 		init-delay = <100>;
