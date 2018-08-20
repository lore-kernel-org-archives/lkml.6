Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50858C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0704B21722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZdxqcvB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0704B21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeHTSBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:01:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53918 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeHTSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:01:25 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so20911469itw.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nvghb6d1UHIvwtIvS1HDDKmjGbMeRZK9ngrHRje7tPY=;
        b=ZdxqcvB+NNIlglD02DYgzJ6WAc9jkjCW9bQe+4wWpUKcQEoh/l72Y2e/JTqc2n/n3v
         iqWlCiu43z2e6eyNImYS0Q3vL61n42qdGEZWZkUpGLgQ2P113LpA50q9hOMkW+tg4PUK
         4wQPfg1+mnnE3bs87eRuEZXZzTn3Li6zxLALcI11ndBQ4QdgTuam0dZUdCIKgsQWoKAf
         Ai2i4kpc2eAqmNGvsrWq2YMFJyHRcKQce/EmzEjsHDyjnLALm2WaFgpUAKtpbwv5d6bV
         dBngNMenVgkRq5exHGEfINFrkH/IyQFCisbLDLRaHyxzVj0ULXXOP6YCNVpHtyidhdvp
         L6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nvghb6d1UHIvwtIvS1HDDKmjGbMeRZK9ngrHRje7tPY=;
        b=VqdoeRsGRyodSzVm8ZvmkS72wSB7T1w5ZQXmYzxt644YyEw0jF3IeZeE4g+LbKev9i
         75fKsRloRRP4QjXRw+mCe9kPcwDeDvqb2h/SkZbT0ISkhDATPWn2GETFMy5TqKrIO4fe
         XaeJcefXqtsRFTkr6GlqniDKX1v8KsUA/l7FxPsUBURDXfoxQhUtQTE4W0dfO5pQUDZK
         zAil6j4SgfHusb83DQLVvMxPBXT7Vo44sd2e0dOXWnPwmbB5LfnucjjwnzG7AdjLB2CP
         pYXy7o9ogrPe8zMEPQzqVfivmF5YmyZ7hDSwBM/mdEX2TrrZfpC74kxaTFwflslZhMN5
         Ho7g==
X-Gm-Message-State: AOUpUlEbvVDrgzzFFxjgCXBjCgBNSgwiuxXrZi5mi0B882Xx3cecUQUc
        AoRYPTOuMERO8ojUmHD4pZ24amU4m6s=
X-Google-Smtp-Source: AA+uWPwwdSxsLLKaVff8X/vv6x3MurMts4QU4+kpkhCz2FC0aJD/NRVSZOaz5h67amXyVSZkSB+m+Q==
X-Received: by 2002:a24:3901:: with SMTP id l1-v6mr12597063ita.88.1534776328786;
        Mon, 20 Aug 2018 07:45:28 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h71-v6sm5416155ith.9.2018.08.20.07.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 07:45:27 -0700 (PDT)
Subject: Re: [PATCH V3 1/2] blk-mq: init hctx sched after update ctx and hctx
 mapping
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534749606-7311-2-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <048cdf08-6c9e-f54a-1e5c-f1d40fb2ecdb@kernel.dk>
Date:   Mon, 20 Aug 2018 08:45:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1534749606-7311-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/18 1:20 AM, Jianchao Wang wrote:
> @@ -2913,6 +2906,29 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_freeze_queue(q);
>  
> +	/*
> +	 * switch io scheduler to NULL to clean up the data in it.
> +	 * will get it back after update mapping between cpu and hw queues.
> +	 */

"Switch IO scheduler to 'none', cleaning up the data associated with
the previous scheduler. We'll switch back once we're done updating
the new sw to hw queue mappings.

> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (!q->elevator) {
> +			q->elv_type = NULL;
> +			continue;
> +		}
> +		q->elv_type = q->elevator->type;
> +		mutex_lock(&q->sysfs_lock);
> +		/*
> +		 * After elevator_switch_mq, the previous elevator_queue will be
> +		 * released by elevator_release. The reference of the io scheduler
> +		 * module get by elevator_get will also be put. So we need to get
> +		 * a reference of the io scheduler module here to prevent it to be
> +		 * removed.
> +		 */
> +		__module_get(q->elv_type->elevator_owner);
> +		elevator_switch_mq(q, NULL);
> +		mutex_unlock(&q->sysfs_lock);
> +	}

I don't hate this, but I also find it pretty annoying to put local state
into the queue itself. It would be much nicer _not_ to have ->elv_type
in the queue itself. That would need an allocation, however...

Apart from those two things, looks fine to me.

-- 
Jens Axboe

