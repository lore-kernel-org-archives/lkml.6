Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4152212-1526054458-2-15666238010114826923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526054456; b=hb0u6RYzMpbvqw7KyyTnkhtmeYooDg2LuM+VJnmh71V4EbwN/f
    Vm3D+5tqcnTvq7bXFDPl2DejfIdx5/ezwVqfu3K9ZxFQIUgAlZXqVdQnpriTM3z5
    0Xt5BOoZHCEzJvIL2IYgvfGcq3pVKdvb4Mjz2wnb9XIo9cIv/3gh5Rpbb5jV7vrE
    jhl5KEsWQDuEMU4IRZNgXULHUCrHUR5VZgCXMpsPxrBXNe3oFDXlDobO4Ri/SNn4
    89aZ2MVcs7mMNunkFZjXiAevpRGPicRU2hnyxAQqExaocmNWpPkhNWSSVN+bzEB9
    ENkiWIMFLJ+QbTUaUJ3U3mZ8QREqsa3onAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526054456; bh=oYOViU29TSbcogxcvpCSaoZySWhrl7
    Mkdzxj064GoF0=; b=Ej/0bHXItFiF33CHD19HNXCg9sfKtVmcEOkBGwol03KFaq
    VywkKK10E0DOvsZ2EMTn1nDIz0T/sXgQQAcojnS5XSfCMxfseMbjzcdzBwuLsKuB
    p3GGZJar5T1lpwscMKkWS1r60Lc2VMhdXF/ykZ+ukPSxg2suzILVbPvxqgIBXk5Z
    6+Lvv9sXlMfETtUw7pI7uWH30rxVCEZscQB3M1Ab/crCF7ZzVio3XQBe4b4tHfVb
    VzhtcGemgPVDsm3ZmfaZwI6/uo/nGW860x4pj90kRuLVeoTOrrxqfJUgnLCvua1P
    48lxNSwfdw8uFOhHf0X3/fJwHu7yXHwU2765mraA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
    header.i=@messagingengine.com header.b=ZBtezM+M x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
      header.i=@messagingengine.com header.b=ZBtezM+M x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPBUXw2KmIi1XPv1XIPbXvcv0YZw/xRLzScb3ppMq/6T69F8kN1/t1DzxCLlNcIidiq6qkVEtqrDJRL+NNRhxXmGO3FVqRTXmCHQk/mjiknKtBR2cryS
    SHWHFvu0iHdUOVX7kT4u5BCOol3sr21W6c3LmoPGfhAhmLzKhYS2L0qyiD4YNawZiSPMsup2xXMrnblDOoC+neeMuuF420wYQsv8PYRRH4EHiAvQrePEYknz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=5hbFD1BkjCuMjG_J0ygA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEKQAw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 12:00:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49583 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751273AbeEKQAw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 May 2018 12:00:52 -0400
X-ME-Sender: <xms:M771WsdIie09upPC4tM3_4ibkI8EBv2xlsVeCz1bhwbhfad82Dkx-A>
Date: Fri, 11 May 2018 17:47:21 +0200
From: Greg KH <greg@kroah.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com
Subject: Re: [PATCH] [stable 4.9] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
Message-ID: <20180511154721.GC17038@kroah.com>
References: <1526046675-23790-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526046675-23790-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 02:51:15PM +0100, Suzuki K Poulose wrote:
> commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
> 
> Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> from an erratum 1024718, which causes incorrect updates when DBM/AP
> bits in a page table entry is modified without a break-before-make
> sequence. The work around is to disable the hardware DBM feature
> on the affected cores. The hardware Access Flag management features
> is not affected.
> 
> The hardware DBM feature is a non-conflicting capability, i.e, the
> kernel could handle cores using the feature and those without having
> the features running at the same time. So this work around is detected
> at early boot time, rather than delaying it until the CPUs are brought
> up into the kernel with MMU turned on. This also avoids other complexities
> with late CPUs turning online, with or without the hardware DBM features.
> 
> Cc: stable@vger.kernel.org # v4.9
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Note: The upstream commit is on top of a reworked capability
> infrastructure for arm64 heterogeneous systems, which allows
> delaying the CPU model checks. This backport is based on the
> original version of the patch [0], which checks the affected
> CPU models during the early boot.
> 
> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com

Now applied, thanks.

greg k-h
