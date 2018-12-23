Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56DDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AB3218E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmDjNSDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLWGAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 01:00:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43129 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLWGAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 01:00:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so4349439plb.10;
        Sat, 22 Dec 2018 22:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xkeNC/WgAPsBcdSYhx6nWUmkzC3i/9ncsk3/Hq54w8Y=;
        b=BmDjNSDzl+tzGkBekBdsZspUB/+mdzGos3VwNzSfhpnkEgr640hjgYR+kQJlsNUHwN
         zMegr8P3GhM3Xcebth5Bsh8W1Cscb6ayBZ60ydgQOE66diQAsAuol5LIvPBpyQyeWIie
         JUwZSinzeRiIONB2NqOmYjZXB4LPjLkePZTqBUnmz9n2cclyWTSbfUbHl4pQClN0siCj
         FR6h2d+FY+VoiRomI/NcvyquQQb4DXs9YVq0brm9VkihokC4HHHJGQbraowe7z9mVwK3
         5/Kjia9jVPp5/MajQVhfOvj0g8Zx5V3YNk3OHYPYG1Mp673lbBMdujBgSVgEGQkgocBA
         kFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xkeNC/WgAPsBcdSYhx6nWUmkzC3i/9ncsk3/Hq54w8Y=;
        b=f63G4pmz8shWox5XT9d79oy9Qw7QqPm/QmT/YeLzPyXR+RJIlr0bws2R3j9lxJ1L6a
         x88MgxaGBjPInti9xcaYF7Qq8PYB0P1qs2sG3YM88uMHA7wtq30aq47tYgKwqBlVZViR
         ZGdvAZrLMEU8T0L1TrZ3WXaXQoCO4cjYGCy/xOzsJFl5Kn3j3buUQj6aiCEV2P5qdL1+
         pGSx7tGqYwWN8I2f+Jcy72rCV/9ft4SX3tNDLBQDamXs/AJUlLj6BxroJk69iLHukCuy
         xAvihqdfgOdYOMJk4ZO72kAuGMOznU6cqmgSyPO7dosoaGSSjiBkQDZJFxcTmGOA23Xk
         TCIw==
X-Gm-Message-State: AJcUukd1Mm6mSgSCPvSZPYTlbXIQXfcjPP/GGdF/fSkH0+ChsVNexK5F
        cWgZ8eeOzC6Yb+j9kEPqTx8=
X-Google-Smtp-Source: ALg8bN6cRME3dk8dkhYXbUECgzCzgYoZeWew+MEdFa4h3/PI4H18qe6rmLLI8wkVXFirUtHCUMYUKw==
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr8740774plg.314.1545544803410;
        Sat, 22 Dec 2018 22:00:03 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:774f])
        by smtp.gmail.com with ESMTPSA id h9sm39639772pgd.53.2018.12.22.22.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 22:00:02 -0800 (PST)
Date:   Sat, 22 Dec 2018 22:00:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Miller <davem@davemloft.net>, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
Message-ID: <20181223055959.jlzbyd5ec55thiz7@ast-mbp.dhcp.thefacebook.com>
References: <20181221204901.GA30045@embeddedor>
 <20181222.150722.1493687829239836271.davem@davemloft.net>
 <20181222235952.keue7a336sg7jfim@ast-mbp.dhcp.thefacebook.com>
 <20181222.184051.718127928973898182.davem@davemloft.net>
 <e1c8e69b-3417-6176-6b49-1b7a23febb21@embeddedor.com>
 <20181223030039.wrpytx7pwfcljdjm@ast-mbp.dhcp.thefacebook.com>
 <37df17ba-7fcf-ab04-fe9a-d2a6fc5b6b9c@embeddedor.com>
 <20181223041253.bxqru567rs32mecg@ast-mbp.dhcp.thefacebook.com>
 <e8343bfd-7846-a23b-b6c0-4b82218efdc0@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8343bfd-7846-a23b-b6c0-4b82218efdc0@embeddedor.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:03:31PM -0600, Gustavo A. R. Silva wrote:
> Alexei,
> 
> On 12/22/18 10:12 PM, Alexei Starovoitov wrote:
> > On Sat, Dec 22, 2018 at 09:37:02PM -0600, Gustavo A. R. Silva wrote:
> > > 
> > > Can't we have the case in which the code can be "trained" to read
> > > perfectly valid values for prog->len for quite a while, making the
> > > microcode come into place and speculate about:
> > > 
> > > 1013         if (flen == 0 || flen > BPF_MAXINSNS)
> > > 1014                 return false;
> > > 
> > > and then make flen to be greater than BPF_MAXINSNS?
> > 
> > Yes. The user space can train line 1013 to mispredict by passing
> > smaller flen N times and then passing large flen.
> > Why do you think it's exploitable?
> > 
> > Without the patch in the mispredicted path the cpu will do
> > if (0 < flen) condition and since flen is hot in the cache
> > it will happily execute the filter[0] load...
> > and about 12-20 u-ops later (depending on u-arch of cpu) when
> > branch predictor realizes that it's a miss, the cpu will ignore
> > the values computed in the shadow cpu registers used by speculative execution
> > and go back to the 'return false' execution path.
> > The side effect of bringing filter[0] value in L1 cache is still there.
> > The cpu is incapable to undo that cache load. That's what spectre1 is about.
> > Do you see how filter[0] value in cpu L1 cache is exploitable?
> > 
> 
> In this regard, the policy has been to kill the speculation on that
> first load (as I mentioned in my last email. It is also mentioned in
> the commit log for every patch).
> 
> > I took another look at the following patches:
> > "net: core: Fix Spectre v1 vulnerability"
> > "nfc: af_nfc: Fix Spectre v1 vulnerability"
> > "can: af_can: Fix Spectre v1 vulnerability"
> > and I have to say that none of them are necessary.
> > I'm not sure whether there were other patches that pretend to fix spectre1.
> > 
> 
> It's not about pretending to fix it. It's about trying to prevent the
> conditions that can actually trigger the exploitation of a potential
> vulnerability.  The code is not always the same, it changes, it evolves,
> and we are currently trying to catch that first load (that's what smatch
> does in all these cases) that could eventually lead to an actual vuln.

in other words there is no bug and there is no vulnerability,
but there is a 'policy' set by ... ?
So hence Nack to the policy and Nack to the patches.

