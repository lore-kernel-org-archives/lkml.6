Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D550C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B5921479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DhDTP8Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B5921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbeKVDsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:48:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39585 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKVDsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:48:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so106661pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wZU2JlaJVaizi+YogbOmhj9V/xA7N6YmVJJKWvdYkLg=;
        b=DhDTP8PcRIyFTHqRevHOXUs7V1SnHyoRnlpZoZV8sFtqjGvjjVYVPu95MkE278B/jY
         LTwUGCqfmz6xrCI/gBfIUFuwpmRZLGyab2jX5WXoEruZ73Sn1rwRCKV4d6E4RJDxmYId
         hHbT5HY3JxZk1F3QwTL2YYNKX/e0HgsYDMkbzCSIwQbMbTxZ/uQeWMX4i+37tAhq3FVf
         NzrZcWmIQ+2nfTokRwXx1viz2qSFofpeKRwxaS7q1xsErwi6vE+pVz0bt4aucRMaH9r5
         gLbwfRYaC+sbtIOonsISIAp/XNX1KlvedO7GJM9wOa0t4OX2w3ydV3Ena2uMucVuVrN0
         EH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wZU2JlaJVaizi+YogbOmhj9V/xA7N6YmVJJKWvdYkLg=;
        b=TQN66VtYSQwn1ujzPg0jNbn7WVsI0DW9O9Jyi11Dky+LJGFDN+uWx1lNshen+k29Qn
         lHVf5oEZtSqlDK6KBneKOy1fELAtxovQhySixpJscbZSMhVuLUuh8YMUY6JZgd6RQkug
         zl+iB5JtVL4TT7ok8p80EOQIqHPFlGjBxYqs47h73JGDYl4yYzWSPmRKxyR/XtxxR/xP
         rPVpklDuR8TRoXaKoVGoWyBvPIlbSkJbPs0U5amZKfpG7nafCSiKebzNnH4v443XZoIB
         7Wkp3GrFDTd4OyZj4FGvTfjHlH8boR4lLOZ7M4PHLpJJdqzFQyXPfBT5D712i+UuMu9e
         joIw==
X-Gm-Message-State: AA+aEWbg6qoqREPir6kmlhvWvf+JizhE/an8Q2B5kPWozInUhDN/ZerS
        +1hv+93WWBzVLYx8pdFVj6J6HOFFuf0=
X-Google-Smtp-Source: AFSGD/VTbs7A1NiN8JzSC3PvJRBv7k9h3KajF8O5PZB/c0TuBR3ctub+nELQzyJRqQT5eORp7m/JuQ==
X-Received: by 2002:a63:a611:: with SMTP id t17mr6685211pge.338.1542820377458;
        Wed, 21 Nov 2018 09:12:57 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m198sm53548818pga.10.2018.11.21.09.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 09:12:56 -0800 (PST)
Date:   Wed, 21 Nov 2018 09:12:56 -0800 (PST)
X-Google-Original-Date: Wed, 21 Nov 2018 09:10:42 PST (-0800)
Subject:     Re: [PATCH v3 2/2] proc: add /proc/<pid>/arch_state
In-Reply-To: <20181121095350.GC2149@hirez.programming.kicks-ass.net>
CC:     aubrey.li@linux.intel.com, aubrey.li@intel.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     peterz@infradead.org
Message-ID: <mhng-a16f4bfc-7c48-4829-9ce6-3ff8b3e1241b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 01:53:50 PST (-0800), peterz@infradead.org wrote:
> On Wed, Nov 21, 2018 at 09:19:36AM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 21, 2018 at 09:39:00AM +0800, Li, Aubrey wrote:
>> > > Also; you were going to shop around with the other architectures to see
>> > > what they want/need for this interface. I see nothing on that.
>> > >
>> > I'm open for your suggestion, :)
>>
>> Well, we have linux-arch and the various maintainers are also listed in
>> MAINTAINERS. Go forth and ask..
>
> Ok, so I googled a wee bit (you could have too).
>
> There's not that many architectures that build big hot chips
> (powerpc,x86,arm64,s390) (mips, sparc64 and ia64 are pretty dead I
> think, although the Fujitsu Sparc M10 X+/X SIMD looked like it could be
> 'fun').
>
> Of those, powerpc altivec doesn't seem to be very wide, but you'd have
> to ask the power folks. Same for s390 z13.
>
> The Fujitsu/ARM64-SVE stuff looks like it can be big and hot.
>
> And RISC-V has was vector extention, but I don't think anybody is
> actually building big hot versions of that just yet.

We don't actually have a vector extension yet, but there's supposed to be a 
draft out in 2 weeks.  The plan is that this draft will be sufficiently 
long-lived that we can start software implementation work.  While I don't 
believe it's intended that hardware implementations become available using 
this draft specification, these things tend to take a life of their own.  I'd 
be pretty surprised if we don't end up seeing hardware implementations of this 
draft specification.

I don't know if they'll be big and hot, though -- the whole point of the vector 
extension is that we can build chips that aren't that big or hot :)

On a more serious note, in RISC-V land we've attempted to make mcontext 
extensible and plan on shimming all the additional architectural state into 
there.  Thus, I don't think this interface is particularly useful for us.

I also don't like this "file full of 1s and 0s" interface, but it's certainly 
not my place to shoot it down.  In RISC-V land we're trying very hard to 
carefully examine any user-visible ABI to ensure it's something we're willing 
to keep around for ever, and this doesn't seem like something that fits that 
mold.
