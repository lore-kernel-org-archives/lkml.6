Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00370C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA34E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeLehfrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA34E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeGZBll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:41:41 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42211 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeGZBlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:41:40 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so9536035qto.9;
        Wed, 25 Jul 2018 17:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8LyNqPMhVkjGBXPiqclf4eLP69u9ZY1td3zRHIRiNM4=;
        b=HeLehfrfcDyCEPSJLboKpTnC4NjPY9FP9EILSdhLQ9XQn+QBqCeFdcZi0z0t5fQxYP
         mqPmvYSoaM81e0d8Rmyt0X1hLamCf4Iy/adxKSIklv8b5SXxoIjuXc9Q9z+FxqKex1rL
         bHEUnrrGr4gu4FYVAsdeV+XbIlr+yoy1RBtiWLn1fC2G4QvPCrtqlKiHvCq+wTAGlS2X
         x7VtUEeEijZ2JP3DLQJOFboDRWbjdxt8BWfcIB1zB2uuKtP9Hf1rn2nt1hsgAMjD61M/
         rHpJzwA9Qfa1PNmg+NfxSmQ//3SRTUmTkAD7OLNyRlojJR/7G/glBL4BhiCPWBp1HwzP
         x7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8LyNqPMhVkjGBXPiqclf4eLP69u9ZY1td3zRHIRiNM4=;
        b=nPj0np6ue0IfEuGF6o/c4rvFeruS2rClYgHM2BtzVrcEM5JqxDUP99raWLgfyM99fH
         VsgAC7BaUyW4Ca9QwJ1Nx4H06iS/c40K20VOEDEplxw3jvmfSbO5nVNlIpG953y3oK3o
         bsTL2jGb9j6XqxI9iQI0LmzQpcf4DdNqAgNRJ8p08qigexHXlxBibGfErCKiowLSouvG
         8xYjIkEcwh11Rn4s6IZaet6iNRT9gkvDu6NRsm4y/ZaUIX5u4SJYEvqCDUhstpCSTrz2
         mdHdcT/iJvWUuIs2bRQbyHn5+DGdN7W/wrBAWCeeodNDvmFcVLs/I5UHnpL4gszcN5FX
         1i0Q==
X-Gm-Message-State: AOUpUlGS3ArzvrXw+fWDNfvrS6XHVGrCs8M0qZ4o6BSJoRt1w5AisCOB
        S1e0qMInwZaLrRGdTzrJ59aWzK8=
X-Google-Smtp-Source: AAOMgpeN5qA62Xh6ELCUeTvGWu0FGqvT3r0w2a77mhJ7Baf1L26M3C+tB26M6KiNa7egNfSL/kYs7A==
X-Received: by 2002:a0c:d6c3:: with SMTP id l3-v6mr4133351qvi.154.1532564850448;
        Wed, 25 Jul 2018 17:27:30 -0700 (PDT)
Received: from ?IPv6:2601:18f:600:d880:855d:545f:54f4:8e80? ([2601:18f:600:d880:855d:545f:54f4:8e80])
        by smtp.gmail.com with ESMTPSA id g39-v6sm8881088qta.60.2018.07.25.17.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 17:27:29 -0700 (PDT)
Subject: Re: [PATCH v2] EDAC, sb_edac: Add support for systems with segmented
 PCI buses
To:     bp@alien8.de
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        m.mizuma@jp.fujitsu.com
References: <20180724190213.26359-1-msys.mizuma@gmail.com>
 <20180725092258.GA14113@nazgul.tnic>
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
Message-ID: <27c2042a-7312-6954-bab9-c232c506aca1@gmail.com>
Date:   Wed, 25 Jul 2018 20:27:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725092258.GA14113@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 07/25/2018 05:22 AM, Borislav Petkov wrote:
> On Tue, Jul 24, 2018 at 03:02:13PM -0400, Masayoshi Mizuma wrote:
>> [*] KASAN report is as follows.
> 
> That KASAN report is an arbitrary side-effect from the missing segmented
> support so I ripped it out from the commit message and ended up
> committing this:

Thank you so much!

- Masa

