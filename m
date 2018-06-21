Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0B320875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0B320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbeFUCO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:14:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:55973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754295AbeFUCOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:14:54 -0400
Received: from [10.1.25.155] ([101.68.79.179]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MBnPX-1fNKwf2rYd-00AnrM; Thu, 21
 Jun 2018 04:14:51 +0200
Subject: Re: [PATCH 1/2] fs/exofs: fix potential memory leak in mount option
 parsing
To:     ooo@electrozaur.com
Cc:     linux-kernel@vger.kernel.org, cgxu519@gmx.com
References: <1528862714-78150-1-git-send-email-cgxu519@gmx.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <38b17aef-db48-0258-3086-206659d2da85@gmx.com>
Date:   Thu, 21 Jun 2018 10:14:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528862714-78150-1-git-send-email-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:2ZkswmcmnJN3rdEtHSljyfk97m51QW3U2I3v9c/9TLUHxBha07p
 AYCh95AJWu0Dfynlb0fc1WauwmNISghtGM3fwShpgj3ipNqlB6E81ypRGC/Ka6b5ElfxSD8
 UI+VmcUkRRDuNA008/trouOQ8mUdi8OmXaGW95NBKaAOAHb8WQILWszh6hRfVuH2ZfiQGHu
 3rzWYz1S5pGqZpDXkEIIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9TNgLDbq8z4=:iDl3UUQalxxIVsGTxmdLwm
 GYoTjVwHcq1vPbV1maSOWETTsBsuH4UoHP055zBXPxDXizGLzFappamZLcIq0kjcJtv8O6kwq
 lca2PZkQWh9k8y1tptoNrOErAvZS8OsAKSzpI7i8dKkYu2EPirQ46dVkfVwsrtmyJk+KXSLuQ
 wHVQ4rL1wzy6TE8cxxnH2GtyJkTcig6TVIRi210bR/FB5TBlQRiQVlY+sYz2F3XXR/jNPNRSW
 qGsEkRaIuA5kfN70CN0qC2bGJMGA0yGI8VVG6dgiPdHuzQ77VkQ+kTo2BKOFA7A/7ItecgWa6
 PyC1KjyG6scVnsHV+nZc7+MgieprxAkS9WT0+jjT/NLNlZTFiEMcJPuuahqIuv9SkQwWxuRtM
 0UMEuO3U/QxVWPBFMwCpo3H1V38koOeSYh13s29eyNChJaXiaX0XDV5/vikMn9Ajm3PPbvMYA
 gPN/s6EZ6B1R3IJTGq/KtFwttMpEExkuAOIcI9w4GAdv//ZmSgAvxlJBOeiCIh24+KS1XtDiE
 nivt50R9OKBsI3lgNXso5R8DZCjNGvRHAhcjF1Al44Ms/wIg27H7KFrV2rECyXje+HryvueQn
 8Sd8bGLCwXm7qr0pUJ6LMrfA+AGVcaV/HSnZ+zCgZCBWrQ7Rfa35KfAzP8wEybNPvH3zwFgVU
 lEtXY6i5uxjdhouvmmjnbfSJPCkqUtRi4hJMXlq3/Ecf9vTGff1j1Xgvn1zUamt0G02tWIZH9
 3+iGa/fJWUsIl9ipYDmz8Nf2FLzA2M4Qs6Sn3dTAivoVTKdC5GofKjxSh2phc6VVRclkq8ZSP
 Zrw46yz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boaz,

Could you have a look at this trivial patch?

Thanks,
Chengguang.

On 06/13/2018 12:05 PM, Chengguang Xu wrote:
> There are some cases can cause memory leak when parsing
> option 'osdname'.
>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>   fs/exofs/super.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exofs/super.c b/fs/exofs/super.c
> index 719a315..f3e17a9 100644
> --- a/fs/exofs/super.c
> +++ b/fs/exofs/super.c
> @@ -101,6 +101,7 @@ static int parse_options(char *options, struct exofs_mountopt *opts)
>   		token = match_token(p, tokens, args);
>   		switch (token) {
>   		case Opt_name:
> +			kfree(opts->dev_name);
>   			opts->dev_name = match_strdup(&args[0]);
>   			if (unlikely(!opts->dev_name)) {
>   				EXOFS_ERR("Error allocating dev_name");
> @@ -867,8 +868,10 @@ static struct dentry *exofs_mount(struct file_system_type *type,
>   	int ret;
>   
>   	ret = parse_options(data, &opts);
> -	if (ret)
> +	if (ret) {
> +		kfree(opts.dev_name);
>   		return ERR_PTR(ret);
> +	}
>   
>   	if (!opts.dev_name)
>   		opts.dev_name = dev_name;

