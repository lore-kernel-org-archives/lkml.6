Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB29C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552D0218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfAHIAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:00:33 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46903 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:00:32 -0500
Received: by mail-wr1-f41.google.com with SMTP id l9so2981604wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 00:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=syrzYwWuhtGu+MRtp/4oGBHKOgFgYtYyODXTX3W8REsrVt3oETCf//cBRomCbRdtzJ
         46Y/Y4dq60tBhsIMhg/uYZ9KOhnC7bbjezxqsNG3/Dx7HgMrI1xScUhBbt4Zr4eQqH+n
         VCjdGYbsqWBvzJiHQV27PAiKmIXAZEp3V3Fr3lZcVFLMHZr2ruH6MsIcu4sMKZ6UdcBX
         JOWaigcyfrv3G56TTb/R8awtY2sxy1ZPriMy/oxrLYRRMTjaJeqQrgsqSMHQXQB/4c9G
         mq8PB8E5Tlcwd3Ly85c+QVzBle+8PeSl2PLLb3lpO3Rkpm2/9egmlqvwMZ05/Ytaz3Ns
         3eJg==
X-Gm-Message-State: AJcUukclvzUKnBS6sq/qXaLAHik5pC+37BUqLsFi7MiCNfzCoIBAtGZg
        fobRlbV4I2BZCTphVAsr2d8Y65IE
X-Google-Smtp-Source: ALg8bN65yTEwq785rTcewgn+OLoeP9ar1oEZjHRs3NGpgwYIX3megPpIKtyGzd/wPYxr3CUMLw7f2Q==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr647992wrm.2.1546934430995;
        Tue, 08 Jan 2019 00:00:30 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:782d:2af2:5049:76cb? ([2601:647:4800:973f:782d:2af2:5049:76cb])
        by smtp.gmail.com with ESMTPSA id g67sm16056292wmd.38.2019.01.08.00.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 00:00:30 -0800 (PST)
Subject: Re: [PATCH] nvme-core: don't initlialize ctrl->cntlid twice
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-nvme@lists.infradead.org
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20190108030849.12870-1-andrew.smirnov@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c5c91840-185c-87bb-976d-6603411c6e29@grimberg.me>
Date:   Tue, 8 Jan 2019 00:00:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108030849.12870-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
