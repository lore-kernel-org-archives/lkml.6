Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133548-1522172380-2-3074930413359070247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172370; b=ZRqaBRKeRyIEfVodsLpPq8XQB1Jv5/YQUWhBCPdVzyH4aC6
    1XijmBp/yD8Lh3GATgt3z+fIAZRLUWa6K7Kw71e4OpRUCibpIjbDOpxZxkkc81Xs
    uusE/KXiy7R0D8xSc5bMOOdkpr4ER0hywHAO/VHXeDkcyEeJYzN/Nkl9PCrWYxCF
    gKLxHQpk2MWeGIPWRqc950joWhsmW/Pcdph8Yw36WiEPgVAytpvkzjXJvKd9A2+G
    jA4GmTyTj+jAbGfpEurI2P1Bgy7lMLzEUZQcoVKA/AoQFqBBBE87BNQ+IIggSNPP
    96miFho8lDBKkWOj4S9NaoNdAGs0GwSXA8ll+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172370; bh=b0Aqe8t7MWG19kPo/+QO8i0AgO
    /LEYMGfLOqsmVlJjE=; b=fWNipL8FSgQX5CZZWQskMWsKGd5td7y4EiTjE0iiaW
    tRELe1JhdBsbYA836DzZTQsw1V6W4Bsq+nwV9XVcXgM5DUdxDrKvd98za0G8qpkE
    jJudp0fTHO2uS6Gx2Mc36ykT7iLS3Vd6Q+/7ywQILbM7mlMgNq9rSlKAAegVFKfP
    XyGkP0CKdlb6aR2BZflrQZiDJAFMPe0uU0o6mVSmkP8sQOdpX9pm99dePlKAOmDI
    mpAE31vcN5D76F+MhXmy5Yn8kiKoiWIYLEwoDvUzfiJe3ZZrTOL3SjJYBr+w6WWt
    LhdiYnB9P3DqZCLbKAPC4dE1Ke8TWCtIUNAUoLw2Dj8g==
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
X-CM-Envelope: MS4wfE/95+HWGy+B1/4O+ncC2BNUaGZkhkBn+n/TPr21YxKBknI/ZgZAx0c+e/NAELevn6bjlZs6Kg6lsqxbVVtPiGltofjGwNGRbI2GPBKZJPEtr5aaRqQi
    5ml7FhPhhBjX+lP2JkkwVkbZntPfYoK1DIFKGdJQGx7IWw1UDtYiwLiY5CNs9HKDT/d2R9Sp/NKPjaQiHvgIOlngMW5pu03Tw7IRgjgNjx0LubALYiQj2hOx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=mK_AVkanAAAA:8 a=WPyIoOwQAAAA:8 a=Vxy2kpnnAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=AfttUzoE7gEzaGJm8xwA:9 a=QEXdDO2ut3YA:10
    a=3gWm3jAn84ENXaBijsEo:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=mQL3ssppXrSh16SuiSjD:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeC0Rig (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 13:38:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbeC0Qe2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 005/101] MIPS: lantiq: ase: Enable MFD_SYSCON
Date: Tue, 27 Mar 2018 18:26:37 +0200
Message-Id: <20180327162750.330367967@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit a821328c2f3003b908880792d71b2781b44fa53c upstream.

Enable syscon to use it for the RCU MFD on Amazon SE as well.

The Amazon SE also has similar reset controller system as Danube and
XWAY and use their drivers mostly. As these drivers now need syscon also
activate the syscon subsystem for for Amazon SE.

Fixes: 2b6639d4c794 ("MIPS: lantiq: Enable MFD_SYSCON to be able to use it for the RCU MFD")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18817/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -13,6 +13,8 @@ choice
 config SOC_AMAZON_SE
 	bool "Amazon SE"
 	select SOC_TYPE_XWAY
+	select MFD_SYSCON
+	select MFD_CORE
 
 config SOC_XWAY
 	bool "XWAY"
