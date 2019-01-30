Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CCDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF5F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbfA3SUP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:20:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:32242 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbfA3SUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:20:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 10:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="295739874"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2019 10:20:13 -0800
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.11]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.115]) with mapi id 14.03.0415.000;
 Wed, 30 Jan 2019 10:20:13 -0800
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH] iavf: Use printf instead of
 gnu_printf for iavf_debug_d
Thread-Topic: [Intel-wired-lan] [PATCH] iavf: Use printf instead of
 gnu_printf for iavf_debug_d
Thread-Index: AQHUqJw1JLz7eXTEnUWkmi46BVmMlqXIP4IQ
Date:   Wed, 30 Jan 2019 18:20:12 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D353FD7@ORSMSX104.amr.corp.intel.com>
References: <20190110042157.8445-1-natechancellor@gmail.com>
In-Reply-To: <20190110042157.8445-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjMxYzg1ODctYmM2YS00YjFmLWFlYTItY2JkNmM3MDE1NzJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVnNyb0VlQ1pSR2YyTjJWR3hpXC9DbFZxXC8yRGF1OUhxNHJiN01BNHhHWFJraU5Pa2c1N29cL1llaDVrakxieUNlMSJ9
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
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Nathan Chancellor
> Sent: Wednesday, January 9, 2019 8:22 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; Nick Desaulniers <ndesaulniers@google.com>;
> linux-kernel@vger.kernel.org; Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com>; intel-wired-lan@lists.osuosl.org;
> Nathan Chancellor <natechancellor@gmail.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] iavf: Use printf instead of gnu_printf for
> iavf_debug_d
> 
> Clang warns:
> 
> In file included from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
> In file included from drivers/net/ethernet/intel/iavf/iavf.h:37:
> In file included from drivers/net/ethernet/intel/iavf/iavf_type.h:8:
> drivers/net/ethernet/intel/iavf/iavf_osdep.h:49:18: warning: 'format'
> attribute argument not supported: gnu_printf [-Wignored-attributes]
>         __attribute__ ((format(gnu_printf, 3, 4)));
>                         ^
> 1 warning generated.
> 
> We can convert from gnu_printf to printf without any side effects for two
> reasons:
> 
> 1. All iavf_debug instances use standard printf formats, as pointed out
>    by Miguel Ojeda at the below link, meaning gnu_printf is not strictly
>    required.
> 
> 2. However, GCC has aliased printf to gnu_printf on Linux since at least
>    2010 based on git history.
> 
>    From gcc/c-family/c-format.c:
> 
>    /* Attributes such as "printf" are equivalent to those such as
>       "gnu_printf" unless this is overridden by a target.  */
>    static const target_ovr_attr gnu_target_overrides_format_attributes[] =
>    {
>      { "gnu_printf",   "printf" },
>      { "gnu_scanf",    "scanf" },
>      { "gnu_strftime", "strftime" },
>      { "gnu_strfmon",  "strfmon" },
>      { NULL,           NULL }
>    };
> 
> The mentioned override only happens on Windows (mingw32). Changing
> from gnu_printf to printf is a no-op for GCC and stops Clang from warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/111
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_osdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


