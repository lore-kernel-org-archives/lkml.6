Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E827C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31FF21A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lls9FstW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31FF21A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeHGFfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:35:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33043 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeHGFfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:35:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id b90-v6so5699703plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 20:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qpUHw5LDqEWVEKrCEXmmGfbhnHn6idCG8Din3tEi/lc=;
        b=lls9FstWpHU4uRx3EAyL3w2LqmxlO3xJZPzB/bCwIMWQ2hF1bnFLHi49YC145ZbNTc
         yGmgOKc5ggtcwvc1donDGUItN6Xh4jJv7ZY4+dmRMpsYgxKOySkAy7FTvjIsXFcO4Zrm
         q8RQkXFqczEib9QHHBCxlQUB6DNt4On+8y9ztjOqcUrsKkkvMnLoxWHfQsqs2oZhNPXN
         L6t39MxbRIpV5BlgTuNrDKJLaqbnfQJsL0+hUZ3lfhmkT1ei0c+A2n4bZyl7eoKTl69b
         x7KZ+d0/PNw3KErSqToKg+ZjVo8+OMSry0jfmdtBObKnSf6i4ZeZxh47Vl+8dB4Gmeq3
         7ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qpUHw5LDqEWVEKrCEXmmGfbhnHn6idCG8Din3tEi/lc=;
        b=pHknm5hNcp8Q1vY9sj91ZwsSQZlFhQ8MBsZMve8cTiJOZLu4vJ+7Ju8dI2sISAi2Gg
         LrMZ805tw6GQ8W2ATyXwO4BI0Gpt8uazMg5NRW8W1OO9Sc3e4pj9eftm1IMEJ6CsKt4j
         jzC+bYer035bijx4FpoVq2XdHzLdTaC0aKSktzlRMCxWphnUv5AJEUhT1OmQ8PfphX4P
         swSaERKHou2TCoErJGd6Dai2555QkYPXPC9DlzUBeLRkTnf6QD9TookyhYG1yZl37TGo
         9JKMDnE0AR9pjA22tKl6ntFTNmzK5INXXruJ1rA7juiju4K9l3fB1JGFc5NnNDHhA+3u
         vEOg==
X-Gm-Message-State: AOUpUlFTOb2CeruRHmj3ANyjp56R16HGZaRKaeMWtbKO89V9zmNFkLMB
        kJcxHX9XyeYyPSsiajbTDFTrIw==
X-Google-Smtp-Source: AAOMgpcmp/rjt9P55GkkDIOezAsdaHeHugtE+w6+MK3P2jxzZIeHbJS+K7u0DenGvKGovnl9vpzPOQ==
X-Received: by 2002:a17:902:4906:: with SMTP id u6-v6mr16170607pld.44.1533612191851;
        Mon, 06 Aug 2018 20:23:11 -0700 (PDT)
Received: from [100.112.67.156] ([104.133.9.108])
        by smtp.gmail.com with ESMTPSA id y86-v6sm234679pfk.84.2018.08.06.20.23.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 20:23:10 -0700 (PDT)
Date:   Mon, 6 Aug 2018 20:23:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com>
cc:     Hugh Dickins <hughd@google.com>, akpm <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        mgorman <mgorman@techsingularity.net>,
        minchan <minchan@kernel.org>, vinmenon <vinmenon@codeaurora.org>,
        hannes <hannes@cmpxchg.org>,
        "hillf.zj" <hillf.zj@alibaba-inc.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] [PATCH] mm: disable preemption before
 swapcache_free
In-Reply-To: <20180807101540612373235@wingtech.com>
Message-ID: <alpine.LSU.2.11.1808061936080.1570@eggly.anvils>
References: <2018072514375722198958@wingtech.com>, <20180725141643.6d9ba86a9698bc2580836618@linux-foundation.org>, <2018072610214038358990@wingtech.com>, <20180726060640.GQ28386@dhcp22.suse.cz>, <20180726150323057627100@wingtech.com>,
 <20180726151118.db0cf8016e79bed849e549f9@linux-foundation.org>, <20180727140749669129112@wingtech.com>, <alpine.LSU.2.11.1808041332410.1120@eggly.anvils> <20180807101540612373235@wingtech.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1084447320-1533612190=:1570"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1084447320-1533612190=:1570
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Aug 2018, zhaowuyun@wingtech.com wrote:
>=20
> Thanks for affirming the modification of disabling preemption and=20
> pointing out the incompleteness, delete_from_swap_cache() needs the same =
protection.
> I'm curious about that why don't put=C2=A0swapcache_free(swap) under prot=
ection of=C2=A0mapping->tree_lock ??

That would violate the long-established lock ordering (see not-always-
kept-up-to-date comments at the head of mm/rmap.c). In particular,
swap_lock (and its more recent descendants, such as swap_info->lock)
can be held with interrupts enabled, whereas taking tree_lock (later
called i_pages lock) involves disabling interrupts. So: there would
be quite a lot of modifications required to do swapcache_free(swap)
under mapping->tree_lock.

Generally easier would be to take tree_lock under swap lock: that fits
the establishd lock ordering, and is already done in just a few places
- or am I thinking of free_swap_and_cache() in the old days before
find_get_page() did lockless lookup? But you didn't suggest that way,
because it's more awkward in the __remove_mapping() case: I expect
that could be worked around with an initial PageSwapCache check,
taking swap locks there first (not inside swapcache_free()) -
__remove_mapping()'s BUG_ON(!PageLocked) implies that won't be racy.

But either way round, why? What would be the advantage in doing so?
A more conventional nesting of locks, easier to describe and understand,
yes. But from a performance point of view, thinking of lock contention,
nothing but disadvantage. And don't forget the get_swap_page() end:
there it would be harder to deal with both locks together (at least
in the shmem case).

Hugh
--0-1084447320-1533612190=:1570--
