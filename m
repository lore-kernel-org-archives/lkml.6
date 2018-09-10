Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638E4C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2EB20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2EB20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeIJMh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:37:28 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:15564
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbeIJMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:37:28 -0400
X-IronPort-AV: E=Sophos;i="5.53,355,1531778400"; 
   d="scan'208";a="278296354"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 09:44:43 +0200
Date:   Mon, 10 Sep 2018 09:44:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Colin King <colin.king@canonical.com>
cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: fix a few trivial spelling
 mistakes
In-Reply-To: <20180909221734.8047-1-colin.king@canonical.com>
Message-ID: <alpine.DEB.2.20.1809100943580.3655@hadrien>
References: <20180909221734.8047-1-colin.king@canonical.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Sep 2018, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Trival fix to spelling mistakes:
> PrimativeSeqErrCount -> PrimitiveSeqErrCount
> Broadcase -> Broadcast
> Primative -> Primitive
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/message/fusion/lsi/mpi_cnfg.h | 2 +-
>  drivers/message/fusion/mptbase.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/message/fusion/lsi/mpi_cnfg.h b/drivers/message/fusion/lsi/mpi_cnfg.h
> index 059997f8ebce..178f414ea8f9 100644
> --- a/drivers/message/fusion/lsi/mpi_cnfg.h
> +++ b/drivers/message/fusion/lsi/mpi_cnfg.h
> @@ -2004,7 +2004,7 @@ typedef struct _CONFIG_PAGE_FC_PORT_6
>      U64                     LinkFailureCount;           /* 50h */
>      U64                     LossOfSyncCount;            /* 58h */
>      U64                     LossOfSignalCount;          /* 60h */
> -    U64                     PrimativeSeqErrCount;       /* 68h */
> +    U64                     PrimitiveSeqErrCount;       /* 68h */

It's not used anywhere?

>      U64                     InvalidTxWordCount;         /* 70h */
>      U64                     InvalidCrcCount;            /* 78h */
>      U64                     FcpInitiatorIoCount;        /* 80h */
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index e6b4ae558767..2b1ea7f8031d 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -7572,7 +7572,7 @@ mpt_display_event_info(MPT_ADAPTER *ioc, EventNotificationReply_t *pEventReply)
>  		u8 port_width = (u8)(evData0 >> 16);
>  		u8 primative = (u8)(evData0 >> 24);

Another primative here.

>  		snprintf(evStr, EVENT_DESCR_STR_SZ,
> -		    "SAS Broadcase Primative: phy=%d port=%d "
> +		    "SAS Broadcast Primitive: phy=%d port=%d "
>  		    "width=%d primative=0x%02x",
>  		    phy_num, port_num, port_width, primative);

And another one here.

julia

>  		break;
> --
> 2.17.1
>
>
