Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481930-2-13847512673716812866
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enit, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481929; b=WqfDW+rEdc3SAYMHQPg0KpWUMv4+CFFsW88Y1zouz9HJWbYGXI
    cCZhOgdFVb4JO2kj2DDssKpFTsBlMEM2EPPjsW31/uvrIVUmRvWmGkipYE2xhTXi
    ouHifWdXy9Hw2rukVr+tDAF5Z+aYy730LH+IH4NMqQufafOEfs5OS0EA8BsGMre+
    pFnpheBO0JSb3u6a4Qlz4aZGufGSZQyMydhNNk3WD8AiURZ6KL9RV7nWCx9+WMH1
    Yh4VK0iVe5ZHhEDOAttatH4pfp7DEiDc0QLzNhSN6EkDcEInlTuoRUT+SMj0ST4i
    Bx5/HYf/XqNAsjmunAo6zrSW36lPS+HETtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481929; bh=d4tEft1P2Ntzc8vQnhUrh3ye+7aTxu
    9YmHG/GiVCSEk=; b=Y8eUdFP3H9UwNFFP4LDXQ5Z04r0pfW1lBMYU3hnJR0biFx
    oTD58Nyi2Wric3a4+SDFrahVOqI32+1cy7NmYUUaZGEAxoCS/J9Te/B8hvO+djfh
    Ec08DbWqVvmBx0xT0E/DyBAGysqWKGLLNMTyOu91QcDQbrc+5uUPdo+Rrai0bEwb
    kb4jIGnFm8d6XLYW8hMSHe2XrSRJtojdS1zdDzQXY2//18R9U7vPzh0Qi12FexYC
    X1wsHiqSURopHI7O+5MgH6Z8KbZfWEsHyvc7/qenne4+t9VoQdT5UxgmbInWlslb
    y+kGCtZvm/0lHps//4WadLQUT+crCDK3m4InAMDQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfBs1MusHQBIc6dYZbxg/yk5RO4ofAr7LeyOCe8iFnTxx1bMcwiNaR4/vD7TMbgllo/nfKKYoRet3ASit+ttxHdo96b2kSQpEteB0Q84X+ojP1e7K5N1c
    QzJ3qcasgVjdQ3fwfSsDXY5VuqweNqoKeVrYGUwSpnPCn1mcjmr1XA2vSzEqamo/vZKNROtQ4e1OAhffDcSJFMltiHJxFh1FDy/2X/bJfwa9gFNrtFklLYtY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=wBxbjNxAvzM0_IQ4nDkA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeDKVZR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:25:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeDKSia (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 021/121] ARM: dts: imx6qdl-wandboard: Fix audio channel swap
Date: Wed, 11 Apr 2018 20:35:24 +0200
Message-Id: <20180411183457.442750624@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -86,6 +86,7 @@
 		clocks = <&clks 201>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
+		lrclk-strength = <3>;
 	};
 };
 
