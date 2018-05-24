Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163704-2-14829081856299065587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163704; b=j9khcyyOyN/hNGKfycXJjt0l0tuSYV+I+MIq3773iil5zuZ0nb
    hdfQx9enr3LDFmtaJ+kxj5thzBME7nuUbr6hxxvr0ngQBJ5L/1n7dWJIy01VBILM
    1kbPlfstRGPpzH5qk7/MuOrIJr5RI8VrtgWMoquYDH1WiZCpbBVHvizq8kVs7LUx
    GU+wN7uTzckjiGjIx7KcRVnRol7HAvGrhdIXeiwcnt7+ug607a5MSwFyQHs9K3Ke
    6xp54xQoxmp3ckQaN5NO5ymmmy2v6VpN4p++8N6+MwzOkDXuG16YCuCd92G5BEAP
    OOqYRChGs3lBx+jRVIIB6rnnIvLErUHHi5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163704; bh=qU0YmFzIDEjt+VfG+Pcv3oo8JxWILS
    pblYdTaa2wDZ8=; b=DDPNkaSkHVDycs/HAlUv5VIY1fc/dF5Rmyppbf1vUIJw6V
    dtRMuw90y+NBY/c8TzAJjarGN+JMsN+F3+UK0XteSQ/a0EMw6Z6up/TpITkQb0sC
    Cj6e9dmCGFQQuhlJ+pGP5tu7tGGlZCMXHUojP2dXFuaLeStNm1EaxquLDe5hh4hK
    kf21i57b4BnakT9zJD/YinVZ0lPu9wLOiCcqD05sgvghiIcU11IvAyDP0Fxpi+08
    wBWnlQ58qf1CHyCEnSYkASugyzNmqNt7fgRnXJsjp5pHkMxPnvXu2bwEIeGo50xk
    m7XwIH7XNMnRER5nC72U0tzeCWkZd2CEJCpdAx/A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tHqio1EC x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tHqio1EC x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHz+Q36yRaOepOA2QMlv3ZbkqOidr1j/L4JYti5qW/IEPSpY9xyKVaXc1ST/vvKlPtO2UHebMLtr0PgvHJXqwZw5Ic1NKo7WX5FmiDUseP1kaC1i7hQj
    MoPpcdGZXxNeiu23g0d2KuRkZsAj5kGMQY9CDaudpri2CQvMmyskkE7S3ihnNMWM3OCKeTum1H94dHMPIO5L3qhSCDB5omG79Cc3eZt/jExBC7R4n8OixHC4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=8AirrxEcAAAA:8 a=1EsaE_6oAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=8loL1zC9vO88QqH-WeIA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=ST-jHhOKWsTCqRlWije3:22 a=3ZumFrijQQ-2J9H5h8ct:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966592AbeEXMIV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966518AbeEXJns (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 28/92] Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"
Date: Thu, 24 May 2018 11:38:05 +0200
Message-Id: <20180524093201.675554790@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 9de3a3bfed892608dc30a6bc3fd8bdbeae5b51a5 which was
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
 		clocks = <&clks 201>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
-		lrclk-strength = <3>;
 	};
 };
 
