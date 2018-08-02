Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980D620C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WCRH/nu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980D620C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeHBWke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:40:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35434 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeHBWke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:40:34 -0400
Received: by mail-it0-f67.google.com with SMTP id q20-v6so5462847ith.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gIDeRN8J/Y/aNqQwy9hbtSwtLadHb4xCCNgbis+F5Hw=;
        b=WCRH/nu9L/Yce2r2tsEWdrJCXekPtTOR/0cD0tJaQjOubEAb5R1UPzEVczxHYn2DLu
         QTgh+/pCO8uEzjQYpW6nfKEt0r0Lc3QU2QzPNjPeNHW53b62tMU0J6kV0Z8nPlPm2iPS
         JGOy23ZSn3fXhqjDyy5UQq7CGGtW+lq4xv+Vf+4KvO/0QOoXSU4StaA+Z2VjzuuxM/HU
         d4FAyY6LQicWujal1TFhZ6ObqaNdV+6vxPxt2IodqNHNS//OuQTfoBPtKATMMqpA9z/z
         1ip3L+V9fBsGazOflLZZBTUwr0y6KdtLYYIeSjX1Z1e9365UWGJK77dGR+Ko4N0Bveke
         qCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gIDeRN8J/Y/aNqQwy9hbtSwtLadHb4xCCNgbis+F5Hw=;
        b=i54jZNreJv7cYBGf9GhDbnyCjNrGgceJftAvNr4X4LiG2ng7vxtG5TRaRwQ7tGxFVY
         mc9+E2Rw97YxCasJWx6Ao8OsnnUPRaY/JLnnqajsNWWpmu6f4KtRGPHVp1BEcCAY5dMD
         IbRSaTggDqWlaf1e6awcJKxU2+g0Np7m8k7ZpCeDzVjrnB+xn6ucKEJ7SjJDJIi0klIx
         jfCr0lQLj4zruWdox4iJ+jzSZA3gvkOKGArSUgjY2XfxZNFD5e52/8TuT32ik1SetapQ
         vtiymkBIUhvLI2VYjpqjAPEJX+i1k4krSYGm5Kwz78EmRREcYf9wJugLThxQ87dEOonN
         LHVg==
X-Gm-Message-State: AOUpUlH/aOM0zVumaV4UK1isgIb15LpFC1pB++/hY34FJDaGRIax0Ojm
        GoJcNyvZv3PQJgIuf4CmZXBl3qPm95w=
X-Google-Smtp-Source: AAOMgpemAEX1MWBJmMWFFy+Jp2L12ZoLl5dsABAncM4uLdjKzGHaApJOTkWAQEwXri9aMIp6+Uw5SQ==
X-Received: by 2002:a02:9b2a:: with SMTP id o39-v6mr1119992jak.106.1533242865121;
        Thu, 02 Aug 2018 13:47:45 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id p84-v6sm1185354itc.2.2018.08.02.13.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 13:47:43 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] blk-mq: fix fix blk_mq_tagset_busy_iter
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180802174937.15444-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d0d3e30-ac78-5a84-48b5-5e558c3e7eaa@kernel.dk>
Date:   Thu, 2 Aug 2018 14:47:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180802174937.15444-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 11:49 AM, Ming Lei wrote:
> Hi Jens,
> 
> The two patches fixes boot hang issue in lots of test vm system.
> And the cause is in blk_mq_tagset_busy_iter().
> 
> V2:
> 	- move blk_mq_request_started() into header file as suggested by
> 	  James

I'd be fine with moving that into a header, if the target of this
was 4.19. But it's not, so there's absolutely no point to include
that in this series.

I'm going to apply 2/2 for 4.18.

-- 
Jens Axboe

