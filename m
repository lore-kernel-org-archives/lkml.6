Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-120056-1517892271-2-10810081496216351411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517892271; b=QiiYziaHTHHqsXoXTb3Be1P1zvu7pMdV50/3pl+spJQJ5Rt
    6AumPRZhqqRKXoQiNSTQBZ5s3KoCbyVqkSRGWATxent0ni9bxUqFpX/nbEivI3o9
    rRHyQE3tuNo9OxDPf36azlAx+mpGT1SSYrWFF9JOu+4v038uimPScd/8yO9sLAFr
    7sdUK68opClCb8kO2Bc+WSODFZ5Wbwkdt53AaExjI+k2/hFEBmko3szu+fVct/SR
    lDIvNQmkj+To5JjzZQdaC3npdkqSx5MYp0Vnbnfqgf/tDY86yHTu7o88MKl7SqRX
    vlmk4OOBrFZizxF9LYIFWdnlqZ5OFPecH+RvpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517892271; bh=dbXZIitr9dF0EDaPOFCanPA3puXye3KJNBsRtY
    JlOsY=; b=mRz5rSSMbjX65a+R57E3qge/clUKLBVzBRLaMooj3wWbjfCS73J/sh
    2iFkjCwltqRiCh7QdKPFxVHYfgnVH29XXQ4Z89QJGj5u1zHO7z0opsed3bkMnGvg
    gB9I9E7SKwjtUl7UT6DzVzVZaL5O9LDIy2mXLlOqe2iINEz4gVV8Cj1VJPZ25mfd
    XwrPu4dY0MVwcB1iS6xG8ZxoBNUCH2Dc2JHCwdB/hzUBDDMOslsBXCul7xO3Wrzj
    eYJl72wgAzykpJf2YlW1sw2zNrO+z0c/mZsUFTsD8GSOAtfo2StBiOAKwvB2cmBy
    FhnlgnDyb0Q6kIOTiTuOZERLLdww0KBw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b=oFF5wGVZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brainfault.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dDhbShS4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=brainfault.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b=oFF5wGVZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brainfault.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dDhbShS4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=brainfault.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeBFEoY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 23:44:24 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35543 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbeBFEoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 23:44:17 -0500
X-Google-Smtp-Source: AH8x226Rs0DMiAWhbkga8BXBLLWxkycDTPGUen9jHLz53dCP9j+TvphKFdW0KNuLLS6lAb77IitYle5XMgp23lRbJIQ=
MIME-Version: 1.0
In-Reply-To: <1515590217-24256-1-git-send-email-anup@brainfault.org>
References: <1515590217-24256-1-git-send-email-anup@brainfault.org>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Feb 2018 10:14:15 +0530
Message-ID: <CAAhSdy2882krYXY5QAA44EaZoq48GdaBNtXr4J813WLyz==kAA@mail.gmail.com>
Subject: Re: [PATCH RESEND] rpmsg: virtio_rpmsg_bus: fix rpmsg_probe() for
 virtio-mmio transport
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bjorn,

Can you please have a look at this patch?

Regards,
Anup
