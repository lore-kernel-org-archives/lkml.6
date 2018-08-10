Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B403C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E6021829
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJT1lBLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E6021829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeHJQyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:54:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42213 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeHJQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:54:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so4476818pgp.9;
        Fri, 10 Aug 2018 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RDFb/9s4KbfHframSPw2B2wjvFfmVa4ZJeDuzhOUNGw=;
        b=KJT1lBLCGJiGaOTA+Dl0AzKsQxRMC7MbH22HpeZQpDbx5uXW4wWQh3A9WcxY0F3IMM
         tOdIybhhKkxuHTK6+6vjnPBSesU+kkLmMWwNwSfOtJpnhxulxu9aFvCy8zlRlxlLTcq3
         TWImIqrE3PInOkst47O1VbBQ1hE/b/wJVTLPygPWdoDpuufw39LCIZ8f+qQYZ7zIaOlA
         znASRAnvF2K0luNaqwN2IdK2UwgR9Eb6o7hvBoEPUTU0j699zXQEFye9yQn+cCvxiO9r
         VtIcAQUmFfk3b0ol/a5odcKqzo/gSkl8IiP9NUhP9LRDt3wizdBP9oxr1COASDoTCYDe
         H81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RDFb/9s4KbfHframSPw2B2wjvFfmVa4ZJeDuzhOUNGw=;
        b=H6wCL5E5pVeMAQSAJ1DBBnjWYKg9aLj8XmsddVeWF5v5M35qo7C16QyaQDZUbB1TSS
         oLGWTHxMT3fGKP8Qze05VMcobietwnS7m1Js+vcj5ApokE+uwmv1ZQcogIJFmlS4K26/
         XAHEPbGtXx9CFsCJvvL27JPYe6OGq8bxOFgo0yqSntRG3og9l0EYpyOQ8WnKUnTTRuid
         6rlGFi4zkiCFKD3ZAhrImI6n7I79IbgoS7paCLjFeKffrauDqesiz0cyzHXcdrv9HY1K
         DbpjL6F45YcLT5/EueO33WRcJD/Fl5J10OmkdG0IF4rBgUlBX9QTo1KOzM763guZRQtW
         zKPA==
X-Gm-Message-State: AOUpUlEDT9tifhNZWzTzY+lVwy0SRO0atWKlXOLJaxLKxSUTbYH4YnvY
        qvyPfVei2znHsE3jVPzvatEkhWww54Y=
X-Google-Smtp-Source: AA+uWPxPkXz+W7fyfAmkcxGIqzaVQ2wfVDVh8WkO+KYKogSqULuq3jSB1ERXQIOwzaESICInyQHDCQ==
X-Received: by 2002:a63:ec14:: with SMTP id j20-v6mr6612234pgh.28.1533911067753;
        Fri, 10 Aug 2018 07:24:27 -0700 (PDT)
Received: from localhost (49-156-241-73.ppp.bbiq.jp. [49.156.241.73])
        by smtp.gmail.com with ESMTPSA id 143-v6sm15837054pfy.156.2018.08.10.07.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:24:27 -0700 (PDT)
Date:   Fri, 10 Aug 2018 23:24:24 +0900
From:   Naohiro Aota <naota@elisp.net>
To:     Hannes Reinecke <hare@suse.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
Message-ID: <20180810142424.62linovnguszljzf@zazie>
References: <20180809180450.5091-1-naota@elisp.net>
 <b60c72ff-8fba-839f-4c42-df68318b9222@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b60c72ff-8fba-839f-4c42-df68318b9222@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:04:59AM +0200, Hannes Reinecke wrote:
> On 08/09/2018 08:04 PM, Naohiro Aota wrote:
> > This series adds zoned block device support to btrfs.
> > 
> > A zoned block device consists of a number of zones. Zones are either
> > conventional and accepting random writes or sequential and requiring that
> > writes be issued in LBA order from each zone write pointer position. This
> > patch series ensures that the sequential write constraint of sequential
> > zones is respected while fundamentally not changing BtrFS block and I/O
> > management for block stored in conventional zones.
> > 
> > To achieve this, the default dev extent size of btrfs is changed on zoned
> > block devices so that dev extents are always aligned to a zone. Allocation
> > of blocks within a block group is changed so that the allocation is always
> > sequential from the beginning of the block groups. To do so, an allocation
> > pointer is added to block groups and used as the allocation hint.  The
> > allocation changes also ensures that block freed below the allocation
> > pointer are ignored, resulting in sequential block allocation regardless of
> > the block group usage.
> > 
> > While the introduction of the allocation pointer ensure that blocks will be
> > allocated sequentially, I/Os to write out newly allocated blocks may be
> > issued out of order, causing errors when writing to sequential zones. This
> > problem s solved by introducing a submit_buffer() function and changes to
> > the internal I/O scheduler to ensure in-order issuing of write I/Os for
> > each chunk and corresponding to the block allocation order in the chunk.
> > 
> > The zones of a chunk are reset to allow reusing of the zone only when the
> > block group is being freed, that is, when all the extents of the block group
> > are unused.
> > 
> > For btrfs volumes composed of multiple zoned disks, restrictions are added
> > to ensure that all disks have the same zone size. This matches the existing
> > constraint that all dev extents in a chunk must have the same size.
> > 
> > It requires zoned block devices to test the patchset. Even if you don't
> > have zone devices, you can use tcmu-runner [1] to emulate zoned block
> > devices. It can export emulated zoned block devices via iSCSI. Please see
> > the README.md of tcmu-runner [2] for howtos to generate a zoned block
> > device on tcmu-runner.
> > 
> > [1] https://github.com/open-iscsi/tcmu-runner
> > [2] https://github.com/open-iscsi/tcmu-runner/blob/master/README.md
> > 
> > Patch 1 introduces the HMZONED incompatible feature flag to indicate that
> > the btrfs volume was formatted for use on zoned block devices.
> > 
> > Patches 2 and 3 implement functions to gather information on the zones of
> > the device (zones type and write pointer position).
> > 
> > Patch 4 restrict the possible locations of super blocks to conventional
> > zones to preserve the existing update in-place mechanism for the super
> > blocks.
> > 
> > Patches 5 to 7 disable features which are not compatible with the sequential
> > write constraints of zoned block devices. This includes fallocate and
> > direct I/O support. Device replace is also disabled for now.
> > 
> > Patches 8 and 9 tweak the extent buffer allocation for HMZONED mode to
> > implement sequential block allocation in block groups and chunks.
> > 
> > Patches 10 to 12 implement the new submit buffer I/O path to ensure sequential
> > write I/O delivery to the device zones.
> > 
> > Patches 13 to 16 modify several parts of btrfs to handle free blocks
> > without breaking the sequential block allocation and sequential write order
> > as well as zone reset for unused chunks.
> > 
> > Finally, patch 17 adds the HMZONED feature to the list of supported
> > features.
> > 
> Thanks for doing all the work.
> However, the patches don't apply cleanly to current master branch.
> Can you please rebase them?

I'm currently basing on
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
for-next branch, since my previous bug-fix patch 266e010932ce ("btrfs:
revert fs_devices state on error of btrfs_init_new_device") is
necessary to avoid use-after-free bug in error handling path of
btrfs_init_new_device() in the patch 2. I'm sorry for not mentioning
it.

I'll rebase on the master branch when the patch reach the master.

Regards,
Naohiro

> Thanks.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		               zSeries & Storage
> hare@suse.com			               +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
> HRB 21284 (AG Nürnberg)
