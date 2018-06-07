Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i8WwMvuPGFunGwAAmS7hNA
	; Thu, 07 Jun 2018 01:52:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B4C846089E; Thu,  7 Jun 2018 01:52:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KgZU6b4/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 41EE5601D2;
	Thu,  7 Jun 2018 01:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41EE5601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeFGBw5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:52:57 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54722 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeFGBwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:52:55 -0400
Received: by mail-it0-f68.google.com with SMTP id 76-v6so10787686itx.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R6dN60/v1VfATXh32y0xGDxE3VZXR4QJnJJGxuLiqQU=;
        b=KgZU6b4/+7Sajo+RIKtYRWjK5l5t3Uh6jv5tS5/7yy7D2zW0EpVSkoyq9Ytm1eOi/6
         eFQ3uBR3Ndg5BRAO4ROyVHEmDsQs9HflreX7ZsSroFqSgQYu/2RC+qnCHj4VdCce0XZr
         Zd/JsaRNfU6n69pfB5Q9RZbSYQp50wMVYO8Y8NThOWS5dqWuHwNvHZwkhE13EWnOqDii
         /dmSfxU+agOaXVUU48wVviStwmtI57eAvC04zvT8WUrHtR6PWQNokptUwWI0ZG4dbImk
         EoPqOId08VgGstMnvtwj9wltoAmVztKskxD3+KdO7BgaG0pW1PM8T9NFy2adxJn91P3w
         ZQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R6dN60/v1VfATXh32y0xGDxE3VZXR4QJnJJGxuLiqQU=;
        b=sYcKgl+BccmPZaEyH4bSw/k57Xkm5UdvmM1DqZq/xWXcexV0DJyYxZ2tr2AAU4OpDG
         NA4v6znJz1TqaFSrBX7WJV4+cXx3D0kFzExv8qmMr8tsLRTqXWINwWmfFcOoiWfaYZ5Q
         zvzpARXXyoAze5zQ0LDVHxLwPFmb8BoQOEqnxyGd35siB0cWLd660RMQqGA2ij5JibUV
         tvPqRRBWAP8p9cE+OEfxPN6hw1iMYHDI36R5GJR+QBzVJw4R7mlLFmAokIzU2zR+vWU6
         +weQSTVQM6S4AEycYWKhlvJwWFisEDjh0NEXg9OfzC/6NerHKkUtxKwxJnNvzX6HmbFY
         M8Kg==
X-Gm-Message-State: APt69E14gvEWY0QpOHUSQedwuQ0SstJmE2f8mrOUVCKxmcHbxj9nDHVc
        YhLT1I/DTLpGKPZGMxY0sc8qQg==
X-Google-Smtp-Source: ADUXVKJa1wM15Wd9ZQVvKSHJVMV+WH+p0ycSDC1OFmWYuO1ZRaDasQZtva3tvz3YR46vlewIskWBfg==
X-Received: by 2002:a24:cf57:: with SMTP id y84-v6mr255616itf.98.1528336374267;
        Wed, 06 Jun 2018 18:52:54 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id e18-v6sm239213itc.3.2018.06.06.18.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 18:52:53 -0700 (PDT)
Subject: Re: [PATCH] block: Add block level changes for inline encryption
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Manjunath M Bettegowda <manjumb@synopsys.com>,
        Prabu Thangamuthu <prabut@synopsys.com>,
        Tejas Joglekar <joglekar@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <20180601081330.GA13067@infradead.org>
 <BD7FB879CC136E419544C8E2AE7B9C3020C566@IN01WEMBXA.internal.synopsys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <918609fa-8721-0ee1-801e-4c29b64ac9ae@kernel.dk>
Date: Wed, 6 Jun 2018 19:52:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C3020C566@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/18 1:35 AM, Ladvine D Almeida wrote:
> On Friday 01 June 2018 09:13 AM, Christoph Hellwig wrote:
>> On Mon, May 28, 2018 at 02:43:09PM +0100, Ladvine D Almeida wrote:
>>> This patch introduces new variable under bio structure to
>>> facilitate inline encryption. This variable is used to
>>> associate I/O requests to crypto information.
>> This seems to be missing a whole lot of context.  Where is the whole
>> series showing what you are trying to do?
>>
> Christoph,
> 
> The patches are generated in the below > manner, with a thought of
> sending separately to the MAINTAINERS responsible for each.

What both Christoph and I have said is that it's _impossible_ to review
changes when you don't know what is being built on top of it. The block
change, by itself, is utterly useless. The use case needs to be seen.
But apart from that, my comments on why it's doing it completely
backwards still apply, and I've outlined how you need to fix it. The
patch, in its current form, isn't going anywhere.

-- 
Jens Axboe
