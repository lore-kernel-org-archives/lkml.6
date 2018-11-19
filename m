Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF66C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C177820871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkfRWYuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C177820871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeKSTB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:01:57 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51266 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKSTB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:01:57 -0500
Received: by mail-wm1-f46.google.com with SMTP id w7-v6so4364338wmc.1;
        Mon, 19 Nov 2018 00:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyUNGkUCzTLUbl0hFBf1C0LnwA7UI9OL1j1upJ5ly1M=;
        b=NkfRWYuPlQ66FVOj/WdXZGRwCsVKq4KUzlqji2JSKJIJGo7tkJDSrgbFL+3oCfOkET
         OQMz8W63XJXRLkExNmrWP5tij1O8oflP+XlvTq64k4iRr2DbhZOlinLIAHZewv28tECC
         EYyH96BMOxu/osqVf38fydNwBpZtGdNCEcQOj9nkHWtujoRmixEx49zxCNnqzb5QMBPE
         XYJ0OwDTuXsWxuYQdDOFC032lOKeKVkZ0O73UhGJwC3w+IRh29R+McbBcm5q3gCrmDkO
         7mi47fhhIvw1OBFtfnbPVL7E3JIZrab24WmGhceU2BkwZTcc9RE86j/7Zvs4SLtdBT1K
         QTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyUNGkUCzTLUbl0hFBf1C0LnwA7UI9OL1j1upJ5ly1M=;
        b=P+bmb/hLFNI6f3AKGBv5776r5pvS9CkSnWFPyO+46iWindDrvXLevkT+/ggyQ79VcD
         VFoyxehMXuNpiuVwhpNeegFWTo3femk9ffciJWtDcEI321S7z46DArPpRYM2S+NSoHJd
         +Y9FL23FpiwZt8/Jv1F6fSW1hqUo2MqjEOgM9MYgnWiB/LycFyPkDn07CDe6UbQKnUsH
         L4/rcMfq2ObRVulpazFQqJI9aGMw31Z5CUECvGlkWsAmiVGH2ZQS73acdFqojKi8IKSy
         LxdDEVovNDx28hfI2hu/CIv1owYteHUesOcFV1P/GPZOgok7gfoIg8Gr7UNROk2Ke/GF
         R8mw==
X-Gm-Message-State: AGRZ1gIAJnuW8Dl2iuMBsowYTPn0pvdeTSUJKzBrZUl1KXeb77nyMK66
        9qpa/WpScwQ2x/51pp2uup4=
X-Google-Smtp-Source: AFSGD/Xio1TvGPgy2os+AZRLNbtVtIw/lhXyOVFepfQYfJzDyYa1STZR0ASTvzzhMWxjhdQznxR7dg==
X-Received: by 2002:a1c:d0cd:: with SMTP id h196mr6052057wmg.13.1542616738617;
        Mon, 19 Nov 2018 00:38:58 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x194-v6sm88903564wmd.41.2018.11.19.00.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 00:38:57 -0800 (PST)
Date:   Mon, 19 Nov 2018 09:38:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
Message-ID: <20181119083855.GA129733@gmail.com>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> This was marked for stable, and honestly, nowhere in the discussion
> did I see any mention of just *how* bad the performance impact of this
> was.

Yeah. This was an oversight - we'll fix it!

> When performance goes down by 50% on some loads, people need to start
> asking themselves whether it was worth it. It's apparently better to
> just disable SMT entirely, which is what security-conscious people do
> anyway.
> 
> So why do that STIBP slow-down by default when the people who *really*
> care already disabled SMT?
> 
> I think we should use the same logic as for L1TF: we default to
> something that doesn't kill performance. Warn once about it, and let
> the  crazy people say "I'd rather take a 50% performance hit than
> worry about a theoretical issue".

Yeah, absolutely.

We'll also require performance measurements in changelogs enabling any 
sort of mitigation feature from now on - this requirement was implicit 
but 53c613fe6349 flew in under the radar, so it's going to be explicit an 
explicit requirement.

Thanks,

	Ingo
