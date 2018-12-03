Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7551620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQIl+PFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7551620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLCFue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:50:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43520 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeLCFue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:50:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so5870380plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 21:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B2RVRe6PPqlKQOz6mb8WfwywxmFsbwDAKHNhWHhhKFg=;
        b=ZQIl+PFe9o6lpt6zfwl5p3/Soi6UILls1FrfmOsgkNu0n7Ol0IzPGmRUVwqpKFho+y
         MO5VGdoU2c0m7xGKxLhbLrodAcm3JtdCEDZh23oz9+mXZH2oX8I3ohQFWv/JBUeZ4zca
         iix0g0tIGsCmaO/OrFN1az+SHUhFaABPJRRiatXRsISHrE4CU32wVzEcNuemMy5eqYyt
         aQCiam3blP5x4aEt2oXLmDn7+K3lPh1qR1CcmS2AFL/3Yv06mLUpCZhnLTh+O7QF3zoa
         zxdDscylIPRaOHUvdnOcuoXimWkWlpAxIrwzU5o7/K/OuB4q38/BNyCEh2eo49PkhVXL
         3mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2RVRe6PPqlKQOz6mb8WfwywxmFsbwDAKHNhWHhhKFg=;
        b=BPHFdXf5fag1+btBm4k4x334bspbLEs8syacGGsyG1fY7qEC4TsF9GZxJh9p9CNbm5
         aYmRASF8MmuQ+v3UmPyqqiYilrBHVGUzhK81s3TervtSoA8nVVtoFcD0aDCKsaEMfiZ/
         9HvWL9uejoo6NDtBvWbVMIDqpKenwxAxqWNG3ABTfogCRLazm3RlUydt94ACztusFwms
         //9xOKPK9yzdVEbdrvYkyDKqopxo811Vjr4nBloDKoV4j4mgA7FB8bcjl3hNeDyDSDIi
         IVeBaP6e6Ksxgttp2aELscy0h9gV2fD68Bfe1jfjEOWilwuacHa6UMBqsykRs8tzgyaT
         xkwQ==
X-Gm-Message-State: AA+aEWYdVNq7M0vvRo17MqG9YhF5dkSZWbvKiNNTthNxVI2N1cIjxQup
        hIT1OWJSB5GJE1t6x7o6sDM=
X-Google-Smtp-Source: AFSGD/WgXOyxH3FoeTt1W5YGVATv/5MGFs3pfIcaIuYEZEB+m2CIZGCnqPsUI2nKo3RX9ca1RB1NFA==
X-Received: by 2002:a17:902:2867:: with SMTP id e94mr14831928plb.264.1543816230276;
        Sun, 02 Dec 2018 21:50:30 -0800 (PST)
Received: from localhost ([175.223.22.143])
        by smtp.gmail.com with ESMTPSA id f67sm17585647pfc.141.2018.12.02.21.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 21:50:29 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:50:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v4 7/7] zram: writeback throttle
Message-ID: <20181203055026.GD427@jagdpanzerIV>
References: <20181203024045.153534-1-minchan@kernel.org>
 <20181203024045.153534-8-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203024045.153534-8-minchan@kernel.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/03/18 11:40), Minchan Kim wrote:
[..]
> +	down_read(&zram->init_lock);
> +	atomic64_set(&zram->stats.bd_wb_limit, val);
> +	if (val == 0)
> +		zram->stop_writeback = false;
> +	up_read(&zram->init_lock);

[..]

> +		if (zram->stop_writeback) {
> +			ret = -EIO;
> +			break;
> +		}
> +
>  		if (!blk_idx) {
>  			blk_idx = alloc_block_bdev(zram);
>  			if (!blk_idx) {
> @@ -694,6 +732,11 @@ static ssize_t writeback_store(struct device *dev,
>  		zram_set_element(zram, index, blk_idx);
>  		blk_idx = 0;
>  		atomic64_inc(&zram->stats.pages_stored);
> +		if (atomic64_add_unless(&zram->stats.bd_wb_limit,
> +					-1 << (PAGE_SHIFT - 12), 0)) {
> +			if (atomic64_read(&zram->stats.bd_wb_limit) == 0)
> +				zram->stop_writeback = true;
> +		}

Do we need ->stop_writeback? It should be identical to

	atomic64_read(&zram->stats.bd_wb_limit) == 0


Otherwise, looks good!

	-ss
