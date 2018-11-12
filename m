Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1950FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7348223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wS0jPtct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7348223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeKMBsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:48:00 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35259 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeKMBsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:48:00 -0500
Received: by mail-yw1-f66.google.com with SMTP id w135-v6so4564094ywd.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r5C+dKXcwSZAzQOUrX1AKmtEGGonS4ljAod+QzwhprQ=;
        b=wS0jPtctkINZdfYY8Yn8YnjPZB9RMnRo+2qQAHSwB4RI5JMXGA5aQunWXZoC2wAKpO
         95dw/8cc4FIcQBfg4LfKJZUd7K/RRlAsMiEVfZfa12Q3HmfTbaqZWjWF61M9jCJIw9b+
         Dk61ET4VQwPqugp8Cr6Cj6j3BoSgPfIX45eyNQMZBe7ACyZVU34fTBlPqzoGuDcVdoFQ
         FbjQBj35p+LwjkFshVqkr4DtqMo8NuHJh++sPr74H52Y0EohT/XpTclKcsbXK4duEqam
         XrmQAQiiPOGK9JZg66GXTXrIWthTVejhYLBhxU+JwcqEHdbaX3O5fKLeKBYRqUOYh9uH
         exHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r5C+dKXcwSZAzQOUrX1AKmtEGGonS4ljAod+QzwhprQ=;
        b=XfQs1Uq1cVGwiJCvVUGljaZ3uV2l6NvmqusSEeVPHh//Ysnkty6BaXXqIeJbXQ5UuU
         Ljw8/q0HUrJTgC5Z2tcdbmh5PeRhGlrZ87JR91JcFpTnAofqeaQi6Tpg1X2pE2upLNXi
         +B6HNWZv8lp537q7gOmUvWTVwmvGB2CEMacbD+YCz6UE9GvVVQySGUw8L3ROhS3oYMX9
         70uoZPDqyVSrI69c+/1N8KF54gGmnz1DhGEKHIeMLu3hANcvReYyzcQUkowbiHMfCKDw
         LphvnOomQbyei3onZVokESCdBqLE8S4l07fQiNZFiB8rtTOQvP3Ck7dam8i7Bzk32d4P
         lnww==
X-Gm-Message-State: AGRZ1gI2Av7qKGRTM3W4Zlkwno7TE7DIUelzZmaODe1OF2K4HUbqkDfv
        qq//vV5bnzZeHrDsdi3G88Qk1g==
X-Google-Smtp-Source: AJdET5dVHxhGWE3gafxp+X9SirAauLK4/M9SfxUCPlodelO8aOEJ7VHE9Si2tq15rx+huJp/cXERlQ==
X-Received: by 2002:a81:256:: with SMTP id 83-v6mr1376248ywc.344.1542038049960;
        Mon, 12 Nov 2018 07:54:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s129-v6sm4548761ywc.41.2018.11.12.07.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:54:09 -0800 (PST)
Date:   Mon, 12 Nov 2018 10:54:08 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        lennart@poettering.net
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
Message-ID: <20181112155406.rtx7ze2l3gadmiyx@MacBook-Pro-91.local>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
 <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
 <e85cfae0-7743-8c51-c2c9-0855c26f868e@kernel.dk>
 <F0F86365-D4EC-43F0-AE13-CC8FA6CC3D97@linaro.org>
 <c665a05b-66fc-6b8a-fa73-1c76885053db@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c665a05b-66fc-6b8a-fa73-1c76885053db@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:48:35AM -0700, Jens Axboe wrote:
> On 11/12/18 8:45 AM, Paolo Valente wrote:
> > BTW, since this patch series is probably even more useful for older
> > than for future kernels, might it make sense to also propose it for
> > stable/longterm kernels (provided that such a possibility exists)?
> 
> That just not how things work, we don't put different things in
> older/stable kernels, it's strictly backports of what we have in
> current/newer kernels. Hence it appears to be a dead end right now.
> 

It may not be useful currently, but my plans are to do a scheduler agnostic
proportional io controller next, so having these interfaces unified would be
nice so I don't have to do a rqos.io.weight or something similar.  Thanks,

Josef
