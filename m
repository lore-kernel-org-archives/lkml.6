Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DC8C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789F1223FF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789F1223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHKKmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 06:42:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40385 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 06:42:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so10112412wrs.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 01:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMk2XbP3Ym0VKedN94Zx9NDJFIGXLl4X4EE8gfYo0/4=;
        b=Z2FReAK4kG5moX7kM+wDopVChBvFbEZ09CS1wusvxDmlmQ54JFQhwiiPD6evJN64/S
         y8aJTsk0SYZK6c5NGCQJUXMzr5hY0IIVFz/yNV0YFKHpse0vEEa2BZAIXPjbRmeYFiFA
         KTdxJ4U+qmoatfrFR3W2ymVqdPsS/db4O1R8yGaRd9Wot3LmRLeCEXRST5Y97rXQmS4N
         FKLKpJnzxv2f6gqKb2yBjrBHrGgi6B+vcKix02P6D7gNaIzy1NOpY6O9dcVCVRK/SFR3
         MEnCm7p9inGA93Vt3mQh0kZ0UGL8NAFf7QlvqW9CuetDdts5pqemGhAyOT7PSQKx68wQ
         wQ7g==
X-Gm-Message-State: AOUpUlEJaFuCsVbOp837BBEEGSa/mPfWNDGSuj0aO62CHpHhuK+egNo4
        AQhcNAwpL0RYA0pqAO2IGoM=
X-Google-Smtp-Source: AA+uWPwWuhNyS8lNO/qE/LrmlZIVwZdfOxGfik3l1EfOwqDUu98cy35xLr3+KWyd5Iq+r3s6zn9N4g==
X-Received: by 2002:a5d:4542:: with SMTP id p2-v6mr6092179wrr.191.1533974927554;
        Sat, 11 Aug 2018 01:08:47 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id w14-v6sm3084538wme.6.2018.08.11.01.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 01:08:46 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 14319124832; Sat, 11 Aug 2018 10:08:46 +0200 (CEST)
Date:   Sat, 11 Aug 2018 10:08:46 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 3/3] mm/memory_hotplug: Cleanup
 unregister_mem_sect_under_nodes
Message-ID: <20180811080846.GA24835@techadventures.net>
References: <20180810152931.23004-1-osalvador@techadventures.net>
 <20180810152931.23004-4-osalvador@techadventures.net>
 <20180810153727.c9ae4aab518f1b84e04c999a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810153727.c9ae4aab518f1b84e04c999a@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 03:37:27PM -0700, Andrew Morton wrote:
> I guess so.  But the node_online() check was silently removed?

A node can only get offline if all the memory and CPUs associated
with it are removed.

This is being checked in remove_memory()->try_offline_node().
There we check whether the node has still valid sections or not,
and if there are still CPUs associated to it.

In the case that either we still have valid sections or that we have
CPUs linked to this node, we do not offline it.

So we cannot really be removing a memory from a node that is offline,
that is why it is safe to drop the check.

It was my mistake not to explain that properly in the changelog though.
I will send a V2 fixing up all you pointed out and explaining
why it is safe to drop the check.

Thanks
-- 
Oscar Salvador
SUSE L3
