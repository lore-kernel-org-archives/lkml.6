Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4774C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759992075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpYKw5b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759992075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbeIGBXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:23:45 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45701 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIGBXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:23:45 -0400
Received: by mail-yw1-f65.google.com with SMTP id p206-v6so4596609ywg.12;
        Thu, 06 Sep 2018 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=615dcgvYagoVUaB+AgYoQbpcTQ8B8tOaJJYCjiBxilk=;
        b=cpYKw5b57qvqc0mnWpsXkj7AztK+R0aUxg8yy/Hbvb/Sw/MUepAmkYWeYdi1e9qS96
         9YcgWBUAGWZB8r+RTbfqnmuDhy3BqRlkrCDzPJwPrXlyVt/uDBj3njpcf0LK//f66aTZ
         Pbl3Ai1nHDhbKt0xpMglJmJKcxtB37Gu0EdD0E9Z95O8uZ7RmyD4RUMGwD65gTyWz2Yj
         uYJpJRyJEFfj4kUyzcEaVHiIETYNRRl3uANvbF+Pt8o0QWVovq9fB010pZyFW6WwXeqq
         E6d8E4U4WRL+gMRAP/oTflD0K5wHrvnzb8IlLJQOEwYFPsDTuPYRff4Ojigj9iSysgxw
         qtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=615dcgvYagoVUaB+AgYoQbpcTQ8B8tOaJJYCjiBxilk=;
        b=jNlMa3hNOggn2ZSPkiYUn6CpYYbYT9r5Goz9SQtN3yJElZy5BC8eUNQWcDIhq3OC54
         Gg6raGYYssBxEZFp/QPVq1/3pjlcnznvDaz6UiUs2KtAbT77v5t5XfcRX0ZyDZgrGmPB
         nRt3hgO++pw+I6neGZ6xfSCOW79lOrgKchi04RL6VuruAgZfIfHCICdP2RJhyJAVyqMa
         32EEP82OqoxCUAo8d3J1zrSHg0+BRbGSY23/49JXsU7/8MSU6t6Jl4fVzuHkZoq4688e
         9+W4JApHCqbmSHE2tRHuMPXM+RpaFo6sDLhasORVaf/AKLZfnC9joHWMkPWvB8vCDWXQ
         /YJA==
X-Gm-Message-State: APzg51DPoe+iRDqYB0yjav9LQJGHRlgXMP8f4QXac6Mx+98ECzxMM5p+
        yXUnuZq/aSvm8NzQrR7XAmY=
X-Google-Smtp-Source: ANB0Vda1VaYozs4YDonwzI+AHNK58xxmkFDDRSsTRzV9Bh5Jo+id8CvuPYautWJ90h8ZptA+TF/WAg==
X-Received: by 2002:a81:7282:: with SMTP id n124-v6mr2619092ywc.57.1536266793000;
        Thu, 06 Sep 2018 13:46:33 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:20a])
        by smtp.gmail.com with ESMTPSA id c126-v6sm2746520ywa.104.2018.09.06.13.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:46:32 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:46:30 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] blkcg: change blkg reference counting to use
 percpu_ref
Message-ID: <20180906204629.GD26048@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-14-dennisszhou@gmail.com>
 <20180901003159.GK1488037@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901003159.GK1488037@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:31:59PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 30, 2018 at 09:53:54PM -0400, Dennis Zhou wrote:
> > @@ -217,6 +240,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
> >  		blkg_get(blkg->parent);
> >  	}
> >  
> > +	ret = percpu_ref_init(&blkg->refcnt, __blkg_release, 0, GFP_KERNEL);
> 
> So, while this would work in some configs, you can't depend on RCU
> grace period inside percpu_ref.  blkg is now percpu-reference counted
> and rcu protected object - it has to explicitly go through a rcu grace
> period before release.
> 

Ah ok. I've made it into a call_rcu which should work.

Thanks,
Dennis
