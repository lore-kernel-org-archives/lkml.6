Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-171462-1519305415-2-2581462719789000595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519305414; b=saZwMsaSwMifZyageGIp5IPF7KNtwdwAzqRRfRKuqFwQDWN
    IMhvCyFjXxZuhZI2LpFK9irLWRRtCQuIcyklDbFIxnaozqKV4+55Y4RXiC03d4El
    e6yxPZVm8xtgx05OkNBLtkm7kO59ubbaV7fTuCqYw9a/dpUl3JRuKZNacL/FFndG
    e+cLCXJ3PRnyifnDJieRPRSvCxcjCRt2IXW2zOS0gwK7E3M/S8B76fEvsnEwY1Ge
    zo3+2wTztQja5SnULFTV8nPwpx4xKawZk5GXuZ/Fdix2e/LGZstn33BacJKXQEKg
    xysfZcOqEGNBVbFNrWxjjIUBcd9L6klU4W3tTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1519305414; bh=QiGmOhWmPO3WAHHLizd0lBVjVKkYA289bFzK2S
    jTsOk=; b=e0ItH9glI/Qht0Dk5RCdprglbxa5mHJ75FuPaBzzxtjUmpyG3LVEmb
    UJvQk1yFnpa/v6Q5g7wZXuhBPPBr2T3M3e+DxeILmRXLyTLQcZjolMQ46ziRf18f
    BXO478g8V3byuQz82I9AqiEwZNSfTFr+MhFJzF2QG5fhGUujaDtiqMo0/AzSGuuo
    0iPpWcHE9NRmLo9lOMonoFwCkCaM3BddMg3fc+7c5qfm6OaLh47DDX8mJZFNohP4
    357CqIEoKZiBOFi0EyNw1dVzSDwombizSBBnl88lTAgEcqSYY7AFgQRJnUs27Ibk
    Y9fFnpW/iRnKNJkOhoukvexZ9KEFug7A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbeBVNQj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 08:16:39 -0500
Received: from ozlabs.org ([103.22.144.67]:47859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932470AbeBVNQh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 08:16:37 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yves-Alexis Perez <corsac@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
In-Reply-To: <1519292030.2388.14.camel@debian.org>
References: <20180221124432.172390020@linuxfoundation.org> <20180221124433.618725458@linuxfoundation.org> <87k1v5rg66.fsf@concordia.ellerman.id.au> <1519292030.2388.14.camel@debian.org>
Date: Fri, 23 Feb 2018 00:16:34 +1100
Message-ID: <874lm9qi4t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Yves-Alexis Perez <corsac@debian.org> writes:

> On Thu, 2018-02-22 at 12:01 +1100, Michael Ellerman wrote:
>> So I guess this patch is OK for now, but we do need a full back port of
>> 222f20f to 4.9.
>
> Hi,
>
> in the light of this, do you know the full status of protections against
> Meltdown on powerpc/ppc64el architecures on 4.9?

With the patches I just sent, for pseries and powernv, the mitigation
should be in place. On machines with updated firmware we'll use the
hardware-assisted L1 flush, otherwise we fallback to doing it in
software.

cheers
