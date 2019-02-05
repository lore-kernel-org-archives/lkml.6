Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B73AC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521792175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vW6cIpa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfBETDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:03:04 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42244 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfBETDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:03:03 -0500
Received: by mail-pg1-f179.google.com with SMTP id d72so1772353pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=U4R4yE369nrKTa7CgvPCPtgPOR1uNAIMOfUGDkxSCgE=;
        b=vW6cIpa4Ip2dQnvO55zgU/BZbaTziP0rn3LBpSGLPaUiUlZ8baDnFw1yxbnf4trxH3
         psWLBB/q7sqsxGnFJOtNSWlX5g7Ez0ADxEwc+tkWyBqpZK63WDoxpSxBV+hORg8kzW4J
         ULH4CQLYVbe0/mR5x7NbtmY2WmHxT7f/UlsRDwM8ajkWC1oY2pWoyaU4xMihnG5XKiwz
         2I7cdcHf1vGHDTVKaS3+WB1S9Ew8dqzFlX3tZEvTlFnQMq1bKSviRrViAjxrFR6Vqp6M
         6RJH+COyJmzszurQTRP2fanOIP/T59KoSyCYfuQxSUQByPT08WhZKamvZmf6a9GVIQ6t
         8a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=U4R4yE369nrKTa7CgvPCPtgPOR1uNAIMOfUGDkxSCgE=;
        b=E9+8fiyRSW+Zep6Bb2fBTBYeAwYGPCgZLpn6piTuRHAOb1pS0FFa+yE8von5LFMSmy
         X6a5/bjdDHgMwHlk2OnMxOhcoVTH9GSLjLTfY4zzWPBFrD9qSl052I08LDeKNaE+yVVR
         KLzz+mN1gwzSbmJA/3kbmd8SnKnCw+N5LrFBbMKwddfdvf50K8O0fnu1OYMk63ZFrBnR
         GIz7JgUqZRjgrIT49kqeVl0MkM8zC7tiexXP7y8hYjDL6S4d+lli3cykqEhGpiuqHMGf
         3SYWMIoXbk96z58Un4RTppvUc1nmcXI1o1BcHwoJnFLBR3RS62ZBOGYOkDzpREzBDIXr
         Ei6g==
X-Gm-Message-State: AHQUAubUQX3bwo7nPJ1tnFnasOPcFoM5Z75VrROsdzHOnaKWX81YoQAz
        eHLNM6aN5lC+5hnpBE6eKBbQTg==
X-Google-Smtp-Source: AHgI3IYigtc/NZJ+hOsqBz2l+YWFFJmz3FXNhOyzEH5zFomALCTTclGAU03PtrJ9Mw2JgNfv6KxM+g==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr6427291pfn.91.1549393382267;
        Tue, 05 Feb 2019 11:03:02 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id z10sm5194066pfg.120.2019.02.05.11.03.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 11:03:01 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:02:49 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Qian Cai <cai@lca.pw>
cc:     Hugh Dickins <hughd@google.com>, Artem Savkov <asavkov@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: mm: race in put_and_wait_on_page_locked()
In-Reply-To: <1ce33d5f-1f0f-7144-2455-fbae7f5f82c8@lca.pw>
Message-ID: <alpine.LSU.2.11.1902051101340.9007@eggly.anvils>
References: <20190204091300.GB13536@shodan.usersys.redhat.com> <alpine.LSU.2.11.1902041201280.4441@eggly.anvils> <20190205121002.GA32424@shodan.usersys.redhat.com> <alpine.LSU.2.11.1902050725010.8467@eggly.anvils>
 <1ce33d5f-1f0f-7144-2455-fbae7f5f82c8@lca.pw>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019, Qian Cai wrote:
> 
> >> Cai, can you please check if you can reproduce this issue in your
> >> environment with 5.0-rc5?
> > 
> > Yes, please do - practical confirmation more convincing than my certainty.
> 
> Indeed, I am no longer be able to reproduce this anymore.

Great, thanks.  I'll add a message to the other thread to wrap that up too.

Hugh
