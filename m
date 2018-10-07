Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09730ECDE21
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DCD2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBxgGcKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DCD2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJHFoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 01:44:21 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:45642 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeJHFoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 01:44:21 -0400
Received: by mail-pl1-f179.google.com with SMTP id y15-v6so9155308plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yxp5id9lMNvSglWhiNLo1rmpjCDxobRwASmj+aoEj7g=;
        b=EBxgGcKhBKklnjENJ90TYhbHIpYEqMovFwW4IZCL5euGyQdCKW/G02LyL9w5rjTN9e
         txH0DEpR41mHWBHy6gfywaHxCUYQ63iFuMKMKK4nBIJLzjEahD27DngGl1ayBlZNPITK
         hPHJcZo1Onke0fsKg1vhu8KRk3RWcsY4lnhb7nE93CSbv+IiShi5U34Rbg5jnKI01Ekr
         Qm/1xlqC/LtLRzADwBV5bp/fMXJ0rSTu7CfE+LlLSJCW4BkRq1+AnS6aIQ8UKeJJyhc3
         G1v+4eyKfb3vJRjLjJHR4kjFZcsudQRKLgP+1dPFrAlIjJZG1JYlYVFJtb3Teubh6pqE
         NACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yxp5id9lMNvSglWhiNLo1rmpjCDxobRwASmj+aoEj7g=;
        b=ha5WR9T0DCEBj1mDI43u3NAPD7fKx6NrzcYECaNJbZJTWZ2uvWnYQYjTT/Kii9Q7kN
         RDKVVshta6qJ5+GMdBI70YUmJVztiaZsaDE0WXnboNbblezJMBRZm+EbHG6ken0eZ1Al
         EHZxafq+YrqpEqacAaXzKUozLJTryDmLx1wPuXvmDsoE/j+d3ene+fudpUug6Ud/qjiv
         rX+qzl5y2gqrpDN6znRooXbTV3aXg11wd19huZZEP5jYbzRxGGrt2QBOaLQUQSD6eR74
         SGFCU5CVhy2cWcDfD88djOq+I7Vcq21yaVq0wqoTLJN5S0rwXNmGWoy42Jlc+oy9i5uj
         Cu5g==
X-Gm-Message-State: ABuFfojKVvvB6WH7vtb50v1IMiZNEqkcGOGFYKZNySNP8o06x+AN1G4A
        1hVvrnuj46bjofSZEMmDnOLAOA==
X-Google-Smtp-Source: ACcGV60yvI5au8Dy95thzySaNf65JOhVuTmxVqFoFhgtAX5hOuVARm7hrtu5q/wZ3rQMvpss5dKTPw==
X-Received: by 2002:a17:902:680e:: with SMTP id h14-v6mr21527729plk.177.1538951737974;
        Sun, 07 Oct 2018 15:35:37 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m11-v6sm17694665pgn.39.2018.10.07.15.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 15:35:37 -0700 (PDT)
Date:   Sun, 7 Oct 2018 15:35:36 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, page_alloc: set num_movable in move_freepages()
In-Reply-To: <20181005142143.30032b7a4fb9dc2b587a8c21@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1810071535080.189597@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810051355490.212229@chino.kir.corp.google.com> <20181005142143.30032b7a4fb9dc2b587a8c21@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018, Andrew Morton wrote:

> On Fri, 5 Oct 2018 13:56:39 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
> > If move_freepages() returns 0 because zone_spans_pfn(), *num_movable can
> 
>      move_free_pages_block()?           !zone_spans_pfn()?
> 

move_freepages_block() more accurately, yes.  And yes, it depends on the 
return value of zone_spans_pfn().
