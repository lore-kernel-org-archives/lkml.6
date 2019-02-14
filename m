Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA20C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB40222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="AslHkVKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbfBNOQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:16:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37989 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBNOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:16:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so6650002wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hh4NnkWKbXg4EnJs40Sev6zsQ/bhX5QcivRqfXoNjZ4=;
        b=AslHkVKZ/MRwMubrhwHQP09C5Gg6pnl4oAKuRqVuMo1WpAqWrpXKQe3/eQaJObxMCg
         ywzhhl47NlyW4ovZp/uHsx80/95pfCFG8YqXgABcQIGdJ5AVCWDtSNHmgOpuMhgUQX4L
         5b20viv3NnrshTMY3AAXCs/Vzy2pIt8s05oZO9Hk/rymm9vUOT2V61QeEYxtUQ95KrTu
         +nqLZwJ1T4Vir76ye8CUmG1V9crtl3seT99WPsAAGwZb8PD+b5W9OCqAh4MpS/7wW+xT
         p75q3a4632l90n6shiKkAG16VdIU4M1/ULDnCU108LsVn7Du8uDDXbgEUi4beaphQ9MH
         Xe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Hh4NnkWKbXg4EnJs40Sev6zsQ/bhX5QcivRqfXoNjZ4=;
        b=YxO9BEdloMJfgD97O5mKincjcbSAzZ+iUPnVLzQXvPeMSjh6LLD92fISEeydPlVp4Q
         AL2rn8dryu7QmIUyYNgExYmNuGnW49fb8W9QmFcEstausfecx4s8QLN2r8M5X+rwLNYC
         pva53F2n64cW3VR5lnu21EiHHwhuhLlH/Qg872vSgW+8YhPOltDaV0n5XYyjHuZVxCCB
         sKKgSsComTdKfKC2ai/EXKI3nIldFwPPKzn1GuYH+LNFnl8aAUpvyc3Bo6VQ72Ur3BIc
         doZetsGkLHwEDYCRN5LJmTPixY5nVarcD50ToXPjVl8gTy5KDwQOP76fZxB+EARfdE3Z
         8sxQ==
X-Gm-Message-State: AHQUAuZFfsYGIur/+j7kZxLUDyD79bNSz2JozYq28PIy3WnfP+07Q5Dq
        Im8h78mEmLKhQqO19B19vJvC07OlZPc=
X-Google-Smtp-Source: AHgI3IZVB0Q8zL7pnPzIEaArctduaIwA2mv4ZOTMrsqkj/t3h657eVs0Yt6MQGZQp7ggQqi3qomkJg==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr3009743wrj.0.1550153778317;
        Thu, 14 Feb 2019 06:16:18 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:b97b:8aa4:ad2c:2f98? ([2a01:e35:8b63:dc30:b97b:8aa4:ad2c:2f98])
        by smtp.gmail.com with ESMTPSA id k126sm1722479wme.27.2019.02.14.06.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:16:16 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v5] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190214024418.21490-1-callum.sinclair@alliedtelesis.co.nz>
 <20190214024418.21490-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <75b01657-456d-8954-55cd-d10d71a23bbe@6wind.com>
Date:   Thu, 14 Feb 2019 15:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214024418.21490-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/02/2019 à 03:44, Callum Sinclair a écrit :
> Currently the only way to clear the forwarding cache was to delete the
> entries one by one using the MRT_DEL_MFC socket option or to destroy and
> recreate the socket.
> 
> Create a new socket option which with the use of optional flags can
> clear any combination of multicast entries (static or not static) and
> multicast vifs (static or not static).
> 
> Calling the new socket option MRT_FLUSH with the flags MRT_FLUSH_MFC and
> MRT_FLUSH_VIFS will clear all entries and vifs on the socket except for
> static entries.
> 
> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Except two minor comments (see below),
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[snip]

> +/* MRT6_FLUSH optional flags */
> +#define MRT6_FLUSH_MFC	1	/* Flush multicast entries */
> +#define MRT6_FLUSH_MFC_STATIC	2	/* Flush static multicast entries */
> +#define MRT6_FLUSH_VIFS	4	/* Flushing multicast vifs */
> +#define MRT6_FLUSH_VIFS_STATIC	8	/* Flush static multicast vifs */
vifs are called mifs in ipv6, maybe it's better to keep the consistency with
MRT6_FLUSH_MIFS and MRT6_FLUSH_MIFS_STATIC.

[snip]

> +	if (flags & (MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC)) {
> +		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> +			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC_STATIC)) ||
> +			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC)))
> +				continue;
> +			rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
> +			list_del_rcu(&c->list);
> +			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
> +						       FIB_EVENT_ENTRY_DEL,
> +										   (struct mfc6_cache *)c, mrt->id);
Two many tabs here.


Regards,
Nicolas
