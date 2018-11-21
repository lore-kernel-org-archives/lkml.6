Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D936C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C921F21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5BInUlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C921F21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKUP2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:28:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33049 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:28:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so3648754plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 20:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aqhDjAmEJk+ZSXKkfcKTbF/IA2KObuibwBf5UluFCPg=;
        b=H5BInUlCJZT0qs/tQs9UG/gwDIzTfYODpS6hBFDnFOWQQMcJLAXIblEETFsDH3V5oV
         xwBGW6z2iGGbNsm9yAAH73R12XQQ05+KDHDhekZ/8OdZLtBBq4zWkttDqgXcsUyTVQg2
         tu9sOK1b60SmgP0cjutLNBt3iqNl6mn7u6BENMsO1+7vtN/iZGhgSOgweooeXFSWjONw
         8SvsxKUrM/OPPlQKmPWnJ7Cll6CKNjiv61cZnn0hGfkEIw6iqtsRBk2e1fsg+6MZSmWB
         ZzLrBspBaahON0+RN5wBuFTZEv742p1SZxqocHeT0nevX2brRVPQsZYzA9MPX3wN8th9
         BTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aqhDjAmEJk+ZSXKkfcKTbF/IA2KObuibwBf5UluFCPg=;
        b=cyebwj5MBE4CS+qUDEEV11iUdmND5Z1FHtSza4dcYm6S1HpnSWSChAV029pbU33gHW
         Abi2QxdCd7BxMKg8n6KbZhrARFtAUYlY9VLBB7/VcRjrIGSTVM2P30PY3de1c1aYmeG9
         fq6lvMVBll9SrX4zGFPgbYWkP4AJl7D71Qr9ey6Eovxtvyr1rhvqlkHTvGPrv1ICvV6+
         OiYNb9Po6DAsYqDe2PBSr4m/6CylUnA7UGsWYPQDjL95cyUGUSBAOxDxaJmc1lUkm76Y
         n8lJvzdKxNO1B3OdZvVkGs4rQj/mwM6UlzC+uWmmyzdMZHmqlgEaqG7wIVmU8QKyrLQm
         ykjw==
X-Gm-Message-State: AA+aEWbvgIv/4xEVhesbVStfhMgXjdqXpVL5zKUrktKBDLWAw7Ftrd4+
        Q+EM7MapqTprbtkhR0k8xBvrF49E
X-Google-Smtp-Source: AFSGD/V6Qj5nryR3bm0/8jdHFEseADi/lnTm+55N/JXl5mGjp0DFF8BQ68rxF06m8EMxlDs8L7zl9A==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr5115774plr.207.1542776155212;
        Tue, 20 Nov 2018 20:55:55 -0800 (PST)
Received: from localhost ([211.246.69.120])
        by smtp.gmail.com with ESMTPSA id u137sm56846643pfc.140.2018.11.20.20.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 20:55:54 -0800 (PST)
Date:   Wed, 21 Nov 2018 13:55:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181121045551.GC599@jagdpanzerIV>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116072035.155108-5-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/16/18 16:20), Minchan Kim wrote:
> +		zram_set_flag(zram, index, ZRAM_UNDER_WB);
> +		zram_slot_unlock(zram, index);
> +		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
> +			zram_slot_lock(zram, index);
> +			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
> +			zram_slot_unlock(zram, index);
> +			continue;
> +		}
> +
> +		bio_init(&bio, &bio_vec, 1);
> +		bio_set_dev(&bio, zram->bdev);
> +		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
> +		bio.bi_opf = REQ_OP_WRITE | REQ_SYNC;
> +
> +		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
> +				bvec.bv_offset);
> +		/*
> +		 * XXX: A single page IO would be inefficient for write
> +		 * but it would be not bad as starter.
> +		 */
> +		ret = submit_bio_wait(&bio);
> +		if (ret) {
> +			zram_slot_lock(zram, index);
> +			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
> +			zram_slot_unlock(zram, index);
> +			continue;
> +		}

Just a thought,

I wonder if it will make sense (and if it will be possible) to writeback
idle _compressed_ objects. Right now we decompress, say, a perfectly
fine 400-byte compressed object to a PAGE_SIZE-d object and then push
it to the WB device. In this particular case it has a x10 bigger IO
pressure on flash. If we can write/read compressed object then we
will write and read 400-bytes, instead of PAGE_SIZE.

	-ss
