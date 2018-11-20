Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F484C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31045205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnTZqB2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31045205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbeKTPeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:34:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37295 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbeKTPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:34:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so400754pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 21:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LHluP8cAaDm0ch8NnG3ZRGKPbbjJbamWEl7mWptBzqo=;
        b=jnTZqB2jhS4t0l0DWQgcAC1AFIjJdso7mqRUSQ0YD4zHm6fmD8qEb5bYnKasnKFsq0
         msQu7JNnA3MrX2sl0SiKSwkS+9l67wsbZtmx0cZto6ULbXRxDvbUQ5szQEMo/Uv1Xsm7
         A5eRij0E7f6ZRw3sFrmqyOEpKfUviEXPKrdPjgUfqFiQuvNGMKl4FgF/UJY3eeZ35Rbw
         ZuN6dpqWu3WgKy3ol0EE1KGzb21uaGY4eGrMqNqpDfmi+3kuvLolaLo4Dp+Odi7HfQlm
         uRUUcKQ6tR0A+7T7bU5Cm7f8jeE8xwDlN5m0EZPvtFlIw8q67nlxql5SK0zWtylGMQ3K
         AQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LHluP8cAaDm0ch8NnG3ZRGKPbbjJbamWEl7mWptBzqo=;
        b=aU936PFW7yORYBOWUcys798iTgwvyFDHYOHobh2CozQVlu6TwMI+DwGm1keZ6Kp+MM
         U9nuVngApO9lyk3mnrP03N0DlTdad984tNOXrg4kFR5pPhjAS3WpMikhYFOQ4+wz0ZBd
         qjF8TxHJn+4TaS8qHqC8qhUISblvvsdAVZvjhAjPGmAsIg9wjthFCTuNPwanEYXdQ6jF
         mjkGMM3WK1twXliR6QLIeTVWmgbm0yjGrPEBSbmrKUNsH36V5FF9ETaSvPywKvHco4T4
         BHZUBL87hHt7KFGLVku3627CDTWuRQ/r1sKUyUTGExBHElsfBnKZFbD6CzTfBlU6J/JL
         HpTg==
X-Gm-Message-State: AGRZ1gKETswYyTkGMz1ozxi0VBuwSwi+1Ni64vgCaZOigHUu1ZwQvV8j
        jtw+5kfjYJui2RjSrOwJ86K85g==
X-Google-Smtp-Source: AJdET5etLsq4LQ6G7osrTntOqFV+7uPCcedWeQ3yJXrHcaDI6ZNFuiCsgI5OGikhQ78n0XDQ/gkF/g==
X-Received: by 2002:a62:8145:: with SMTP id t66mr711418pfd.55.1542690457214;
        Mon, 19 Nov 2018 21:07:37 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id f13sm23117889pfa.132.2018.11.19.21.07.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 21:07:36 -0800 (PST)
Date:   Mon, 19 Nov 2018 21:07:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Zhao <yuzhao@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix swap offset when replacing shmem page
In-Reply-To: <20181120012950.GA94981@google.com>
Message-ID: <alpine.LSU.2.11.1811192057490.2185@eggly.anvils>
References: <20181119004719.156411-1-yuzhao@google.com> <20181119010924.177177-1-yuzhao@google.com> <alpine.LSU.2.11.1811191343280.17359@eggly.anvils> <20181120012950.GA94981@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Yu Zhao wrote:
> On Mon, Nov 19, 2018 at 02:11:27PM -0800, Hugh Dickins wrote:
> > On Sun, 18 Nov 2018, Yu Zhao wrote:
> > 
> > > We used to have a single swap address space with swp_entry_t.val
> > > as its radix tree index. This is not the case anymore. Now Each
> > > swp_type() has its own address space and should use swp_offset()
> > > as radix tree index.
> > > 
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > 
> > This fix is a great find, thank you! But completely mis-described!
> 
> Yes, now I remember making swap offset as key was done long after per
> swap device radix tree.
> 
> > And could you do a smaller patch, keeping swap_index, that can go to
> > stable without getting into trouble with the recent xarrifications?
> > 
> > Fixes: bde05d1ccd51 ("shmem: replace page if mapping excludes its zone")
> > Cc: stable@vger.kernel.org # 3.5+
> > 
> > Seems shmem_replace_page() has been wrong since the day I wrote it:
> > good enough to work on swap "type" 0, which is all most people ever use
> > (especially those few who need shmem_replace_page() at all), but broken
> > once there are any non-0 swp_type bits set in the higher order bits.
> 
> But you did get it right when you wrote the function, which was before
> the per swap device radix tree. so
> Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
> looks good?

Oh, you're right, thank you. Yes, the fix is to that one, in 4.9 onwards.

I don't much like my original use of the name "swap_index", when it was
not the index in a swapfile (though it was the index in the radix tree);
but it will become a correct name with your patch.

Though Matthew Wilcox seems to want us to avoid saying "radix tree"...

Hugh
