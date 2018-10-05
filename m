Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D709C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05962087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcrRLn6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05962087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeJEWlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:41:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43496 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJEWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:41:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id r8-v6so11979363ljc.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffO0ddT/QwV8P0wfLFDM6hWi70lPxM74ciQCIUknNOA=;
        b=CcrRLn6Zd6CMc9aSY1W2Ap4ubS5IFpwTBszb5UiXbSNVcVVxMUgQK7ncOwBd9tZ6vu
         /HAASH2rUbLBqdrvU8Oki+I8gvJNS2lGtRlpOFAJt0c6dS5d71fdWR3UmaucohxWvaRi
         WSEJkdJ6jhF5tNT/2TVIVcZK8ixhYYdhSo4XcaudjPSVmegN7r7R3oJXiVoBvFgJtyer
         bYoxb9JlxoYCVEKUSfV3JG/GXKNi0e4vt2AhKvzG9pIxSDfwk5ne+g2YKAXxsrFA/PLC
         B+2lgpGSY+0rNtPWd2fA28yUK1Z7j+MtIoxh/L1+vietGyeK9zNBCQkTiiC3BCbY8kMP
         iI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffO0ddT/QwV8P0wfLFDM6hWi70lPxM74ciQCIUknNOA=;
        b=fW84pzLo9xmSg8QO5P5rD3JaOzdCsIBoJr8NBYMTaH40SnygcDCVzh+jTVuuqFyQgQ
         WTA5/p5kHDkduajPBWO6mDwSuaZKE0pNpyw/TSOgj2Ic+VlZMTbXbEQ5z+puLvRg65qy
         anJjD7vCYyj1yGd7vVEw3Jxvfu19OC6gyjCw7WJU4XfLa+kSvckEkX2Nj4DmxsudLwY0
         qC1hikkORz8bWh/1h7eA2sSPCppslomXgyrT7QTZJznCSTgXb7ec6T5L07ApsTE5bvqV
         8D3Y3IUNrq2aNoPKpFgw48Dt9wi4uq3UY+P4qrhGkiLAgDWTXgGKQU2eMY6ukG+Wjmmk
         886A==
X-Gm-Message-State: ABuFfogihEObylgcW2RpHYZbVRVKT8TLthbe8s87VOHJIYnHfAqiV0f9
        aRa/l94aNAXBjDsfp+lHGARC2qFTBLWLJ9M1stI=
X-Google-Smtp-Source: ACcGV60PesLIxumV/DGlkmthShcVoQjWuoymDXWDct9lPvPtirszyn4TguPkALkEWW7XOBnsQqaG/SXxaSJsbt9FldM=
X-Received: by 2002:a2e:6c0c:: with SMTP id h12-v6mr5428523ljc.112.1538754142967;
 Fri, 05 Oct 2018 08:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
 <20181004142942.11887-2-ricardo.ribalda@gmail.com> <20181005002125.12fd229f@bbrezillon>
 <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
 <20181005090811.6b7e9957@bbrezillon> <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
 <20181005103730.57d52e3c@bbrezillon> <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
 <20181005121235.7e64b64a@bbrezillon> <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
 <20181005172332.173791b5@bbrezillon>
In-Reply-To: <20181005172332.173791b5@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 5 Oct 2018 17:42:06 +0200
Message-ID: <CAPybu_3LxSuGm5F+=dgJvpLTpEZPDFsu8QEL3QdL=hzdMTGL=Q@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI again!
On Fri, Oct 5, 2018 at 5:23 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Fri, 5 Oct 2018 14:04:52 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Hi Boris
> > On Fri, Oct 5, 2018 at 12:12 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > >
> > > On Fri, 5 Oct 2018 11:54:18 +0200
> > > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > >
> > > > Hi Boris
> > > >
> > > > Just seen that  you already did the rebase at
> > > > https://github.com/bbrezillon/linux-0day/commits/mtd/physmap-cleanup
> > > >
> > > > Thanks for that.
> > > >
> > > > I am about to test it in real hw (unless you want me wait)
> > >
> > > Sure, go ahead and test it.
> > >
> > > Thanks,
> > >
> > > Boris
> > I had to change this on your patchset to have it working on hw:
> > https://pastebin.com/78A7yhJ9
>
>
> I pushed a new version to my branch. Can you test it? The reboot
> notifier bug should still be present, but I don't think this is
> something we introduced.

I will do it next week, I already left the office and this weekend I
have a big 2 year old bday party .

Have a very nice weekend and thanks for your help!


-- 
Ricardo Ribalda
