Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4727C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990122086C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990122086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIEVYE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:24:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:20329 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeIEVYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:24:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 09:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="230468052"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 05 Sep 2018 09:52:59 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.230]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.237]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 09:52:59 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] net: ethernet: i40evf: fix potential build error
Thread-Topic: [PATCH v2 2/2] net: ethernet: i40evf: fix potential build error
Thread-Index: AQHURMAAM4c2y25c5Eiz/OFL9FQ39qTh6DJg
Date:   Wed, 5 Sep 2018 16:52:58 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884C78D96@ORSMSX115.amr.corp.intel.com>
References: <1536114430-21356-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536114430-21356-2-git-send-email-dongsheng.wang@hxt-semitech.com>
In-Reply-To: <1536114430-21356-2-git-send-email-dongsheng.wang@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWJmOTg3NWMtYmQ4MC00ODcyLWEzOGYtZWE1MGY0YzE3NjcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVkJOOWJFUWYxQ25tVUZHa2JYTHJ3QnJLN1huN0t3WlBIRTlFU0RhNlhrVmdcL0h4YlFqb0w2RkNSblVucWxWak8ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wang Dongsheng [mailto:dongsheng.wang@hxt-semitech.com]
> Sent: Tuesday, September 04, 2018 7:27 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> sergei.shtylyov@cogentembedded.com
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem@davemloft.net; intel-
> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wang Dongsheng <dongsheng.wang@hxt-
> semitech.com>
> Subject: [PATCH v2 2/2] net: ethernet: i40evf: fix potential build error
> 
> Can't have non-inline function in a header file.
> There is a risk of "Multiple definition" from cross-including.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  .../intel/i40evf/i40e_ethtool_stats.h         | 25 ++-----------------
>  .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 ++++++++++++++++++
>  2 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> index 60b595dd8c39..d70a071f065f 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> @@ -181,29 +181,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring
> *ring)
>  	*data += size;
>  }
> 
> -/**
> - * __i40e_add_stat_strings - copy stat strings into ethtool buffer
> - * @p: ethtool supplied buffer
> - * @stats: stat definitions array
> - * @size: size of the stats array
> - *
> - * Format and copy the strings described by stats into the buffer pointed at
> - * by p.
> - **/
> -static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> -				    const unsigned int size, ...)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < size; i++) {
> -		va_list args;
> -
> -		va_start(args, size);
> -		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
> -		*p += ETH_GSTRING_LEN;
> -		va_end(args);
> -	}
> -}
> +void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +			     const unsigned int size, ...);
> 
>  /**
>   * 40e_add_stat_strings - copy stat strings into ethtool buffer
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> index 9319971c5c92..c9a54f6de61e 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> @@ -171,6 +171,30 @@ static void i40evf_get_priv_flag_strings(struct
> net_device *netdev, u8 *data)
>  	}
>  }
> 
> +/**
> + * __i40e_add_stat_strings - copy stat strings into ethtool buffer
> + * @p: ethtool supplied buffer
> + * @stats: stat definitions array
> + * @size: size of the stats array
> + *
> + * Format and copy the strings described by stats into the buffer pointed at
> + * by p.
> + **/
> +void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +			     const unsigned int size, ...)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < size; i++) {
> +		va_list args;
> +
> +		va_start(args, size);
> +		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
> +		*p += ETH_GSTRING_LEN;
> +		va_end(args);
> +	}
> +}
> +
>  /**
>   * i40evf_get_stat_strings - Get stat strings
>   * @netdev: network interface device structure
> --
> 2.18.0

