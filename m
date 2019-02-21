Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF59320818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/+zw7sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfBUVke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:40:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42059 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:40:33 -0500
Received: by mail-ed1-f68.google.com with SMTP id j89so77330edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U6umnKcmrpvh6pr+wrq8JquzEl64oVuliEyZreit8ho=;
        b=V/+zw7sRLrqtJxUPyvxNb8MKQsG2pYQGlbLh5rUxJQAR2/0Y0Wh7OzdkUXlN8ltfaD
         MCi7PFUTlM6tgdnda2uupDUq5TqIJnW/OwnvjE+ec5euqPHx24tHCKzzGJPeLcbNpEHZ
         BEex63cUbrVXiKGRWvC8pLmoCGzej0NDpsKi21cCTgdyIXcz4fqjFFXtv5E5o17yJMpq
         T4ptRaFBG0w4aiahaEqIf82ww2rWf7Xp94Tf3LRzLgA8B+CuZfETCSz24jBsVsW8hRoe
         LAWl61Oq9YaMwWELVIrp1gz2V1nZrpQPEISAoREKmN2+MDiNBJnVUormmg6z6SNBCFi7
         3lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U6umnKcmrpvh6pr+wrq8JquzEl64oVuliEyZreit8ho=;
        b=YrSzapP9+mNyCVgRFwKhQu9pL0QAmDTmlH9xOYqRn1Che2hJlvqq5zTQyDaIsgaiNB
         IW4XVHZvMxD6ZMOrSjlgAvECPMWjeBTfHx//7c17z5VYm0f4YNRYVZCh8yRF15BRvG2y
         llpdDSbQ2r8j0xN+CJSAJ0Q/Uo/bjQJ1kHW7ZrZNL1gkgPmyytoniZbIqHI+200s2LoR
         jRqbeylKFXfB5I3wyAraeM5LUtCnLQmAgEABAZr7XkVn6Bg6nPEqK3TGfPMMkat3ozDa
         BF6gVwl7lxVjOTMSlwYpPBkjVkiuxnlCKEAbQFEbNE10fYFW+tEsMu4J2K4vzFokkw/T
         d0qw==
X-Gm-Message-State: AHQUAubtXhTzLZjBhYQRS2Wxb4c6nk7rlbDe6w+S5hh1JFW/dryWNW6U
        VMwMmv/hluWJS6vqH22wRBs=
X-Google-Smtp-Source: AHgI3Ibb7+mt/4l+lgojp/7/oTKoJrf98ow7LaCXjFPIfShGaFH43RfU1zrj7DaqtU+40xAnBfG1iw==
X-Received: by 2002:a50:86ce:: with SMTP id 14mr504217edu.33.1550785231958;
        Thu, 21 Feb 2019 13:40:31 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e21sm467edb.27.2019.02.21.13.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 13:40:30 -0800 (PST)
Date:   Thu, 21 Feb 2019 21:40:30 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [driver core] 570d020012: will-it-scale.per_thread_ops
 -12.2% regression
Message-ID: <20190221214030.niwvh3xjlioi3myd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190218075442.GI29177@shao2-debian>
 <20190219005945.GA16734@richard>
 <20190219121904.GA24103@kroah.com>
 <20190221031049.GE28258@shao2-debian>
 <20190221071023.GA28637@kroah.com>
 <8736oh1uf5.fsf@yhuang-dev.intel.com>
 <20190221073510.GA17369@kroah.com>
 <87va1dzgpj.fsf@yhuang-dev.intel.com>
 <20190221083926.GA7834@richard>
 <20190221091217.GA18701@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221091217.GA18701@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:12:17AM +0100, Greg Kroah-Hartman wrote:
>On Thu, Feb 21, 2019 at 04:39:27PM +0800, Wei Yang wrote:
>> >>> I don't think this is an issues of struct device.  As you said, struct
>> >>> device isn't access much during test.  Struct device may share slab page
>> >>> with some other data structures (signal related, or fd related (as in
>> >>> some other test cases)), so that the alignment of these data structures
>> >>> are affected, so caused the performance regression.
>> >>
>> >> But allocation of a structure should always be "properly" aligned, no
>> >> matter what something else did in the system as that is what kmalloc
>> >> ensures.  If not, then we have problems in our memory allocator :)
>> >>
>> >> So something is odd here, but I don't think that is it...
>> >
>> >If all these data structure are allocated with kmalloc() instead of
>> >kmem_cache_alloc(), then my guessing above seems incorrect ...
>> >
>> 
>> Seems we don't have special kmem_cache for device and device_private.
>
>Nor do we need one :)
>
>Remember, 'struct device' is included inside lots of other structures
>already, it is not very often created "on its own."
>

You are right, I get your point.

>thanks,
>
>greg k-h

-- 
Wei Yang
Help you, Help me
