Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84803C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3116F20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3116F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeIDUtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:49:39 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:52658 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbeIDUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:49:38 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 461F013FC78; Tue,  4 Sep 2018 18:23:48 +0200 (CEST)
Date:   Tue, 4 Sep 2018 18:23:48 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180904162348.GN17123@BitWizard.nl>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl>
 <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904161203.GD17478@fieldses.org>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 12:12:03PM -0400, J. Bruce Fields wrote:

> 
> Well, I think the point was that in the above examples you'd prefer that
> the read just fail--no need to keep the data.  A bit marking the file
> (or even the entire filesystem) unreadable would satisfy posix, I guess.
> Whether that's practical, I don't know.

When you would do it like that (mark the whole filesystem as "in
error") things go from bad to worse even faster. The Linux kernel 
tries to keep the system up even in the face of errors. 

With that suggestion, having one application run into a writeback
error would effectively crash the whole system because the filesystem
may be the root filesystem and stuff like "sshd" that you need to
diagnose the problem needs to be read from the disk.... 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
