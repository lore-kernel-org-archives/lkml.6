Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtsijCHHnWlkdn1pbp/vNXcqihXN6il01mA4v8pkHAVh/2RANe3zKREUfGsuVr0k8tuX1kf
ARC-Seal: i=1; a=rsa-sha256; t=1521483933; cv=none;
        d=google.com; s=arc-20160816;
        b=RPsG+Qw/yt3Z/t3VM0cqpcAG/naejbS8fW+Jhgo3dgQLOML+Z9ICdlv6XBk8/Epe97
         C3bDvGpwGhlOmFl3Jcj1XrERi/o8vWFzbwFt916notWdOh0AvSnC+nkgkbTnAAevyUNH
         LcLH7aigFBabX9wB41mVeFbF3xoiICZbELY/yjNpU0Zlq9q0vZrt+JyD/84MLYnaipz0
         xqsiP60kvikZUiKCU3Yczpp08r2VSCs6uWHHjx+OYmTUivtGeF/HTB3OllS8ZuUTcmn8
         cyhuai1yL3nQu1FtOazaHpvWYjEPL+fpy6ByfVbhCtm1taCOL9vNcYb8QfFZx2NbYUMN
         dz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kxivaxyWpCTsW/zeQaQYRRMVQkNA9XxHDVHmJBg9Oz8=;
        b=VIe0iIGGjyNO5WZOMHA3yl3HVH5Fduts7/qxRnwSmv08HMWZuBq0kSf3OM9PN4ssn9
         eduhbhE0mtkWLQHLpb6aQ17M3fEWJ8iWv1quE1yDLeu9LQrWWbkLmQBo0eYmw5iKY4PL
         l5UIpfP5wXNKQVDhLJBzB8++4OfEgbhwVnrABvnxNeTCURfvOnW4nxw+WiN+6K01VIiC
         U/+VD4XUo4oLMqjkjFlsssl9uzoB0VP/dD/3dipvkEzEhoCIvkoLsb/XJKOI7DYm9gry
         EDKKN8eRsP3T+IjG/PUMjwATDOSoxtmMtPpquCmQePAJUdFOXU0UELhIWim+CkrNEKY0
         8/AA==
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
Subject: [PATCH 4.9 169/241] ARM: dts: exynos: Correct Trats2 panel reset line
Date: Mon, 19 Mar 2018 19:07:14 +0100
Message-Id: <20180319180758.162772222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390897153858560?=
X-GMAIL-MSGID: =?utf-8?q?1595391537404854996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -408,7 +408,7 @@
 		reg = <0>;
 		vdd3-supply = <&lcd_vdd3_reg>;
 		vci-supply = <&ldo25_reg>;
-		reset-gpios = <&gpy4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpf2 1 GPIO_ACTIVE_HIGH>;
 		power-on-delay= <50>;
 		reset-delay = <100>;
 		init-delay = <100>;
