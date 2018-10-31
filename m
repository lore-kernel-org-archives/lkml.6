Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A6ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA7020821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GYFtGDrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA7020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeKAA5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:57:47 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:37557 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbeKAA5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:57:47 -0400
Received: by mail-io1-f44.google.com with SMTP id k17-v6so10046752ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=raTvYmrQOcBgKwPiiBdvCiNXMNBbFKAuz71kva2OpEc=;
        b=GYFtGDrB1kkFqE7Yh7bRnBWTq+uASq7iDFihD/Q2T/NDi3DmUGa6HfCmgVGPlR3n/Z
         OEUBKrwSccWLcuP0y9dssN/7VhdIFlcFwR1mpYyj5xh3FN5roSkjiPayErDzjdWtInUU
         jmJsuMeDKq3SHWLf9QhCS566S7sYESl9jyUO6vaTUyF2Q6RrbAI+IdGcakaSUvLgW8EU
         lLl0pNqvfbHcXpHVfZ38axel8kJ4BoEaP6FfPF6hg/mEdBQCZ8Vht/DpFnwgqfAqoPJq
         nLWDgk/MFHzLmYffEbHnQ6wMUSyMnxGYYoouUD7e3GxRX1Eb017MqdaNFfylE4/kvdjD
         YXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=raTvYmrQOcBgKwPiiBdvCiNXMNBbFKAuz71kva2OpEc=;
        b=d9PEneyQJiSZuj/L9iqN+3O/JYivg5hPaV5FiJ5VvWv1qoOPxU5DMbndcgsvjzdfN+
         fFn8PZj4UysQHuY52U1BpfuX9RGZoDonOcDfXc20gjcuSVfgY0I4uukRh85x/CnEi+wm
         obvWKnV4menHs5ZDJmjcAgdQusAfc7TZrRaIFVTPruT3JHDTYU7siDvaF/LeFsAXBTYl
         unQ8oYobOsOLDilsw19a8Nt5doOdh9ZDHopX8MgxV1F7FklhNkyqlqPev/rmzKm1d6eq
         paVTfXiUwfB5FBvig4j+5sG8SQ8GTSwdGk7QpRyjZeDUtlSAtL0TzkIu7QYquIOjgX7/
         XS7g==
X-Gm-Message-State: AGRZ1gIx6gRK5nEcRtt8mIsGVh3JzwRQ1dZi+jhHQ+gD0ER5ylpUiB+2
        7LQwguitJ9AOXEg1YGRyLFu44hPxQa4=
X-Google-Smtp-Source: AJdET5dsaU8EwUy58ixnEVAuEm94jUDJHK+n/TPngl0hEutpN563xB0A6IqW9UTSGW/D0CB1AcU8nQ==
X-Received: by 2002:a6b:e90f:: with SMTP id u15-v6mr2283375iof.200.1541001549952;
        Wed, 31 Oct 2018 08:59:09 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z132-v6sm5160603ioe.78.2018.10.31.08.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 08:59:08 -0700 (PDT)
Subject: Re: remove exofs and the T10 OSD code V2
To:     Christoph Hellwig <hch@lst.de>
Cc:     ooo@electrozaur.com, martin.petersen@oracle.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181027082019.20838-1-hch@lst.de>
 <f9423180-e0fc-efba-e759-dfa4725953ad@kernel.dk>
 <20181030074542.GB24697@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0b36cce2-af24-30de-5eb8-dd0d16fd4223@kernel.dk>
Date:   Wed, 31 Oct 2018 09:59:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030074542.GB24697@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 1:45 AM, Christoph Hellwig wrote:
> On Mon, Oct 29, 2018 at 02:42:12PM -0600, Jens Axboe wrote:
>> LGTM, for both:
> 
> I also have this one on top as requested by Martin.  The core block
> bidi support is unfortunately also used by bsg-lib, although it is
> not anywhere near as invasive.  But that is another argument for
> looking into moving bsg-lib away from using block queues..

For the block parts, there's really not much there. But it'd be
nice to remove that as well, if someone wants to undertake the
job of moving bsg-lib away from the request_queue.

-- 
Jens Axboe

