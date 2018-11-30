Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316ED20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TnIzjRIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316ED20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeLACZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:25:04 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33188 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLACZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:25:03 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so4822539ioi.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CnrImWicQ5cjLvxAEca4Q70u8vQw5IX4HqN7CybOfG8=;
        b=TnIzjRIM6FDTwNJjmBLfRiRC9/Xhf6j4JmPsWMnU+m+3FWNW/CwL3XFMDFDp/nRJGP
         2CrH1LqdxpunBRohMi1zzWO2DKQoWIKMevvVehqOI+5K0bWI2EkgIERC0Ubpe+NF5ZEN
         vyBYIyOIm7uTgTnO9a045e1Nf2fAP3xSJffXOV8WzUy3c2O51MQOkYDHPEQ1biv8glw6
         /AUoww5HGM9GDKrht9HUM2jsicgDzU8Aeh8MXQuPD2Y5dUSmA0gcwcjL0lcO82cRkh0d
         8hxTGFzZx76pqy+iDLH4ykaHF7AdNqkekOqz93fspoNb4Zm7cleCgImZL3IpdGCg9gXJ
         87xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnrImWicQ5cjLvxAEca4Q70u8vQw5IX4HqN7CybOfG8=;
        b=VmexTVQAi2Ob42XCwJUObNK44R1Fd8UApCTh//YY4t5Mli4R9HR6g9Vg3HdhpdCpwt
         ebtlnIs2R5JxfynqaAPuO3qxM/pW2OBXff7N2U7JI/TCtNUdEJcSqk85vV4v4yI3tjlX
         +x2Wy/xWNhA/MSxwd2yb7L2lusKjk1wl73WIBQGqFwk12KrGflk/AfDQc3sFMGioTLs0
         T3W3Cb95F/WoKWYceCast8zKTHzD4pNd4oUeLEy+BTToQyd+eRp0qo6jQYqtrAID2NWu
         3JlBX9BQOxnNidjilRV4zkrGF/UY2R25OF3M3nzHXqGxJWAlczRwvK2t7oL+Lj7+15/Y
         RrxQ==
X-Gm-Message-State: AA+aEWZ2H+X/kihhW4wlddiEFqFeNB/clprewy7IOMxh8KbB6SV+FAyK
        GONf1ZgsTAMmnviwg7zcZ0c7+t7yYyw=
X-Google-Smtp-Source: AFSGD/U1NXbUd/TDPBgc4BM+S1hich23sjLdPEGBrLKp/dToDNfy8d+3+bXKfQ1MJamt8fok2ItqXA==
X-Received: by 2002:a6b:8bc6:: with SMTP id n189mr4557802iod.234.1543590923489;
        Fri, 30 Nov 2018 07:15:23 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u18sm2028975iom.15.2018.11.30.07.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:15:22 -0800 (PST)
Subject: Re: [PATCH v2] fs: fix lost error code in dio_complete
To:     Christoph Hellwig <hch@lst.de>, Maximilian Heyne <mheyne@amazon.de>
Cc:     Torsten Mehlan <tomeh@amazon.de>, Uwe Dannowski <uwed@amazon.de>,
        Amit Shah <aams@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>, stable@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181108185835.17803-1-mheyne@amazon.de>
 <83319cde-9855-d544-8079-15e028f4458f@amazon.de>
 <20181130104620.GA26765@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c98c7576-53d6-cfd6-8b16-3edbf4c01d50@kernel.dk>
Date:   Fri, 30 Nov 2018 08:15:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130104620.GA26765@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 3:46 AM, Christoph Hellwig wrote:
> Al, Jens,
> 
> can someone pick this up, please?
> 
> On Fri, Nov 30, 2018 at 10:02:22AM +0100, Maximilian Heyne wrote:
>> On 11/8/18 7:58 PM, Maximilian Heyne wrote:
>>> commit e259221763a40403d5bb232209998e8c45804ab8 ("fs: simplify the
>>> generic_write_sync prototype") reworked callers of generic_write_sync(),
>>> and ended up dropping the error return for the directio path. Prior to
>>> that commit, in dio_complete(), an error would be bubbled up the stack,
>>> but after that commit, errors passed on to dio_complete were eaten up.
>>>
>>> This was reported on the list earlier, and a fix was proposed in
>>> https://lore.kernel.org/lkml/20160921141539.GA17898@infradead.org/, but
>>> never followed up with.  We recently hit this bug in our testing where
>>> fencing io errors, which were previously erroring out with EIO, were
>>> being returned as success operations after this commit.
>> I just wanted to follow up on this. Has anyone picked up this patch?

I'll pick it up.

-- 
Jens Axboe

