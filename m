Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EFBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E8521991
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E8521991
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbeHFPTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:19:06 -0400
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:39741 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeHFPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:19:06 -0400
X-Greylist: delayed 673 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Aug 2018 11:19:02 EDT
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/AES256-SHA; 06 Aug 2018 12:58:48 +0000
X-IronPort-AV: E=Sophos;i="5.51,452,1526342400"; 
   d="scan'208";a="14532745"
IronPort-PHdr: =?us-ascii?q?9a23=3AoSmz8xFAzgm3B0+Y2ulhPJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pcm8bnLW6fgltlLVR4KTs6sC17KI9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa8bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFFJ0A0m63bK4U/zbEsjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?R95FRayAo1zdBS/J1UCrYGIPL8Xk/+qsbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKLvSvkWV5uIrOOSMfJUauCv5K/Q84v7uing5mUUDcqWzwZQXb3W4FOx8I0?=
 =?us-ascii?q?qFeXrsnssBEWASswUgVOzlkkeCUT9IZ3upR6Iz/Cs7CIO9DYfbQoCimqCO0z?=
 =?us-ascii?q?mhEp1RfGBGBUiGEW30eIWcR/cMdCWSL9djkjwBUrihUZUh1RC1tALhzbpoNO?=
 =?us-ascii?q?/U9TMZtZ7509h1/eLTnwko9TNoF8Sdz32NT2Zsk2MTWTA2xq9/rlJmx1eDy6?=
 =?us-ascii?q?d4h/hYFNxV5/9TTgg6MpvcxfRgC9/uQgLBYsuJSFG+T9WiADExSM8xwtAXb0?=
 =?us-ascii?q?ZmBdqtkg3D3zCrA78Jl72HHZk08qXB0HjsI8Zy1W3L1Lcuj1Y4WMtDL26mib?=
 =?us-ascii?q?Bl9wjVGYHJl1+Vl6GwdaQTxCTN7nuMzXKSvEFEVw59SaHFXXEZZkvLotX1/0?=
 =?us-ascii?q?DCQKG0CbQhLARBzdWPKrVFatL3l1VKXvTjN8rEY2K3hWiwAQyExrSWbIrlKC?=
 =?us-ascii?q?0h23D/AU4C2yAU53DOYQo3ACGhi23ZCzNqGBTkZEa6taFGoW6/BmozyBuHJx?=
 =?us-ascii?q?l53qex0gYcmPjZTvQUxL9CsyAk/XE8MUy81JruAsCBvEI1cb1Ve9ImyE9Oz2?=
 =?us-ascii?q?PCrwh0NZHmKLpt0BpWaAlzvkXzxz1rG45Alo4st3psww1seoyC11YUTC+VxZ?=
 =?us-ascii?q?D9PPXsL2D2+B2+I/rN1kr2zMed+qBJ7u8x7Vrkolf6RQIZ73x73owNgDOn7Z?=
 =?us-ascii?q?LQAV9XCMipXw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BwAgC4RWhb/wHyM5BbGgEBAQEBAgEBAQEIAQEBAYMkg?=
 =?us-ascii?q?gwog36IaIwyAQEBAQEBBoEICCWIUYhThEOBJANThHcCg0c2FgECAQEBAQEBA?=
 =?us-ascii?q?gFsKII1JAGCXgEFIxVBEAsYAgImAgJXBgEMBgIBAYJdP4FzDatdgS6EX4Vvg?=
 =?us-ascii?q?QuIFXmBB4ESJwyCX4RHgziCVQKHdIU8cowRCY8/Bo4gK5N7DiMzgR8rCAIYC?=
 =?us-ascii?q?CEPgySQbyMwjUyCSQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Aug 2018 12:58:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w76CwQ5I023579;
        Mon, 6 Aug 2018 08:58:28 -0400
Subject: Re: [PATCH] selinux: stricter parsing in mls_context_to_sid()
To:     Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180803093604.38254-1-jannh@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a4c0b0a6-3331-1abc-266c-7e6589a04208@tycho.nsa.gov>
Date:   Mon, 6 Aug 2018 08:58:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180803093604.38254-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 05:36 AM, Jann Horn wrote:
> mls_context_to_sid incorrectly accepted MLS context strings that are
> followed by a dash and trailing garbage.
> 
> Before this change, the following command works:
> 
> # mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
> none mount
> 
> After this change, it fails with the following error message in dmesg:
> 
> SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
> failed for (dev tmpfs, type tmpfs) errno=-22
> 
> This is not an important bug; but it is a small quirk that was useful for
> exploiting a vulnerability in fusermount.
> 
> This patch does not change the behavior when the policy does not have MLS
> enabled.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/mls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 39475fb455bc..2c73d612d2ee 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -344,7 +344,7 @@ int mls_context_to_sid(struct policydb *pol,
>   					break;
>   			}
>   		}
> -		if (delim == '-') {
> +		if (delim == '-' && l == 0) {
>   			/* Extract high sensitivity. */
>   			scontextp = p;
>   			while (*p && *p != ':')
> 

