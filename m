Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFABC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C2C20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC8kmSG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C2C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJ1UEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 16:04:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42129 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1UEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 16:04:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so2523494pgq.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=URUJOjWx2zMb8INLm3z0n3/dESvN8PI2X6HDtfi34hA=;
        b=pC8kmSG0jf4qmgvy1e8KpRPT4wvM38fUU/wiEPLqevXNUYcRO7ewaLPheiG+c44kJY
         dJxk99v3xyGHNd4igH4tkRLvJsixCKNuz6fPdvsSg9Vhe8gWNQrihsIJx9ZUFBjX8NBq
         Tx23BMSnwZwerJgM4BQFCXbv5oe48lH3lAEL4hzCEsIk5V0i8P2+OKal/0R222zk3x2T
         Xbypx4K4k3vJI1B6+IP1L9aG6Gr+LwKWc9rizRDt9gu8QzX0fvv2un/guqY4jqIG+4jH
         dc3mwkznVd7q/+v9T7184AITTYltx1PCbgUo5BOYQ5dPN3Ye1TNci0QrUPWOO+mbqX8H
         NlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=URUJOjWx2zMb8INLm3z0n3/dESvN8PI2X6HDtfi34hA=;
        b=jxMa9cATxVi/MIKjk2692CZXzWQQNJs2KtaNL3hHeNl3erIw8wJ1tkGELKOLb3dlrd
         f5Z53I4cPMzwkSzXKPfLFbv+L0nCC18z3xZjo4yDpspuapU638N+QVB0ZexAQja0qh0r
         RWohs+lnnSmHdIcApfiApCR1wjwYrC4M/Pxek1apdKrI9Tt10X62hz5Nus8shJqVjB2d
         WXTvFHLyquO7t+uNW8CPZtERkIaqHs+Ie+OOXtxO2cJuNxA2fyXew8BUDg1Vw4wz3e3L
         IXoFnF0AGOlnAMg18DM1bFu7TWu4a2dPvwfR6jUbmKHLrgzdV9nAzlQ7k6lUcOMTsVP2
         FAPw==
X-Gm-Message-State: AGRZ1gK4G//YCWB3CEkWjcktWUZSuKDiI16IOIQbdCaHzPxdTN2zPnxY
        I2eHsyLsOl75sppN5MFWgl8=
X-Google-Smtp-Source: AJdET5ccwl8HJBakR9q77nqtxL3Rk+6uesMsR8P9mD1CQ5kmLvAyPDYh5k/MqbiA7AkNZipkBNE5jA==
X-Received: by 2002:a62:6506:: with SMTP id z6-v6mr10823075pfb.20.1540725620243;
        Sun, 28 Oct 2018 04:20:20 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id u124-v6sm36137938pgc.0.2018.10.28.04.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 04:20:19 -0700 (PDT)
Date:   Sun, 28 Oct 2018 16:50:12 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Sasha Levin <sashal@kernel.org>,
        Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [RESEND PATCH 2/2] staging: vboxvideo: Use
 unsigned int instead bool
Message-ID: <20181028112011.GA5157@himanshu-Vostro-3559>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com>
 <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com>
 <20181026204225.GH2015@sasha-vm>
 <20181028075209.GA1938@himanshu-Vostro-3559>
 <alpine.DEB.2.21.1810280932030.2450@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810280932030.2450@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 09:47:15AM +0100, Julia Lawall wrote:
> > The "possible alignement issues" in CHECK report is difficult to figure
> > out by just doing a glance analysis. :)
> >
> > Linus also suggested to use bool as the base type i.e., `bool x:1` but
> > again sizeof(_Bool) is implementation defined ranging from 1-4 bytes.
> 
> If bool x:1 has the size of bool, then wouldn't int x:1 have the size of
> int?  But my little experiments suggest that the size is the smallest that
> fits the requested bits and alignment chosen by the compiler, regardless of
> the type.

Yes, correct!
And we can't use sizeof on bitfields *directly*, nor reference it using a
pointer.

It can be applied only when these bitfields are wrapped in a structure.

Testing:

#include <stdio.h>
#include <stdbool.h>

struct S {
bool a:1;
bool b:1;
bool c:1;
bool d:1;
};

int main(void)
{
    printf("%zu\n", sizeof(struct S));
}

Output: 1

If I change all bool to unsigned int, output is: *4*.

So, conclusion is compiler doesn't squeeze the size less than
native size of the datatype i.e., if we changed all members to
unsigned int:1, 
total width = 4 bits
padding = 4 bits

Therefore, total size should have been = 1 byte!
But since sizeof(unsigned int) == 4, it can't be squeezed to
less than it.


> bool x:1 has the advantage that anything that is not 0 is considered true.

Yes, implicit conversion rules for boolean.

> So for bool x:1, x = 4 is true, while for int x:1, x = 4 is false.

Well, int x:1 can either have 0..1 or -1..0 range due implementation
defined behavior as I said in the previous reply.

If you really want to consider negative values, then make it explicit
using `signed int x:1` which make range guaranteed to be -1..0

Regardless, integer conversion rules will kick in.

> But the :1 adds instructions, so at least for only one bool, where little
> space is saved, it is probably not worth it.

True, we should reply on a promised guideline rather than possibility.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
