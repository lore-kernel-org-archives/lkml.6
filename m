Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD432087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xxuejiVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD432087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbeGMObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:31:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55963 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbeGMObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:31:10 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so11672229itl.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8UwqBKAgKdhQf8RETiOMwXj56HuLRalwCQK/zQucx+s=;
        b=xxuejiVM/dXupHISJhsJYqtIASF5kmLfcYY2LTg/9JVN10KQ+GYzU0MXs6P/293rpL
         X+HB3iiEQSqeX1y9SXhGc7zGXpN/vVT0EP5RaQatbCoQGZlogFdQVNsIHjy3xmGaio4O
         hi/svFxtY38kjGIxWzJ6iXK7+wvzkZ2YsNFKlLX94PQu9YnS+09skua4FeW/66wafnAv
         vGJOcj3e5DxpuLmMs7kusLNH13urTiJUElbTp95pSpLRVGdC3HzfctK7lqrXZe0ZOSu6
         R5heqxGAapiGjJArZFLXzkkRb02u3zMe+gHNv8XP0C2DLg1edgqbkZQBM/ZrwFg7PXTs
         IXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8UwqBKAgKdhQf8RETiOMwXj56HuLRalwCQK/zQucx+s=;
        b=m+jgNBZBuoWeqIysgbXfDw/9dd/STcjtV1kmXxI1L3yfloPwXCmsGO80fA8RVKqrIk
         2raCfqBWwAhRKMVMM0IG5glkhCGsm/qVX29qw2yEiYZbtNgzcz5oKBpQg5kKzqRRpN8e
         I7xIY0/KwYFHilQCEm6xY2Y+oI1AzkM8jyXFGbGlN60fk//X7ZcA6/zQUQ0ByisEb8CM
         qgYRzur2KSIMuQsPjYj+Iy/efNKBcDb0NTpg9+2NTRBuQGuUG4+jYscZPdl7tEvmtcfW
         CQF10k0ftqVD39u48uZ8BKD2otvebprUK8F+vwQtW1t6I06cYwo+NBFq5BsRnYEt3X1p
         T/qQ==
X-Gm-Message-State: AOUpUlEWnVe5Ow36SQOZx6KpPBMBaMxenpdhZG+4ndIt2armMJaw4FkD
        qCtjwetmeoQ2XcCtHYVy1FSxkA==
X-Google-Smtp-Source: AAOMgpciTRBnqEyHjgBunt2JFay97zF8Pdsm3dn8knr2NRxhvYo9GTcl5rD67kVT2iCHQRPIv2LaRQ==
X-Received: by 2002:a02:a1d9:: with SMTP id o25-v6mr5564199jah.86.1531491380858;
        Fri, 13 Jul 2018 07:16:20 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id m7-v6sm8227850iog.30.2018.07.13.07.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 07:16:19 -0700 (PDT)
Subject: Re: [PATCH 02/18] block/aoenet: change strncpy+truncation to strlcpy
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     "Ed L. Cashin" <ed.cashin@acm.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445105-18941-1-git-send-email-asmadeus@codewreck.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41bf49e3-70a5-4362-7389-55752ebc6c02@kernel.dk>
Date:   Fri, 13 Jul 2018 08:16:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1531445105-18941-1-git-send-email-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/18 7:25 PM, Dominique Martinet wrote:
> Generated by scripts/coccinelle/misc/strncpy_truncation.cocci
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> Please see https://marc.info/?l=linux-kernel&m=153144450722324&w=2 (the
> first patch of the serie) for the motivation behind this patch

This is a weird combination in terms of a single patch, why is
it patching aoe and gpiolib in one patch?

-- 
Jens Axboe

