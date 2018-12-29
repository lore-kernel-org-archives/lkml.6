Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D696C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DDD20869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546097774;
	bh=1QOBIjHwuqyqeFAdYwNxE3NnN7HZn9IuvYV34VxiEAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mLVctcsmf0fQe84Rdt3vAkEHteBt4a63CQYiHm8HGuIEisNWTxjhERUVkT+U6MnzG
	 HpP4mPmYC5Qv8f1508LvJqXq/aj4myoBFUnKkW3rhIMm5szd7xlqqAz232nVpIjHir
	 ZrJ48pfWEuDDwnVnAxzeIEoLvMFPKtMxHq2VopDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeL2PgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 10:36:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34643 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeL2PgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 10:36:13 -0500
Received: by mail-io1-f65.google.com with SMTP id l22so6976020ioh.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4sel/3T2/lF15dciKVV5SWGlwGjyjWJ71iycbukrgBk=;
        b=gCdTmRF5pIv4FYeOUQ9p2QHI+oTePbYT26M5brLjMvzvMkZoTHfK0a2FDSZdYy1qHA
         +NNzkp3kNdGIRw70YjZaLduQzwS02ESOkD9hquQKZ3y3DKjj8JL/7h/IedeE19aWLrYb
         fKZ+coY4F9fIExb4jFfXwRP6az/Xp3rRkEjoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4sel/3T2/lF15dciKVV5SWGlwGjyjWJ71iycbukrgBk=;
        b=qbadNB/qU3lsDEOTAvHlW4vSdiZZtHWmeY+gDOhYgD0oiU/1z1hnjk0M7NSRmhcHoN
         EFEQxbPP+NYl/pPcpmHDBtq97jrFizoUdTbNFft1ZNSndNkAyT7JCZ9pGtGe8+6RdXNy
         Pz41zw+cDO4Fp+SSBTRddfMeZyW1crDyhfAqFeMWFwAkS88Oscuw5jzW+4UJ/9BBMdMA
         2wT37cHg9sAgW+MdIj+6VWgV6tN67Jc2rsHMep3J9UKHFwajbxa+iIdsIh9kc3LE5eup
         Kz3fU2uvdGkYb0DvN516Hka6hTdZrl37rZhrkVtaMcqzDZ8yhGmCvyfzALRkL8gM+Q8g
         AfoA==
X-Gm-Message-State: AJcUukd0NCDmRAOI2Xo3B4v6HUbckykYrL6Zop6VvN2iK3muczWV7c02
        yJyIU+N/sWv7oS3vwA2SXN3Yu04/oWZyHE6T
X-Google-Smtp-Source: ALg8bN6oZuZRKJi9WyEpN4fWQFOPF4eoZzDUkLvP0ccgtQzVVAzjiGoIfRgaCifa53+1jiCrTVAS2w==
X-Received: by 2002:a5e:a911:: with SMTP id c17mr20015961iod.127.1546097771851;
        Sat, 29 Dec 2018 07:36:11 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id 193sm2718108itl.19.2018.12.29.07.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 07:36:11 -0800 (PST)
Date:   Sat, 29 Dec 2018 10:36:08 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [GIT PULL] libnvdimm for 4.21
Message-ID: <20181229153608.GA21173@pure.paranoia.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
References: <4880b31d0d32c38a675048be903814a062907125.camel@intel.com>
 <CAHk-=wgMfBXdiaeAxYrdTq9VoaVgN26T8MU7+3EnvJP_e0byuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMfBXdiaeAxYrdTq9VoaVgN26T8MU7+3EnvJP_e0byuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 09:57:28PM -0800, Linus Torvalds wrote:
> Hmm.
> 
> This pull request doesn't seem to have gotten an automatic pr-tracker
> reply, even though I pulled it, and even though it was cc'd to lkml.
> 
> Konstantin, any idea why the automation didn't trigger? I'm not seeing
> anything all that odd about it.

As you've noticed, it's not on lore, and it's also not on any other LKML
archive out there (I've checked lkml.org, lkml.iu.edu, marc.info). So,
I'm not sure precisely what happened, but it would appear that despite
the CC in the headers, the mail never actually passed vger.

> Does lkml hate Dan?
> 
> Headers say
> 
>   To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
>   CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
> "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>

I wonder if vger doesn't properly process "CC" headers when both letters
are caps, but it's a very thin guess. As I don't have any access to
vger, I can't shed much more light on this either.

-K

