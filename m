Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40204C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6982080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nrEokc98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeLNTdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:33:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50776 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbeLNTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:33:04 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so10556260iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BVMq4uJdj9GiwZS67Gsjx6en9Dve9CoCPZnQ6kVkVLQ=;
        b=nrEokc98pvt18UbB3FYJTOC698g7Yr67c4/3MpnDsO2cFDYYS9ky3Mkp3FS5sJsJtr
         CVAWC9RTvW9KtJdg/ba/f2515astTw2h8Ni/yXe0wPplEUezZRZtM3kdDUDo0fcfN9Vb
         s13fvuD1uKZppb6qSkOjvvLs0EJDAobCgAvuS96YzNswDTKe4qrtVtVEapQc3nFLHJvY
         OEBNgDKg6Yx+F8d+KJBTm47m4SBGW29C9uaTgB7AVX/ePcS4z6GcLYnY43ne+yBfqZrm
         y1gnIg3ww5amw2Hz6squUpV6pgBu3fB294QsgJKXp4HdnOm50qCIh0YsVkD7HWicjJ+x
         kF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BVMq4uJdj9GiwZS67Gsjx6en9Dve9CoCPZnQ6kVkVLQ=;
        b=kUXYNVlTZn4uNM5swheqFXHSY3GHUmBXXmUZ9khGLpnDJ6uQgmouaqvYSH4mtf0T+w
         vcLdUx7xlDHtvbC7GgcmlXkZydUzRiJ+NDCrd6XG5ru45mhEacb/f3fAAOSu8l6/a/jJ
         xzs+NESRJou7MNF5RPyu8a7bZg1300vvaVGmJ9qa0DqGin5nSXj+x6qe7IN73zm0uHqI
         S6Sg9JRxOVAf0bEm+OzSFkwxiLyeFlgzdac8JzO+GGSu5lR1qKmbez9oLPYSSKksuSdN
         fU3eWas5uwvefeVoUxG9J9+9xrbX77MXNyK6niVTXUmfwhmouPQUEWVU/CmECg+GSES5
         OEPA==
X-Gm-Message-State: AA+aEWbRqzXzYM/87vxhep1ZuDqJObgHSOiTBbHu2zmDAnWV1OIKopa/
        hZFU/qJu6U6gdVmbBeGiE+Qd4B6MYJ+3Zg==
X-Google-Smtp-Source: AFSGD/XNDIPRnYmA/sSN2eCqrJirV4argD6D85cwmd20Y9sog8CA/YJzXtWej9Vin0kGJIIQJe5vAg==
X-Received: by 2002:a24:ef44:: with SMTP id i65mr4156646ith.165.1544815983535;
        Fri, 14 Dec 2018 11:33:03 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k64sm4131244itb.7.2018.12.14.11.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 11:33:02 -0800 (PST)
Subject: Re: [PATCH V14 0/3] blk-mq: refactor and fix the code of issue
 directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544750900-1549-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f13c2983-8e59-374f-7fd7-7158f3b71b8b@kernel.dk>
Date:   Fri, 14 Dec 2018 12:33:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544750900-1549-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 6:28 PM, Jianchao Wang wrote:
> Hi Jens
> 
> After commit c616cbee ( blk-mq: punt failed direct issue to dispatch
> list ), we always insert request to hctx dispatch list whenever get a
> BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, this is overkill and will
> harm the merging. We just need to do that for the requests that has
> been through .queue_rq.
> 
> This patch set fixes the issue above and refactors the code of issue
> request directly to unify the interface and make the code clearer and
> more readable.
> 
> Please consider this patchset for 4.21.

Applied, thanks Jianchao.

-- 
Jens Axboe

