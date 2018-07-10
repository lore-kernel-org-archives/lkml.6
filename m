Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBE8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EB820BF2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3TgIVLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EB820BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbeGJTNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:13:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36888 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbeGJTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:13:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so7258981ljk.4;
        Tue, 10 Jul 2018 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ggW1R3iMgkA9CS8e7IhJg5iSjttFX5GWOBFUTrbHqWA=;
        b=D3TgIVLLU9kUzf8wIe4sukhJ48i1jcbphoe4gCfbNl5bU8tQXiqVejIEThR5rM36Rs
         7vwzIQBOiCKUcFl6bqDEYP0tCzIoMNs26hGXd4T94tJ0vwneG8TzqFLf9Ic5PXRKzyuJ
         wQzZJM3MeTpKQThZ5rv18DYeodtf0mTaUlD278mFnAfop0O+4EtaBJdR/gmIX735hsGY
         0LL20tFQCX4AhzbW2MsVHYpfwz//HISv2C3vaXWs5MPlzB73L2L40EOl0U0fBYzQtJCh
         h4ba7EOnwKxT5YxO6YseGwa1dB3fuVj1yfpvsGCo8bTr/IOzNwKIMKl4OkjxSftyGl1C
         mEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ggW1R3iMgkA9CS8e7IhJg5iSjttFX5GWOBFUTrbHqWA=;
        b=GvVXfYWDHT02uDYY8K/iv1B6a03Ac7ZR4Vy+n5ih0Yt1PtiJe/iumKj3WG/+fKrnrm
         wD+PQ7NG5x0/r7JcEFU8ZAQ+9nCE8oupujkGvAOM9tj2HyEjIv2SNOtkTthfx/8RBDXS
         3/QrHJmyCus3E5XXFPomTfdz1CLvWfVj8UUYbS0TQykjBSLtcCVR6UpsUQFh7YdK41JA
         tnxDgWA8W2moVjdmmHUjFUfEIq0lM8S4+QFa3AnWTVWQGL55GMzaiH1uL170/yU+0WFG
         xrtoypHvEpykyV/2MMJHDLKRGWYnNzmPdCP3oYZh+O7GdxPUK13xn3E5wrPwLJJTVv+J
         2Skw==
X-Gm-Message-State: APt69E1J8S+y8OU9Fw9QS+KGxzSxFS8cMyokDCxj7i2ccMIwbJmHO/Z3
        dMWXllCrHFZMDmc/VimiD2U=
X-Google-Smtp-Source: AAOMgpe66n6hJzTIsXijXn6IrULUyPYwMe9FLvMX5TeVwxhkFml4pLvDrytflut8Rq05I0Jv1Nux4g==
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr15213961ljj.80.1531249987719;
        Tue, 10 Jul 2018 12:13:07 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id p20-v6sm2875063lji.37.2018.07.10.12.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 12:13:06 -0700 (PDT)
Date:   Tue, 10 Jul 2018 22:13:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180710191354.GA32182@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
 <20180710074815.GA30235@mobilestation>
 <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:59:40AM -0700, Paul Burton <paul.burton@mips.com> wrote:
Hello Paul,

> Hi Sergey,
> 
> On Tue, Jul 10, 2018 at 10:48:15AM +0300, Serge Semin wrote:
> > On Tue, Jul 10, 2018 at 09:15:17AM +0200, Mathieu Malaterre <malat@debian.org> wrote:
> > > On Mon, Jul 9, 2018 at 3:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > Adaptive ioremap_wc() method is now available (see "mips: mm:
> > > > Create UCA-based ioremap_wc() method" commit). We can use it for
> > > > UCA-featured MMIO transactions in the kernel, so we don't need
> > > > it platform clone ioremap_uncached_accelerated() being declard.
> > > > Seeing it is also unused anywhere in the kernel code, lets remove
> > > > it from io.h arch-specific header then.
> > > >
> > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > Singed-off-by: Paul Burton <paul.burton@mips.com>
> > > 
> > > nit: 'Signed' (on both patches)
> > 
> > Good catch! Thanks. Didn't notice the typo. Should have copy-pasted
> > both the signature and the e-mail from another letter.
> > 
> > I'll fix it if there will be a second version of the patchset. Otherwise
> > I suppose it would be easier for the integrator to do this.
> 
> I've fixed this up & applied these 2 patches with minor tweaks to
> mips-next for 4.19.
> 

Great! Thanks.

> However FYI for next time - you shouldn't really add someone else's
> Signed-off-by tag anyway. The tag effectively states that a person can
> agree to the Developer's Certificate of Origin for this patch (see
> Documentation/process/submitting-patches.rst), and you can't agree that
> on behalf of someone else. Generally a maintainer should add this tag
> for themselves when they apply a patch.
> 

I'm sorry if it seemed like I added Signed-off on your behalf. I thought
the Signed-off also concerns the ones, who participated in the patch
preparation. Since you suggested the design of the change, I've decided
to put your name in the Signed-off tag. What shall I use in this way
then?

> Anyway, I think we should reserve the Singed-off-by tag for patches that
> quell fires. ;)
> 
> Thanks,
>     Paul

Regards,
-Sergey

