Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FE5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C064620892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUDpvRYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C064620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLGGaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:30:46 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:46836 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:30:46 -0500
Received: by mail-pg1-f169.google.com with SMTP id w7so1250653pgp.13;
        Thu, 06 Dec 2018 22:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gw0GKbOmZn3aBOU80S/qsHk3rpBVZI3rfX0kZSo7L1g=;
        b=SUDpvRYEGffdFT1MsQ3Um7+IIfKu/a6yihW+LvTTswkOQwCzc5a5UmomhZBWCohHAH
         euFgetSDJDw/kmj4hg4mLa82Vmhu+hbZNepTLvECQ9FnivA4aYRbl9bB41HzKZoHQQMG
         yZHbm4aqpjni69NOg0qDEk98Xh9bJi74j0MZrymffkf08fBCXXqlbVAwbwcxv4aANoCe
         NtaomaLwTHw2Yfp84tmkzULn3x4mgtW2rvFFl6emXXUefgsZdxgo8ELFIi8CQy9Spyru
         I7iTTJK4Um5ROZ7c5v+Yi6aL/SPKkwLILBqGblcZGgIMW1wZV5xbjrOZi6bVAujMas/M
         e5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gw0GKbOmZn3aBOU80S/qsHk3rpBVZI3rfX0kZSo7L1g=;
        b=HEird9D2gCc/6m4O7DgaJPME2nSHDDUA9sa4+p4drn1jeVjKdXE9kU5LT8AZvyueUM
         R/Q9CHXIC/tNT7CFb5WkbNRjeH8/s/74n1d5mGUSMqlLry5D9VSIs5viLsr5sXVcdZi0
         CPoN77IsUU/5VA3uFz8EDGAl+bQqAsQywOCT73Z/G4EcjPB1W6jEHjlZwsBsNBzMOgtK
         Nd9XValnMMRuYvz27CmbSAYt9MsxcWAR4iqdFPqnim36/Kwq38BVGH7FT+nDIRkA0r5o
         wZYBJ4dJtLATGaDt07v/S56p3xEE5Fy9traAnlufr/ObKKgDiI/q1YDzZIzAtmW0di6c
         cX8g==
X-Gm-Message-State: AA+aEWajMMstMTyQGR0VGIVthZ3HANE//1U6m0OFv/Z2yrML7/CzmYT6
        nNBP5ixhcifscBDPtqv59sFlPYmw
X-Google-Smtp-Source: AFSGD/Xe2XxlWXpl29GCcR3Qsp3zAHe4aQC+o2nif+mW5XM2HNVMx33f6o8Gc5zos7iHDT9c1JWVYA==
X-Received: by 2002:a62:c583:: with SMTP id j125mr1056229pfg.37.1544164243728;
        Thu, 06 Dec 2018 22:30:43 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 7sm7137563pfm.8.2018.12.06.22.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 22:30:43 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Eric Paris <eparis@redhat.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCHv2 net 0/3] net: add support for flex_array_resize in flex_array
Date:   Fri,  7 Dec 2018 14:30:32 +0800
Message-Id: <cover.1544163962.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the support for the total_nr_elements's growing or shrinking
dynamically, flex_array is not that 'flexible'. Like when users want
to change the size, they have to redo flex_array_alloc and copy all
the elements from the old to the new one.  The worse thing is every
element's memory gets changed.

To implement flex_array_resize based on current code, the difficult
thing is to process the size border of FLEX_ARRAY_BASE_BYTES_LEFT,
where the base data memory may change to an array for the 2nd level
data memory for growing, likewise for shrinking.

To make this part easier, we separate the base data memory and define
FLEX_ARRAY_BASE_SIZE as a same value of FLEX_ARRAY_PART_SIZE, as Neil
suggested.  When new size is crossing the border, the base memory is
allocated as the array for the 2nd level data memory and its part[0]
is pointed to the old base memory, and do the opposite for shrinking.

But it doesn't do any memory allocation or shrinking for elements in
flex_array_resize, as which should be done by flex_array_prealloc or
flex_array_shrink called by users.  No memory leaks can be caused by
that.

SCTP has benefited a lot from flex_array_resize() for managing its
stream memory so far.

v1->v2:
  Cc LKML and more developers.

Xin Long (3):
  flex_array: make FLEX_ARRAY_BASE_SIZE the same value of
    FLEX_ARRAY_PART_SIZE
  flex_array: support flex_array_resize
  sctp: fa_resize sctp stream instead of redo fa_alloc

 include/linux/flex_array.h | 40 ++++++++++-----------
 lib/flex_array.c           | 73 ++++++++++++++++++++++++++++++++++++--
 net/sctp/stream.c          | 87 +++++++++++++++++++++-------------------------
 3 files changed, 130 insertions(+), 70 deletions(-)

-- 
2.1.0