> 
> ---
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Date: Tue, 24 Jul 2018 15:02:13 -0400
> Subject: [PATCH] EDAC, sb_edac: Add support for systems with segmented PCI buses
> 
> Extend the driver to check whether segment number and bus number matches
> when deciding how to group memory controller PCI devices to CPU sockets.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-edac <linux-edac@vger.kernel.org>
> Link: http://lkml.kernel.org/r/20180724190213.26359-1-msys.mizuma@gmail.com
> [ Cleanup commit message. ]
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  drivers/edac/sb_edac.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 4a89c8093307..07726fb00321 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -352,6 +352,7 @@ struct pci_id_table {
>  
>  struct sbridge_dev {
>  	struct list_head	list;
> +	int			seg;
>  	u8			bus, mc;
>  	u8			node_id, source_id;
>  	struct pci_dev		**pdev;
> @@ -729,7 +730,8 @@ static inline int numcol(u32 mtr)
>  	return 1 << cols;
>  }
>  
> -static struct sbridge_dev *get_sbridge_dev(u8 bus, enum domain dom, int multi_bus,
> +static struct sbridge_dev *get_sbridge_dev(int seg, u8 bus, enum domain dom,
> +					   int multi_bus,
>  					   struct sbridge_dev *prev)
>  {
>  	struct sbridge_dev *sbridge_dev;
> @@ -747,14 +749,15 @@ static struct sbridge_dev *get_sbridge_dev(u8 bus, enum domain dom, int multi_bu
>  				      : sbridge_edac_list.next, struct sbridge_dev, list);
>  
>  	list_for_each_entry_from(sbridge_dev, &sbridge_edac_list, list) {
> -		if (sbridge_dev->bus == bus && (dom == SOCK || dom == sbridge_dev->dom))
> +		if ((sbridge_dev->seg == seg) && (sbridge_dev->bus == bus) &&
> +				(dom == SOCK || dom == sbridge_dev->dom))
>  			return sbridge_dev;
>  	}
>  
>  	return NULL;
>  }
>  
> -static struct sbridge_dev *alloc_sbridge_dev(u8 bus, enum domain dom,
> +static struct sbridge_dev *alloc_sbridge_dev(int seg, u8 bus, enum domain dom,
>  					     const struct pci_id_table *table)
>  {
>  	struct sbridge_dev *sbridge_dev;
> @@ -771,6 +774,7 @@ static struct sbridge_dev *alloc_sbridge_dev(u8 bus, enum domain dom,
>  		return NULL;
>  	}
>  
> +	sbridge_dev->seg = seg;
>  	sbridge_dev->bus = bus;
>  	sbridge_dev->dom = dom;
>  	sbridge_dev->n_devs = table->n_devs_per_imc;
> @@ -2246,6 +2250,7 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
>  	struct sbridge_dev *sbridge_dev = NULL;
>  	const struct pci_id_descr *dev_descr = &table->descr[devno];
>  	struct pci_dev *pdev = NULL;
> +	int seg = 0;
>  	u8 bus = 0;
>  	int i = 0;
>  
> @@ -2276,10 +2281,12 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
>  		/* End of list, leave */
>  		return -ENODEV;
>  	}
> +	seg = pci_domain_nr(pdev->bus);
>  	bus = pdev->bus->number;
>  
>  next_imc:
> -	sbridge_dev = get_sbridge_dev(bus, dev_descr->dom, multi_bus, sbridge_dev);
> +	sbridge_dev = get_sbridge_dev(seg, bus, dev_descr->dom,
> +				      multi_bus, sbridge_dev);
>  	if (!sbridge_dev) {
>  		/* If the HA1 wasn't found, don't create EDAC second memory controller */
>  		if (dev_descr->dom == IMC1 && devno != 1) {
> @@ -2292,7 +2299,7 @@ static int sbridge_get_onedevice(struct pci_dev **prev,
>  		if (dev_descr->dom == SOCK)
>  			goto out_imc;
>  
> -		sbridge_dev = alloc_sbridge_dev(bus, dev_descr->dom, table);
> +		sbridge_dev = alloc_sbridge_dev(seg, bus, dev_descr->dom, table);
>  		if (!sbridge_dev) {
>  			pci_dev_put(pdev);
>  			return -ENOMEM;
> 
