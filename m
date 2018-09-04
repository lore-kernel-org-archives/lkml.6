Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED216C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DD020843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YgMlJFis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DD020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeIDPTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:19:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40832 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeIDPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:19:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so2557922lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0RO+aW7tuXDYfI8cP4xc7WBlaOD07/tVAbpYO7eMyek=;
        b=YgMlJFisWyvyMy6QNBGpsK1K3i2miJyknkkeJ6P/NMsbv/IcYPHb7/XlA5DPnYPNRf
         AmBp7hvqTPn24uBERlRSAmgK8OXzlKPnLb1hs73NUH1JQ84mLbmZNES5M9qHluqkVyMn
         RvfLwD+uktfU9QrI1XJWNabGXr+4MF3GFrYWrOLJSL8dLpH0oTBjxWlER7hRD9261yXs
         4ZXsTKbXDRSXmsrXIiNOngf2iUJ3xeddNraDMKcLCLtBkacu8k1cpVHFBsr4DAF5ZxzE
         mvA8gAcqgBOWISdf5iMGue2HNPLE3HaCFEvwQWb/+2625nC4dd+SD2YFBqI93Lr3k8U8
         PF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0RO+aW7tuXDYfI8cP4xc7WBlaOD07/tVAbpYO7eMyek=;
        b=XhFpzVvzsPrs7cWCzo7Rzvh8uRz0c8wMd6iXlvVHMq37Pl/y04fnF93xZUPyDV17vz
         sXMHTsEuYcE4ysK3wL4LTeUWg+SReg79qJAJeobvmLPbbJ79WpgFnek1qJ7JWUTuP/+U
         ODB1PSE2YZLA7lH6FuZx5HS4NO3Wl6LTivPTINYBNi30u8Ef8CsfoZdyJP0FxHwjfd/A
         zmjH7GI9kNn58ORDi81csqcQqP8amfR05VuD9Dj21+0bcGgKw0i71CkI4a8xH2nBvic0
         y7x1rvujfaeTqQ8Kf+eESHz9dW3lIwd7YQiwZeXE7SPnEdyWIQVRcMBt9leQpZKc4rXA
         PY8A==
X-Gm-Message-State: APzg51AYdzvqsW2CUPBeV//fpxpoWNTfXkYFWg1a55+ssMS9fMgkqup5
        xq/dLbwmi/Ht3e1NF5Ujuuc3/gi69SM=
X-Google-Smtp-Source: ANB0VdbsJ3TZvSo3tsKVqsXISABOMu4NP71gUOBQXPEBldAopocX/J1sgODHTXTsLSWAQOd0JdQ8Ug==
X-Received: by 2002:a19:1761:: with SMTP id n94-v6mr19777559lfi.64.1536058469190;
        Tue, 04 Sep 2018 03:54:29 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.176])
        by smtp.gmail.com with ESMTPSA id q81-v6sm4084266lfq.85.2018.09.04.03.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:54:28 -0700 (PDT)
Subject: Re: [PATCH] net: ethernet: i40e: fix build error
To:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        jeffrey.t.kirsher@intel.com
Cc:     jacob.e.keller@intel.com, davem@davemloft.net,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536054527-34184-1-git-send-email-dongsheng.wang@hxt-semitech.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <84982f95-940e-d278-f6a2-13a9f76823c9@cogentembedded.com>
Date:   Tue, 4 Sep 2018 13:54:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536054527-34184-1-git-send-email-dongsheng.wang@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/2018 12:48 PM, Wang Dongsheng wrote:

> Remove "inline" from __i40e_add_stat_strings.
> 
> In file included from
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
> ‘__i40e_add_stat_strings’:
> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
> function ‘__i40e_add_stat_strings’ can never be inlined because it uses
> variable argument lists
>   static inline void __i40e_add_stat_strings(u8 **p, const struct
> 					    i40e_stats stats[],
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> index bba1cb0..0290ade 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> @@ -190,7 +190,7 @@ struct i40e_stats {
>    * Format and copy the strings described by stats into the buffer pointed at
>    * by p.
>    **/
> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],

    You can't have non-inline function in a header file. Please move it, 
leaving only prototype here.

>   				    const unsigned int size, ...)
>   {
>   	unsigned int i;

MBR, Sergei
