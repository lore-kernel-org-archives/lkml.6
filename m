Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3061C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BDE208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+o07Oqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BDE208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeH0WAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:00:54 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:41977 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:00:54 -0400
Received: by mail-qt0-f180.google.com with SMTP id t39-v6so18366714qtc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KVLZ8vAN9XvG1iTfPcq/M/NtTgRNoVJn4MtutliEVJI=;
        b=X+o07OqvRClk9gR881kOE6nnBOsg0BznjiC5lsWaVMSdi7aZlCtJPthOWT73vnFMbW
         puRfsEwbCyjryQ3pW0jU3j50F6ThTMnVFeqZNl9J6UTvFYe1TabD4h/NtYqjJluzA+l1
         maV6nUT7AUtBV9DG/lWoifBW/JcrdSEFyNzMm/ewmuCzxWiV+s5HxrclacaysFvB9C7O
         vBTT+tRQGLSK7aAsQmcPd0sG0xomhC0cfw421LGEjXZhKfNnydwgkWSwYgKXi42VgYoS
         RlN+up8JAo0XypWvVlxldb5H0YtZ8h1xABcVvdE/KBnPmD8kdM37l0Pb7LRkYo3vkKIL
         eImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KVLZ8vAN9XvG1iTfPcq/M/NtTgRNoVJn4MtutliEVJI=;
        b=ptvbVNf6W9TBU5HLqBlL7ITLsQVCtX1SJQA9xv8TjPKlzPokSVyzFj3qILWknqSGzj
         2lvW75KwnncKlXJ7NUPcNEGrKxaE7XYphK92aQ+Q2t6LVC4LiCqysXRvYoCVTcoRQD3i
         w4rn3MQRCQNlRn1ZxmZLptwoaLZop81W0W3e0UuvfrXyUpN3jdmmBe1fhufHcjNXZxQD
         DoYPR5v3zsTjqlqgcA/0wQH+oPLu+nVpVVs0Pl8OP54rReUulld1j+AXnWzSSHhzJG5u
         mmJKrVm6oeGW2QP5E7LHlRVwm6292GF27HIpM+IWvoRIIyvsWXHjfp/MU/cQ4GpPhU0c
         Ceug==
X-Gm-Message-State: APzg51AjkVCb+qP+COBQxoPWEHY0aQU1Qgw2zYeHjG3k3V+CgUvl7bGL
        5NyK0NaOf38p83OyyjJRZoE=
X-Google-Smtp-Source: ANB0VdbgfjJ+Mx7y09NlbxyjYTG0+QKkt+h0oFG/SBndv97JePahoJoISvU3U9vnOzhDCIpIqQYX5w==
X-Received: by 2002:ac8:8ad:: with SMTP id v42-v6mr15402965qth.297.1535393594093;
        Mon, 27 Aug 2018 11:13:14 -0700 (PDT)
Received: from 0021ccb48c25 (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id d11-v6sm9638435qkg.14.2018.08.27.11.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 11:13:13 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:13:11 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: swiotlb cleanup (resend)
Message-ID: <20180827181309.GA3834@0021ccb48c25>
References: <20180725113802.18943-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:37:56PM +0200, Christoph Hellwig wrote:
> Hi Konrad,
> 
> below are a few swiotlb patches.  Mostly just cleanups, but the removal
> of the panic option is an actual change in (rarely used) functionality.
> 
> I'd be happy to pick them up through the dma-mapping tree if you are
> fine with that.

Hey,

I put them in my 'devel/for-linus-4.19' as I would like to make
sure that they work just fine with Xen-SWIOTLB and some baremetal
machines.
