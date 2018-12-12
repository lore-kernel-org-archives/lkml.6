Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B569C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F0B2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCI6tprS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F0B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeLLIKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:10:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39996 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeLLIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:10:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so8238975plq.7;
        Wed, 12 Dec 2018 00:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJwlyndDJBGW56rrYVUjYBY47O8iVFOkSIn5bU8BPRA=;
        b=PCI6tprSi4UDEP0LPvawg1WwzJ17ehiV8nqvKt6Aee5vNTQqKYCeI0BIRbG7fXVk7o
         Z2MrjtjqRiSKTRPk9jBASKCiGqRqdEtsEvR7gj1sIj8pn5PIr+LZDcPLDq7MA30aFs2F
         hKhehJ6EAqSU0gLTRkd6M1zk2B4WMRfWMLlmulQjhSkbLtNxEIzngcDmhF6wyVcQ7Er9
         u/g0xQ0NW8gIvfr/vWS2I9Z3HEluKegC9KlXSUml+z9RwDXFfCcP1LLtR6Yh6+zqnVvm
         Ma/TCnFQ4zORoi806ymz2a6l8+kPmr/I5CrlP9basTUinxQ6oPGN1MLHyvPnMOuuTfOV
         IuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJwlyndDJBGW56rrYVUjYBY47O8iVFOkSIn5bU8BPRA=;
        b=XaGNETGW/LYCUQZVcBEYBm5hN1bIBljflRTHV+xrkW5hjy1sNW4FoHmo77asa0IzPY
         SvsUvwb7SFnhRyCjfph2MNv2j+Wg7BTeXNKr4Fh7sNfOOAFf+c/sN0BvwXX+NwGyEezl
         KEubdVJot/DZ3uopE9AzCXJChmQtD1Hg0qSvfI5przO6Thztf7zZcP7QUCS8MCgN3rSs
         c672bRCwDpT1/D4VEL5R24mgFTGPKNC5Jokc0Q/4YPjQtk2+ZfqR7ArL/Ck/lHkr4Qdw
         uVHGIsYM79xk2DKWAxYPk6+filLdpsTLEoTve0G8ZkL1MG0Sc2L0xHLd0XXENneKx8+l
         OtyQ==
X-Gm-Message-State: AA+aEWb15f1lKBP4zhkfpUPKFdc/cwHbsQMcVBQ+Iegn5dYTNqKWS6u1
        nVsTS0wimUmKScr7aewIQW0=
X-Google-Smtp-Source: AFSGD/XLwxHn1w0kTLFqRcDREDduCK7fx0uvj38VUJT2s6W6cETmGHLOwQU26OzNHyoRHu5fn/Ua3A==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr19210726plb.312.1544602239310;
        Wed, 12 Dec 2018 00:10:39 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id d18sm25578911pfj.47.2018.12.12.00.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 00:10:37 -0800 (PST)
Date:   Wed, 12 Dec 2018 17:10:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Daniel Wang <wonderfly@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181212081034.GA32687@jagdpanzerIV>
References: <20181004085515.GC12879@jagdpanzerIV>
 <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
 <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212064841.GB2746@sasha-vm>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 01:48), Sasha Levin wrote:
> > > > I guess we still don't have a really clear understanding of what exactly
> > > is going in your system
> > > 
> > > I would also like to get to the bottom of it. Unfortunately I haven't
> > > got the expertise in this area nor the time to do it yet. Hence the
> > > intent to take a step back and backport Steven's patch to fix the
> > > issue that has resurfaced in our production recently.
> > 
> > No problem.
> > I just meant that -stable people can be a bit "unconvinced".
> 
> The -stable people tried adding this patch back in April, but ended up
> getting complaints up the wazoo (https://lkml.org/lkml/2018/4/9/154)
> about how this is not -stable material.

OK, really didn't know that! I wasn't Cc-ed on that AUTOSEL email,
and I wasn't Cc-ed on this whole discussion and found it purely
accidentally while browsing linux-mm list.

I understand what Petr meant by his email. Not arguing; below are just
my 5 cents.

> So yes, testing/acks welcome :)

OK. The way I see it (and I can be utterly wrong here):

The patch set in question, most likely and probably (*and those are
theories*), makes panic() deadlock less likely because panic_cpu waits
for console_sem owner to release uart_port/console_owner locks before
panic_cpu pr_emerg("Kernel panic - not syncing"), dump_stack()-s and
brings other CPUs down via stop IPI or NMI.
So a precondition is
		panic CPU != uart_port->lock owner CPU

If the panic happens on the same CPU which holds the uart_port spin_lock,
then the deadlock is still there, just like before; we have another patch
which attempts to fix this (it makes console drivers re-entrant from
panic()).

So if you are willing to backport this set to -stable, then I wouldn't
mind, probably would be more correct if we don't advertise this as a
"panic() deadlock fix" tho; we know that deadlock is still possible.
And there will be another -stable backport request in a week or so.


In the meantime, I can add my Acked-by to this backport if it helps.

/* Assuming that my theories explain what's happening with
   Daniel's systems. */

	-ss
