Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B71C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5981A26115
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="f3dRkncY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5981A26115
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965466AbeF0OQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:16:03 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33921 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965341AbeF0OQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:16:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id n96-v6so1695749lfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IY3W5P1fTbs2TJllrkAsNvoxS3ZPlZJfBSo3HYJdRNo=;
        b=f3dRkncY9iORXE3VOq3TbS+hRBYrRB564HV4amttZRm+cRo4slFcnUaRbk8omA4aN5
         ql9YLbqPFfgaK7ABCJTmDgapsf9lWmJ6KW30uJZbgnXyciWzn5/7OCoCRuKTYV+N+0C+
         fPayHm66D7/nFvMtdSGXp874Xb1k2rCBPNfbPYoEKxrQhK1/ETDkyTf+8FaSqICDzEpn
         RCwF+GM3zptkHEjEbdDmOXbeWrBnKnDKGQgA+1xa0myufYfusSGVp0PRyNLnQLbKjnqB
         msPvInLUCnIVLk6v0G4ogr8nEHZHTzfa8Aqm0nSfUuw08WpmAcFIpjNkoePjHOeCeH6h
         NTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IY3W5P1fTbs2TJllrkAsNvoxS3ZPlZJfBSo3HYJdRNo=;
        b=iVTr8cGNOmln01yU5Ot1uUExxAwK7YZWgpTRND7oeObkOTKfq/uYkQGlEKImvB67NM
         BdCJlE7bCL6VWwqvJVw+wy5UvR+HFEeyA2bIdKqrkyx31aPbtvK6aswykRFP1p0q4RhL
         dtAr5XVpTkwS7cKz+QOIBJ/ggfogRaAj7AONy6NCI3+5PkS4GWyYVKtNTxiwLjC4atVl
         x02PNQ3ioMJ75xqVVF4Bz2i6OgUk1SkcokZriFaCyL5/+tcQB5/MJMzDm+STUW3QfaGY
         LsQ+wDJo2J2x5O3+gtfSqqzLzjm/6ieMJWoJGK1wXWB81KE8l7qLLY5FhSvUFRmn59OM
         jXeg==
X-Gm-Message-State: APt69E2uD1ZsfXxhipADp3g7FEWTm+bXWpRYPDkEdzmCBobvBHfWytXw
        uGhUc7BezyyZ1+Ec30GRHFgT4Q==
X-Google-Smtp-Source: AAOMgpffuPMF251sW0HnJb9PY/32FaMmWY9isdTA9xVIsUvNhMR4JqV8wOa0iZrTSskQuYN8NmTIlw==
X-Received: by 2002:a19:6801:: with SMTP id d1-v6mr3957197lfc.138.1530108959172;
        Wed, 27 Jun 2018 07:15:59 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n9-v6sm873283lfb.7.2018.06.27.07.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 07:15:57 -0700 (PDT)
Date:   Wed, 27 Jun 2018 07:15:45 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ARM: uniphier: fixes for v4.18
Message-ID: <20180627141545.ux2nzpgqxunhdcpb@localhost>
References: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
 <20180626174215.spnsyfqh5wk4tzep@localhost>
 <CAK7LNATHQMSNV0HoHNm-Lnha3oz7z5fd=iUPcufC0L-AuK9BZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATHQMSNV0HoHNm-Lnha3oz7z5fd=iUPcufC0L-AuK9BZg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:51:43PM +0900, Masahiro Yamada wrote:
> Hi Olof,
> 
> 2018-06-27 2:42 GMT+09:00 Olof Johansson <olof@lixom.net>:
> > Hi,
> >
> > On Mon, Jun 25, 2018 at 11:13:04PM +0900, Masahiro Yamada wrote:
> >> Hi Arnd, Olof,
> >>
> >> Please pull some fixes of ARM UniPhier platform.
> >>
> >>
> >>
> >> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> >>
> >>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> >> tags/uniphier-fixes-v4.18
> >>
> >> for you to fetch changes up to 4e62893c25bd3d5758058e15958364df3ca15fbc:
> >>
> >>   arm64: uniphier: select RESET_CONTROLLER (2018-06-25 23:00:31 +0900)
> >>
> >> ----------------------------------------------------------------
> >> UniPhier ARM SoC fixes for v4.18
> >>
> >>  - add missing cooling device properties for CPUS
> >>  - fix widget name of headphone
> >>  - select RESET_CONTROLLER
> >
> > It's unclear to me what the severity of these fixes are. and I think the
> > headphone widget name is the only bug that's causing problems for someone using
> > this kernel, is that correct?
> 
> Right.
> The others are on the boundary.
> The criteria on those is different by maintainers
> because some pull and some do not.
> 
> 
> > If so, it would also be useful to get a "Fixes:" tag for it, seems like it
> > should be:
> >
> > Fixes: fb21a0acaa2b7 ("arm64: dts: uniphier: add sound node")
> > Care to resubmit with just the bugfix? Or, if it's easier, I can cherry-pick
> > just that fix at this end and add the Fixes line. You should queue the other
> > patches up for 4.19 and include in those pull requests.
> 
> If you care to cherry-pick with Fixes: tag,
> that would be good.

Great, done now -- cherry-picked "arm64: dts: uniphier: fix widget name of
headphone for LD11/LD20 boards" into fixes.


-Olof

