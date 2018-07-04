Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B841221A12
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+Jx3F04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B841221A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934196AbeGDJVF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:21:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36633 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbeGDJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:20:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so2383832pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+29LCJCZp2gmqW3dbCZ1fQab2ptOjeIeCbKY2a+hXr0=;
        b=E+Jx3F04d1+z+Mjw/YcNKg+T5lRwReP+EccPP86T9MSDH/TOJTHilL5IG8NY+jZd59
         k6XYbapQMj5/bkPA1GAdkRakiU3ZSuHkBwKDQBIzj6tLrPALOJ3rhJRaPmdk7LFAWgEt
         0T/QqKGyQ6Jyom7DNKk8eUv9SslKNq8ccduVVLZOlRWl6hdhKadqbfzDCvj61BVrGscV
         kYFcO2W0OSHWclWLqosLSg6h1UaLvtloHOBgAQBTMqZW/thCX1+NwRmQqoJCZWW0JuJu
         +Po672UR6ImfRto0d3IKmT+5Ep2h2v6JJ0MEepwwBa9kb65nHokoQShsHyrdVI4o9dEn
         Pgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+29LCJCZp2gmqW3dbCZ1fQab2ptOjeIeCbKY2a+hXr0=;
        b=V2Px+UrS1Mt86gGRKakswakExxWs9pw7PmWvkGi612gk5umnS6JmyifZI2pEHAJUXy
         08N6++vRuJdjpmGDkrJ2bldShiYRDuMnA0CCnF5DPFeEGbevy5BnaKifVx/pJE/O9O7U
         Vashc9bOmDIQ5LZ7Va76ytvBaUhSxYkmRXdRUnT7PBJniP3yjIqNiCScQC6XEpQG4VuY
         LkC81jt5a7mgQuFLiOi6+xOTzHK0V//8BsZ4NPefR9QMHi0h8gUioNCp3tZt4m+p3YYg
         n0HEprUrzIbSEfBBzHRcVn6NWMPKu32OUBNaD1z97wVpMNbYqLWxJOokZKqGHZN4H3uO
         dDNg==
X-Gm-Message-State: APt69E2+YFpNrFCduU3JVLuOb4DR8fvy6ExdURYZrLmUJeEY3FxLAokl
        SanIaw94PxhWVSzSBPnQT98=
X-Google-Smtp-Source: AAOMgpcQ6rrfCMHg/TZGUC9FOEZ3ar042raNRCXGJ2Zo7XeTW3RI/jZkvwTmUrXhQY7S3Yr0m91p7w==
X-Received: by 2002:a62:4308:: with SMTP id q8-v6mr1390927pfa.86.1530696047230;
        Wed, 04 Jul 2018 02:20:47 -0700 (PDT)
Received: from localhost ([175.223.14.150])
        by smtp.gmail.com with ESMTPSA id n2-v6sm4556128pgp.71.2018.07.04.02.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:20:45 -0700 (PDT)
Date:   Wed, 4 Jul 2018 18:20:42 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
Message-ID: <20180704092042.GC458@jagdpanzerIV>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
 <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
 <20180704070305.GB4352@rapoport-lnx>
 <20180704072308.GA458@jagdpanzerIV>
 <8dc61092669356f5417bc275e3b7c69ce637e63e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc61092669356f5417bc275e3b7c69ce637e63e.camel@perches.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/04/18 02:04), Joe Perches wrote:
> > Sorry, NACK on lib/vsprintf.c part
> > 
> > I definitely didn't want to do this tree-wide pf->ps conversion when
> > I introduced my patch set. pf/pF should have never existed, true,
> > but I think we must support pf/pF in vsprintf(). Simply because it
> > has been around for *far* too long.
> 
> And?  checkpatch warns about %p[Ff] uses.
> 
> > People tend to develop "habits",
> > you know, I'm quite sure ppc/hppa/etc folks still do [and will] use
> > pf/pF occasionally.
> 
> There's this saying about habits made to be broken.
> This is one of those habits.
> 
> I'd expect more people probably get the %pS or %ps wrong
> than use %pF.
> 
> And most people probably look for examples in code and
> copy instead of thinking what's correct, so removing old
> and deprecated uses from existing code is a good thing.

Well, I don't NACK the patch, I just want to keep pf/pF in vsprintf(),
that's it. Yes, checkpatch warns about pf/pF uses, becuase we don't want
any new pf/pF in the code - it's rather confusing to have both pf/pF and
ps/pS -- but I don't necessarily see why would we want to mess up with
parisc/hppa/ia64 people using pf/pF for debugging purposes, etc. I'm not
married to pf/pF, if you guys insist on complete removal of pf/pF then so
be it.

	-ss
