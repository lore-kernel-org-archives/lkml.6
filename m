Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B085C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0166A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ui7cU7vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0166A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeH2SNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:13:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38480 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeH2SNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:13:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so2343237pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l2woWWn9mTd09WCed6KZ4JHOMWuOe3bmM0XJNKOmEgY=;
        b=ui7cU7vRU6b1dEaFELXOFLWW5lnaFBXCH0/d3ncZ+g9KzPx36k48ieQV8bwZbopf8k
         bKbAxXE/VElEqk2U1FGln+TUmWXXCTBpbimHWIzgm4ZgCEfgZ82eRbW/f5S3hlUhBDPZ
         +x8gw+dTcJU7s0oqHG7VtQU7Ju1sfZLcWP2m/wJnYVjGkXJ4UDuDDe13OsFS0CKsR4mX
         g/Ztqjr96BPAcUCT0xXZe8WfEELjlFWJZOO4P7x2x7uXp7CpGYY8DcaOJYe+JzqLrgJ9
         YNIfRu92gqkQIVlD5hS6He4YPS1diRGRkGdJLIHlvWiir5WLbxoanrTfuqgExw74MD2J
         nBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l2woWWn9mTd09WCed6KZ4JHOMWuOe3bmM0XJNKOmEgY=;
        b=AHHOCLWZ88DH+reOfUv5YBp2wAV/6znyVDKwZSmDHU4lgSOTztvLlKZCwSMBPakUC6
         bMeIoeDddZAlr81OWZdzimurVIxjZQtn1mS6Q88IwyitDsF6zHupHtVcNBdgrXKCycKv
         cA/F5k7CsVk9oB/Nj6NU8aJVsE1C87Fibgn6pbK34OC5S5cHu7rCAqm0pl8LBYOVst7o
         FK0DUdDYsDZKvySwMBlE9IRDHHNrVnXyXCS9SCJnqmxTGUWymqbgRH4ho4EGWctyKhU3
         BHQ0nijCwk1Y+N0WMpgQo2uhThGmyCEc17X3ISvf9sNobjYeIRXPKpanTFfcEOpFvRFG
         k4EA==
X-Gm-Message-State: APzg51C3KfKNSMPBsckxXOoydXp1oawPg7O88VhbH5Pdul8FMDcNTM+x
        AV13btuvOJYFlw8PZgaxFVchyiMjNtIPWg==
X-Google-Smtp-Source: ANB0VdbeJPQtPtlG3mBx4C7jJTtMvYPSZowWktR2+pBsQKN6aHJaIcDwdWZtZfK4CsS+1Z2XER1nUA==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr6202724pfb.13.1535552185254;
        Wed, 29 Aug 2018 07:16:25 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id o62-v6sm5697753pfb.0.2018.08.29.07.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:16:24 -0700 (PDT)
Subject: Re: [V2 PATCH] lightnvm: pblk: add helpers for chunk addresses
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535548379-11125-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d9e4f836-1ad0-526b-241e-e934d767ab77@lightnvm.io>
Date:   Wed, 29 Aug 2018 16:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535548379-11125-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 03:12 PM, Javier González wrote:
> # Changes since V1:
>   - Move 1.2 / 2.0 specific code to core (form Matias)
> 
> Implement helpers to go from ppas to a chunk within a line and an
> address within a chunk.
> 
> These helpers will be used on the patches adding trace support in pblk,
> which will be sent in this window.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk.h  | 19 +++++++++++++++++++
>   include/linux/lightnvm.h | 19 +++++++++++++++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index be67bbfa3d0a..f95fe75fef6e 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -1034,6 +1034,25 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
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
> +
> +	return dev_to_chunk_addr(dev->parent, &pblk->addrf, p);
> +}
> +
>   static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>   							struct ppa_addr p)
>   {
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 0106984400bc..77743a02ec0d 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -487,6 +487,25 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
>   	return l;
>   }
>   
> +static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
> +				    struct ppa_addr p)
> +{
> +	struct nvm_geo *geo = &dev->geo;
> +	u64 caddr;
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {
> +		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)addrf;
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
>   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>   typedef sector_t (nvm_tgt_capacity_fn)(void *);
>   typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
> 

Thanks. Applied for 4.20.
