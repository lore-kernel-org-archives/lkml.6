Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214945-2-11151305774146038443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214943; b=GCGXKdJ/6mrxex5r8cPJZMXK5dmHOpP91QnSDlmFuNTPNA1
    E9G4b4cDCa3S71WmHVkH+HvNCfC39ErUjLNUEM09cRQ1skd4X6wY8Cel3GkBYvmt
    N2Es778VABI43UGLUc9iYITv9eDDni/PHf2EpqkUd/TD/mk/z7OzJ0HyYQb22ImP
    SsuoPot6VzbP6wY92xJSxt84UYTKFRTcsOQplvYxHBjxXPwT1jLzosPg4oDa44f6
    i3LLiUhUG08wzoBB/y5lgH9aNXbSeaLngEq1/L6FbQx6qPLXmYND8Xps6NM5jejU
    /Xq6g/g5a/ZZlNTQBfvWOAfxwPZ0iQucnhf22UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214943; bh=G1icvRSvC88h2l9/vzJV3UVicM
    4Whxo9mUu2057KjI0=; b=OskUEm1Mjo7hLJDhoOv5QRGVtcnqg/sjn6yBZ0c9jn
    dZQ8Z8JaIypY3RTSQLgnQceiEhHMV/L5UBDdcw6t8485YyBccx3u9+88pNFCw2tr
    oNv1RK2vF6iDIl+O0LrvzytBcQMVWE2uv6sGcsxMNjm3sCJTSQZcpgJzoEyPgI4Y
    6QSdJdzrySGAwuA1g9H0TVmwY7nUxcf/Hlg6hFtxhfICsP7QiS7HARUBoeMqyhR6
    ydwqc8mkfsSd4yhbGJWFqkTDzxMrh8xKpPBmhxzyYuZNL1ubAeZKgOi+7RqtRFDn
    o+hOfPgUsClTe++VRolLvVw0Vl7xa2qB4Euw52X7Th3g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754844AbeCPPmP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:42:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754843AbeCPPmJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:42:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Shields <simon@lineageos.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 040/128] ARM: dts: exynos: Correct Trats2 panel reset line
Date: Fri, 16 Mar 2018 16:23:01 +0100
Message-Id: <20180316152338.720256679@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -454,7 +454,7 @@
 		reg = <0>;
 		vdd3-supply = <&lcd_vdd3_reg>;
 		vci-supply = <&ldo25_reg>;
-		reset-gpios = <&gpy4 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpf2 1 GPIO_ACTIVE_HIGH>;
 		power-on-delay= <50>;
 		reset-delay = <100>;
 		init-delay = <100>;
