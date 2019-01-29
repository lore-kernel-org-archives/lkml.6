Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AA0C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030E82086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="IEeywxed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfA2EGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:06:33 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25495 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfA2EGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:06:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548734777; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Q5gVPtcGSRqwYxnkRDf14d/27v3U3egy2ycN2vfGIAShRfktN34fOYSG6AGDT0doBPX900+Ns0wj3ApKaTYU3hmEcxUR4OMySZewbzvW8JgV7ZglLinKBsgNMQwfINrMe2o3RS+MmOmMKhZmF1pkUxtFjxRwE2t7PKPzJyQRXhM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548734777; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=eVWPnxIpahyQ5RTzqIJ8nl/MJQnNarrN5F3AafkBOQg=; 
        b=M5vm8XPXiFTpUNJ55oSfEahHh80C1coew9VBqZoPClY8guYdIzeRURfb4y3mYL8eKnGaR1RypOHg2xlrt+t8EHmbou/ES8YBzCPaad3vJAAj8xdlz/7G4C0jHEYuTEw3ve2BxYMA+Hz2AgnSa38oeYKHMfleme0l9PpK+a4KOYw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=ENtkCpX2UfsxP+q5+IwiYFSh+eWNAcCTqEHLWeF7xnYn/h+vsqHeNjkIyPDVCpQk25/JwBFpV+9Y
    G3WJKybOOiXEZUcHVMTDTeHIvUHV1mhaHzCLwJkc19xqXJoGWpWO  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548734777;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=1762; bh=eVWPnxIpahyQ5RTzqIJ8nl/MJQnNarrN5F3AafkBOQg=;
        b=IEeywxedqkDKNjden8PI2MUeAcCywJCZ2rGbV1kcmTzFJ6fmz0l/IL9lh/npLQHt
        ngPYlhhty/18KBsmM8Ie9yABrwqsLyOHFTr7PlJs2t4Y33DgqrxIAucKcBwMwD4SPWC
        IVzd1cLgpbG1M6DRTa+ufdHteCg5V2SwwOIjd/To=
Received: from [192.168.88.133] (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548734775058984.7677012084524; Mon, 28 Jan 2019 20:06:15 -0800 (PST)
Subject: Re: [PATCH RESEND 4/4] Pinctrl: Ingenic: Fix const declaration.
To:     Joe Perches <joe@perches.com>, Paul Cercueil <paul@crapouillou.net>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
 <1548410393-6981-5-git-send-email-zhouyanjie@zoho.com>
 <1548439157.1804.1@crapouillou.net>
 <c6de4935a2b3acdbcc9146af702322c58707c9f5.camel@perches.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.burton@mips.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5C4FD12A.2050005@zoho.com>
Date:   Tue, 29 Jan 2019 12:06:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <c6de4935a2b3acdbcc9146af702322c58707c9f5.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would prefer to keep it. There are many other drivers that also use=20
this header file.

On 2019=E5=B9=B401=E6=9C=8829=E6=97=A5 03:22, Joe Perches wrote:
> On Fri, 2019-01-25 at 14:59 -0300, Paul Cercueil wrote:
>> On Fri, Jan 25, 2019 at 6:59 AM, Zhou Yanjie <zhouyanjie@zoho.com>
>> wrote:
>>> Warning is reported when checkpatch indicates that
>>> "static const char * array" should be changed to
>>> "static const char * const".
> []
>>> diff --git a/drivers/pinctrl/pinctrl-ingenic.c
> []
>>> @@ -172,23 +172,25 @@ static const struct group_desc jz4740_groups[]
> []
>>> +static const char * const jz4740_mmc_groups[] =3D { "mmc-1bit",
>>> "mmc-4bit", };
>>>   static const struct function_desc jz4740_functions[] =3D {
>>>   =09{ "mmc", jz4740_mmc_groups, ARRAY_SIZE(jz4740_mmc_groups), },
>> With this patch applied I get this:
>>
>> drivers/pinctrl/pinctrl-ingenic.c:196:11: attention : initialization
>> discards
>> =E2=80=98const=E2=80=99 qualifier from pointer target type [-Wdiscarded-=
qualifiers]
>>    { "mmc", jz4740_mmc_groups, ARRAY_SIZE(jz4740_mmc_groups), },
>>             ^~~~~~~~~~~~~~~~~
> You could change group_names to const char * const group_names
> in pinmux.h
>
> ---
>   drivers/pinctrl/pinmux.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
> index 3319535c76cb..2b903774ba5c 100644
> --- a/drivers/pinctrl/pinmux.h
> +++ b/drivers/pinctrl/pinmux.h
> @@ -122,7 +122,7 @@ static inline void pinmux_init_device_debugfs(struct =
dentry *devroot,
>    */
>   struct function_desc {
>   =09const char *name;
> -=09const char **group_names;
> +=09const char * const *group_names;
>   =09int num_group_names;
>   =09void *data;
>   };
>
>



