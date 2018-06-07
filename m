Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0CaqAveYGVt5BAAAmS7hNA
	; Thu, 07 Jun 2018 20:43:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 86D13608BF; Thu,  7 Jun 2018 20:43:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="h5EyTmow";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P3gwci+s"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BE4DB606FA;
	Thu,  7 Jun 2018 20:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE4DB606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeFGUnL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:43:11 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46983 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeFGUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:43:10 -0400
Received: by mail-vk0-f67.google.com with SMTP id b134-v6so6882578vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/xWR1vwVrfdBIqw2Rcw074r7x93eVC98mKlL4MKuScE=;
        b=h5EyTmowB3NGJlqgu54/PnjN36yUrruwBQnD9aC8ca+6m7TVOxhb4JUNwOzajr4nwd
         fsVNJ7o9LgElAdEjOhAysMFg8ordjkZgh7cMw3Eit06cyxD35ceCPRtc0+KLyO4e3POg
         rPMtRzUrw7D0IQ11dDTWiMg//ixtpTnDvPm6H5wyOKYQy9vzWcAEpnqgL6aVMzEMSopY
         WYFVYDy6XbsUBYS2KaoIedyMeZ5Rsy3s9XLBOgFA0JT8gnTCRa4WS4Zpi32NNUOxp4k4
         edAAhpv/xIGC0Ke8+Iv1EwLIu3X6g/giYyTh8SWQJx4cVFoScU6i7v46XU0PBBwaIRFp
         f+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/xWR1vwVrfdBIqw2Rcw074r7x93eVC98mKlL4MKuScE=;
        b=P3gwci+skJTDm48GeJyK1Ff7JkH6bAI0xUGdjMD7O/3brbXVdI6JeeP9+KznPzJuvu
         QCszn7F8IZvshDIEnBb+4auWIVfJUDyw5Qpdr7+isaFlz+SDj7aJCB6CvYxK0BiHD0of
         41W3nemkNbx2KGj/EsFNUXBG6mUSNDJybhg5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/xWR1vwVrfdBIqw2Rcw074r7x93eVC98mKlL4MKuScE=;
        b=rMWRNOzs2ssmUMCDaDO7KXG3qbYeHfhvdeQwgKuo1Z4/G5aWQ6weRJl4LB6cNWZ+P8
         LAqol55QN3eYGHYsRvkMIlx5/SCA1OPjq2FFH6gc4QcEu3Ccx/61pr6vo3fRwqQrX83J
         y6jAMlhiJbIp45uSNsYBGsQ3o2PpdbsoSZ8JBySR2IjBRd2onsOs5dQjFKF5GN/rZhlA
         d2Dk9tFOfQo/3UeSekRMOIj5R/2/WVAqN4kuD0ZFx3Arh7vvEOw4LGPOMCGVJeOJWono
         dvB272UTUzPpEUTgRl58wO14pv5vyUVe5NFe+qLxhKXaG3IFmr2I39M4rAJS8d1rvZ8i
         bDBA==
X-Gm-Message-State: APt69E1Bnhnq5CSQiM+vc0+aTr1AJtieDAr49mXTRMY/sF1db895IO+z
        EcTWGo8wpLurs2Qjv+HAoCfWOYPM9tulOU+5laV4RQ==
X-Google-Smtp-Source: ADUXVKI1A8fbyUXyQRul7qbr2jqfU2ivPQQFsdbZnQ5PGRCrSehA2nYE7AO56WMg9EhBNm6DNBvvjc+/2YsBAbdBSJ8=
X-Received: by 2002:a1f:5785:: with SMTP id l127-v6mr2239199vkb.84.1528404189025;
 Thu, 07 Jun 2018 13:43:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:a085:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 13:43:08 -0700 (PDT)
In-Reply-To: <CAGXu5jJt_Y5KJwCKVPpTFOBt36aDAG9TqbB2bWAdu+2oGV5cZg@mail.gmail.com>
References: <20180607145720.22590-1-willy@infradead.org> <20180607145720.22590-2-willy@infradead.org>
 <CAGXu5jJt_Y5KJwCKVPpTFOBt36aDAG9TqbB2bWAdu+2oGV5cZg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 7 Jun 2018 13:43:08 -0700
X-Google-Sender-Auth: P4bkQaUV3N0vCjIx4cqRMsPrdkE
Message-ID: <CAGXu5j+X1BrPhtdOP9AJ-oSovoHcS1CQHNsiFisdQt=Th7LgWw@mail.gmail.com>
Subject: Re: [PATCH 1/6] Convert virtio_console to struct_size
To: Matthew Wilcox <willy@infradead.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 12:29 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jun 7, 2018 at 7:57 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>>  drivers/char/virtio_console.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>> index 21085515814f..4bf7c06c2343 100644
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -433,8 +433,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
>>          * Allocate buffer and the sg list. The sg list array is allocated
>>          * directly after the port_buffer struct.
>>          */
>> -       buf = kmalloc(sizeof(*buf) + sizeof(struct scatterlist) * pages,
>> -                     GFP_KERNEL);
>> +       buf = kmalloc(struct_size(buf, sg, pages), GFP_KERNEL);
>>         if (!buf)
>>                 goto fail;
>
> I feel like this one should have been caught by Coccinelle... maybe
> the transitive case got missed? Regardless, I'll figure out how to
> improve the script and/or take these.

Oh, duh. Got it: "struct scatterlist" is not an expression, it's a
type. I'll adjust the script, catch stragglers, and incorporate your
patches. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
