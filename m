Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B6FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEE820645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbIl3AQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEE820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeIGKYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:24:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:24:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so6394354pga.13;
        Thu, 06 Sep 2018 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wtqcbMNl0pf6NugApCz4YR3ywzHIzDsoFRlkHrnYNjA=;
        b=CbIl3AQJfZy3qP9Xu0OmT4l9apv2JA5DFCMM+9/MN+jbPlwPpeLPM1ucpqMnxOjs/1
         3kLrm1lVGAO8LDLmnExU7T1jG7gCNrnRE494KRpVChvSko9E7G/6qN8HGSH3ybbCFBwC
         IhRTbSlwvUJhGu18S9L0rDWJsO3WJnBO03lGsGmN3QGrBOmMJSOJfVpWCRaad0dfesPh
         dOdTPjuye0M63qkBHbwvRD7pLWlRJzbZ0gmKKu4h+Uw6/T3WBM/8ElsaE3JPvcNSIBmX
         sToHGxC7MGRyRyczsXYQ8KYJW/5V3a6EcXgP2WmhvFxnKYaqG1+pNSJ12wzmmBd+OxRR
         AYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wtqcbMNl0pf6NugApCz4YR3ywzHIzDsoFRlkHrnYNjA=;
        b=l0LjL7Fpaobb0Z8wfjaXWY4SaU2afPDBJSIQWffL+dCnndxDRF66dj3FX/UBEVDNIL
         6exLXkqrXmkY2AP5uOnBYDsQf555NWvzN22eMxYWRN7INGIC5zd60aDofIzJZsT8itNf
         mZi39ZluIqAwDkm+cpqs+0JKPivrcZkJqqzsq+uEOekHlTlwZ4jg/XLBNMw97LBsAWOr
         jXe2gR2uW9fMckGvpUOSESSU0Iw/0RNqbpZ6v+1+9TZCjjgg4UPjiFLO93zlYPaf/LeC
         awNDBZAfkI3JnYQNtBG2u1WbhASGXpTK6Uz+8+DRnS7ma54LQMKPy1vap++uq1aE8Sow
         OgCA==
X-Gm-Message-State: APzg51ApOMMLSjRhHxURZBg95S+LWLYziws+GkGqZF/ufyi3emRNtqxs
        jUjYeQ09czRFtlzBfB7IhmY=
X-Google-Smtp-Source: ANB0VdZmuYkmbwhKfIK84lTDCqDtauFmxOoYr8eVpW6iScXOXRotU+xbicRNg5jX/c5407vRjKhPjQ==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr6689809pfo.151.1536299123124;
        Thu, 06 Sep 2018 22:45:23 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:9bbd])
        by smtp.gmail.com with ESMTPSA id g66-v6sm9982760pfk.39.2018.09.06.22.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 22:45:22 -0700 (PDT)
Date:   Thu, 6 Sep 2018 22:45:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     sfr@canb.auug.org.au, Daniel Borkmann <daniel@iogearbox.net>,
        ast@kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20180907054518.jnnckempmerazwwh@ast-mbp.dhcp.thefacebook.com>
References: <20180907101923.4d2a85c6@canb.auug.org.au>
 <20180907002223.tpizglyhrwn26oox@ast-mbp.dhcp.thefacebook.com>
 <CAJ+HfNgRd5ztzwJ9HtgnrDyf8F0ykODY_EGC91d9KiAfDbhcXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNgRd5ztzwJ9HtgnrDyf8F0ykODY_EGC91d9KiAfDbhcXA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 07:21:05AM +0200, Björn Töpel wrote:
> Den fre 7 sep. 2018 kl 02:23 skrev Alexei Starovoitov
> <alexei.starovoitov@gmail.com>:
> >
> > On Fri, Sep 07, 2018 at 10:19:23AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the bpf-next tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this:
> > >
> > > ERROR: ".xsk_reuseq_swap" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
> > > ERROR: ".xsk_reuseq_free" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
> > > ERROR: ".xsk_reuseq_prepare" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined
> > >
> > > Caused by commit
> > >
> > >   9654bd10da60 ("i40e: clean zero-copy XDP Rx ring on shutdown/reset")
> > >
> > > CONFIG_XDP_SOCKETS is not set for this build.
> > >
> > > I have used the version of the bfp-next tree from next-20180906 for today.
> >
> > merge conflict and build error...
> > Bjorn, I'm thinking to toss the patches out of bpf-next and reapply
> > cleaned up version of the patches...
> > what do you think?
> >
> 
> Yes, do that. I'll get back with a cleaned up v2.

Done.

Unfortunately during interactive rebase that removed your commits git didn't
preserve merge commits that came after yours,
so Jesper's and Yonghong's cover letters are not in the git history.
Yet all patches are in the same order.
Explicit revert with trail in the git history would have been worse.
patchworks + git isn't the most convenient workflow. sigh.

