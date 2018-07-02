Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99655C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7372550D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rCYMQqzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7372550D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeGBO1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:27:01 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:44022 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeGBO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:26:59 -0400
Received: by mail-io0-f178.google.com with SMTP id i23-v6so14877603iog.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YuDE8NGn6O83JuZ14zPgnbbksrBPVZhc+fCQ2UeafUc=;
        b=rCYMQqzh2fCaI8+MvqhDTaNzi8/EjXUUFcLM/PMVP7A+3iqE9duixoYwyUiDHqMu70
         ThMj0wfCzKewCyM2mRxGQE8bPTxKSHT+nEdBfU0n27O5JRG3VfuFP1nnmFEznCaaTqAu
         p5kFlx5GbI6TtQShh2dLyT4rqYNxkwI/m5aO/nYOy0z9YSQir4W+4lSag0Se8qU9S47b
         vftNHIVbmx0p8L5I6uS0SBP7yT0npEdGtvkiVph+b9zyHLHPLrPnr7eA1MhUUiqRarXp
         FUtrJwrlA/i/sdd0ACK6sZjkTwGWErPTEzyFv0Ti3atTnZscIcrJcyrTnK1InD7tT8XE
         tBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YuDE8NGn6O83JuZ14zPgnbbksrBPVZhc+fCQ2UeafUc=;
        b=WFV95DHvqh9IFxpeooHVh0Vo8H8hqQ7grriPoqCWZeoSnqL74fxqvcToRUakF22HhY
         1aA2yCqHJDE1isQt1OBBtIA9mrVybhlbNgCROQtDPdWDqFhYaQEMcZ/0grQvD4V/yvkb
         rdkRYS3cAt4tCZrhvkg0GjR5hftmOoJ4t96FrofTPJ/taCV98mi98xOd+B5wUaRud0bc
         M1cBYhn+uUstPQwMDuSF1irfCV+hSaTBzgMOhtoxPhOJnQ1sYufVUTNEvZ9MaXUjAjro
         I8s/7VCcnLkxI/w03U8gaXVo6HpsJ9vwFPdSO970fD4OuFSLftRA7jnxxrNoOIl9a4rf
         3rTQ==
X-Gm-Message-State: APt69E0aFzjRMd+XHmoJVmsvNV4UCLbQPOLwpGMK2A72D5Zcg1N05GTH
        YY11433axxFQOqg5KTItac55Jrrg9uA=
X-Google-Smtp-Source: AAOMgpeBCx06JYz82g3cpYxsqLCYnUOcIIs0cKutGj2tvY60ZmAzbK27J4DHXOz0hVFCA7IHHq0OHw==
X-Received: by 2002:a6b:6a08:: with SMTP id x8-v6mr20698839iog.158.1530541618746;
        Mon, 02 Jul 2018 07:26:58 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f127-v6sm8100823iof.32.2018.07.02.07.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:26:56 -0700 (PDT)
Subject: Re: [PATCH] partitions/ldm: remove redundant pointer dgrp
To:     Colin King <colin.king@canonical.com>,
        Richard Russon <ldm@flatcap.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702071359.6534-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3ea960d-90eb-1bda-2d24-7730a94d3285@kernel.dk>
Date:   Mon, 2 Jul 2018 08:26:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702071359.6534-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/18 1:13 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer dgrp is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'dgrp' set but not used [-Wunused-but-set-variable]

Applied for 4.19, thanks.

-- 
Jens Axboe

