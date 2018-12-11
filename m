Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD930C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0CE2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="us5/Skef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0CE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=desy.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeLKSzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:55:38 -0500
Received: from smtp-o-1.desy.de ([131.169.56.154]:44017 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeLKSzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:55:38 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2018 13:55:35 EST
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (DESY-O-1) with ESMTP id C78E32809D9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 19:48:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de C78E32809D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1544554114; bh=yX2LlJBHMvi6oXwSBlMv6uM7Aw6CiSKmHOt3efypaCA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=us5/SkefiBWemUP8Nk9efm1+i55qnDvwLqhE9/L1FUcT0Xvp9zlbnv6DL6hFfnszf
         LMcC9Fp+8YhkFH0r0krIXVRV4grWp9ptkdCniIF9tyFaecISLwl4//yTtjokwhF9JH
         NO7Bl4qGmZ/0NjV/wdQfC3YBdd4p3ldTyowTMTKY=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id BA480120856;
        Tue, 11 Dec 2018 19:48:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (DESY-INTRA-1) with ESMTP id 837213E901;
        Tue, 11 Dec 2018 19:48:34 +0100 (MET)
Date:   Tue, 11 Dec 2018 19:48:34 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Message-ID: <915991654.5303561.1544554114494.JavaMail.zimbra@desy.de>
In-Reply-To: <20181211151631.719148510@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org> <20181211151631.719148510@linuxfoundation.org>
Subject: Re: [PATCH 4.14 26/67] flexfiles: use per-mirror specified stateid
 for IO
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.10_GA_3713 (ZimbraWebClient - FF63 (Linux)/8.8.10_GA_3041)
Thread-Topic: flexfiles: use per-mirror specified stateid for IO
Thread-Index: vMQzWgOUiVe9PimcauPEYD64kmgRvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for pushing this into sable as well. However, I think patch makes more sense
with 320f35b7bf8cccf1997ca3126843535e1b95e9c4

Tigran.

----- Original Message -----
> From: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> To: linux-kernel@vger.kernel.org
> Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "stable" <stable@vger.kernel.org>, "Tigran Mkrtchyan"
> <tigran.mkrtchyan@desy.de>, "Rick Macklem" <rmacklem@uoguelph.ca>, "Trond Myklebust" <trond.myklebust@hammerspace.com>,
> "Sasha Levin" <sashal@kernel.org>
> Sent: Tuesday, December 11, 2018 4:41:26 PM
> Subject: [PATCH 4.14 26/67] flexfiles: use per-mirror specified stateid for IO

> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> [ Upstream commit bb21ce0ad227b69ec0f83279297ee44232105d96 ]
> 
> rfc8435 says:
> 
>  For tight coupling, ffds_stateid provides the stateid to be used by
>  the client to access the file.
> 
> However current implementation replaces per-mirror provided stateid with
> by open or lock stateid.
> 
> Ensure that per-mirror stateid is used by ff_layout_write_prepare_v4 and
> nfs4_ff_layout_prepare_ds.
> 
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> fs/nfs/flexfilelayout/flexfilelayout.c    | 21 +++++++++------------
> fs/nfs/flexfilelayout/flexfilelayout.h    |  4 ++++
> fs/nfs/flexfilelayout/flexfilelayoutdev.c | 19 +++++++++++++++++++
> 3 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index b0fa83a60754..13612a848378 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1365,12 +1365,7 @@ static void ff_layout_read_prepare_v4(struct rpc_task
> *task, void *data)
> 				task))
> 		return;
> 
> -	if (ff_layout_read_prepare_common(task, hdr))
> -		return;
> -
> -	if (nfs4_set_rw_stateid(&hdr->args.stateid, hdr->args.context,
> -			hdr->args.lock_context, FMODE_READ) == -EIO)
> -		rpc_exit(task, -EIO); /* lost lock, terminate I/O */
> +	ff_layout_read_prepare_common(task, hdr);
> }
> 
> static void ff_layout_read_call_done(struct rpc_task *task, void *data)
> @@ -1539,12 +1534,7 @@ static void ff_layout_write_prepare_v4(struct rpc_task
> *task, void *data)
> 				task))
> 		return;
> 
> -	if (ff_layout_write_prepare_common(task, hdr))
> -		return;
> -
> -	if (nfs4_set_rw_stateid(&hdr->args.stateid, hdr->args.context,
> -			hdr->args.lock_context, FMODE_WRITE) == -EIO)
> -		rpc_exit(task, -EIO); /* lost lock, terminate I/O */
> +	ff_layout_write_prepare_common(task, hdr);
> }
> 
> static void ff_layout_write_call_done(struct rpc_task *task, void *data)
> @@ -1734,6 +1724,10 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
> 	fh = nfs4_ff_layout_select_ds_fh(lseg, idx);
> 	if (fh)
> 		hdr->args.fh = fh;
> +
> +	if (!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
> +		goto out_failed;
> +
> 	/*
> 	 * Note that if we ever decide to split across DSes,
> 	 * then we may need to handle dense-like offsets.
> @@ -1796,6 +1790,9 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int
> sync)
> 	if (fh)
> 		hdr->args.fh = fh;
> 
> +	if (!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
> +		goto out_failed;
> +
> 	/*
> 	 * Note that if we ever decide to split across DSes,
> 	 * then we may need to handle dense-like offsets.
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h
> b/fs/nfs/flexfilelayout/flexfilelayout.h
> index 679cb087ef3f..d6515f1584f3 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> @@ -214,6 +214,10 @@ unsigned int ff_layout_fetch_ds_ioerr(struct
> pnfs_layout_hdr *lo,
> 		unsigned int maxnum);
> struct nfs_fh *
> nfs4_ff_layout_select_ds_fh(struct pnfs_layout_segment *lseg, u32 mirror_idx);
> +int
> +nfs4_ff_layout_select_ds_stateid(struct pnfs_layout_segment *lseg,
> +				u32 mirror_idx,
> +				nfs4_stateid *stateid);
> 
> struct nfs4_pnfs_ds *
> nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg, u32 ds_idx,
> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> index d62279d3fc5d..9f69e83810ca 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> @@ -369,6 +369,25 @@ out:
> 	return fh;
> }
> 
> +int
> +nfs4_ff_layout_select_ds_stateid(struct pnfs_layout_segment *lseg,
> +				u32 mirror_idx,
> +				nfs4_stateid *stateid)
> +{
> +	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, mirror_idx);
> +
> +	if (!ff_layout_mirror_valid(lseg, mirror, false)) {
> +		pr_err_ratelimited("NFS: %s: No data server for mirror offset index %d\n",
> +			__func__, mirror_idx);
> +		goto out;
> +	}
> +
> +	nfs4_stateid_copy(stateid, &mirror->stateid);
> +	return 1;
> +out:
> +	return 0;
> +}
> +
> /**
>  * nfs4_ff_layout_prepare_ds - prepare a DS connection for an RPC call
>  * @lseg: the layout segment we're operating on
> --
> 2.19.1
