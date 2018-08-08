Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63658C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E2B219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OVgivMif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E2B219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHHRhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:37:12 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38833 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:37:12 -0400
Received: by mail-it0-f47.google.com with SMTP id v71-v6so4023326itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w90LW1nrE9UpYZUP3DyVhBymL06r1X5rIzw+efL0iww=;
        b=OVgivMifOM+uepUxrtpKfKrNox6QLmSyIKH9zn82KielcnQgof5NLRH9DnV2ov8cwG
         8zNE4sy6Rav1fh2yYVHKc1vTG4VrLPYizjId4U11Mik3bxP7ynxvxrWd5kLhFBlseMIr
         LVxGVSSLeXIk2Psqpvhsgk2t8MMJixJ1WBRsrNxgV5i2x6ldAeDI24YxQm/TcfsAVTYC
         0+C8FnrUfN4si1PBDegiWrHmgPImYPEFE35piUlSTbNbhElK71PSbC0FVCTDd1a9wOA5
         6di9UjSifGwiwcAtacWg8Rg92iP7sIx3zcub1IH8qe2zhMgrW09bDTVvEU/SNOGJFO5x
         ONXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w90LW1nrE9UpYZUP3DyVhBymL06r1X5rIzw+efL0iww=;
        b=LHlwEQiAOHTqy6n2nHMfrXCVstB6QYciqDqdKF+2qUnWZSMcIrAbw/JciAjU1Zx52O
         jw/njIqnclV5ZmPamrKNrWSzJP1AppxOT0ioAFE/AxvSo8a38XYJssyHTNzhPl7QnqPN
         m/hnbl7EWanpmHN/FvQ4a1PBgB4gtlh2w58AQ89rXRKnvWra5FWmDG4JAFqDxshkRZUO
         oh0zWeZ+JL9Eqegtf8sebuMofIhx3UZRk2/ukUR2RtXQslYGtBTX9oQBBHKzvFBH/gBU
         F2G2mj99D/B99XS0OIiQxtUvO07ADDzFnIKyfGeHsCsGJywErT1S9P75WNnyIWagkaRK
         c2OQ==
X-Gm-Message-State: AOUpUlGUn6+EgkfQAKIXg4YQmoftdOrspKDzg0Sa7ts6Znk0TW4xE9JM
        skeW1Q6I8s94M2VZ4YHF/33bbSFSzLQ=
X-Google-Smtp-Source: AA+uWPzXQ8F94rwN2s3aecdGQTDv8ftyAFKbdTwr4nGyKeBQKWHTIyg9SNN5hKApARuFbERU5l909Q==
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr2868489jab.87.1533741425389;
        Wed, 08 Aug 2018 08:17:05 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2372233itf.0.2018.08.08.08.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:17:04 -0700 (PDT)
Subject: Re: [PATCH] drivers/block/aoe/aoedev: NULL check is not needed for
 mempool_destroy
To:     zhong jiang <zhongjiang@huawei.com>, ed.cashin@acm.org
Cc:     linux-kernel@vger.kernel.org
References: <1533740435-12088-1-git-send-email-zhongjiang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a19aadf-fe57-1989-51b1-494b072128c8@kernel.dk>
Date:   Wed, 8 Aug 2018 09:17:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533740435-12088-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/18 9:00 AM, zhong jiang wrote:
> mempool_destroy has taken the null pointer into account. So it is safe
> to remove the null check.

Applied, thanks.

-- 
Jens Axboe

