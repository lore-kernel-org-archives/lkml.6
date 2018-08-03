Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846EAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6DB216ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8FUNbFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6DB216ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHCHRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:17:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38192 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeHCHRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:17:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so2287192pgq.5;
        Thu, 02 Aug 2018 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k542X4pG5W7XIPYrOeJTmG6azuuDbAC/Kxa8+Np9U+g=;
        b=W8FUNbFkgMbNg9qzbrEFqEP/SekXtYymjLEaB4VcqNhohGXn+PWfdm3LZVB+wil7Dn
         6Y1Md3oBGJabLXgLMRb5KqCCWPoW2gxrTzrWGksliVCnoQ0CFTMflRfHIdLcMcyiQD8K
         ZlNGJLY9irfIL3Hr/EdRjgHB5+An5PauCgAmyzOGfQ2rlxSI3kSOuVDwxnFDsg/vdEsh
         /vttA+2d1mP2RrTA3ASZQ+QBVXfix8AXCaW86F/w5MkI65EjbNcpjW6iba1kmoRhNGsx
         ZsnwMNv0vx2me4diM603eOnRgCgF/HBpbynnIgJiBHIk18V+71eIyrnBlha34eVU1qAp
         5imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k542X4pG5W7XIPYrOeJTmG6azuuDbAC/Kxa8+Np9U+g=;
        b=q3ptnRjeD6fhhXvnDSaoq+61jRzrRNizWwLJnGGqS9TLWJQBSFXveaY77QCJ7vEb04
         EDPzsT9UALd7LqV4aUTJT2mGKisGQFj+4M64SPBDk4jLiR4jOOFCe2iwyx0seQIVFJbs
         fZOAE6INGWOXZOnhPBtLMAISMwKGQPJ98tIZDj85Ei8g9RpljAQ9K6GrJ43lqqbwDM0b
         7Rul+XcsnrfAmh4DyRLPQq/nGu1IMKIbfxPX1iTI+5TjNDboKy0R6hDOEkx22bpYKQzO
         Gc6JRSyTUK982HhlxtfmHH3CZM3Qxt0AM05YBI9e2tah6XECSMLN//aLa5xwG1pE3iMs
         lxoQ==
X-Gm-Message-State: AOUpUlFC6uiS/nbMFC/+UqFwYCw2jr+FapqFYu9pvuP2pkyky1xcXtLM
        PpNUMz+yTWRb05G8hCYhIFQ0GoKU
X-Google-Smtp-Source: AAOMgpdxFtR2vaoX7Dz3IyxNwn63HBAQyrgV7N+Z4dbkyXMf0+52aKLSovef403C8xBZgWPob35eew==
X-Received: by 2002:a62:9d14:: with SMTP id i20-v6mr2727076pfd.3.1533273792068;
        Thu, 02 Aug 2018 22:23:12 -0700 (PDT)
Received: from localhost ([175.223.10.158])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3368643pgv.61.2018.08.02.22.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 22:23:10 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:23:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803052306.GC502@jagdpanzerIV>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
 <20180803023929.GA7500@jagdpanzerIV>
 <20180803030019.GB86818@rodete-desktop-imager.corp.google.com>
 <20180803041302.GB502@jagdpanzerIV>
 <20180803045121.GC86818@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803045121.GC86818@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/03/18 13:51), Minchan Kim wrote:
> 
> AFAIK, onging writeback page couldn't freed so it was not writeabck problem.
> 
> What I'm tryig to fix is read part.
> If we use swapcache, it shouldn't be a problem either because swapcache
> has a reference count and we should wait PG_lock release before the freeing
> from the swapcache so there is no race condition.

Hmm, any chance a WB device can be async on its own? We add a page
to a new bio and submit it to another async device driver. Then we
return back to the upper layer (swap), which can free a page before
the device picks up a request. Can this happen?

[..]
> However, I decided, at this moment, going this simple way for
> stable-material to solve #0 and #1 problems at the same time.

Agreed. Thanks.

	-ss
