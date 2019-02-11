Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D0FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6419021B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="2TFXZsd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfBKPzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:55:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37597 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbfBKOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:02 -0500
Received: by mail-yw1-f68.google.com with SMTP id k14so4255228ywe.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hj0MjswvEEpi6GUcA72y7SumBVEoA1u1KmXStbni5s8=;
        b=2TFXZsd38q8t9ZoeodhurKIh7X92YNULkkeVe3drZ/Zi4m57s0KWI3UMxhmRUEAgef
         iSKnqIgH5Qz8p4GfMeCUl6O3ApsKvWYIynVbWd570KzP/TlnxxuOHtJTZAvWBXqUMfiq
         3L7jKBkyHL/4DK0NBa82UZN+unsVLpVQvnrRpdDzDfVbNhAKuanXO6KTU4MumzwI44Uq
         ab0dQbFVtiIrPpLUGkmB2/s3/EvXOrD9qshNfsYz75jO/iJ0L5afMQPeKkuUfO9pUhxm
         TBTSzo4pShwy6LJcDzWRBhHeRDeJgg3EGsIYZy0SweDwOuNJvSkp6VgWR0Qs8M9kX42R
         qbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hj0MjswvEEpi6GUcA72y7SumBVEoA1u1KmXStbni5s8=;
        b=hwUa1wq7fzWh6itvidyfZbAgwPbUpnlj9oH2J1IfBPbwSnbmZypo+3YhGSmghUUCuK
         I4d7EB/hTjYNzgZzzwQnwkGVMpE7dt8WORPCZX7i9PNBLO/S9MIrjLyq+BhVYsafZfed
         SaC0PGDFG85xeLkEPrzWFm6Q74rfFySbVnNDrwDHF06lDQSs7X0eFLGEMzOYUnPp8lHn
         IpdY7RFjErPeB8/z8B/0YT3PG4Px7dzrlJieOH5doqHpiXk9rRtc+gSCjxmp11YurKbY
         zmhzB9BmMG1fq6O5Lfivqmjx7wBLTMPlVBq14qwLDZO6pCEVqWN7rB2PxpegiVRHcIDs
         cSYg==
X-Gm-Message-State: AHQUAuanNtOiB6aESXjsL4UyxQtePugZ4vER8nD+XuagSPhvYzg3eXw+
        JAkfB6u7jXZwVpFvXDzys4pDBQ==
X-Google-Smtp-Source: AHgI3IbCypHpz0Nss5yaUTXdv6w42taFK7B37pLDjPJ+qbBAZdP0dEFmMDVg5YQ4GTsm07T0oLSfdw==
X-Received: by 2002:a81:3d96:: with SMTP id k144mr28899978ywa.339.1549895700968;
        Mon, 11 Feb 2019 06:35:00 -0800 (PST)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id v9sm4149610ywh.2.2019.02.11.06.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 06:35:00 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:34:58 -0500
From:   Jon Mason <jdmason@kudzu.us>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Joey Zhang <joey.zhang@microchip.com>, dave.jiang@intel.com,
        allenbh@gmail.com, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_transport: Free MWs in
 ntb_transport_link_cleanup()
Message-ID: <20190211143458.GA13951@kudzu.us>
References: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
 <2dccf9e6-d9d7-200e-f689-56c962ea5e7e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dccf9e6-d9d7-200e-f689-56c962ea5e7e@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 06:16:02PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 06/01/19 08:12 PM, Joey Zhang wrote:
> > If NTB peer host crashes or reboots, the NTB transport link will be
> > down and the MWs of NTB transport will be invalid. But the
> > ntb_transport_link_cleanup() does not free these invalid MWs. When
> > the NTB peer host is recovered later, NTB transport link will be
> > up and the ntb_set_mw() will not reset up MWs. Because the MWs of
> > NTB transport are invalid, the NTB transport will not work.
> > 
> > We can fix it by freeing MWs when NTB transport link is down, then
> > the ntb_set_mw() will reset up MWs when NTB transport link is up.
> > 
> > Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
> 
> Looks ok to me.

Added to the ntb branch, thanks!

> Reviewed By: Logan Gunthorpe <logang@deltatee.com>

Looks like your missed the '-' ;-)
I took the liberity of adding it

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 3bfdb45..6e8902d 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -862,6 +862,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  	if (!nt->link_is_up)
> >  		cancel_delayed_work_sync(&nt->link_work);
> >  
> > +	for (i = 0; i < nt->mw_count; i++)
> > +		ntb_free_mw(nt, i);
> > +
> >  	/* The scratchpad registers keep the values if the remote side
> >  	 * goes down, blast them now to give them a sane value the next
> >  	 * time they are accessed
> > 
