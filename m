Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A513BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422A120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDtDKZV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422A120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbeGXLxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:53:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42005 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388307AbeGXLxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:53:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so3164417ljc.9;
        Tue, 24 Jul 2018 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E1WiLk+F+7CjPGSyq2onh46HhSjFMXz9x1Dl0NOr89k=;
        b=YDtDKZV4YiCFIsjESPjVYApCmr5bZC0gj9cOC78MtTr/XcJ7EpVBHJrCOE/sJ1+rd8
         MJAuBD8wMyVA26Ccp6Xfszac91CupG1KSE/IMTc/93/axnrwhoqh4IaKmlW3pBMats9R
         yL4WAQycliDeGZz/H5R6/P7XBalpz4K0/3wkkpLSaqisljjk03UUGMPjrQjlyKgvQ3jH
         +jxLCfR4wTDETGMBztjDJXG2F7qO+jNntt3B+FAQkhUtoEZ9acB+FYoxn2BGXV17915e
         UibzOVK8cZ2bQIHk6TgTYrcWtGyfCts3gfJLk5vV8MZEm1lZbZq9N9WeMlcR7/4dNkdw
         l+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E1WiLk+F+7CjPGSyq2onh46HhSjFMXz9x1Dl0NOr89k=;
        b=n7/hvevQ17SHb8esHCDH5fyW2ErKdH0h2X5bK+uEma4WgR43hJ7f8H9KAODo6VjYXE
         p+SqPOOHEJ4amgYOP0bJlCwqY2emGV7l8+IY9nxgki7ZlUAlDzVyoTTBJjQOnuqWAGBZ
         0WoZfv3ADD14T2hrdOLb2RQh9ZmbtizsM5jYH4S81dyHqXMqT3s2TYKJAQEkcS4NDEW6
         FFp93ZusxuzVxMGlYzL8TPuIEa0zfKm2DOkd/dkuVkOL1sSfev4Q3zHENfMuWDf3xReZ
         iVpl3OpeqTbvs5L928yRxpH5cokCwJPMdseujxmEl0tClVUNId0gJyJfHpucSapeD/It
         A4wA==
X-Gm-Message-State: AOUpUlGBnFH76PNI+N+J3ckIkB84MZA9ttnL/p+ZI2fq6GmIgUM8vjtK
        rg7neT0N9cq416a6/74zZys=
X-Google-Smtp-Source: AAOMgpf2Ac2WaIGRqll+HekrvFMlG3Me7fWoASR0DTxObe4nScELdNFLhpjonBrmiVR7u0ISXs315w==
X-Received: by 2002:a2e:88d0:: with SMTP id a16-v6mr11157321ljk.63.1532429267206;
        Tue, 24 Jul 2018 03:47:47 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id f28-v6sm2228997lje.61.2018.07.24.03.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 03:47:45 -0700 (PDT)
Subject: Re: [PATCH] net/p9/trans_fd.c: fix double list_del()
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     jiangyiwen <jiangyiwen@huawei.com>, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <20180723121902.20201-1-tomasbortoli@gmail.com>
 <5B568374.9010507@huawei.com>
 <844e4101-6980-82dd-6f02-0a7193ed438c@gmail.com>
 <20180724101932.GA17454@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2e02c44a-0775-dc74-c3a9-3c41759d182b@gmail.com>
Date:   Tue, 24 Jul 2018 12:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724101932.GA17454@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 12:19 PM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Tue, Jul 24, 2018:
>>>> @@ -228,6 +226,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>>>>  			req->t_err = err;
>>>>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
>>>>  	}
>>>> +	spin_unlock(&m->client->lock);
>>>
>>> If you want to expand the ranges of client->lock, the cancel_list will not
>>> be necessary, you can optimize this code.
>>>
>>
>> Unfortunately, not. Moving the spin_lock() before the for makes the
>> crash appear again. This because the calls to list_move() in the for
>> before delete all the elements from req->req_list, so the list is empty,
>> another call to list_del() would trigger a double del.
>> That's why we hold the lock to update the status of all those requests..
>> otherwise we have again the race with p9_fd_cancel().
> 
> What (I think) he meant is that since you're holding the lock all the
> way, you don't need to transfer all the items to a temporary list to
> loop on it immediately afterwards, but you could call the client cb
> directly.
> 
Yeah that is possible.

> I'm personally not a fan of this approach as that would duplicate the
> code, even if the loop isn't big...

Yep

> 
> This code is only called at disconnect time so I think using the extra
> list doesn't hurt anyone; but as usual do what you feel is better; I
> don't mind much either way.
> 

I think it's fine as it is.
