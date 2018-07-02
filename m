Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C9CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F65025025
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LFeBMLtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65025025
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeGBVrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:47:47 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:51385 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeGBVrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:47:45 -0400
Received: by mail-it0-f51.google.com with SMTP id o5-v6so369405itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwRD2Oxn9GqBIvs9gvCg5Mzju0e0I3Ojbls2iUc+3wc=;
        b=LFeBMLtO8GMOhQtiYBolBJH2hVuiJtGwRFI4Xn4jW4nCLR85MsICb73evgZJYFPtEy
         QA8nSVcy3AlGC5iRXsmrOAAY9tvs7rZ6wjJ9QgKf4FcjRQUUtd02wiWW6fVOvfLuv92u
         0fwZEA9q45CsmJ0+c8MQ6yi6eeOjdD8WssnCdpbBk0NTnJ1U16ZdzG+Y/8WkXLsleYOy
         qhYR7ZTgVuT34ysT+Pd+SiSPgMwWYlvi5SkX0HxrLyTx0eYt/QEMsY8Ec7N8Us/e18zA
         KfT88IdYCHQ6gfPX1gP1L/hvuYiePOf05lrLG4vX28DUyDq7rs4giW8V0g2YIsZFfgxq
         3q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwRD2Oxn9GqBIvs9gvCg5Mzju0e0I3Ojbls2iUc+3wc=;
        b=QOvJYtahL05CMK+pTlLKyzqNJhwZGya+KZjBpC1iFd9ll92xMWe5BOkaYFk+qJNrFG
         lh2v3zjI7X1rueRfQ8V8f/8U52mpK1/bohxev2kTUW+lVrwFsG7Pv/Ovl4Utxdv2M0tl
         OLP/Ynp6a20hxIuP3SkWecXL5sMaQWuvFOGbw1VJ34/C4Dbh0oHCph2aKuCRC9ogLRL5
         ISjsnagyyBcnVqHoh+Z7LdFInUnQeoW4ZBhBAaVbAq7JW+8SCXuIrrJ0/k8k0HxaC0bf
         1stnRt2WpJCpYOPxafpNSdMEim7xEePv8N+ripUFJWsYBk9iRZ/7aMkooeLQZ+n5kGKk
         XSwg==
X-Gm-Message-State: APt69E2pL0SDLWOakM4cbAHcscDIDbEoKEbhGTK1bRMOdtBcLtgLIwBt
        EOdAd0IFlP+ZySFaRdC2qPbfDUMCHT0=
X-Google-Smtp-Source: AAOMgpf2dLspl/rnTftD5hZg/mzy7oCsCTKuO382UFeOKzTV700kyXlBBnlcT63WVqBJbhxn7OLkCA==
X-Received: by 2002:a02:4d57:: with SMTP id l84-v6mr22662948jab.56.1530568064765;
        Mon, 02 Jul 2018 14:47:44 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id k7-v6sm1679369ita.0.2018.07.02.14.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:47:43 -0700 (PDT)
Subject: Re: [PATCH 04/14] blk: introduce REQ_SWAP
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
 <20180629192542.26649-5-josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <702d4535-5ea7-8704-b23c-91c44fda34a8@kernel.dk>
Date:   Mon, 2 Jul 2018 15:47:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180629192542.26649-5-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/18 1:25 PM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Just like REQ_META, it's important to know the IO coming down is swap
> in order to guard against potential IO priority inversion issues with
> cgroups.  Add REQ_SWAP and use it for all swap IO, and add it to our
> bio_issue_as_root_blkg helper.

We should convert wbt to use that as well.

-- 
Jens Axboe

