Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219EE20873
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="akPTyAiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219EE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeICUZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:25:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34553 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbeICUZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:25:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so877674ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5r5gqtUZE+qaW58qqjIE3/eF1ZCDsHQ8aNx/53BCW7E=;
        b=akPTyAiHY2aMMhGq4PEu/oRSir60zcttcJjcEubsNBoM3g3wBy+NUfNLgOncM68a0R
         hnuXLh4A+RXv7pP40VQKPOd/5MnRHttdwWTieRjljY6etrdTFPuoKg20QqML+F6ohleJ
         ttZz+fg7yWyFIi1f/cK9ZjO+GnOawtx2o2GvWe2DdxYtY3OG3eMzUFCy9B1fV2wKq7sv
         zfKKDp10I64l/WO2XjcIIHzbwOdfFboggc+ec9N/mugvD/ytcvCWEJASubpC3zLXAunx
         fMNOToXYkvJ2gQx827yEtkjGgORMd7bHTMcbQklN9oXyfu35+x9Sw+3FOuLVhVUSuDtf
         3g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5r5gqtUZE+qaW58qqjIE3/eF1ZCDsHQ8aNx/53BCW7E=;
        b=LaoULBSvh3dyBd1WNXsYYC9k9Nxz0zFx646E9IJfbGX9V+JSgvuegVTg5rYJO4Ksj4
         PtPv/JsLE8vtHCPGqFyhS5kujCdEnbbjSrImzU7M4MGkfWieZjUBsmr6l5bRy1eqtum1
         fkIRuxCNq6bwERCwVugIEEuU5aR/1vfT54aXXBEO46XaNMbg+fBAotDL3x/TyrKXt8Hd
         oKOAMu5AIfkWwq8uSSOXiEagGUNekzGVnRyxOQan8HUG/8MA3VOMhDR7K1lEDPmx7GnN
         j5PZvMu6DFXNn7GDUhEDLxX3b0i4rZZPVbBgBB5TzrrnG6C+9dU7tZ0HDs1elg4CFP8N
         Qw1g==
X-Gm-Message-State: APzg51BPD6tc6uTP+n8MTVVe4x0u0oV3fJw5OknWOcEqQZue/JfI17gw
        R6HeLik5ZwtE5ogc2Cebtg0tPg==
X-Google-Smtp-Source: ANB0Vdafm6zD08Gr6NMEOt404Nqigo2s8spVtcSSGbo8lc0k4DhK48WizYddMxBjk0Wz6mS+DKWlyw==
X-Received: by 2002:a2e:2f19:: with SMTP id v25-v6mr17329640ljv.113.1535990707338;
        Mon, 03 Sep 2018 09:05:07 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.189])
        by smtp.gmail.com with ESMTPSA id y23-v6sm3634103lfk.43.2018.09.03.09.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 09:05:06 -0700 (PDT)
Subject: Re: [PATCH net-next] i40e: remove inline directive
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        jeffrey.t.kirsher@intel.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
References: <20180903123621.8696-1-yuehaibing@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b7bfa13d-d33d-87f1-6f0a-95d040610847@cogentembedded.com>
Date:   Mon, 3 Sep 2018 19:05:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180903123621.8696-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 03:36 PM, YueHaibing wrote:

> Fixes follow gcc warning:
> 
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_stat_strings':
> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function '__i40e_add_stat_strings' can never be inlined because it uses variable argument lists
> 
> Fixes: 8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool_stats.h")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> index bba1cb0..0290ade 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
> @@ -190,7 +190,7 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
>   * Format and copy the strings described by stats into the buffer pointed at
>   * by p.
>   **/
> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>  				    const unsigned int size, ...)
>  {
>  	unsigned int i;

   You now need to move this function to a .c file and leave here only its prototype.

MBR, Sergei
