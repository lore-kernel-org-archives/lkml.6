Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E8EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2072082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdxLzXka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2072082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJaF2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:28:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33609 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJaF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:28:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id i15-v6so15222957qtr.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvVU6/4hfEVaWtqaOqNuHWJ/edwbT7cUJ+lxdx0olMA=;
        b=IdxLzXkaNfdilLzkRAChtXdvfeD7jrP+/ULzxFCiExZGrFThQMnOIfvDn6+ifHUeSk
         xItZ5bNNbKVtJikpSF+Bc5IrfozAH1zlAv/hAEmtPx8Ow3ks5C3Xlx59EKPTDxHfJYCn
         OINv7rsnMQBwkO63TT72n5PuM3b2AdVGvU6CdpHeVQsKvRmxb8RYpJ8QhKqbyGZlb4WO
         xtpqUaVb9ViOtidlAhidUaOuv1Aj/KXCsK/bTWhLTayAS2eLf+1Sp/iYK0xq1cEeN7iD
         tQS50UyE3c8WFYFgmJjY9PuY1s1Av1P5swNkKrToOzUUV7zmZH01eyT+1r9NG3EzjCng
         05pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvVU6/4hfEVaWtqaOqNuHWJ/edwbT7cUJ+lxdx0olMA=;
        b=n1qw7NojDdqwQge92c+dVQkAWqqCO9sC0tF9W0dM1TGIiX6GDIIClLfDxX9xmlmLO/
         IZqFg5nn4ddIq3Anw2uK0lLxuPeF9cw9Ut853rwaCjb56btb97iGrI4maQI6ymRWOxh6
         64wjdwSgsK8ysRgvb5U//y2IbvzZkwEvBAZBUAPHgQjQlHN4082m/edZYOGoqgfe20Mg
         rmbvnGfFN0SPixh0eKbiI2ImSthnZAv4zMRHR8rfYY5JPl+iQzRGquJb2CCy1AnxR2ZV
         kwA7Xoesa7lCujTh3w1jCxSxXBJjYm9Ed2EFyH/LsZnN9/QwQBeI3TrACfBZ4RNQ3L0+
         pvIw==
X-Gm-Message-State: AGRZ1gINcyvVZk3oh54cHANiGv9kw671plhwJS9JnczT3XjZfdU+RYFX
        zBZr3WMVfkArHDayznrkBfw=
X-Google-Smtp-Source: AJdET5fi79O5rW0jNl7sYqvOIGZ0I7w0PX3+PTV7ir2ksOIwhlAccAjCsc1gvAUIsmR+6+uzDPcy8Q==
X-Received: by 2002:ac8:4419:: with SMTP id j25-v6mr208110qtn.243.1540931618671;
        Tue, 30 Oct 2018 13:33:38 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f75sm1788546qkf.96.2018.10.30.13.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:33:38 -0700 (PDT)
Date:   Tue, 30 Oct 2018 17:33:33 -0300
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [RESEND PATCH 2/2] staging: vboxvideo: Use
 unsigned int instead bool
Message-ID: <20181030203333.2eh7hcpcndukjs52@smtp.gmail.com>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com>
 <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com>
 <20181026204225.GH2015@sasha-vm>
 <20181028075209.GA1938@himanshu-Vostro-3559>
 <alpine.DEB.2.21.1810280932030.2450@hadrien>
 <20181028112011.GA5157@himanshu-Vostro-3559>
 <alpine.DEB.2.21.1810281243420.2433@hadrien>
 <20181030201816.joihhwd7htgixo5i@smtp.gmail.com>
 <alpine.DEB.2.21.1810302122290.2949@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810302122290.2949@hadrien>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Julia Lawall wrote:
> 
> On Tue, 30 Oct 2018, Shayenne Moura wrote:
> 
> > Hi,
> >
> > > On Sun, 28 Oct 2018, Himanshu Jha wrote:
> > >
> > > > On Sun, Oct 28, 2018 at 09:47:15AM +0100, Julia Lawall wrote:
> > > > > > The "possible alignement issues" in CHECK report is difficult to figure
> > > > > > out by just doing a glance analysis. :)
> > > > > >
> > > > > > Linus also suggested to use bool as the base type i.e., `bool x:1` but
> > > > > > again sizeof(_Bool) is implementation defined ranging from 1-4 bytes.
> > > > >
> > > > > If bool x:1 has the size of bool, then wouldn't int x:1 have the size of
> > > > > int?  But my little experiments suggest that the size is the smallest that
> > > > > fits the requested bits and alignment chosen by the compiler, regardless of
> > > > > the type.
> > > >
> > > > Yes, correct!
> > > > And we can't use sizeof on bitfields *directly*, nor reference it using a
> > > > pointer.
> > > >
> > > > It can be applied only when these bitfields are wrapped in a structure.
> > > >
> > > > Testing:
> > > >
> > > > #include <stdio.h>
> > > > #include <stdbool.h>
> > > >
> > > > struct S {
> > > > bool a:1;
> > > > bool b:1;
> > > > bool c:1;
> > > > bool d:1;
> > > > };
> > > >
> > > > int main(void)
> > > > {
> > > >     printf("%zu\n", sizeof(struct S));
> > > > }
> > > >
> > > > Output: 1
> > > >
> > > > If I change all bool to unsigned int, output is: *4*.
> > > >
> > > > So, conclusion is compiler doesn't squeeze the size less than
> > > > native size of the datatype i.e., if we changed all members to
> > > > unsigned int:1,
> > > > total width = 4 bits
> > > > padding = 4 bits
> > > >
> > > > Therefore, total size should have been = 1 byte!
> > > > But since sizeof(unsigned int) == 4, it can't be squeezed to
> > > > less than it.
> > >
> > > This conclusion does not seem to be correct, if you try the following
> > > program.  I get 4 for everything, meaning that the four unsigned int bits
> > > are getting squeezed into one byte when it is convenient.
> > >
> > > #include <stdio.h>
> > > #include <stdbool.h>
> > >
> > > struct S1 {
> > > bool a:1;
> > > bool b:1;
> > > bool c:1;
> > > bool d:1;
> > > char a1;
> > > char a2;
> > > char a3;
> > > };
> > >
> > > struct S2 {
> > > unsigned int a:1;
> > > unsigned int b:1;
> > > unsigned int c:1;
> > > unsigned int d:1;
> > > char a1;
> > > char a2;
> > > char a3;
> > > };
> > >
> > > int main(void)
> > > {
> > >     printf("%zu\n", sizeof(struct S1));
> > >     printf("%zu\n", sizeof(struct S2));
> > >     printf("%zu\n", sizeof(unsigned int));
> > > }
> > >
> > > > Well, int x:1 can either have 0..1 or -1..0 range due implementation
> > > > defined behavior as I said in the previous reply.
> > > >
> > > > If you really want to consider negative values, then make it explicit
> > > > using `signed int x:1` which make range guaranteed to be -1..0
> > >
> > > The code wants booleans, not negative values.
> > >
> > > julia
> >
> > Thank you all for the discussion!
> >
> > However, I think I do not understand the conclusion.
> >
> > It means that the best way is to use only boolean instead of use unsigned
> > int with bitfield? I mean specifically in the case of my patch, where there
> > are some boolean variables are mixed with other variables types.
> 
> To my recollection, your code had a bool with larger types on either side.
> In that case, I think bool is fine.  The compiler it likely to align those
> larger typed values such that the field with the bool type will get more
> than one byte no matter what type you use.  If there are several fields
> with very small types adjacent, there might be some benefit to thinking
> about what the type should be.
> 
> julia

Got it! Thank you!
