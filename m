Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB08C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAFF2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rwe8/YlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAFF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeK1IIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:08:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36250 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeK1IIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:08:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so8430466pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1GHkoMMfRNkVBZTHiK4GuMAOAn4lMUU8z6RX9bBUWCc=;
        b=Rwe8/YlIHozcBzSAGRPwqdt4qNcarycOyu8A0/X+bJ8y6mOMHcoD2irplDwzJID0Ri
         n/nVOsuD31igpwynT/myW/1kBIfW4GOqQBiW8c4nGXg1DzmRTpdwnV97llCBPdSpuaSb
         wqn0vfEkrHLUab69OhJA+StvSNX5GhalkDi1TC1EsLmt4fVEuFue19YsUYE0dk3U6tN+
         RH/dHCzBI/RmZKsWV19XAHWM4PwfHfmDrZu5mCwM/lyh6iPH+iAOZF0B7TZ+VC3OK3Qu
         B8y2M7uGFjcmPQqSnXaJpaRdUVeJgGgw0pGSom+9LqA0sg9aDkGWKPx7y8nYfJF7y6I8
         Sqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1GHkoMMfRNkVBZTHiK4GuMAOAn4lMUU8z6RX9bBUWCc=;
        b=giaY36MXqS2NMLK37ePKWwd7+Gw8mwedzYDJwnOYRA+she+UlgumGRKZlvSxMdEP+Q
         OzCR8Y4bV5P02ta5/O0jj3B6tsiLo3cE+eiVKv4u4+3L4lqaMOWYPo/qn4LUiW0H7Eur
         /Gku9lUbnyMuD2dcmrH1jjgKCc9NkbbXNocKbihvyewMk799nI4iWVUIn5puF88CK/em
         dPX3H80thKrsF9etLqQi6duDHSnKmVqtHopuPDncXfmmxJmMYK7CdUnnoi9c0x6Maeoh
         9zsrKzzZIxW2QL+lNMsPJpUIbO1BV6Zt1eXhvyE2USVmKUDFig4MdHhbwJ+4Zyn06dGe
         XIpg==
X-Gm-Message-State: AA+aEWaEqW8OAuGZ4bC7uYwLW6iZmtoljdAfVvbnF/eHr7APAnGDf/Ux
        q9D0eGZv0B6doVGwZNBC77+d8Q==
X-Google-Smtp-Source: AFSGD/WfraJLRb62PcXgJvdCh0jmGR+4lpM/GCN2jhcaK2UedFXL3bjBpUW3NhLnHlm11RFoN0u3KA==
X-Received: by 2002:a63:104d:: with SMTP id 13mr30753655pgq.303.1543352944636;
        Tue, 27 Nov 2018 13:09:04 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id g70sm10845279pfg.98.2018.11.27.13.09.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 13:09:03 -0800 (PST)
Date:   Tue, 27 Nov 2018 13:08:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Mike Rapoport <rppt@linux.ibm.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is
 migrated
In-Reply-To: <20181127105848.GD16502@rapoport-lnx>
Message-ID: <alpine.LSU.2.11.1811271258070.4506@eggly.anvils>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils> <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com> <alpine.LSU.2.11.1811251900300.1278@eggly.anvils> <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
 <20181127105848.GD16502@rapoport-lnx>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Mike Rapoport wrote:
> On Mon, Nov 26, 2018 at 11:27:07AM -0800, Hugh Dickins wrote:
> > 
> > +/*
> > + * A choice of three behaviors for wait_on_page_bit_common():
> > + */
> > +enum behavior {
> > +	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
> > +			 * __lock_page() waiting on then setting PG_locked.
> > +			 */
> > +	SHARED,		/* Hold ref to page and check the bit when woken, like
> > +			 * wait_on_page_writeback() waiting on PG_writeback.
> > +			 */
> > +	DROP,		/* Drop ref to page before wait, no check when woken,
> > +			 * like put_and_wait_on_page_locked() on PG_locked.
> > +			 */
> > +};
> 
> Can we please make it:
> 
> /**
>  * enum behavior - a choice of three behaviors for wait_on_page_bit_common()
>  */
> enum behavior {
> 	/**
> 	 * @EXCLUSIVE: Hold ref to page and take the bit when woken,
> 	 * like __lock_page() waiting on then setting %PG_locked.
> 	 */
> 	EXCLUSIVE,
> 	/**
> 	 * @SHARED: Hold ref to page and check the bit when woken,
> 	 * like wait_on_page_writeback() waiting on %PG_writeback.
> 	 */
> 	SHARED,
> 	/**
> 	 * @DROP: Drop ref to page before wait, no check when woken,
> 	 * like put_and_wait_on_page_locked() on %PG_locked.
> 	 */
> 	DROP,
> };

I'm with Matthew, I'd prefer not: the first looks a more readable,
less cluttered comment to me than the second: this is just an arg
to an internal helper in mm/filemap.c, itself not kernel-doc'ed.

But the comment is not there for me: if consensus is that the
second is preferable, then sure, we can change it over.

Hugh
