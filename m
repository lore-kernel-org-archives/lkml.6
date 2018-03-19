Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvgPbctyU870Ou7Uj+fLVe1KDeqPNyedNK3LsVf4D9Sv+E42+oK70a6wTRXHnXyADpS9KY7
ARC-Seal: i=1; a=rsa-sha256; t=1521483322; cv=none;
        d=google.com; s=arc-20160816;
        b=OK0q/TRBWfK1XCkP6J1LOCvJV6SRHjWCDelGhN1ivMCcntfFBRCKJtJDCY1Jm/SNUO
         MbJdkuai0L+8k8sDY4zYyY/TL/M24IGzW/jmbjYdWpUBtlxIZKutgiMeq1v6mJxMnIh4
         VxzrZa+yXlq0uy4lDXBCjcAdJHvLlWsWsFKxItwDOw6HeBBO3VMwHJdwFc9no3/kLr0g
         FEEg1Ndoj5ou2ZCJiHyIvGrTduIomtTPoUnSUlQGduDXkAOWo48Iogts2P/7bhPzaInx
         PTk2wfLS9hyVHglfOUvC66Z2YGvXdYn9nNGmhGDkQGbzsZyZDVYmYkvrRbalDKkQ0j7S
         5UMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xFwr8ynOJzvPuaGLR/tEjfyY8MZ4dmuQnYdP4Db7y7U=;
        b=sfwMiNoyb9MfeK8mLnkNeW6KM1m2y3vt42pAjaZo2B1dGR2hG2OdtYAcTki9tZQXW/
         /p8L+oflXKk4iuooLlra1se00dz3Esf6sNC3unOWqjzKls32dANMwlYC+TTonhU49+B9
         csdRqb3HqgBb+jnzr6nilHYYvj/8bXNNsnLi54wC47wqyToX3Zf6mYhxLfrqvlr2Q4b9
         XELrdWWvcLNxPjAD//K53Lf2lLaYARRp7FNmw9fZI3toQXfFxCiXiYlq1jOttdShMcYH
         qRYXcXVfBt6Qm3coghlDEkegeJRCX0Lz5TCECTdAwZ8A2l2qEhUHZKcDL5aLlgmzXCM4
         6nMA==
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
Subject: [PATCH 4.4 082/134] ARM: dts: exynos: Correct Trats2 panel reset line
Date: Mon, 19 Mar 2018 19:06:05 +0100
Message-Id: <20180319171901.139261101@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390897153858560?=
X-GMAIL-MSGID: =?utf-8?q?1595390897153858560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -359,7 +359,7 @@
 		reg = <0>;
 		vdd3-supply = <&lcd_vdd3_reg>;
 		vci-supply = <&ldo25_reg>;
-		reset-gpios = <&gpy4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpf2 1 GPIO_ACTIVE_HIGH>;
 		power-on-delay= <50>;
 		reset-delay = <100>;
 		init-delay = <100>;
