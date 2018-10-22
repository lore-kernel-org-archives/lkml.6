Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA2FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B51020665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kUox0kFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B51020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeJWGM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:12:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39019 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeJWGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:12:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18-v6so4795793wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8wLxXY2mrlQ5rAqDdzXl6+UReIzHAvwgZVFqBrQ+C5U=;
        b=kUox0kFr6YZyvRu0ktxADAuYAFQ0yh3mExZpgHeLQYADXJxT6tcuGUiqERecq1a4sj
         RAcIEhjHiTNuePfxJnhTu0eZUWGd/AUxKL7IlsOlwWlvb337Ve0jxprusqUyHfo5jjVv
         FKtKzaW/zDYtzo993BRcKVesxvF2l/gDI36ylJqRPHWX5KGKKRvsY9D7CHRgZPyxrTDv
         wUfiQ9Pyc4C6ye3jlqF3aZQ3kIRqdOIeteG286qGXzTcA1cl5K9VIDtosOlthfY94G2j
         2mSe9kS7wp2Ro9I2p1HO6MdjFDQayM5Qd7Embq17rn6BYKOXdDNjU2zDxGz4kBc9KZCj
         hYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wLxXY2mrlQ5rAqDdzXl6+UReIzHAvwgZVFqBrQ+C5U=;
        b=V/ynmObLwP1e7/0itkel2r3Qu/asMYiLF+A71mzpmCvCVXpvWSlsaH6dDkexzo5wdC
         jrEPMyPDyDkJ3HS8Ss/jcJSWMZMeypA5z+wcnyRKola0ICbntoC9fcc6bXb/RuKgzd2l
         8i+TqU1o8+MxdIHgdsxxcnY8fWPbaT8Y7YkrXKK2EdxUE1nPfEq+SscEyY1LwQ7Nm4ZS
         zrfVUvUUDmpozS7Yx8ligBPsPLWvwpIQU/40wI4cafaHD9iw4/XlfBWvELTqecsmX9dM
         rcFsgFPmxCt7tvznEPGEV3dAyydUv6+nRGCJFL5VPYjaucxnKOn7wXu9c7bOYWEEW7vy
         G+gA==
X-Gm-Message-State: AGRZ1gJ18cf82uNsyDs4LURASyYxNobPB9z8Jv2r7eNVSTA8WQIh/+h+
        xSc2YHV6H2LqjL87SRU6KX+wYQ==
X-Google-Smtp-Source: AJdET5f3j+dUY0OlNieVhZkDOoRcbSvaS90tEKu9aoyNp8iCh1/vGqUO8LbiA9LY1PyVXKhI9ayfKQ==
X-Received: by 2002:adf:a285:: with SMTP id s5-v6mr4258265wra.100.1540245156163;
        Mon, 22 Oct 2018 14:52:36 -0700 (PDT)
Received: from [10.111.198.69] ([109.144.211.86])
        by smtp.gmail.com with ESMTPSA id 77-v6sm25453095wmv.6.2018.10.22.14.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 14:52:35 -0700 (PDT)
Subject: Re: [GIT PULL] (xen) stable/for-jens-4.20
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xen.org
References: <20181022193132.GB20677@dhcp-10-175-29-12.vpn.oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9c5cb854-12fd-159c-12b5-afbefc4bd131@kernel.dk>
Date:   Mon, 22 Oct 2018 15:52:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022193132.GB20677@dhcp-10-175-29-12.vpn.oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 1:31 PM, Konrad Rzeszutek Wilk wrote:
> 
> Hi Jens,
> 
> Please git pull the following branch:
> 
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.20
> 
> which has exactly one tiny patch fixing an NULL pointer issue (also has stable tree CCed).
> 
> Thank you!
> 
> drivers/block/xen-blkfront.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> Vasilis Liaskovitis (2):
>       xen/blkfront: avoid NULL blkfront_info dereference on device removal

Pulled, thanks.

-- 
Jens Axboe

