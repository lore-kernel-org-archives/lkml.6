Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3158ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81814208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81814208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeISInW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:43:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:58707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbeISInW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:43:22 -0400
Received: from [192.168.175.55] ([218.18.229.179]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MexaL-1gQQfl30lF-00OYwF; Wed, 19
 Sep 2018 05:07:25 +0200
Subject: Re: [PATCH] staging: erofs: Fix a unused variable 'arg' warning
To:     zhong jiang <zhongjiang@huawei.com>, gregkh@linuxfoundation.org
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1537323381-23839-1-git-send-email-zhongjiang@huawei.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <5b3438ac-f4d4-7f66-4be0-1720c1eada98@gmx.com>
Date:   Wed, 19 Sep 2018 11:07:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537323381-23839-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:VXqopPZR7tHc+KY+6grLbeHlmxQcRunasrXUymGCCYN1d8JpfT7
 AAfQfdlibflGsbtxPouCeDAJ3/Zeqn3ZEmz3crd6G1S7+u15J+Ydf7ONxaNDOw2eTH3j052
 HokPNWlz6PXeO2J4ztzb704J+FxfRrGIoHo/eDezsQOyp8E+NeTQ5DFaKejTzSciVVdY2og
 W1qQ0g6g+B3snlPTf1fKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dp+Zzxv3Tr4=:Uwk3liIWK26rnA3V0Hs/On
 41mt+odEYzBINtgCcuHvkKCRutCEh2fVuM1REaJXAZ5g+VVq5iTb8u++Qv7WWw0AuDnF6NEPm
 CwLC7SyWoI+MAxlO3XaDbksopdc81SHAJkbLkgK576wrD4PG1K/+QAGPt+zIDpEn82ZSm3Ztv
 ve1+fk1TGEHgpTL7FCVz/rHZd78lCbXHfu7YYubZgkwufA/Np0LcpqaspXkZoFkxEAnzP432X
 ofhM6K5U4M3aZbdKLN8rDMStMlNoW9aYPfaepzvcKpHQzkokBjUgHB8zsnQBQfjtVd68ftOlw
 5c+f1JGHAUE42S9viIo76nEYmQafsiH55fG09TWBE3/wFtDdVS8/OSfPjjES/HnNMEf/LP//i
 vbBRLrrdgCrtYgELqtpW8+zTI15HUAlCv2TAxOFlJMT1dyRmeaRcJADjjirWpaSoMjxPWCJ59
 gv+plRfr56Uhd2JXWow6FwSW/D2bdq1LgZH03Fufp+wOgeCD9LOlmv8vr9FSMapV4/QxeQ+6p
 xJDRZupJiP9DSMb4rl9iOSusA7wnOczz34t5muzJM+JEw9JHEXgWLwGebRHntonSBBm6oARke
 cexXHplOoU+akaZ2AHrdFhX0B12uoA/acq8pbBE+OS7HoMky0avFYX9suo2aAblXnO6IdxtZE
 RX9SyAwGc4z/mJ96/ZuI5kykGlKKbRztvjeDOpcoPy8qkRR/dH+XWePLN0tIxJITQ2I1aMfy4
 ruyq7V0Qk99pmVjZof9+y8hjWdtT8rl1Qf1Kblqs62Ne7HhXMIac+gidIRHOXLsYs/MHP5iJD
 dVMJIXmHzym/4oRqA67vib9heE9yRQfUEM0KRY3nSaqMeCGeV0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 10:16 AM, zhong jiang wrote:
> I find the following warning when compiling the kernel.
>
> drivers/staging/erofs/super.c:195:6: warning: unused variable 'arg' [-Wunused-variable]
>    int arg = 0;
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>   drivers/staging/erofs/super.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 6423592..c04313f 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -192,7 +192,9 @@ static int parse_options(struct super_block *sb, char *options)
>   {
>   	substring_t args[MAX_OPT_ARGS];
>   	char *p;
> +#ifdef CONFIG_EROFS_FAULT_INJECTION
>   	int arg = 0;
> +#endif
>   
>   	if (!options)
>   		return 0;

Hi,

The fix has already included in my patch series "staging: erofs: option 
validation for remount and some code cleanups",
so it will be fixed when the series merge into tree and we do not 
encourage surrounding the code with macro in option
parsing for this case.

Thanks,
Chengguang
