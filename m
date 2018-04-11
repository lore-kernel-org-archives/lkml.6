Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480113-2-14118028304227454206
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
    1523480112; b=Wb8GXHFe6LK65kvr9L39zq1Mfd3G8IAH1ZnUHWzVYWQqPKHyIR
    MYe3+2dqt61tmO8CxPjy9+UA4e/bHTGftGCK9d369bOBV1JTk5xJ6mQC62ZaRNpX
    v93xBcfXhMiUFyTrLqfyjN8bx6ShVKEzTnYe62BYb922UfyBAzm3dx2YoRkEFsO+
    e1pXiFPr6Uhm+u2nT+sQNWy3K4tpR2mV8gBwj2FCqn85YzZh3u7xdKs/9X+/h9Hh
    TPmfYgsSHJ+lU5IyRsooJkBPRiGglF0TN4QvF0lo76meJ+G87cvWxS8Kb2XaA6nr
    dFgNZSsOJoyv/Wk5Cjpld5AkwoB2X2fCsfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480112; bh=bvRPy+XZJfhUEznk0MHySXJeTpkfqL
    2Iv5jiAiVVXjI=; b=qkNq6yG5axshG8TJe8HBp2+wzsrceiFIVPxpConHNTMAfl
    z9+3ZZbbjh8DURWt4NC6vsTyzmschYGcXPUPkrmk4CJIYZWRJLADwluiwI143MeI
    D3RgDBCrIgkDaJW8hPV3kLhf+LN/uV67x/0ICXiR29AzJyj+xBEz4n9Q2zTyiWl3
    IY+8e6QVoykZ677aLdR9UzqsOCPH0uIWH6V046DA9oaYMIfZh4i/nCo+xkTaHLw1
    KlyFzX489sn1EGYVYTpvfnDwRH0V4WaOqmidi89cc7Eev+q3hjTZIL7JFME6G+vZ
    bJAIC1CmhikIJydF2ir8QyWH2pg6OrJnodbWOm7g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfC8bT3cfAmhDXwaFq+qNgEBdkPu/U1OyI7zTIWntbXH8N9TEJC3zL135OpqvmhgUy0WQP4IqoJXFSlkBoezg5RF2kYa46RvSDtot6lFA6d0iWKj5jPLi
    scNT+w7KKkriUY+50LSSz7KWoaExIGmBDFggADwKVmzozw7lomsTk9yavdy4Z3vvM6Jle2GNhmhi62dqm3V1H0dTNkLGXYztm7bRhAEiDMCynQm5j2W8KFb9
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=wBxbjNxAvzM0_IQ4nDkA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755751AbeDKUyy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:54:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932260AbeDKSox (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 035/190] ARM: dts: imx6qdl-wandboard: Fix audio channel swap
Date: Wed, 11 Apr 2018 20:34:41 +0200
Message-Id: <20180411183552.238086370@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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
 		clocks = <&clks 201>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
+		lrclk-strength = <3>;
 	};
 };
 
