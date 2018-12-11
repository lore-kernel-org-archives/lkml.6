Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A38C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87492084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="XqtsjXtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87492084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=desy.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeLKSzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:55:41 -0500
Received: from smtp-o-3.desy.de ([131.169.56.156]:34340 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbeLKSzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:55:39 -0500
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (DESY-O-3) with ESMTP id CE9F528079B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 19:49:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de CE9F528079B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1544554172; bh=1YI1zqDrdppyHlD+9bp2tWVhFNMUgkfPdQqVg5E4xSg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XqtsjXtY3Dtccjz767py/BF7FcVQv+cUmGuRzFD9JJ81lZEWKOVDQTXf3UDAH6gcU
         TUubxP08P+S+WAesxicv0CWftCWqlWe5haj1w2xo2g9If7I6arKydlJtzX5wBl5W/S
         4vVsUt1rDFEDTav4j3E/MiV7NKbeD0ryCRs+1Of4=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id C6B91A0040;
        Tue, 11 Dec 2018 19:49:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (DESY-INTRA-3) with ESMTP id 135E11029;
        Tue, 11 Dec 2018 19:49:28 +0100 (MET)
Date:   Tue, 11 Dec 2018 19:49:27 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Rick Macklem <rmacklem@uoguelph.ca>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Message-ID: <922713302.5303567.1544554167994.JavaMail.zimbra@desy.de>
In-Reply-To: <20181211151646.307760274@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org> <20181211151646.307760274@linuxfoundation.org>
Subject: Re: [PATCH 4.19 051/118] flexfiles: use per-mirror specified
 stateid for IO
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.10_GA_3713 (ZimbraWebClient - FF63 (Linux)/8.8.10_GA_3041)
Thread-Topic: flexfiles: use per-mirror specified stateid for IO
Thread-Index: jj2s2lLwB2tLSTK0CnId6RIeRK/bmg==
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
> To: "linux-kernel" <linux-kernel@vger.kernel.org>
> Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "stable" <stable@vger.kernel.org>, "Tigran Mkrtchyan"
> <tigran.mkrtchyan@desy.de>, "Rick Macklem" <rmacklem@uoguelph.ca>, "Trond Myklebust" <trond.myklebust@hammerspace.com>,
> "Sasha Levin" <sashal@kernel.org>
> Sent: Tuesday, December 11, 2018 4:41:10 PM
> Subject: [PATCH 4.19 051/118] flexfiles: use per-mirror specified stateid for IO

> 4.19-stable review patch.  If anyone has any objections, please let me know.
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
> index cae43333ef16..86ac2c5b93fe 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1361,12 +1361,7 @@ static void ff_layout_read_prepare_v4(struct rpc_task
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
> @@ -1542,12 +1537,7 @@ static void ff_layout_write_prepare_v4(struct rpc_task
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
> @@ -1742,6 +1732,10 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
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
> @@ -1804,6 +1798,9 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int
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
> index 411798346e48..de50a342d5a5 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> @@ -215,6 +215,10 @@ unsigned int ff_layout_fetch_ds_ioerr(struct
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
> index 59aa04976331..a8df2f496898 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
> @@ -370,6 +370,25 @@ out:
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
