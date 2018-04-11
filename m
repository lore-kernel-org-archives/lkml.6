Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477432-2-132024114137467707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477431; b=MHCzlUCI703+Otl5N7U0pnpN2Ag/6Ax+jjiMAJHz5IsJZQGVfD
    VSUM1mlytjvpkq/FZHu5T8hNZkwWUIi0ZfmFpiXWZxej1sODfQ7qxJKsunxeCBCK
    3i+Q8e142x4b4u9rEN9Mgh26TIPtQEwNPs2BTpoDWWziuaIgzOdjl4mzF3PqM/h9
    qssbjkqKqRFKXCAT+PNJRbaGUo6Z+KuiVgrRTotR6DM9bjHrBUtfkRnSgotng3mN
    Nue6k8+DIjE8ae9ZF9MxkZGt8jakY9+rfhgCDY88nDAl9R+eYevmr7zJBWJnvqMZ
    3rt93SL9U437KHdostJua21Gy/8LLe4T2SBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477431; bh=10VSAdycEqcegQcYrNhkw2VhnIOSHU
    Da85cPEJSRivI=; b=DIS9e061+f2awEFn17ToJTLNRfT1otpsVbCftbMWDMYZ4s
    FjOj816XsIHD6US8LZ7y6hcKxv9PKbzsyXF9cQkR1JApXaThoeJRmRLbwmDFlJL/
    82lKLVFyis3CcRt7BV1TOgvOH5rNovR+L21BHCD4rS8ShQ+UAxQv46SXIIAiFWd7
    ni2XtQ1UGF31gFWyxD5Y5WejoqEAlPrOS8Iy1HxR3wgVVPaAl7Ft/uNcfFHI4eAX
    YINLHbmgaHDuf32TB4VkHwy0fvF5bAvwJfHe42zOl/5yJtU18E9kswb6E/zcs54u
    dhoxvtjxNBGpaOA5GQWqzRS+D5vziSz59Y3zba8A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIXd47Dlfb86Vmr1gZn05pACG8s1cZ2HK1bL+zxrjxqB08qA73rAiBGgNo0SuxlN6AWhrmImx/6YKmZYjhWJLTfBqL0dLvdcS4O0vxf/ocJPbKyT9x2J
    /7jbmb2N7GiMXXM0zrC+axefLR9KBp1mgM+np3G84RxN4P8jY+vHKmXuwCjcVAp6gW8hKpQxCeb3kndLLqguWFOCQIZn8BuSqQ1VBTb+M8E60XR4OoXE3xI9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=wBxbjNxAvzM0_IQ4nDkA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756128AbeDKUKQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:10:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbeDKSyj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 049/310] ARM: dts: imx6qdl-wandboard: Fix audio channel swap
Date: Wed, 11 Apr 2018 20:33:08 +0200
Message-Id: <20180411183624.358058567@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>


[ Upstream commit 79935915300c5eb88a0e94fa9148a7505c14a02a ]

When running a stress playback/stop loop test on a mx6wandboard channel
swaps can be noticed randomly.

Increasing the SGTL5000 LRCLK pad strength to its maximum value fixes
the issue, so add the 'lrclk-strength' property to avoid the audio
channel swaps.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -88,6 +88,7 @@
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
+		lrclk-strength = <3>;
 	};
 };
 
