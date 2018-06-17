Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F7E20895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRlbxH2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F7E20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933334AbeFQBZo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:25:44 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42673 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756937AbeFQBZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:25:41 -0400
Received: by mail-ot0-f195.google.com with SMTP id 92-v6so14933275otw.9;
        Sat, 16 Jun 2018 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZnQbdfYArYMP4+Xa9VQ8teSxLEs+5QRhSw2MACrklYc=;
        b=iRlbxH2eOPf6FVgcUzzH5AM/cnwh9ZwPCDi/Q/DQ3D4TxL3A7jNrPvwRrqkS+ff8ER
         5GmTYfmQMWFUI2QCxT/AZlJ3HE/AD/FsCW61pGoIw+dUEzncRAlGmmJ2COWqhj1/yk5g
         z3Sz+eh6LXaAsVLQztL/3RXtqXo5ZPWUVmMa3NT8p4AlZJxwvn6xl7RpWsx6ycluRHbu
         uK3d5xp4IETXRLhGBxgkKKb7rJoXG5ziqw5d05IpkNfAyaUjqSpdB0K0EW0O4slYA7Iw
         r4FvxOkWTxeq1+EVHudgVGmDhTmGAxnB7xegQK0hgM3OUWLs5nfEcWQhL3S4MXo/Ourg
         OX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZnQbdfYArYMP4+Xa9VQ8teSxLEs+5QRhSw2MACrklYc=;
        b=mY7/xYu1FVrPFOQunQN3xmdO6Eyu7M9Q7Jrfe8mJwDTK+YvIcoAP3mkSGnqen10gbY
         ehCrJ8rGfJDS63+omCYZCgmd8thNSc0zjCRdF5bB7/A6TpA+XFHD1NhwxwmyNG8uIsCo
         wR4urG8D232HgKUIYAGWkwBPK/1rgzwi1+YPuDDRLn1ENQ7QJZeTIeK05d0430HGiQgc
         2/gqYwFUGRFCSJQVBUHwRvuEvNecNH+e+O+KlpR97Q2JIXtUqD+sW6+WqjNCo5m57S0b
         stgXQ8EofHPP47O6uE+J+oW26mwo9DF2wtEmFvEng/oxt40idb2pApswTd0CLtqhGL+m
         zYIQ==
X-Gm-Message-State: APt69E2PQdhV/6emTeQXfhDrPRzeHm1Ftb+0F4LbEQCFwjvNfdARv/+I
        HAwwSX8mpTla9Z3Bsc4UfRI=
X-Google-Smtp-Source: ADUXVKKIguO965VUob4Fi0a5qvI61HgY9b6130nD1flPEs7o1vy49zHlFNw2PG0/kja8EYgQM4vUDQ==
X-Received: by 2002:a9d:14db:: with SMTP id r27-v6mr4495825otr.190.1529198740991;
        Sat, 16 Jun 2018 18:25:40 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id u13-v6sm4666912oiv.18.2018.06.16.18.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 18:25:39 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] mm: gup: don't unmap or drop filesystem buffers
Date:   Sat, 16 Jun 2018 18:25:08 -0700
Message-Id: <20180617012510.20139-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

I'm including people who have been talking about this. This is in one sense
a medium-term work around, because there is a plan to talk about more
extensive fixes at the upcoming Linux Plumbers Conference. I am seeing
several customer bugs, though, and I really want to fix those sooner.

I've come up with what I claim is a simple, robust fix, but...I'm
presuming to burn a struct page flag, and limit it to 64-bit arches, in
order to get there. Given that the problem is old (Jason Gunthorpe noted
that RDMA has been living with this problem since 2005), I think it's
worth it.

Leaving the new page flag set "nearly forever" is not great, but on the
other hand, once the page is actually freed, the flag does get cleared.
It seems like an acceptable tradeoff, given that we only get one bit
(and are lucky to even have that).

As hinted at in the longer writeup in patch #2, I really don't like the
various other approaches in which we try to hook into the (many!)
downstream symptoms and try to deduce that we're in this situation. It's
more appropriate to say, "these pages shall not be unmapped, nor buffers
removed ("do not disturb"), because they have been, well, pinned by the
get_user_pages call. I believe that this is what the original intention
might have been, and in any case, that's certainly how a lot of device
driver writers have interpreted get_user_pages memory over the last
decade.

John Hubbard (2):
  consolidate get_user_pages error handling
  mm: set PG_dma_pinned on get_user_pages*()

 include/linux/page-flags.h     |  9 +++++++
 include/trace/events/mmflags.h |  9 ++++++-
 mm/gup.c                       | 48 ++++++++++++++++++++++------------
 mm/page_alloc.c                |  1 +
 mm/rmap.c                      |  2 ++
 5 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.17.1

