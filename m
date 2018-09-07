Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93442075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="qJkxx708"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93442075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeIGUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:14:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42233 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbeIGUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:14:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id z11-v6so12360196lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQ7tOSQmSo0LW4X37FAdoAzEWGq6wkKIGNpN4dGVPoA=;
        b=qJkxx708kKhBJZr+Rrsn+RsaoyGhNNT2iKO5I+Ox8/Za92YTOZTJj8Oo7+uictHFFz
         DXQIV9uCXXe+8hRV9BgFNiI/rtjNnuAqqdACsGhTRewL6sEz04StWOJMyrHUqEbkctFl
         QEIbmwK17mR1s3Uqdll+EF1Y+0DTpwsib+MmeJYju24XgRPgujc4cQ37df4PvTrEi7eE
         ssF90qThw0TtH8m4Jgw6Y4mSjewANkCLkMojQ9VhoEo/OP1Zm8LzeY8YCZLbnWZSl/48
         ugfhF+Fq3n+l8lHsTgGI7QfYN857hoEcNDbFjlPeq7Ix8H9vlyh++o/iohMxFTm84DCk
         f3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oQ7tOSQmSo0LW4X37FAdoAzEWGq6wkKIGNpN4dGVPoA=;
        b=V3IYrYbxUPumW7jMspbO4DUgYxdsU/CZkw8eQmtUf7nYAXRn0c3erGUrcvNkK8SBj7
         uVqUX7EQjPMwfu7pylVLNbDXq0sPDjoakbfGPak5IHlvaOmzbkw9FcdUKiPzlHUWxz5k
         mieVoZsQwpulbjLKMvrdP49skOkaQLL9wpZEHkKgZC1T9qBwQAA2nfSSx1KhIQ971edm
         VXsp7Ur6tREeXshzQdOLbTZDTaCbmfoFc2buh4hKSShf3uUU42OXY1hnR0SO1HFHwKgC
         SvikiI+muMYXj3FrU6iaNFrfV//BnfLvtyfLM6zO/aWLjonwGijRB0w5TF6twiK0a4NG
         FSjw==
X-Gm-Message-State: APzg51B+oGGRj7WyE8/7n/W8VhX+i7Qs4YVgYVg9J3Y/wspzYYno8TIU
        TGGqIgWa7pW1hbR5kOwZUhyD+ondKoI=
X-Google-Smtp-Source: ANB0VdaH3hFoaKeJGVQPGIjR4uoWc158EN9EwfNQlBozuO85ES6vcOmeHJYDQSyLsmv33p9gLJVXMw==
X-Received: by 2002:a19:c016:: with SMTP id q22-v6mr5274926lff.8.1536334390667;
        Fri, 07 Sep 2018 08:33:10 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.58])
        by smtp.gmail.com with ESMTPSA id d16-v6sm1325268lfa.42.2018.09.07.08.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 08:33:09 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
To:     Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        jeffrey.t.kirsher@intel.com
Cc:     jacob.e.keller@intel.com, davem@davemloft.net,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <59fd149c-bacc-c39c-b0d8-a4fb9366f26a@cogentembedded.com>
Date:   Fri, 7 Sep 2018 18:33:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:19 PM, Wang Dongsheng wrote:

> Can't have non-inline function in a header file.
> There is a risk of "Multiple definition" from cross-including.
> 
> Tested on: x86_64, make ARCH=i386
> 
> Modules section .text:
> i40e: 00019380 <__i40e_add_stat_strings>:
> i40evf: 00006b00 <__i40e_add_stat_strings>:
> 
> Buildin section .text:
> i40e: c351ca60 <__i40e_add_stat_strings>:
> i40evf: c354f2c0 <__i40e_add_stat_strings>:
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> ---
> V3: add static 
> ---
>  .../intel/i40evf/i40e_ethtool_stats.h         | 23 +-----------------
>  .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> index 60b595dd8c39..62ab67a77753 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
> @@ -181,29 +181,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring *ring)
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
>  static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],

   There's no point to keeping *static* function in the header file (unless it's
also *inline*).

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
> +				    const unsigned int size, ...);
>  
>  /**
>   * 40e_add_stat_strings - copy stat strings into ethtool buffer
[...]

MBR, Sergei
