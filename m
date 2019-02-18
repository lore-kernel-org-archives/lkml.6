Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06746C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5132173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fc51Dots"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfBRLPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:15:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34478 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfBRLPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:15:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so1509073plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 03:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bnsuTPZJgCfJkno9x9y084y1LYZfgF4jJqn/Ofc0v/A=;
        b=fc51DotsSi/ZDVqcuM+zz2E5VvzsHBADPHlsTIeijFmdP1Nl4JKwpAkZ4jwpS8OUMF
         AT5Rbpqri+1WoVsMlxCvRPW7kip5cUwDzp6ApSChQJZbbYD1LSOfBW92pzlX9XnUvmrQ
         QHwUan7ORaoLdsDCo/VSVsxPdeBUKnvrcCXOJy8GhAGrtmhXbD5+rz0oPgXb0gsU9J3D
         2ZCXm+DstbvHcFbGdtkI0JE1N6YBUrGO7gKu/f5x9QcG/E2y/+cb3vMI36Rz9p9Y1GZH
         C6adDUZlg/iOx9w7cVhzlPukqD1S69Bz2C5hDr6y84DY6irCpDo+gsSzWYvX8Q3aOtzt
         soog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bnsuTPZJgCfJkno9x9y084y1LYZfgF4jJqn/Ofc0v/A=;
        b=R6AjKL3tc7avXFprJ20Ozay7WzHZmbeYnyZAWJDv+Ng7KoeSX5n18epA1Fkyy7q8Xo
         FC/UMnmaKtNOR0wUpebXjKXZRF5/UxchOXIv/1+JMmx7idJ3z60FXxTuMY+WxuMVTVdg
         TMR7D1UC4gOW9TBUDwBN+drg7gLqQBMoGTpuCNeWe69YLEQvJT76DnBV660PuRXrPH4a
         dr+qyszm+QMbzJrJbwVCr8d4+BQsrwhhzJJuFX+PIS7jVHK6/UKo6IelIKSftDrDaeNC
         RSE1V5D+wjBTPTBnNC205hmjn47hmuISfxxgXFEp8PUud9LGjUxt0umnQfY1QbSPc51F
         5xJw==
X-Gm-Message-State: AHQUAuY7IEdGY7m/zbv/Q9Akkiubmv/ySVfiaeft/PhEH27ELlO60hQ8
        /M5wUFDnsIqE+ZEK9QV+zanFqw==
X-Google-Smtp-Source: AHgI3Ia4sdyFpZDnnzf1LF4LNTSmFm3tiVnCyW0A2KoBUCySQ0q8bKhqCeNniENUIugm8eyXLQJtPA==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr24391965plo.121.1550488540222;
        Mon, 18 Feb 2019 03:15:40 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id d68sm18849242pfa.64.2019.02.18.03.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 03:15:39 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id DA3AF3002B2; Mon, 18 Feb 2019 14:15:35 +0300 (+03)
Date:   Mon, 18 Feb 2019 14:15:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        hughd@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org
Subject: Re: mremap vs sysctl_max_map_count
Message-ID: <20190218111535.dxkm7w7c2edgl2lh@kshutemo-mobl1>
References: <20190218083326.xsnx7cx2lxurbmux@d104.suse.de>
 <a11a10b5-4a31-2537-7b14-83f4b22e5f6c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a11a10b5-4a31-2537-7b14-83f4b22e5f6c@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:57:18AM +0100, Vlastimil Babka wrote:
> On 2/18/19 9:33 AM, Oscar Salvador wrote:
> > 
> > Hi all,
> > 
> > I would like to bring up a topic that comes from an issue a customer of ours
> > is facing with the mremap syscall + hitting the max_map_count threshold:
> > 
> > When passing the MREMAP_FIXED flag, mremap() calls mremap_to() which does the
> > following:
> > 
> > 1) it unmaps the region where we want to put the new map:
> >    (new_addr, new_addr + new_len] [1]
> > 2) IFF old_len > new_len, it unmaps the region:
> >    (old_addr + new_len, (old_addr + new_len) + (old_len - new_len)] [2]
> > 
> > Now, having gone through steps 1) and 2), we eventually call move_vma() to do
> > the actual move.
> > 
> > move_vma() checks if we are at least 4 maps below max_map_count, otherwise
> > it bails out with -ENOMEM [3].
> > The problem is that we might have already unmapped the vma's in steps 1) and 2),
> > so it is not possible for userspace to figure out the state of the vma's after
> > it gets -ENOMEM.
> > 
> > - Did new_addr got unmaped?
> > - Did part of the old_addr got unmaped?
> > 
> > Because of that, it gets tricky for userspace to clean up properly on error
> > path.
> > 
> > While it is true that we can return -ENOMEM for more reasons
> > (e.g: see vma_to_resize()->may_expand_vm()), I think that we might be able to
> > pre-compute the number of maps that we are going add/release during the first
> > two do_munmaps(), and check whether we are 4 maps below the threshold
> > (as move_vma() does).
> > Should not be the case, we can bail out early before we unmap anything, so we
> > make sure the vma's are left untouched in case we are going to be short of maps.
> > 
> > I am not sure if that is realistically doable, or there are limitations
> > I overlooked, or we simply do not want to do that.
> 
> IMHO it makes sense to do all such resource limit checks upfront. It
> should all be protected by mmap_sem and thus stable, right? Even if it
> was racy, I'd think it's better to breach the limit a bit due to a race
> than bail out in the middle of operation. Being also resilient against
> "real" ENOMEM's due to e.g. failure to alocate a vma would be much
> harder perhaps (but maybe it's already mostly covered by the
> too-small-to-fail in page allocator), but I'd try with the artificial
> limits at least.

There's slight chance of false-postive -ENOMEM with upfront approach:
unmapping can reduce number of VMAs so in some cases upfront check would
fail something that could succeed otherwise.

We could check also what number of VMA unmap would free (if any). But it
complicates the picture and I don't think worth it in the end.

-- 
 Kirill A. Shutemov
