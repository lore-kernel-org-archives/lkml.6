Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8799C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBCD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="cyxseUYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBCD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeH2Qct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:32:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35595 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbeH2Qct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:32:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id w8-v6so679722pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6cnYM4JxGL/GXYjeMMtyJXPSFkgH2Z1/OHPpFFP0cw=;
        b=cyxseUYqaj0Gv6LtDFYLr8QDmVRO1K5P2wpJz9QKbEpNZSmjHcfSnCD42zI1LnT3xN
         PHUPS2CZR7Y5cgUWuA6Wb5lE9T2GK+Znl3ixkXyi0nhBD8JVzbRfOnlZO0cgiHtP28zB
         LvN6VGlNh/+p9gajAhViyl1+STTA9L20R6jIbccXbS3yjiv8zKbObGUe7YaCAGEV7yGn
         Ggak5ReDSrSHMQyegfolG/TAMgTxReVcHeXVgVmOq2eG2mzs6whPx9bY31BDqEoseedq
         s4ul6NuqGreZEOM3D89KI7vyigjt9HCsrhF7do/DIfbu+3Bga8no5C80EjkF+0TsYgbz
         SNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6cnYM4JxGL/GXYjeMMtyJXPSFkgH2Z1/OHPpFFP0cw=;
        b=CrqPFmFe8dikwbGZ9XHW323dxn31Nu5conOxgKfTIEhFgdE6HoEE2GjvAh7UIr1Foz
         RHiuU2HRn0r/GyRyeW6REr+fpujbDbXmG8G9UZkd/jVpMjeW7t6W4QQu8VGTRLGb2SWt
         hNpXhwkBpxx+UUU7n31Hiv8fE5Va11K2hTLw1D8vam3eujgjKREGWge1CaQ/lvX5AFIO
         pwMljFxMOGkAy/Hmz7zs+vV9syvTOIlhalF/6xOkimfNYE8WHGQuRCTHiVyTxg/wle4K
         dUtH71nPhfgTDG/wlS1NZv3lsy3yr/Iib97yB6IyBdRR6aRkaZaSMszwYuHT0/VfeGHa
         oRCg==
X-Gm-Message-State: APzg51DU0Zrw50mYrDt9ecDV3TEqYNlnh0TU3vQ4rbBoEe8ZTjiXkc2G
        TAI2tNJ5USuHhs2yUWutpAWEig==
X-Google-Smtp-Source: ANB0VdZmoM00b7Svx9cp/1aPyb3zy8WYsk6DVEpV1eVtJfSYcNODHGbKWH/0e87VC0zyJebdtA+mNg==
X-Received: by 2002:a62:6d02:: with SMTP id i2-v6mr5927195pfc.218.1535546166100;
        Wed, 29 Aug 2018 05:36:06 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id r87-v6sm7114925pfb.1.2018.08.29.05.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:36:04 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: add helpers for chunk addresses
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <742b25cb-c871-2ef4-d34c-a81bce9283a8@lightnvm.io>
Date:   Wed, 29 Aug 2018 14:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535531871-23255-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 10:37 AM, Javier González wrote:
> Implement helpers to go from ppas to a chunk within a line and an
> address within a chunk.
> 
> These helpers will be used on the patches adding trace support in pblk,
> which will be sent in this window.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk.h | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index be67bbfa3d0a..1bfbd3315598 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1034,6 +1034,37 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
>   	return ppa;
>   }
>   
> +static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
> +							struct ppa_addr p)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
> +	int pos = pblk_ppa_to_pos(geo, p);
> +
> +	return &line->chks[pos];
> +}
> +
> +static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
> +							struct ppa_addr p)
> +{
> +	struct nvm_tgt_dev *dev = pblk->dev;
> +	struct nvm_geo *geo = &dev->geo;
> +	u64 caddr;
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {

Please move this into core.

> +		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)&pblk->addrf;
> +
> +		caddr = (u64)p.g.pg << ppaf->pg_offset;
> +		caddr |= (u64)p.g.pl << ppaf->pln_offset;
> +		caddr |= (u64)p.g.sec << ppaf->sec_offset;
> +	} else {
> +		caddr = p.m.sec;
> +	}
> +
> +	return caddr;
> +}
> +
>   static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>   							struct ppa_addr p)
>   {
> 

