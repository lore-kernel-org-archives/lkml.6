Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946249AbeBOR4q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:56:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:1311 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946231AbeBOR4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:56:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="27588491"
From: "Ramamurthy, Harshitha" <harshitha.ramamurthy@intel.com>
To: "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "garsilva@embeddedor.com" <garsilva@embeddedor.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH] i40evf/i40evf_main: Fix variable assignment in
 i40evf_parse_cls_flower
Thread-Topic: [PATCH] i40evf/i40evf_main: Fix variable assignment in
 i40evf_parse_cls_flower
Thread-Index: AQHTpoS3Pio8hV3JC0SSFJLGsWwvlKOmRe4A
Date: Thu, 15 Feb 2018 17:56:40 +0000
Message-ID: <1518717442.29950.1.camel@intel.com>
References: <20180215174435.GA19969@embeddedor.com>
In-Reply-To: <20180215174435.GA19969@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.177.120]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4009ABC963698F40898DF54F6DC011B3@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1FHurFi022065

On Thu, 2018-02-15 at 11:44 -0600, Gustavo A. R. Silva wrote:
> It seems this is a copy-paste error and that the proper variable to
> use
> in this particular case is _src_ instead of _dst_.
> 
> Addresses-Coverity-ID: 1465282 ("Copy-paste error")
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Thanks for the patch!

Acked-by:Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> index 4955ce3..58be99e 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> @@ -2763,7 +2763,7 @@ static int i40evf_parse_cls_flower(struct
> i40evf_adapter *adapter,
>  
>  		if (key->src) {
>  			filter->f.mask.tcp_spec.src_port |=
> cpu_to_be16(0xffff);
> -			filter->f.data.tcp_spec.src_port = key->dst;
> +			filter->f.data.tcp_spec.src_port = key->src;
>  		}
>  	}
>  	filter->f.field_flags = field_flags;
