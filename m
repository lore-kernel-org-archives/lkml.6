Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3458174-1518632617-2-3378275589412878211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518632616; b=Br7eC8oWc43Yzi/adzZgtPQ2lusnvhxR91GKukEtfEJsdlY
    MWGCL3gbFdYcCU1hkzFt4CC4t6hx911w0LwIenCkM1Ms9y4g3ZcRNeXSjmGQvzzu
    oU93cO8tXSCur3SQ0eMoLEtfF0I2QRT+CpAYjyWJ1OGfe1FtKbNtaDCCEf4DnS2T
    jUSq2yHVn1E9NBKS0bId3/KnzGpUBt5pMsNDv68/+k9o9GrqSIgeq08EixFZuTf4
    KbB3ztQbCr3b4EDSKKoY1TjKrFvn75/oASsLMza/cBXARabJkjeyfrGMmacLz/C9
    8IBeKTeDoH8OJv25nGIWfWQFcY7eCy7TQ734V2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518632616; bh=/ptHmaQi1aIOvwUVjfFUQBYpn6
    jWy9zdjGZ8zgCnpiY=; b=LQuUrga4VqbuEENELUp6iFMtVDrtMsdfxB41ZL1rXa
    SmgqqckL/CpQ3BbzBzAQvQx2cx2tTp3URC+IiS1IrnY2jQsekul98Rk/XXIUc0T9
    TYjlr47nzwJzhpYQjBsZ9Nzfio4NmjRER+1JAlnc+rIVEL4onyS+uyZRXS5P4jW4
    M4V6lSqUQGKNTBr0K+FDU5NCp8x/zfW4Rs6HDRkMWzua2T/EZsOW/CihQAGhMHwu
    el1HkUMoA7nUWZq5KwW0tr5DqpwmGy9TMYKrVt1icm30ZBgsi9Y/PYvDPmofcVIP
    RUzTauMAWE3KJaUxDiOf97Xal98lbkg7MZ7xNoiEkL8w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161773AbeBNSXT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 13:23:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161864AbeBNSWg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 13:22:36 -0500
Date: Wed, 14 Feb 2018 19:22:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        catalin.marinas@arm.com, broonie@linaro.org, marc.zyngier@arm.com
Subject: Re: [PATCH] arm64: Move post_ttbr_update_workaround to C code
Message-ID: <20180214182236.GA4611@kroah.com>
References: <20180214154033.GA2745@kroah.com>
 <20180214155140.27162-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214155140.27162-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 03:51:40PM +0000, Ard Biesheuvel wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Commit 95e3de3590e3 upstream.
> 
> We will soon need to invoke a CPU-specific function pointer after changing
> page tables, so move post_ttbr_update_workaround out into C code to make
> this possible.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/assembler.h | 13 -------------
>  arch/arm64/kernel/entry.S          |  2 +-
>  arch/arm64/mm/context.c            |  9 +++++++++
>  arch/arm64/mm/proc.S               |  3 +--
>  4 files changed, 11 insertions(+), 16 deletions(-)

Thanks, now applied.

greg k-h
