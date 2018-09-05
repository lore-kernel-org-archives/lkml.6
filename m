Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3706DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE179206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=secretlab-ca.20150623.gappssmtp.com header.i=@secretlab-ca.20150623.gappssmtp.com header.b="ozqJ3w7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE179206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secretlab.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIEXlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:41:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44145 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIEXlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:41:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id k38-v6so9391225qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=secretlab-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYnO7nSxadKTavqClFYfjERWzkNdVbXtcrfMUat0B10=;
        b=ozqJ3w7olAcNjcJiqUKUo96OBUYIoW6MBFkpSs6ErScVJMJxpJmQ3D+3Pvz1YWQoTu
         8luMo+ONy+P5PFg+p5IGg/AVXLCp0s9pA6CuMlsCFF1WhRRRrtWebm5HDSULST4kcmYg
         hZ36AlG12cqUWJHtO9qIQXH4tAa4k9gJUOWmo3JHS1u7TtDJHXnQlAJ2zCShPRysRYUB
         JqNENvMNJ69WawIuPY80+TLGz3Ci9gwFvlA53Oi7T8PtlrLcy0dTngcGzX52I9B2mn7j
         DdxD5sMg+VnMYlanM8kWERa0zgtGyH993DZvlyn90nW4s0mL5Z/8dRmJVUkEiQ+p2ibf
         5olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYnO7nSxadKTavqClFYfjERWzkNdVbXtcrfMUat0B10=;
        b=lpTztLbXX0/qetg3weEfzatLYABUVJMvSNacqwHpnaTAX7S+x2SQMt9BXzrOhVJvwE
         mtOTQUvGEoipkG9ybsIGDb0SpfgofSy8EYKNS58VWXw/Ubg60BTH4VWBWxh5gpsJaMN1
         36F7bNoI1EFlzeJjV4Q3LJc4zRGtOD70zhiGqhCncmLDDYBCzqs0yJKlwbZUb9Iz7/4l
         /08loQL2rNdCa2uILAWtstCXPtxegPip4JBJrv7JJX5Eo805NJOCk2TxcW4r2g5s3UEq
         40r4LaUBqdT/sekNCc+O1JlQx0DvBk7tGVGLHyE4dpMhQPOpG6IS3ski2EB4eZ9A4R0U
         Gxzg==
X-Gm-Message-State: APzg51AsqwrwMeDWGuhotMvWF9Jqd2wwzn/unLXezFFBshC6FWIEdVc2
        /WVwZ2/yh1mX2WnLhOcohpdRf/f98YrUC7a53Ut1jw==
X-Google-Smtp-Source: ANB0VdZ6t21xjAaQq1s5OHuNRnbakjTH4QBP/vwefXyseBejmdBxE6pBaIVlm+ZiEUeUxvWRII8krceaGV1QmxIGHzI=
X-Received: by 2002:a0c:d5aa:: with SMTP id g39-v6mr8240199qvi.176.1536174605066;
 Wed, 05 Sep 2018 12:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com> <CAKv+Gu_zDJ11+CjgpBPRm2C66sUq6bzGGA2EBCZoDXa-3NdYNA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_zDJ11+CjgpBPRm2C66sUq6bzGGA2EBCZoDXa-3NdYNA@mail.gmail.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 5 Sep 2018 20:09:50 +0100
Message-ID: <CACxGe6vSAjO3N-_6OHASHiDLpN+0b3=p54WWq93GgCY=YGQiKw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, scott.branden@broadcom.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 10:37 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 September 2018 at 12:13, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Tue, Sep 4, 2018 at 7:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On 2 September 2018 at 04:54, Olof Johansson <olof@lixom.net> wrote:
> >> > On Thu, Aug 30, 2018 at 9:23 AM, Ard Biesheuvel
> >> > <ard.biesheuvel@linaro.org> wrote:
> >> >> On 30 August 2018 at 17:06, Olof Johansson <olof@lixom.net> wrote:
> >> >>> On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
> >> >>> <ard.biesheuvel@linaro.org> wrote:
> >> >>>> Don't be surprised if some future enhancements of the EFI stub code
> >> >>>> depend on !EFI_ARMSTUB_DTB_LOADER.
> >
> > That's an odd statement to make. The DTB loader code is well contained
> > and with defined semantics... True, the semantics are "I DON'T BELIEVE
> > FIRMWARE", but it is still well defined. What scenario are you
> > envisioning where EFI_ARMSTUB_DTB_LOADER would be explicitly excluded?
> >
>
> Well, to be honest, I don't have a real-world example at hand, but my
> concern is about cases where the firmware provided DTB and the
> override DTB diverge in a way that leaves it up to the EFI stub to
> reconcile them and/or to reason about which one it should prefer.
>
> One example could be OP-TEE support: currently, we put a
> /firmware/optee node in the DT to inform the OS that OP-TEE is running
> in the secure world. If we allow a DT to be provided via dtb= that
> provides such a node, we are blocking all future opportunities in
> future kernels to do any kind of preparatory OP-TEE related
> initialization in the EFI stub [while boot services are still
> available] unless we decide to make it the EFI stub's problem to
> reason about which version of the DT is the correct one to use. What
> if the firmware's DT has /firmware/optee/status = disabled and the
> dtb= one does not?
>
> Another trivial example is GRUB: passing dtb= via the command line
> will break initrds loaded via GRUB, since they are passed via the
> /chosen node.

Using 'dtb=' straight out means *I don't believe anything firmware
tells me*, so of course nothing like OP-TEE integration, command line
passing, dynamic configuration, or anything that firmware might want
to tell the kernel is going to work. Anyone who uses dtb= gets to keep
the pieces when they break stuff. That can be written down into policy
in the dtb= documentation if you like. I've just posted a patch to do
that.

g.
