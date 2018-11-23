Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1195C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9617D20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHaT7Kc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9617D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439421AbeKWNAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:00:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40909 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:00:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so2396915pgp.7;
        Thu, 22 Nov 2018 18:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ENN/1jJ8EwAaPH9pZGXV3pxliDwM4jcLxlfjImodmpA=;
        b=fHaT7Kc1jIM2nILCZHTpECWwaB3WbHjGO/87uFqPWG66A2U/Y1R1QNTYA5Cfq+7i4K
         2ZNiuto8r8m6/c0UdmJF1DGEUT9cP1dWruhfYtxnRjuUe3hrzmzDOGh81v+T3PI6PZKc
         5z9D1z0WJH2vmLKoUxTURWmdBqzYtLGs+TPCk7c7pnPayegWfpOGLdDxXCMElvMjpIj5
         Lj3DBVSGW+gv9FYn6IG5GkOasxrOOB2EIsrVVeep4DNcgF93ujWcC6zE/sp4Ae5EV5+g
         qR2bWmT32T//+XKXix5jtQmpTL9DgzFgUm62hKa0TiSm5tOvvec5kY37MK2rXuozEVeq
         yMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ENN/1jJ8EwAaPH9pZGXV3pxliDwM4jcLxlfjImodmpA=;
        b=dSpsDu7xPfCU6zcx6b1MERijIrDMdew3VlfPgIYsNrHzcrELfUWXqk+e/dwAI9xClz
         WvKIsDln4/GJnD2LVLfPDUZNJfuv1Li2pPzXsXbTz5KFebMBdjXIOWW2fdbn6iqtHjWv
         BTYs3VTnaRcH5gIUfq++fwycstH+hUIyYsoN/sHGa2bwBZg38vCFte/NbeC32pyUajgJ
         /UqQli8GxbXEnDqy1t3waifwJBzgb21bWRT/iCOGB3P9IL2vCYcOz7wCy/eRcKoTuXx+
         MooCFVr0gbv7t4DI/HZZKMtt86l2T5YMafqbxr/fEB4BQ23MeXdIdStCadAL++S/NgJA
         Hf+w==
X-Gm-Message-State: AA+aEWYZdVHjLPdDTVq8oiga/+jhFs5nGreF+07WZG1wGj98Y4k68xfC
        QJ8XUxC81ya/m1vkCjAhLP8=
X-Google-Smtp-Source: AFSGD/Xd+BENZJfVl8hDbs+YsSSyIhoWtHcwgJFcYORifBuVIkWRfpXSNIq9xgS3PrKppw9wNXBKDA==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr12346836pgk.386.1542939474092;
        Thu, 22 Nov 2018 18:17:54 -0800 (PST)
Received: from localhost ([175.223.19.111])
        by smtp.gmail.com with ESMTPSA id i62sm35172360pge.44.2018.11.22.18.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 18:17:52 -0800 (PST)
Date:   Fri, 23 Nov 2018 11:17:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Remove obsolete bust_spinlock() implementation
Message-ID: <20181123021748.GB1582@jagdpanzerIV>
References: <20181122141529.14933-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122141529.14933-1-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/22/18 15:15), Petr Mladek wrote:
> The commit cefc8be82403cf ("Consolidate bust_spinlocks()") kept
> the s390-specific implementation because of the absence of CONFIG_VT.
> In fact, the only difference was calling console_unblank() instead of
> unblank_screen().
> 
> The common implementation in lib/bust_spinlocks.c started to call
> unblank_screen() explicitly since the commit b61312d353da187
> ("oops handling: ensure that any oops is flushed to the mtdoops
> console").
> 
> As a result, the custom implementation is not longer necessary.
> And we could get all the other improvements of the common
> implementation for free.

I believe I sent a similar patch several weeks ago and it's
in s390 patch queue as of now, waiting for the next merge
window.

lkml.kernel.org/r/20181025081108.GB26561@osiris

	-ss
