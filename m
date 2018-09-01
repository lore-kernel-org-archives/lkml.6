Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B9CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418E42083A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx+AmDGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418E42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIAEjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:39:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36308 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeIAEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:39:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so6159259plb.3;
        Fri, 31 Aug 2018 17:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=StEz1mAJv0KzVZGP1EaarXGr3LePzazclN3Lxla0Mp0=;
        b=Gx+AmDGBv/s3qria3fxuFzM5YHMkloGdUQ+f0LNYy2qzNN30B5ctsJi/ZczOaKxzKp
         ol1RTToAh6Fj6/FRpNXItJchWh2ri4Ftfaqa40Rbk4yBilWli4TlVfNztJ9xCXSON6L+
         c07PuyyoWxI5+MUUVc+AZ04hbwysuksBfIomrhqMhqHOEKHT6v5HSmGR7Ei9Td5ptZOU
         EgLPpQtHnNw2ubvxx5HOYe8yQ8LFsyn6A4K7fkISn5mwMaQ8sr94jEhPPUk8qOEXNNwQ
         iQd/kqmzja5JV3czwd08abHbjFXZgAz5cKOz572pe6TTJ9OX30XWZhB7p3PB+y6HLX2v
         /+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=StEz1mAJv0KzVZGP1EaarXGr3LePzazclN3Lxla0Mp0=;
        b=F4Fawt6t4S5Hcg2uGesVnxZLHGUokkaK+HCXsyWhQHBAKJfHfV18ULmDo/ryNT4/ym
         cD3V+EEjz78K+nhCAW0jvpbB76AqWsd7Tv/LEXY9GMZSQRSHOf/TN4Frl15lDIs61H60
         ieMNtlBHqGV0ks242Y3Cymw3/7SjuIC6DE+NMkEq2+O9I8t7+fna/qXWo6IvcvBdk9JZ
         QP+Dce7offnrvOLsNVK6FyifKM3DiXNmblevnnOR4aaoqg53AfRkSgfU5OZoFokpAh61
         /SqlyR/ZWpqlCjefv2RRuluzsz+ODFPQ83bMiDQg/DYGO7aLjoPTTK4qPlz/XdSLJqqc
         vtpA==
X-Gm-Message-State: APzg51AXmW7zHKSrvRbeF92YcyoOIS18PrLwtn5lsukn85fhpwWCtV0+
        Jtfy3oQkS900VKATmpAPVcg=
X-Google-Smtp-Source: ANB0VdbLIb0C2HbaG5MWlp4s6C3ZDQ+rotzNg0vO6wVhQEC5Aw+AwpT8eVXM7uRwWIAVE/hlLZezEw==
X-Received: by 2002:a17:902:8b8b:: with SMTP id ay11-v6mr17533808plb.1.1535761743820;
        Fri, 31 Aug 2018 17:29:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id x4-v6sm14573522pfm.119.2018.08.31.17.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 17:29:03 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:29:00 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] blkcg: cleanup and make blk_get_rl use
 blkg_lookup_create
Message-ID: <20180901002900.GJ1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-13-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-13-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:53PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> blk_get_rl is responsible for identifying which request_list a request
> should be allocated to. Try get logic was added earlier, but
> semantically the logic was not changed.
> 
> This patch makes better use of the bio already having a reference to the
> blkg in the hot path. The cold path uses a better fallback of
> blkg_lookup_create rather than just blkg_lookup and then falling back to
> the q->root_rl. If lookup_create fails with anything but -ENODEV, it
> falls back to q->root_rl.
> 
> A clarifying comment is added to explain why q->root_rl is used rather
> than the root blkg's rl.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

We're replicating that retry busy loop a lot.  It'd be really great to
factor that out and document what it's doing.

Thanks.

-- 
tejun
