Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D92DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f6GUuSpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118B820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbeFRQXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:23:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38842 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754391AbeFRQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:23:48 -0400
Received: by mail-it0-f65.google.com with SMTP id v83-v6so12834532itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/NoG4DJZQDec7Sv5FVTU/vlHksYAqrGExJ64Uu8GRTY=;
        b=f6GUuSpUBRWJGnwh3jw8sRIStkd7mv3r8N46KI02lG3O69FFNdK4qAPaORb6ahilbR
         vo6OZ4foFnYKatXwo1R+gDRNoim3tDMEq0sBghfPTQKgLvZVrZe2ZpZ5QASdeuUD+JA0
         23SgnxFYAsWt86RDM15OeBQoxgRKPrgFIC5Pb1dKk+/gJjqxcve3k3MPBuFI16YWe/Z2
         wPmP6ylh/nG2XqPLelO2RrlQOgse2DQeXii6kWP7OgDFOCAMHAz+QdwztIh8Evv9ErNr
         NgTDL6MOphqItPQRavzLQHDueaFulhQXo/C8oHnbKOvJ4EoRttUwiOYmQrIu/qNNsCOT
         tT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/NoG4DJZQDec7Sv5FVTU/vlHksYAqrGExJ64Uu8GRTY=;
        b=h4wqM28p9AdlCY9x4p8YGWnf9/ASm086AxTL1xdUOy4B5eOgWgB46rXl0cO2+4m9Zz
         HvPrZgc1Q22NuJOQXJ7cDeuRPOgC5T/WgDPG5Jra8sz7x+Z3nWGJHI3zN2wdsD5aHTCc
         lOm7apQNZwoStDcLgIl0bD4odD+SvySR3F7beOJvUXh66c6r45ri0XgEWENWM9L9GzLK
         eON4qKAayI7rxiQhblKagZUw0GhKa0EeUn+/GNlp7CFkN3GoqDeGD/nYJS87/08mguoB
         o6s/O2v/v3tSPBEszB/TfSjnNxrSNUCHm+ihnK9s1kbMrIRMsULMT7eRU5/HPwMOkJja
         n6Fw==
X-Gm-Message-State: APt69E1JADloIW2BLBg4w4SO+lYoxgJO3bJpTptFRF4jOUldrHzNMknY
        E3gRZf4cYOzan6X4N5L4FDtAcQ==
X-Google-Smtp-Source: ADUXVKLikIwdbJA9ghnX2aNiGp532zLFxcuMGT6DgFoj31AoHpSithwfukquzXQk53N8u7DZ9MvUrw==
X-Received: by 2002:a24:1d8f:: with SMTP id 137-v6mr10694956itj.41.1529339028007;
        Mon, 18 Jun 2018 09:23:48 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b128-v6sm4496097itb.3.2018.06.18.09.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:23:46 -0700 (PDT)
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dgilbert@interlog.com, Jann Horn <jannh@google.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        security@kernel.org
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
 <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
 <20180618161657.GP30522@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <229a6637-3f9e-e8ed-d94a-cafbbd47f140@kernel.dk>
Date:   Mon, 18 Jun 2018 10:23:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180618161657.GP30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/18 10:16 AM, Al Viro wrote:
> On Mon, Jun 18, 2018 at 09:37:01AM -0600, Jens Axboe wrote:
> 
>>> The folks responsible are no longer active in kernel development ***
>>> but as far as I know the async write(command), read(response) were
>>> added to bsg over 10 years ago as proof-of-concept and never properly
>>> worked in this async mode. The biggest design problem with it that I'm
>>
>> It was born with that mode, but I don't think anyone ever really used it.
>> So it might feasible to simply yank it. That said, just doing a prune
>> mode at ->release() time doesn't seem like such a hard task.
> 
> "prune mode" being...?

Basically what Jann posted, not doing any copy-back of data. Need to
verify if the bio unmapping is handled correctly, as some of those
will also copy when the end_io handling is invoked.

-- 
Jens Axboe

