Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608381-1526631770-2-15635788785160387983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631769; b=a2IwCuzpqZQrpK41QlchH5ysNWMl+CYQWBYBOUUxMHdDJgL1YM
    0j1uy1bSmq1LAfAU3FavqG49ajNjpf4HUgavYEMMCxbih+MgONnzuXl77yB6MdDY
    fJst36+3G3VbFnShgJ8csUHXB2oa0jw6w9QXYj2MM0BY/5GsuqGRMpWYwdAM1cZ0
    f0QIJMoLidMgUEtjaKkOJEvfPVPb9UExunFHPMevjP2woFNQkOfTFnhj4myr7tdK
    Vp6wZ0GdrKguzeQq8ZLiGjLLOrqnVwImsSn6LA/mxn/taXtDo39DT4BYMRiYsZAs
    b/LK8c+gSIcux9Yb0WAyARGN7yF+QKnEK7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526631769; bh=lxS2af+VfRUPejHzrGD4dbu6gCFvZl
    6GmWKMW+idrVE=; b=aKJq5rQSWT6zMEfRd5anFpzFIJJtxsdE5u/mkgKOkdxLxJ
    o0ojBSFgjJSH1p5Is+XHLZIbLUu6AP90xRMu+YQxrbx/fDcnmEYXIUsbIqtdfBpa
    GkjFNT6wjDeyR9ZD8bn7AyBQmXPJnl0VYgP/dbnN14Il6jnWEMF2xhpAfBKlbpUc
    PD5WqsmResoHLoSvYw2NeRMNLNR7L4SR29Yq2bkSgCYsTCDft0HoTK54OU9NrpQ2
    4wcCKhTMWF/v5MFf3HJtqNk/yhRJOE+fHmAn5OQZhJg6F8FFdRE18az00umIXdyN
    imDqe4JVOr3SuwNZOYGoE+wJwgCmTpy8SHUNi/ww==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=LBr4anp5 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=LBr4anp5 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBXaX5rwb17Nk85YRIXHkUTisEwsMN58MxQTQrZ179x17Ed/ylqYS5XUvmeOBvW5hhRkfzVh9UZvTjeK7anMZjN8ARrs72Yo69yQHIOxD6K4HDbjkw96
    QhJ5v8Atg65AiV09dub6kDmBweJJ+a4A2iWxcgG6+ijtPpLv0GA09Msmb/xYhDMjl2Gu8SwMsfY0pyVUQi9xjknTBrKjjO44PdAh83ZpLSZ92oXaemznGpDC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=8AirrxEcAAAA:8 a=1EsaE_6oAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=fs2a0GfmMcxWNEDwrTwA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=ST-jHhOKWsTCqRlWije3:22 a=3ZumFrijQQ-2J9H5h8ct:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeERIWp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753084AbeERIWm (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:22:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 30/33] Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"
Date: Fri, 18 May 2018 10:16:09 +0200
Message-Id: <20180518081536.310837274@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit c53c4ad96242e868da492f424535bf4b45f80503 which was
commit 79935915300c5eb88a0e94fa9148a7505c14a02a upstream.

As Ben points out:
	This depends on:

	commit 570c70a60f53ca737ead4e5966c446bf0d39fac9
	Author: Fabio Estevam <fabio.estevam@nxp.com>
	Date:   Wed Apr 5 11:32:34 2017 -0300

	    ASoC: sgtl5000: Allow LRCLK pad drive strength to be changed

which did not show up until 4.13, so this makes no sense to have in this
stable branch.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -88,7 +88,6 @@
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
-		lrclk-strength = <3>;
 	};
 };
 
