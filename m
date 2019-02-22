Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F05920818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyQ0AHFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfBVOyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:54:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40414 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfBVOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:54:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so2739093qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 06:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2xPwnetDMJ7UuPEnGsEaiMlGDFY3dv7wYRH7IEpLn3U=;
        b=kyQ0AHFdQhX1sJQZilAvruy1HRlcrf16lphe0wENw941Y1v/BaVo+RmBwwFbG4bJTV
         yAnk/Oi7+vQQBoaDDnyl7kcmahldNoNkJ9+9qJi8FbN0Cl+krk/qS3/hjnzRG29sXltf
         BwM2qbGHJhn+dFzdxH/ipHkdG2Lq8VBb4UPpumcsPFnMuew1MsdETFu9adQYbSZhO75G
         mh/4t5X0gZ+4GLsoUNlcHHcdzoXvOOkadLgVTO7MzDgJ3DBSFFKrQvz2whYnE6d3Lxw4
         GYFqI96TDbRmCybXp0p959uub7YpfkiaWd2ZP1vVyMSoY+vmrx2DamDpAmGErJhk6000
         lD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2xPwnetDMJ7UuPEnGsEaiMlGDFY3dv7wYRH7IEpLn3U=;
        b=ugfWhz4Q+QC6WV8k8FwGXILKgPfDc8P2ad2koUf4DB+HtsFDEty362kvNFD+SE+E4D
         ht4midyfiOVFOr8ixixHVr1D0LyHGSOd4nCF40iNSWrbcl0cuOpywgb4o0MosFGODVLi
         o0cH7RJN4tvgJMBPcnjUfzaZWz5lAc6LFtwDniuh5xblHgN8IeL0td6FbVP1qGXIP5R+
         mv4YhWcFSd+yJak0A5wfywwZJ3FdfyTa3HZOk1O2WvGdGe2PoyBRwQH45jcFnbjLskgW
         t7T8UQ5/1Boay2YiQUntHpRAtYW5AtfMlvQx3kj1cf/v0hx2bL+qbhcsTeQZ7zyJ75ww
         Hi3g==
X-Gm-Message-State: AHQUAuY8Hn0YIam3DYxXfdMfSk3T1NfT6wVxjHnDz5ThUbmTEuhzS5wy
        vYKPOyGyU766zY44EKyzy+I=
X-Google-Smtp-Source: AHgI3IbgIBaUM1LbvHLUzru11DfVl6a/LRa5wqpiXl3uPhp5TWoV99CUasNaX1m/MSN0VQqkag6Q0A==
X-Received: by 2002:ac8:31d7:: with SMTP id i23mr3364509qte.123.1550847285793;
        Fri, 22 Feb 2019 06:54:45 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id a68sm984513qkj.82.2019.02.22.06.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:54:44 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82A48410DB; Fri, 22 Feb 2019 11:54:42 -0300 (-03)
Date:   Fri, 22 Feb 2019 11:54:42 -0300
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, Mansour Alharthi <malharthi9@gatech.edu>
Subject: Re: [PATCH v0 1/2] perf: Copy parent's address filter offsets on
 clone
Message-ID: <20190222145442.GA26132@kernel.org>
References: <20190215115655.63469-1-alexander.shishkin@linux.intel.com>
 <20190215115655.63469-2-alexander.shishkin@linux.intel.com>
 <20190215181038.GK5784@redhat.com>
 <87d0nkc77p.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0nkc77p.fsf@ashishki-desk.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 02:56:26PM +0200, Alexander Shishkin escreveu:
> Arnaldo Carvalho de Melo <acme@redhat.com> writes:
> 
> > Em Fri, Feb 15, 2019 at 01:56:54PM +0200, Alexander Shishkin escreveu:
> >> When a child event is allocated in the inherit_event() path, the VMA
> >> based filter offsets are not copied from the parent, even though the
> >> address space mapping of the new task remains the same, which leads
> >> to no trace for the new task until exec.
> >
> > Peter, I'm processing this one, ok? Ack?
> 
> Any news on this one?

Will process it now, was waiting for some ack from Peter.

- Arnaldo
