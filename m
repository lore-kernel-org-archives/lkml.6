Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3010894-1518618275-2-10366632200005686731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518618275; b=NKNuXZsOL5ONELIRZdpeSI7OB2wkle3yp5/dQtB2X5UW6fm
    L20XNbRPiEr6Jxxq906csPzKjZdJBZtgS//Q9K0G0EAhFrajkWhoN1VGg3ZkNcHV
    JDcV90MWGnjelJU4K0Mvgl+OE7XbX8Jbk0hN6BZ0S3xVrWp0oTlk6PoN5xQxz5U+
    HUKD30QJL2UU7F/Yp+XrHZgZdncVHZ2FtC/1VSsBwc6y9Hv09kUlK9U2aM77eJPi
    2aVz/SF9UiDcazlX6vlXWyHGg9tWpl/y6p32O/HYGX8M2X3xH3SrQIFHXOOF5UQ4
    Pz2wcOp3BevwcLGhPOA6WzXSgPUwTIfs/0fBRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518618275; bh=LLnOWBU2CL1k2DB/kXwE3bJbjbB6JixOqtK+Mv
    fmOFs=; b=VNodLSeCREh7H0ymR9C1okAZI4hGjAXzftiiEkilXv+Pnl/3Sw+GmP
    v1Af092gwMTFo/mcuPLcAKIKD6/qX23kfuYzf7lzFRRItslUz12xiyhEDwyb2Xma
    bS9TRAltBgYpxy295iaNVl6zY5ae/YOiFY12+UYrQ9Uho1+PYHMZWFRQg+elFQp3
    GRkmNXugh9aYBpjUfBzE7bpsoZE8zclqV40K8EIl9EbZ2e3u/v1/jcvBt42PHwYW
    sVIVAiTot6tdAqMF/Fu67Vq9uqbbl6Ck5THlHv/92Q5KA8hIbLOP8YwNN8Lu8kp5
    YHqzeqCgflF2PPPDEqDI1Y/SgHOQBvMQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=JAuw0jus x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eGRhKgjN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=JAuw0jus x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eGRhKgjN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030381AbeBNOYb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 09:24:31 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:37882 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030449AbeBNOY3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 09:24:29 -0500
X-Google-Smtp-Source: AH8x224yiFkQ+TWrd1ZelGykdr4zdgX9b/gT1ZpdWxx+giPUvGTfqv3UDyzLUCG0cVgQTOaBVgejWBT1W7YGDClZ6EI=
MIME-Version: 1.0
In-Reply-To: <20180214135420.GB24189@kroah.com>
References: <20180212113801.2552-1-ard.biesheuvel@linaro.org> <20180214135420.GB24189@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 14 Feb 2018 14:24:28 +0000
Message-ID: <CAKv+Gu_uqudgFU1_+cWZtvyQmZMxjCYuUr-2L59yEfoY8EyWQA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for v4.14-stable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Brown <broonie@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 February 2018 at 13:54, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Feb 12, 2018 at 11:38:01AM +0000, Ard Biesheuvel wrote:
>> Hi Greg,
>>
>> As mentioned by Will, I have created the v4.14 counterpart of his stable
>> backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
>> into v4.16-rc1.
>>
>> Given that this is the v4.15 version backported to v4.14, I have removed any
>> mention of 'conflicts' from the commit logs as they are now ambiguous. The
>> patches applied surprisingly cleanly, I only needed to drop two patches that
>> are already in (the same ones Will mentioned in his PR), and drop another one
>> dealing with SPE, support for which did not exist yet in v4.14. I also included
>> the patch
>>
>>   arm64: move TASK_* definitions to <asm/processor.h>
>>
>> from v4.15 to make Robin's Spectre v1 patches apply more cleanly.
>
> I've queued these up now, but if you could pull the whole quilt tree and
> verify I got things right, that would be great.  There was some
> conflicts with a few previous patches I had already queued up that
> touched some "Falkor" errata code.
>
> Specifically 932b50c7c1c65e6f23002e075b97ee083c4a9e71 "arm64: Add
> software workaround for Falkor erratum 1041" is the offending patch.  I
> think I resolved the merge issues properly, but verifying this would be
> wonderful.
>

No, the build is broken now. I will investigate.
