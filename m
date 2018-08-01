Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CA7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C40208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="R/yizYsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C40208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbeHAWqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:46:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37138 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeHAWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:46:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so8473720pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iH+DA0dU8hNg6Y0IhJ0IkWVsazpHAR/aOqKMgnJ0C4s=;
        b=R/yizYsBbTGp3u9N6BxX1CGDFuSfoLziffj6/jEZEXlVy66m3KBDl/8hTCZhfJSubO
         vyFF+DidXRgs8lPkHt5N+mXTriu4dGFkPsupeFvlh/9+YjC82LUH0ffWYJ4JMljyJW0g
         wMwCPS5eVnhg2U0r4CJV0NKETeO1RqZtYo4m43eQU6e8pClflvR7Uhw+7Hlu3ralSHEB
         RW5tIsOXgBTuMWXBEvMhyde1gHi2cRCrBKJYWrX20gNWH48VkbSR1Mc7d4MBRhSEBQP8
         CVL43N20cnRZCuS6CLcRuXMntcRlnEQPhryt3mHjc+DAjWOkmZ5frm6atzOh5uyDtLSr
         pdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iH+DA0dU8hNg6Y0IhJ0IkWVsazpHAR/aOqKMgnJ0C4s=;
        b=iOaa3FckCufmIlbMf0Q9K0A5tgR4/c1MEttXWj3mh3iAVQPI7sJYYPYuWhMyQZmD/p
         JV6rydyWWLHBT0N98khAaISu0M/yNl51TUB1u88PkB+aNrCebw/TpfL2jN0QMTChfDHj
         Wh2rCnPSKvIx+Gik8dCV7+8IlEyHo48ZQUfwY8/svvq/cP31YqfCNByIbZw6EEnzeORz
         TBZv4Xk6IpxKy11N14irWf82mGRaltW4/0TLElp8KGJtpGgdFDSUpQHWpIp6k/qlm2/z
         7+AqIMHaem6CjgagNeCn6H5+Ce2VHGFvwFdsbZzuxL8Z0RxN4UWPfsPyo1Dlz9aSXv8Q
         OzDQ==
X-Gm-Message-State: AOUpUlHiWCQlZZ7xBXG/Hig0GKMX/8bZag+WcIt1LhMcSWMgaI9orHbU
        EYwE3y5A46wyxv05v6cHYjrOsw==
X-Google-Smtp-Source: AAOMgpergOARa8utc/tn7vzTGX9Ik76zjFopFX630q4Rft0FwY854oVE5KXdBnUkymS5U9I+GeQkhw==
X-Received: by 2002:a62:fccd:: with SMTP id e196-v6mr8807323pfh.245.1533157134617;
        Wed, 01 Aug 2018 13:58:54 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id q81-v6sm4465pfd.15.2018.08.01.13.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 13:58:54 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1660E3002A5; Wed,  1 Aug 2018 23:58:49 +0300 (+03)
Date:   Wed, 1 Aug 2018 23:58:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Subject: Re: Linux 4.18-rc7
Message-ID: <20180801205848.6mgcfux4b63svj3n@kshutemo-mobl1>
References: <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils>
 <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1>
 <20180731174349.GA12944@agluck-desk>
 <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
 <alpine.LSU.2.11.1808011042090.14313@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1808011042090.14313@eggly.anvils>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:31:52AM -0700, Hugh Dickins wrote:
> On Wed, 1 Aug 2018, Linus Torvalds wrote:
> > 
> > Anyway, the upshot of all this is that I think I know what the ia64
> > problem was, and John sent the patch for the ashmem case, and I'm
> > going to hold off reverting that vma_is_anonymous() false-positives
> > commit after all.
> 
> I'd better send deletion of zap_pmd_range()'s VM_BUG_ON_VMA(): below
> (but I've no proprietorial interest, if you prefer to do your own).

Agreed.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> John's patch is good, and originally I thought it was safe from that
> VM_BUG_ON_VMA(), because the /dev/ashmem fd exposed to the user is
> disconnected from the vm_file in the vma, and madvise(,,MADV_REMOVE)
> insists on VM_SHARED. But afterwards read John's earlier mail,
> drawing attention to the vfs_fallocate() in there: I may be wrong,
> and I don't know if Android has THP in the config anyway, but it looks
> to me like an unmap_mapping_range() from ashmem's vfs_fallocate()
> could hit precisely the VM_BUG_ON_VMA(), once it's vma_is_anonymous().
> 
> (I'm not familiar with ashmem, and I certainly don't understand the
> role of MAP_PRIVATE ashmem mappings - hole-punch's zap_pte_range()
> should end up leaving any anon pages in place; but the presence of
> the BUG is requiring us all to understand too much too quickly.)

Hugh, do you see any reason why ashmem shouldn't have vm_ops ==
shmem_vm_ops?

I don't understand ashmem, but I feel uncomfortable that we have this
sneaky way to create an anonymous VMA. It feels wrong to me.

-- 
 Kirill A. Shutemov
