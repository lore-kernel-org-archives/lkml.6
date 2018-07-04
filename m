Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD98C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9766023C35
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="LJMlmO68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9766023C35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933910AbeGDIJf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:09:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42675 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933746AbeGDIHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:07:12 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so3658900lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIFEWIbC+ZD9Oqb78a7ai1aLeWCCFIXuittM2Jhcdms=;
        b=LJMlmO68T9kxmhXVcYgcZ1Ywmk/06U/40UEsbWgtcybum3bzq0UW4gZI6CrmFQH7de
         lOxCfVdHWprEgLvFtzpvmTK7OXayHZic3DwsqJTphkwXcjZs7X7lW6dW+M9HkfkqrTdL
         jRmG4MZZkORATuZdWnwy61P+aR6B76MzLg1Cl2WU1eze1XJQXszH3q3ugDeyD/DIFMJF
         wMPz4xe9kJcHRzViZLb3N+Gu+Svt0SYhkkRy1YjFKcotvYIx7HoEKEnyh69f71soeEpg
         k5BDMBA30TVnl2BGNCALPkSE4Ijd4sl1RV4NMKDM5lBJQjWLLOsGQv1Qqcy62eTm9mri
         QBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIFEWIbC+ZD9Oqb78a7ai1aLeWCCFIXuittM2Jhcdms=;
        b=bQ/o83uBGVoc1MEeqtD0BI+Kw34N0K2gCCSNtnR1Sujvknjraf7UfqZg3Gb/4ZxTzH
         OPES+XZH/GQGpmDOPAXcFsZUezbwu+5LGkHyBKQ12iToy9sF/Gyat/NtD83dBKyttkAq
         WTSrDe1W/SfmBLiKyUtZ63N3u2PrNjkPrSY4it0f4lKugVkLiDSY8W8JHly1Fws2R4JV
         RZZ29gL6jvmsXnH42peUMpn97YjPzIl1qhbbVQbA08miLHxfeOc4nVYVPlzy9e4AEbxF
         HRH166T2Mfj3fKlHgzrRiSfODr9JgMoryScj4eEMUKpzuehe/CSDFKQ6Axio0fNHhaZU
         2n8w==
X-Gm-Message-State: APt69E3JFsnmThYocNuBI6A0FgzsbF3iQQfJesnte8k7whKmXVPLUPIg
        XkyFsz2tGVzUKJ6eHDpIST/W1tu6
X-Google-Smtp-Source: AAOMgpcgHoXHBOB0NmOUBD5/1g2utjUKEENPqVdEmLuc3dEjuC6Nw/81eD/B2JezonO4JE9HfbRJjg==
X-Received: by 2002:a19:d754:: with SMTP id o81-v6mr763949lfg.124.1530691631201;
        Wed, 04 Jul 2018 01:07:11 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id j12-v6sm473375lji.35.2018.07.04.01.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:07:09 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: mark expected switch fall-through
To:     gustavo@embeddedor.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703212125.GA29262@embeddedor.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <79636e4b-0932-791d-bd06-9f7bbf6d00f3@lightnvm.io>
Date:   Wed, 4 Jul 2018 10:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180703212125.GA29262@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 11:21 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/lightnvm/pblk-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index ed9cc97..9c93334 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -264,6 +264,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>   	switch (type) {
>   	case PBLK_WRITE:
>   		kfree(((struct pblk_c_ctx *)nvm_rq_to_pdu(rqd))->lun_bitmap);
> +		/* fall through */
>   	case PBLK_WRITE_INT:
>   		pool = &pblk->w_rq_pool;
>   		break;
> 

Thanks Gustavo. Applied for 4.19.
