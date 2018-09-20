Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6611C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F48E2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Zr6oFgfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F48E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbeITP6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:58:21 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:40432 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbeITP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:58:21 -0400
Received: by mail-ua1-f44.google.com with SMTP id 101-v6so4256877uav.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycyHlqo2zLMsvN6aVN1w5p7UQDUNqWOlovdTBWcupYI=;
        b=Zr6oFgfNy9AfFQslellEWarP+7khGQF5qjE3kLmVP3I8wCPTVlscXm+BWmGj9hA67M
         JRJEXG9UGx2bsIjLYdPiHKHYTITqgnhABy7TA5IIPLpnAVqwfKNiJybZaSGzOZ7kQ2pT
         RrI1IogW8A1X3t64MoLwvaTaozQFoQnewaRzdirijOstC8mTxlcUXA48B0ppf/3ynxrd
         +3Dhd35fv4NQl4qgFXSADFV5h4N9/K6ALIJz+ueGFfMWfEEqRym4plSGPh1IN45NzHbP
         D7H5bpqk8k0HodW0QNWnEUNRVLMR8FLHeoCsX219vRZSyziokv6LGL4LBxFXO75V6IQS
         BP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycyHlqo2zLMsvN6aVN1w5p7UQDUNqWOlovdTBWcupYI=;
        b=opXsR0a82SpoJtA344XdafyJ396UGtlNxz9SrefBNaqvgXr2TWHy2BcEYuWNBv0xKp
         Cu5gWiEJQUvESl00/zteZeBNqHe59VW0oWbYwqOCSRKABLNjcNuET24Ie5x1BwBeFmUv
         1rg3zIPoR3r45QrLoEdmU9sOqNOPKbm7ur5M7T+99lrxhdSXuAOfLcjeCHAWNZAMfc+n
         G9SyKvy35plORatRi6Rlotc4xeyfAn+La/QTyG0W7vp434zFfeC+qhwO+7TVQ305Iw+p
         Utuv34j0gomMuojfKm/IGMyA0kPOS0ZEk8wQPSGWKWOBKodUqu+4bAU4g3ln0E94cbEv
         YV3w==
X-Gm-Message-State: ABuFfogWOxBcokjc82McDiQyc3r1/WCXRKnj5Me4+AKC1zoijFDkABgc
        AXELVWGLf6J/t2d59b4IQkqGKgAuF45cvP0ck1U=
X-Google-Smtp-Source: ANB0VdZTPr5e7yKs9jUok6P2L93ZhXdzBYdywQ5qTThdrwr07sdyLtCrj9OvE2nGBtc6LRBUGGy+4EvygJdwipAGJys=
X-Received: by 2002:ab0:1886:: with SMTP id t6-v6mr507836uag.19.1537438536114;
 Thu, 20 Sep 2018 03:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <6b4a0cf6fa672938b8ab98acd1dea0a1@redchan.it> <BBFE2346-72C7-47D3-910A-DD720C7637DC@charter.net>
 <24cf6d6095c740903f16b56e22dd137c@redchan.it> <996c99ea4146a247730d87df14dfca1a@redchan.it>
 <E1g2TJn-0006lD-Lm@fencepost.gnu.org> <0bd7fb92f5b2d5f18e67fdc9b3f6e603@redchan.it>
 <77f81bcb07d6a9193992f87dbd040658@redchan.it> <CAMjeLr-qVubez4wJ0AVrjVv2hEk6HjCpA30U=Of0hJEWmwqKyA@mail.gmail.com>
In-Reply-To: <CAMjeLr-qVubez4wJ0AVrjVv2hEk6HjCpA30U=Of0hJEWmwqKyA@mail.gmail.com>
From:   Martin Schroeder <mkschreder.uk@googlemail.com>
Date:   Thu, 20 Sep 2018 12:15:24 +0200
Message-ID: <CAGmj6qv9k+24qvA9Kxik797cx07=_qJdkxYU-39SFG0tu50HNg@mail.gmail.com>
Subject: Re: Re: Fwd: Re: [DNG] GPL version 2 is a bare license. Recind.
 (Regarding (future) linux Code of Conduct Bannings).
To:     dreamingforward@gmail.com
Cc:     observerofaffairs@redchan.it, linux-kernel@vger.kernel.org,
        dng@lists.dyne.org, debian-user@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the license clearly states that permission is granted to any third
party to use the code provided that the same rights are granted to
everyone else who uses the subsequently distributed versions, wouldn't
the original holder who is willing to rescind the license fully also
be liable to compensate everyone involved for damages caused by such a
rescission?

It would only sound reasonable to me. You can not first grant
something and then revoke that grant and expect that it can be done
without consequences. If that becomes possible then there is no point
in giving the grant in the first place. It would sound reasonable that
there should be plenty of room for a counter lawsuit that would focus
on how much damage a complete revocation would cause to everyone who
have originally accepted the grant and then went with it. It is
crucial I think that rescission of a grant (not just any license) be
made close to impossible to accomplish after the grant has been made
in the first place and the work has been made public.
On Wed, Sep 19, 2018 at 7:22 PM \0xDynamite <dreamingforward@gmail.com> wrote:
>
> > On 2018-09-19 03:38, Richard Stallman wrote:
> >> [[[ To any NSA and FBI agents reading my email: please consider    ]]]
> >> [[[ whether defending the US Constitution against all enemies,     ]]]
> >> [[[ foreign or domestic, requires you to follow Snowden's example. ]]]
> >>
> >>   > One is rescission of the license they granted regarding their code,
> >> and
> >>   > then a lawsuit under copyright if/when the rescission is ignored.
> >>   > The others are breach of contract, libel, false light, etc.
> >>
> >> If "rescission" is really a possibility, it would cause greast trouble
> >> for the free software community.  We would need to take steps to make
> >> sure it cannot happen.
> >>
> >> However, that goes against everything I have been told by others.
>
> This is where copyright differs from IP.  With copyright, you have the
> right to derived works if they don't violate Fair Use -- but that
> could essentially be violating the GPL.
>
> The only way to protect the code and spirit of the GPL at that point,
> is to accept the legal concept of Intellectual Property.
>
> The question then, is, is source code released under the GPL
> considered "published work"?
>
> Mark Janssen, JD
