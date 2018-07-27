Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B05C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612E020891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZZOK//3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612E020891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeG0EjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:39:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43210 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0EjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:39:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so1236985pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to;
        bh=qWfBSTpInzWIFH5tMg3/zio3jOOZB0sEzDBSySOcG8k=;
        b=VZZOK//3MkM1al5jsgUTrP095MlT7OWWEyH1IW+JkEBMh5DhlLULQjRcEGYXfYxz5W
         PYIknnN7wMYqjzFLpaYJYsgr4DA4A8qAixbU4xwfqyv/9IJTQMq/Fkf8i3a4C1mjOWnq
         OxlbtF9+n67WUwEld2cLDIrVRZrZOFqYpHR370KKkPfz/osqfhiTsH0n4KcU566b7dqO
         Cf3TC+886K9xzyayhdWVREra1GjGCUGzwvglpruVlH+daL5qfBXCRZZnI9P0pDHKRO1z
         7hhZboCbPleQ/uLoJn00U0uCa2nv/gkiVayTtQbAgZ/bgefbLocEYYuM5tnbHeXJVI+h
         5viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to;
        bh=qWfBSTpInzWIFH5tMg3/zio3jOOZB0sEzDBSySOcG8k=;
        b=m3EFJQEIHMjgz/NTVA2KB3F3NOJbmqjpHDZUUMz8fUjcV85Am3pMbt0Oipy9xX0a3R
         xQV4t7jguQms3+PVNnfKLWAicYIa9SXHG0zElWoltwIwGHK/QlZ85IbFZULtwf0TXx2j
         O2S4oG2NGyDC/7D/0GfYrjEQpLa2vN/UYz4cWIaisaknGFMaeQ/GgpM9fPCgteurZABD
         g0tvrcQDsmO7n29GDYwzpi36rkzwqTYOUipGL3WuTCatpmryTleXDhEKsD6htDBR4Rd2
         aNVJqt08yPCghRttkGXJgLzt8q4Dzalb+F81jmMdqzr9tQbK+gnsTeh1Vd/rdTmmKkYR
         1r6g==
X-Gm-Message-State: AOUpUlEcA+XUVhZA+Pv54JeDNTABWgnTE2eCN5UjRT+Nl9s4XWg9S0o3
        dglIKj7N+kg3jZS87o3YFno=
X-Google-Smtp-Source: AAOMgpfMz/YUrNz1p0y4f7Er9016F5kLuB+1+0GLZvkLi/vRAlORitHEAgLNpGnL4TC7RSTunMSdCA==
X-Received: by 2002:a62:3b89:: with SMTP id w9-v6mr4817138pfj.80.1532661579784;
        Thu, 26 Jul 2018 20:19:39 -0700 (PDT)
Received: from localhost (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id y3-v6sm8765025pfi.24.2018.07.26.20.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:19:38 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:16:35 -0700
From:   rd_dunlab <rd.dunlab@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: [PATCH 0/4 v2] arc: some allmodconfig build fixes
Message-ID: <15326613951079@infradead.org>
In-Reply-To: 
X-Mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Hi,

Here are a few patches that fix build errors or warnings that
I encountered while doing arc "allmodconfig" builds.

These patches do not fix all of the build issues.


 arch/arc/include/asm/delay.h            |    3 +++
 arch/arc/mm/cache.c                     |    7 ++++---
 arch/arc/plat-eznps/include/plat/ctop.h |    1 +
 arch/arc/plat-eznps/mtm.c               |    6 ++++--
 4 files changed, 12 insertions(+), 5 deletions(-)


-- 

