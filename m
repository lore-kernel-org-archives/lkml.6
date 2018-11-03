Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C731120843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Eh+Xte2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C731120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeKDGdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:33:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38079 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeKDGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:33:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4-v6so187782plo.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CzPngopffJOD3tB4KK8NZH5GIHivE9K5b8Fb9M0G200=;
        b=Eh+Xte2Xbnydte3x5bWf5fkvFv7Sy0t8lcu6GCDeDB3TsbjciFnkVFN6N4pdTBMS7C
         /WNnYs3wwG2O4+UGiWWcu4PO5FBasVYBRHVhl23Ple/kltSVp3W+gJiqbYjb+vgoyki7
         TGXMI5BDvobCl7MUOuCLh0KiL2aIT99eGX6RCP/ot5zch09Yt5g87HRPKS68dNXGEXYv
         miD0herBKYgBksVYnMVZn1tdFTyHp/Iakz7JiCnMH7pEB+xXEtAjNPK3kkBo8893TL61
         vlYJ056wLNtbKGc9a991s2EZTPG7OOgWLB0kXIhUFE5aMzU3K4Bh0DCRbUBl+ZWZ+IXX
         E/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CzPngopffJOD3tB4KK8NZH5GIHivE9K5b8Fb9M0G200=;
        b=fJGekFZDIlmTNkj4wRmh8maQeERs8ZblSfVdL83vEb+ov9pWhTHQ9mHQv2vCdzqQDt
         G0BlDGOEI2XlRZ6JqB1848X4H8li4kWGJm9Hj5nwk5DcE35yLljZsG0r7cSQ/5KlJ0bk
         LAPXHHwlbT1r5e/2fwti5dQwGUOVXWDXpNNbpj2aiQVLb3ljy9HbiPTwpm5St3BWUau+
         zdb0D5/vn+nBxtkbJuS/xlohh6ytkPZXcaOxm+sa4FpMnmziYCdsbzdgVA8f1DbdAtIS
         Z8l1ZSXo3qjovUx06Ny6zBOTOwwI/5AMoXbS4ubXsASC6XJpNMUcUZB+GeNx2CaHe3LM
         60OQ==
X-Gm-Message-State: AGRZ1gKFQ/jdpT1DKSaoh+j0YzA6y7UGRLRm0DQ1G1cz0LtHOxWGRbJ6
        VRxJkxAAoj2U43yRPnowD+i6Jg==
X-Google-Smtp-Source: AJdET5fYcLGGCED1ozXYhdGjqgoM2+kcgpRHSX+VtSq1rjC8on6Ne2f3kmiGhQEv1lwbh5yUR11V2Q==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4-v6mr12076531pls.13.1541280080614;
        Sat, 03 Nov 2018 14:21:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v19-v6sm42113720pgl.80.2018.11.03.14.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 14:21:19 -0700 (PDT)
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20181102145951.31979-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
Date:   Sat, 3 Nov 2018 15:21:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102145951.31979-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 8:59 AM, Ming Lei wrote:
> Hi Jens,
> 
> As I mentioned, there are at least two issues in the patch of '
> irq: add support for allocating (and affinitizing) sets of IRQs':
> 
> 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
> 
> 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
> 
> The fix isn't trivial, and I introduce two extra patches as preparation,
> then the implementation can be more clean.
> 
> The patchset is against mq-maps branch of block tree, feel free to
> integrate into the whole patchset of multiple queue maps.

Thanks Ming, I ran this through my testing, and I end up with the
same maps and affinities for all the cases I cared about. I'm going
to drop my initial version, and add the three.

-- 
Jens Axboe

