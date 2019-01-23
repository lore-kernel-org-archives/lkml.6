Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5CBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D862421019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfAWIGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:06:23 -0500
Received: from gateway32.websitewelcome.com ([192.185.144.98]:35867 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfAWIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:06:22 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id E2DAE2A6026
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:06:20 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mDYCgLFXodnCemDYCgOQHF; Wed, 23 Jan 2019 02:06:20 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41342 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmDYC-003bJd-FB; Wed, 23 Jan 2019 02:06:20 -0600
Subject: Re: [PATCH net-next] bna: Mark expected switch fall-throughs
To:     Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Rasesh Mody <rasesh.mody@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        "Dept-GELinuxNICDev@cavium.com" <Dept-GELinuxNICDev@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190123075328.GA25319@embeddedor>
 <CY4PR18MB125398716A4A84409D301F7AD3990@CY4PR18MB1253.namprd18.prod.outlook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <d28e5ffa-cac4-57d9-d7c5-503f0532e122@embeddedor.com>
Date:   Wed, 23 Jan 2019 02:06:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CY4PR18MB125398716A4A84409D301F7AD3990@CY4PR18MB1253.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmDYC-003bJd-FB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:41342
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/19 2:03 AM, Sudarsana Reddy Kalluru wrote:
> -----Original Message-----
> From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com] 
> Sent: 23 January 2019 13:23
> To: Rasesh Mody <rasesh.mody@cavium.com>; Sudarsana Kalluru <sudarsana.kalluru@cavium.com>; Dept-GELinuxNICDev@cavium.com; David S. Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
> Subject: [PATCH net-next] bna: Mark expected switch fall-throughs
> 
> External Email
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/net/ethernet/brocade/bna/bfa_ioc.c:790:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/net/ethernet/brocade/bna/bfa_ioc.c:860:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/brocade/bna/bfa_ioc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
> index a36e38676640..cbc9175d74c5 100644
> --- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
> +++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
> @@ -788,9 +788,8 @@ bfa_iocpf_sm_enabling(struct bfa_iocpf *iocpf, enum iocpf_event event)
> 
>         case IOCPF_E_INITFAIL:
>                 del_timer(&ioc->iocpf_timer);
> -               /*
> -                * !!! fall through !!!
> -                */
> +               /* fall through */
> +
>         case IOCPF_E_TIMEOUT:
>                 bfa_nw_ioc_hw_sem_release(ioc);
>                 if (event == IOCPF_E_TIMEOUT) @@ -858,9 +857,7 @@ bfa_iocpf_sm_disabling(struct bfa_iocpf *iocpf, enum iocpf_event event)
> 
>         case IOCPF_E_FAIL:
>                 del_timer(&ioc->iocpf_timer);
> -               /*
> -                * !!! fall through !!!
> -                */
> +               /* fall through*/
> 
>         case IOCPF_E_TIMEOUT:
>                 bfa_ioc_set_cur_ioc_fwstate(ioc, BFI_IOC_FAIL);
> --
> 2.20.1
> 
> Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
> 

Thanks, Sudarsana.

--
Gustavo
