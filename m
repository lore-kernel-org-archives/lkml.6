Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B0C1B0E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB8216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="P+lnyYD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAB8216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeI1BGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:06:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37033 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbeI1BGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:06:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id x26-v6so2529276pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8gGTefPliVXuB3MK0oV0l1+/Y8rrKEEYTUbzCEqKSo=;
        b=P+lnyYD+zP37fltMY+MH51bNITdkTdKOIZMK0IPiAJhMiSwPnMs/zhjXm9JifB9b1W
         wLg4HE0HAjAOQYJiSI16oA0eH7pHW6k8G2y3dxwiO61n935Z3dHYtzfDH5vUxbEEmj/W
         O5JjRtHOVGEBvbCX5ctprLd7QRNu+YVchAPUNrZcZAz6fwT1Iu6nHOpjFbtPk0Znvcgt
         RDvwRyjupjdMUWmZVxrJk6bKUuOJHA+8w5F7evEgRTEoLaxESyiU2cgERPgMng1CUCJI
         JNrW2cE4fO+5DCXfuiZ6qz6v3LQiupWf/fzYvd2usoNdS680PUnpG4Z3fRRM9ngvh/1Y
         tlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8gGTefPliVXuB3MK0oV0l1+/Y8rrKEEYTUbzCEqKSo=;
        b=PYwhqNKgYulnkebH/AUDqpJdKHEubxAUsh5sgcNEmxHH+jdVOWtAINIe+7rI0vc7Kb
         OC3bAEAn1o17xIRpef48T0luHXuumb5yc7AJfjFfFuX7739TtlSVunb/Cj3/cvYY/RHf
         17mqfaFGQLouUbriqSEixmcaF7qPFDtSoF39FmIhzKTZuNO0OGR/Z7Vvhu7QSdtt1GoA
         LTZknzpjnrJB/ca2Pse6y/ZU9JXkTYkbo8xlSKyZdSBh8SuzvU/CpYNzzDyjWrcWXUBK
         o59duK4DNOHZDfB+L/H/2wK9O+KsF92mXFKApTuyipt+KCQ4KpL9UUBK1bwqkyv+flx3
         WWNw==
X-Gm-Message-State: ABuFfohvSeZE1A2jzbUjk2K7yrRBfp+CxNkkqwLbg8XpykaFCh/SuvRF
        hThKLuPoYMHcH0pseAEGsOloJ9n1gwo=
X-Google-Smtp-Source: ACcGV60fAtqrIukR4ErbrTxtK8YDaqNYogDNrpBusrEU/q2A+APnKBjUlrgsZ2FEfXxp72166bKuzA==
X-Received: by 2002:aa7:881a:: with SMTP id c26-v6mr12728116pfo.82.1538074025590;
        Thu, 27 Sep 2018 11:47:05 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::5:3e64])
        by smtp.gmail.com with ESMTPSA id t85-v6sm5561876pfi.73.2018.09.27.11.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:47:05 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:47:04 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     dsterba@suse.com, jbacik@fb.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: list usage cleanup
Message-ID: <20180927184704.GA29754@vader>
References: <1537950945-5627-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537950945-5627-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 04:35:45PM +0800, zhong jiang wrote:
> Trival cleanup, list_move_tail will implement the same function that
> list_del() + list_add_tail() will do. hence just replace them.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  fs/btrfs/send.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 094cc144..d87f416 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -2075,8 +2075,7 @@ static struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
>   */
>  static void name_cache_used(struct send_ctx *sctx, struct name_cache_entry *nce)
>  {
> -	list_del(&nce->list);
> -	list_add_tail(&nce->list, &sctx->name_cache_list);
> +	list_move_tail(&nce->list, &sctx->name_cache_list);
>  }

At that point do we even need such a trivial helper, considering that
this is only called in one place?
