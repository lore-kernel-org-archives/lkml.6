Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E765C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D338020657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SkD4CyF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D338020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJ3AW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:22:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38985 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeJ3AW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:22:29 -0400
Received: by mail-io1-f65.google.com with SMTP id n11-v6so5217997iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dfGgbrC4b0WyXjkop9aK6GQ7n5vgXjd3j09BRRY1IcM=;
        b=SkD4CyF65IGCUEobBzvE2g2TCuhbh5mOOtYDpo2lg/rAgA95brGcL/CXi1JC6rlFlJ
         CL1tctOwxzoFjoPJwjWvfzaSbU2lF5hMRu+hR82TC5LZjLJ/e7iT90idJzU6wsLuSHWO
         P4FVqCfEdYzhbnDaU82O6mvxB/6mxtekAj66mcaDqPBJfVca0AF9WXXXH0yE1xJgmLz+
         FYcbwBv2uv6b4u64Me1q8ZQRqIwlu1vfOsMWyyfcXMKzeDVVimJy+ntSSOvoOgdY+6v+
         lX/PV76SMYw8Qw/rcEAWJLw6U6EHysO6wdVtS5UAVmOJYRf6Cc1XK+9/xqyAhUyJ8Jg6
         gANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dfGgbrC4b0WyXjkop9aK6GQ7n5vgXjd3j09BRRY1IcM=;
        b=GeGjNsxdkkDSy3/Zn54S2PtjdahqMCGsdmlB/o+wOCbo8c1GzxBd9LtACrrfktJ18Y
         3Nik2xT1EXp5sYbX7hhNB0Pj7PBbDkuFwU6uptXszA13V9KA5bo/slFjhXHFLiuEO292
         VD3GhQ3oSsCeEjcGvWjva/2XPujG9GK02S2r8QjYL31pooGRxThLa6syWVqblXyIOqmG
         WTM90MCgCG1UHqb06MGx5doEDhYWHk0Qm+qxbc4PcilFvEZRN+iDa+X7RVUOTrVwL6Cl
         I4Bc5BMnlfh4EeLGbnCVyrSmaWTcc88/DsMd32IHyDZowJx1XZ6wmAr0mZY9vVyjE4iO
         D1+Q==
X-Gm-Message-State: AGRZ1gI+EkbpiCpncAEj2EDnR60KZsPk9BTGON+Zrs5VDu2x9U8zQ7qj
        WEiinOimQcgE/dN4tkFCGCVDOJfJftY=
X-Google-Smtp-Source: AJdET5ffCb7wTca2+J94LEMmuvZ2o93izzS53DRy7JvKsp7a9w2DgkqwSdeowTTil/9wQe5MTS4wQg==
X-Received: by 2002:a6b:1506:: with SMTP id 6-v6mr7895104iov.50.1540827201588;
        Mon, 29 Oct 2018 08:33:21 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n202-v6sm1891252itn.34.2018.10.29.08.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 08:33:20 -0700 (PDT)
Subject: Re: [PATCH V5] block: fix the DISCARD request merge
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <610adbc6-24ba-e6ed-a98a-f3faeef8bd51@kernel.dk>
Date:   Mon, 29 Oct 2018 09:33:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/18 5:52 AM, Jianchao Wang wrote:
> There are two cases when handle DISCARD merge.
> If max_discard_segments == 1, the bios/requests need to be contiguous
> to merge. If max_discard_segments > 1, it takes every bio as a range
> and different range needn't to be contiguous.
> 
> But now, attempt_merge screws this up. It always consider contiguity
> for DISCARD for the case max_discard_segments > 1 and cannot merge
> contiguous DISCARD for the case max_discard_segments == 1, because
> rq_attempt_discard_merge always returns false in this case.
> This patch fixes both of the two cases above.

Applied, thanks.

-- 
Jens Axboe

