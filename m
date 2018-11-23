Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D42C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE27120824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCPfFakR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE27120824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410221AbeKXG44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:56:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41106 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeKXG44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:56:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so11039566plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZE9elG57jUJLAbzSG6k5YnO5Fx2q1yadOHcew8XAH1g=;
        b=HCPfFakRc7OdbvOfkF6k26/GeZlv1RRIBUN/rr2YvQt9TQfFuMSoxCAvveqC+mu1F1
         BzwGEjEBFu4Y5yD4//USBrvoDOeP8omp4Jrsh+jJiA9fbZZcFGN8o19DBcS6cv6xM9Gk
         R01T282rQvDihipOxJ82lymsCRR5t32r5kLVpPM5WLnn6grHq+CjEfXCoIxV7T7W2pEY
         Hfx3TxvuUKPPQGrrO3WLGF9w3/I02Ok1g3gxUJ55UjJ58gMbISzY2xwhkkII3hmddq7G
         BA2UbUufgguCVYIQWg2dj8tdJhxvpYCPMyHO0tzmq+QM+WTh5YysWxTnRUW/jbuA+jDr
         fveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZE9elG57jUJLAbzSG6k5YnO5Fx2q1yadOHcew8XAH1g=;
        b=uXEnbPIfMSSE7lLF0cZ+iPO4HFgtVRgbs017pD1loo4WPfxBcuQ+qTiKM3qwyUdIOQ
         yhhc8gCdWy1Xxr+MyAJkAzmJC95ycUIsXJuSI+8VU1zJOkUDCjBIDYt9dsSc03bgM2NB
         3RZbMsIa3Sbmbj7c+DBbD61szPAJeU7gcQgGnh8RyQxPcKxOp/dRETu/hmc+OauKMGQT
         JvZEayR94OSg80MgaYI1wFtdI+FAA6VgquPbPiGtyNJBNkS5S1QvzF0XruED3xvew2vY
         O/gcS8vIXvNfrkTv3l6mJF+A2zC6cCUrgEJion0Rq/PJbNwZy7/DeY8QZh7TbTZAmn2A
         Zagg==
X-Gm-Message-State: AA+aEWYx2PTUEdQFzzQoTAlSePhKSvydu7COopxKZxFCaOF4z0ib+dQ2
        k/KGRjQgDGWjqpTiMiS2dkK5nA==
X-Google-Smtp-Source: AFSGD/XuRZQOwZxRjT9+847pjTVmx1erYzWWX2liO29pX65/Kr/Bhzbg6NwN2Ae8JAZ9RN4W3po4jg==
X-Received: by 2002:a17:902:a710:: with SMTP id w16mr16789086plq.95.1543003871830;
        Fri, 23 Nov 2018 12:11:11 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id p5-v6sm66510057pfb.109.2018.11.23.12.11.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 12:11:10 -0800 (PST)
Date:   Fri, 23 Nov 2018 12:11:02 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: use swp_offset as key in shmem_replace_page()
In-Reply-To: <20181121210159.3a5fb6946e460c561fdec391@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.1811231140190.1964@eggly.anvils>
References: <20181119010924.177177-1-yuzhao@google.com> <20181121215442.138545-1-yuzhao@google.com> <20181121210159.3a5fb6946e460c561fdec391@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Andrew Morton wrote:
> On Wed, 21 Nov 2018 14:54:42 -0700 Yu Zhao <yuzhao@google.com> wrote:
> 
> > We changed key of swap cache tree from swp_entry_t.val to
> > swp_offset. Need to do so in shmem_replace_page() as well.
> 
> What are the user-visible effects of this change?

Sorry, I don't know; and I don't know whether it's something Yu noticed
by source inspection, or in trying to use it, perhaps in some new way:
I assume the former, but he can add more info if the latter.

shmem_replace_page() was added in 3.5, to allow Intel's GMA500 graphics
driver to use the shmem support for GEM objects, despite its hardware
addressing limitations.  (I did once try to extend it to NUMA placement,
but that turned out to be a waste, doing more harm than good.)

My guess at user-visible effects would be that the screen goes blank
or weird on GMA500 after a bout of swapping (because shmem_getpage_gfp()
failed to bring back a part of the object).  The code in shmem.c looks
robust (amusing to see my "Is this possible? I think not" comment!),
but I don't know how it plays out at the graphics driver end.

> 
> > Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
> > Cc: stable@vger.kernel.org # v4.9+
> 
> Please always provide the user-impact information when fixing bugs.  This
> becomes especially important when proposing -stable backporting.

So far as I know, nothing but GMA500 gets to use it, but perhaps other
uses have been added since.  We could ask around, but, frankly I'd prefer
just to remove the Fixes and Cc stable tags if they're causing trouble.
It's just a good simple bugfix, we thought stable would be glad of it.

> 
> Hugh said
> 
> : shmem_replace_page() has been wrong since the day I wrote it: good
> : enough to work on swap "type" 0, which is all most people ever use
> : (especially those few who need shmem_replace_page() at all), but broken
> : once there are any non-0 swp_type bits set in the higher order bits.

Yu then kindly restored my honour on that: I was misreading,
it was not broken from the start, but got broken by the commit in 4.9.

> 
> but we still don't have a description of "broken".
> 
> Thanks.

Hugh
