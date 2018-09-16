Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC5ECE564
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 08:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E6C208DD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 08:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E6C208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIPNcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 09:32:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40108 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeIPNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 09:32:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so14256224wrw.7;
        Sun, 16 Sep 2018 01:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ukTHCHhpyrvTfZVGOetETVZAiCdu99vMaE7VJlEprMM=;
        b=fvY6toyOd7gD6a962Ac4TEN+9M1aJT+ZTMi9bsIUFks1C1idouMaGbc1t1gqrxOlun
         bONgSv2ReSdRKG7kKi4Y6Hgn+NFFA8OeuoDLotT1hrNhTyb0zsUyh/5PKtcP5oiqSNrh
         8IVRoAJ2xXg4gKrkX3mfjUfJMfx1C2XfaE58DxUNhiMuq18cg4tOMQtbogdcMhiQG01w
         ce9p6+to7TOUT2JUsY1tjlqBxjGzZ2+dmKNoxNNEi0m76nvJFHWsT+Pt0uI6Cd+10qJG
         HTKmAz90gvPRSPq2WeKpFdS9g6vAoT6UFzv5FHFFLLlaI1V9amNZ7fhdmqoMl5eoV2G5
         MH9A==
X-Gm-Message-State: APzg51CQkNlCz1bfdrBIov971EDIJDtE/XZBD5Dgd4ry0YQiDyfMe/0H
        s/XwiKv/G485GSxzKBpIYLIlDR+w
X-Google-Smtp-Source: ANB0Vda/sixo77Me8ccYoN5SiJYpftbB3r6OEodS8FvhZ83IwVm9wBrwCSPkl0/T1yjvdxQH32FGew==
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr15246840wrm.21.1537085393464;
        Sun, 16 Sep 2018 01:09:53 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::ee2? ([2a01:4240:2e27:ad85:aaaa::ee2])
        by smtp.gmail.com with ESMTPSA id u7-v6sm5867259wmd.46.2018.09.16.01.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 01:09:52 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogUmU6IOetlOWkjTogUmU6IFtQQVRDSF0gdHR5OiBt?=
 =?UTF-8?Q?ax3100:_Fix_oops_while_'cat/proc/tty/driver/ttyMAX'?=
To:     chen.lin5@zte.com.cn
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <201809151014546700030@zte.com.cn>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3fa25b44-d5e4-9b40-6a7d-e2ea4a35dca7@suse.cz>
Date:   Sun, 16 Sep 2018 10:09:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201809151014546700030@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/2018, 04:14 AM, chen.lin5@zte.com.cn wrote:
> yes, creation and destroy of the workqueue is not locked, I think
> maybe there is some
> 
> remainder work to do in destroy-wq, so I cannot sure if there is
> any usage about lock destroy-wq.
> 
> 
> What you worried of the races is about this  ?  
> 
>    --> when max3100_shutdown,  destroy_workqueue is doing, s->workqueue
> is not NULL, at this moment, get_mctrl is executed, destroying wq is
> queued again.
> 
> bu this cannot happen, becasue s->force_end_work = 1
> before destroy_workqueue  , so max3100_dowork do nothing.

Oh, so this relies on flush_workqueue or destroy_workqueue to be a
barrier (so that the assignment to end_work is not reordered), correct?

> static void max3100_shutdown(struct uart_port *port)
> 
> {
> 
> ...
> 
> s->force_end_work = 1;
> 
> 
> if (s->poll_time > 0)
> 
> del_timer_sync(&s->timer);
> 
> 
> if (s->workqueue) {
> 
> flush_workqueue(s->workqueue);
> 
> destroy_workqueue(s->workqueue);
> 
> s->workqueue = NULL;
> 
> }
> 
> 
> 
> static void max3100_dowork(struct max3100_port *s)
> 
> {
> 
> if (!s->force_end_work && !freezing(current) && !s->suspending)
> 
> queue_work(s->workqueue, &s->work);
> 
> }

Also, on the first open:
        s->force_end_work = 0;
        s->parity = 0;
        s->rts = 0;

        sprintf(b, "max3100-%d", s->minor);
        s->workqueue = create_freezable_workqueue(b);
        if (!s->workqueue) {
                dev_warn(&s->spi->dev, "cannot create workqueue\n");
                return -EBUSY;
        }

Here, s->force_end_work is 0, s->workqueue is non-NULL, but s->work is
garbage until:

        INIT_WORK(&s->work, max3100_work);


INIT_WORK should be in max3100_probe as far as I can see (or at least
before create_freezable_workqueue), right? But those variable
assignments also rely on some implicit barrier which is not there.

thanks,
-- 
js
suse labs
