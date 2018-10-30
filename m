Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE0C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3744A20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HfBr3dtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3744A20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJaAMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:12:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51199 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJaAMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:12:02 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so14150903ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OjfRhRv23qil778Hvb40+cZ9PaAdBfTdgJhkqoxeGPU=;
        b=HfBr3dtf5IZjoW9choJSWDukpycrUWinuzVLqmXHghBdh4PP4x18lAlSnuE2qZDfIH
         43Syskd1H6ybUmgiOcnr/9W3hmbaDrnjipFRu1pbQzRCHyrhv1Q20UYJhM2uw8utkW6Q
         uI3FEkWA3RTrLRC5WR+eZvjBvQdyERWPRKMfaOs+yxv9PQcuUaY4wUEnDBdcy3bn3aqb
         jGEPV6s0pm8UfUk2VS0DdG4hh1k1yfCQD8ow2gKFCXFp5//vbfPfKXasbSPfofPA0BSq
         +4I1NmlDeXZ9DQJViR9uBOcG509kpDQp3iej2Zl5llLUjp5G7ZmY7QJUbMTHqbjy3imi
         LjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OjfRhRv23qil778Hvb40+cZ9PaAdBfTdgJhkqoxeGPU=;
        b=WXvubTvEXeEF2ZuQViqlJZWViOzLIUJfNoEGaaqyMQIjwMX0iA8pNf2T87jCbtn8MP
         ptvQEHZie5By9Tt/TxRg8HTsLCcwm4XdzCnM4FaphrtsQUfnxzS28wXOa5/rz6R2SbKw
         nyNs7V4nYJAf/RS04GeT26rl/nYRqFe3xNDdlZrQ8QDOMuaKWWvaqEin09HYkFm7Voad
         PuL2Uy1frXgo27v6TYzp/aQi+Ng+OdzwCQC7m9si0nyfJ1Co03zyyu2EM3DDF0wnwRmA
         4qAsaLTD4PZDE24E1lJzU7xzc3FJbbOvvr2a8QJFeGDj9Di0QQjkIsLaHLxTdvYkpQpt
         2hCQ==
X-Gm-Message-State: AGRZ1gJI56zHUe5dtbOU86Ga1k5RPDUcSMWdeypg+8XngAAUunflSTn4
        j8hmbAgn0ubnh0rqgh1GZt+d6Q==
X-Google-Smtp-Source: AJdET5d58aUMeGtju/H6/9xeremeWOaU5rrdrsz1+lSZjakvxg/tvaoERm3Nk7FxmuBa/FbosSkL5A==
X-Received: by 2002:a02:5605:: with SMTP id o5-v6mr9652053jab.107.1540912688860;
        Tue, 30 Oct 2018 08:18:08 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w124-v6sm8912104ita.0.2018.10.30.08.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:18:07 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
Date:   Tue, 30 Oct 2018 09:18:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030150840.GC18906@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 9:08 AM, Keith Busch wrote:
> On Tue, Oct 30, 2018 at 08:53:37AM -0600, Jens Axboe wrote:
>> The sum of the set can't exceed the nvecs passed in, the nvecs passed in
>> should be the less than or equal to nvecs. Granted this isn't enforced,
>> and perhaps that should be the case.
> 
> That should at least initially be true for a proper functioning
> driver. It's not enforced as you mentioned, but that's only related to
> the issue I'm referring to.
> 
> The problem is pci_alloc_irq_vectors_affinity() takes a range, min_vecs
> and max_vecs, but a range of allowable vector allocations doesn't make
> sense when using sets.

I feel like we're going in circles here, not sure what you feel the
issue is now? The range is fine, whoever uses sets will need to adjust
their sets based on what pci_alloc_irq_vectors_affinity() returns,
if it didn't return the passed in desired max.

-- 
Jens Axboe

