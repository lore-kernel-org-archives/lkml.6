Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF33C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22C82085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVzAdAWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfAGJEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:04:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35761 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfAGJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:03:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so20585186plo.2;
        Mon, 07 Jan 2019 01:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=S2B37O98QMCt2cG+izQaudZPrCGnPFKTb4h4KBC1HAo=;
        b=jVzAdAWOOZT6+dZtspyF/rE60dNrqf10jMVQee4Dgrsb04hJaioS8qAm6neDQK3TEX
         VrUwjLjmd6IGvTRJNFA1NrK1XZ+8RPCOBsCABdsQavdfvF15/mU88fSdbcAc1+xDY/vj
         vw64A85suLSj86RPltdkKpiV6Er90Zc3Ez3JKo1fT6rFClpPCh1SLLpAos2oC+Cy+Oxp
         rjypubr5XAx6kTRS+waXbq8z8X7G0F9J8h1sf3JvX8DW6rnMkd34F4Ef8HEd/NTrZXvD
         Ob/UfRgzQFpXT/FGObInbxXq6iMGwoCR0d3tnaka8zyzoRwNyWTOeTD53bXYIJPv0KB5
         z30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=S2B37O98QMCt2cG+izQaudZPrCGnPFKTb4h4KBC1HAo=;
        b=sfTfinM1UQK3aikoe1iKbAhhB0n9fjouHDtKrogrzUX1F3kueqaU7ayfNV8VPPLDXt
         IhNkEM2tcxRqKfqBzJL0GZ/4Dy4KjWxbAYITCtHQbAH+4dh/OuOmHHkZChjQuc2N28Kq
         4zucIuazHM0TK3/uuassHH5Mj9ChgBQnysZmZa+h7NQXQpJSZTqU4r1/JsYJL03lVwso
         UtsyT/XschE3ZDg9rkIh6DmMlOg7ir5NjRXnoLPpAuNcePcbvDvzd7szCUTHakoAo58z
         bm3cwklKMyxbl6yGFUrZPYIhrvzrSKFhY5QgHDaQSgm6PwWU2zxSwicPAmLbpABz89GR
         gBTQ==
X-Gm-Message-State: AJcUukfGni0NiMVTUHKELYn/mM2nh6z+WDAqn89LZrfXFfZ8wC5c4W3M
        sHxEfQFYBqLcmB8vSMpgND4SBmSh
X-Google-Smtp-Source: ALg8bN6VLU+X+up6/e12MLI1zD6K8R1wDBY5qi+6dfS1QoRpQWLABGbAMNhebtj8WGkbE838NrjPpQ==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr61584193pls.230.1546851839146;
        Mon, 07 Jan 2019 01:03:59 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id x12sm86792800pgr.55.2019.01.07.01.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:03:58 -0800 (PST)
Subject: Re: [BUG] tty: serial: mxs-auart: possible concurrency use-after-free
 bugs in mxs_auart_dma_exit_channel()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8da85649-f539-9c36-a97e-3582844e82fb@gmail.com>
 <20190107085224.GA26384@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <21a86d5e-ff1c-74ec-c683-cc76a7c6e670@gmail.com>
Date:   Mon, 7 Jan 2019 17:03:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190107085224.GA26384@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/7 16:52, Greg KH wrote:
> On Mon, Jan 07, 2019 at 04:47:43PM +0800, Jia-Ju Bai wrote:
>> The driver functions mxs_auart_settermios(), dma_rx_callback() and dma_tx_callback() can be concurrently executed.
>>
>> In Linux 4.19:
>>
>> mxs_auart_settermios
>>    mxs_auart_dma_exit
>>      mxs_auart_dma_exit_channel
>>        line 918: kfree(s->tx_dma_buf);
>>        line 919: kfree(s->rx_dma_buf);
>>
>> dma_rx_callback
>>    line 862: tty_insert_flip_string(port, s->rx_dma_buf, count);
>>    mxs_auart_dma_prep_rx
>>      line 890: sg_init_one(sgl, s->rx_dma_buf, UART_XMIT_SIZE);
>>
>> dma_tx_callback
>>    mxs_auart_tx_chars
>>      line 590: void *buffer = s->tx_dma_buf;
>>      mxs_auart_dma_tx
>>        line 566: sg_init_one(sgl, s->tx_dma_buf, size);
>>
>> Thus, possible concurrency use-after-free bugs may occur.
>>
>> These possible bugs are found by a static analysis tool written by myself and my manual code review.
> Care to send a patch to fix up this issue?

I would like to, but I do not know how to fix these bugs properly...
There is no lock and lock-related function call in 
drivers/tty/serial/mxs-auart.c.
Thus, we may need to introduce a new lock in this source file.
What is your opinion?


Best wishes,
Jia-Ju Bai
