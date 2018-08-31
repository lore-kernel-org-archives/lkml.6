Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751FDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E6F20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TopJtve0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E6F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeIAA2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:28:22 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:38002 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIAA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:28:22 -0400
Received: by mail-yw1-f41.google.com with SMTP id n21-v6so5489035ywh.5;
        Fri, 31 Aug 2018 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vk6eJaICnaGPvd/ak8gSgiTZzuoqUM/6teuv/tKzh+w=;
        b=TopJtve0M1jk2OYvgWWQBfCKtk+Fv0HLw7ge+DUSAoydFXq3v2J0ZbIEdj14OOcy8W
         /0fH5/sNsnEQlGv9d8+kgosmxRSNMJzyfaJpOHI5yf35vx4blaxsaFV6E9x8xGCjN8qO
         HXj1OG0Ox5r/j3O0djnSnz1x98dA6+EkuyVg//C1wPReRDp9YPE9vn5dNcmE17eR5fzG
         /d7ri0mHHyRPOZCzYMnmNvGmyC46HT+FZVZmOsVYzIB0h/TS05yy8m9R70FuVGVDyBUU
         +uzN4iiPIFES0Bo7AXF+/F6uT8VXgQH6uLuHq7lxeZtySmEXFeRFIHpynmlhFalhx/1N
         6WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vk6eJaICnaGPvd/ak8gSgiTZzuoqUM/6teuv/tKzh+w=;
        b=GEDfI/orCzqNezJ0cYFMPAPpWdagSrEOjss+3qvrcRQQ/tY+QnThe9Da8yU4Wp6sfN
         Um9sDthtAX21b5QQ11ifciDSIlIYbyQ7FklwaLroKfl+REeZF3E+qxtzaPOoSuJGKwVb
         TKy/WpkSjreeuNgiCCIAwTTlLxyP9WD/a8ps5hoxc68tcqFibRlvT+Ak0l5SqXZjlhRh
         HO2tFb4A+eFOZE25yZpWouLQg1g33DOws7sHSrZXPHjN/CrqpwYq0DOqqm4v2hpisNlV
         bbblVcV+sSZHQ1xMZy1k9umu0RIufEABu30tetm1KUpWwYEkzsbTS0utGHfnfCeKrGIH
         eOZA==
X-Gm-Message-State: APzg51CoX/iZ5nBhxg+03KcdxTPVweM6qNBFmWky4BrBC+t5/4GNzxFY
        2UleT0g3/3cgLVZJizDrzGw=
X-Google-Smtp-Source: ANB0VdZSKuFvRZLTVXtFWUL+wGq6F3WAiKwDjD+gz/RZnlVpDYxFq5MyjNDoGimEYPNVl+Pmy5fizw==
X-Received: by 2002:a81:83c5:: with SMTP id t188-v6mr10015697ywf.224.1535746756557;
        Fri, 31 Aug 2018 13:19:16 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:ae4b])
        by smtp.gmail.com with ESMTPSA id o193-v6sm5153332ywd.84.2018.08.31.13.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:19:15 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:19:10 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 02/15] blkcg: delay blkg destruction until after
 writeback has finished
Message-ID: <20180831201909.GA20194@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-3-dennisszhou@gmail.com>
 <20180831152705.4mjm7xo6jq7ptdqn@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831152705.4mjm7xo6jq7ptdqn@destiny>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

On Fri, Aug 31, 2018 at 11:27:07AM -0400, Josef Bacik wrote:
> So the general approach is correct, but it's sort of confusing because you are
> using nr_cgwbs as a reference counter, because it's set at 1 at blkg creation
> time regardless of wether or not there's an assocated wb cg.  So instead why not
> just have a refcount_t ref, set it to 1 on creation and make the wb cg take a
> ref when it's attached, and then just do the get/put like normal and cleanup as
> you have below?  What you are doing is a reference counter masquerading as a
> count of the wb cg's, just add full ref counting to the blkcg and call it a day,
> it'll be much less confusing.  Thanks,

Yeah, that makes more sense. I've switched to using refcount_t and
renamed it to wbcg_refcnt. The corresponding actions have been renamed.

I've also fixed the kbuild error in v2.

Thanks,
Dennis
