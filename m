Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8284EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5196E2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5zvq6AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfBYOIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:08:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45736 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfBYOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:08:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id h10so6931892lfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 06:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CvRb6Hdr3kvkn94kc9k7+/6MupmEne/LfIYo+qZk6SM=;
        b=P5zvq6AX0JTY/TNY9k4ciw+Zc2KHuTxYmWin9r1BFh5lH+9Opir5a98lvfbWwgLDmP
         8UuiZytxUpzswDGYX+aOEUFUyru56FS4ny6zV+Qm5BnR5aFYcROYQ37kdlHXzl1rPwnc
         3Z0hiy17+ZqTHndDKn6QqzinT4Pu1951sqMljEtHwt+vgt4cA/WNr9wtalEfk1XR9kkD
         S4tjpCJwcOQiE8OjI43ZGmEe5VT5pCGzA+G5Q4IzaC5Str2ZPbqU1LiIy0NSQUVtyy04
         N0IbOp6F7U6E+QNYbM6hIQkOR+YUA0GJzvA6BKpE9BsmBJphnUhKkDeAagXRRe82vyxk
         RhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CvRb6Hdr3kvkn94kc9k7+/6MupmEne/LfIYo+qZk6SM=;
        b=r06jfkCQIBxD+fTdmi45V4Z7JDuLkaNA0e6ERCuARB4hw2DsMf6rZdKy7yfsknpIlF
         lB9/FEYgWchwv2u7PMl1zua0stTUEahfwQnzi5DsOQp9L6wNE+N/qtj+iYVx7RO8qBk/
         cuvD0lTygfY476zr69O0WEJ7dCEIWa+URyLbEZnqcuUHnOz0Gbk2XOKmRTleyo6ikpda
         oS6/m+dvMntb5X99jxWVrRjaNX5+WHwFlkAsUiemPHKrme+JuNgQiBNN3Ht+enEEUKgk
         59Ck7i8Idu4Q0NcImH5RLEvnQ5HQ1ZurYrEFfFWA4Ny+n0+SuVPiMZFnZZkLt+qQU3ub
         EheQ==
X-Gm-Message-State: AHQUAuZGjK++Y/oYSr6mjKGvA/IE4Wab49oEsZaHGbAYTmjJ3zdJx/z0
        8Md9STolTPM0p98eLyKLu14=
X-Google-Smtp-Source: AHgI3IZZpZWE4QNEH8gPA4MP5Xu6MXROXt0pDkAqAg0RsYJLBlaYjAOwj1YUa/SNhOWvU7j3wo9mOA==
X-Received: by 2002:a19:26c4:: with SMTP id m187mr9746156lfm.9.1551103693240;
        Mon, 25 Feb 2019 06:08:13 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id w30sm2298128ljd.65.2019.02.25.06.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 06:08:12 -0800 (PST)
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
To:     Julien Grall <julien.grall@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        xen-devel <xen-devel@lists.xenproject.org>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
 <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
 <13a9616c-2d9a-f90b-3358-f2dcadbbb64d@gmail.com>
 <dbfd87e9-48fc-f641-9e24-ddb6c4f61135@arm.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1aeda04d-3420-fa50-ad33-a0b3e981f5e4@gmail.com>
Date:   Mon, 25 Feb 2019 16:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dbfd87e9-48fc-f641-9e24-ddb6c4f61135@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 3:55 PM, Julien Grall wrote:
> Hi Oleksandr,
>
> On 25/02/2019 13:24, Oleksandr Andrushchenko wrote:
>> On 2/22/19 3:33 PM, Julien Grall wrote:
>>> Hi,
>>>
>>> On 22/02/2019 12:38, Oleksandr Andrushchenko wrote:
>>>> On 2/20/19 10:46 PM, Julien Grall wrote:
>>>>> Discussing with my team, a solution that came up would be to 
>>>>> introduce one atomic field per event to record the number of event 
>>>>> received. I will explore that solution tomorrow.
>>>> How will this help if events have some payload?
>>>
>>> What payload? The event channel does not carry any payload. It only 
>>> notify you that something happen. Then this is up to the user to 
>>> decide what to you with it.
>> Sorry, I was probably not precise enough. I mean that an event might 
>> have
>> associated payload in the ring buffer, for example [1]. So, counting 
>> events
>> may help somehow, but the ring's data may still be lost
>
> From my understanding of event channels are edge interrupts. By 
> definition, they can be merged so you can get a signal notification to 
> the guest for multiple "events". So if you rely on the event to have 
> an associated payload, then you probably have done something wrong in 
> your driver.
>
> I haven't implemented PV drivers myself, but I would expect either 
> side to block if there were no space in the ring.
>
> What do you do in the displif driver when the ring is full?
>
It is handled by the originator, the display backend in our case: it 
doesn't send
events if it sees that the ring will overflow. But I was worried about
such a generic change with counting number of events received and if this
really helps to recover in general case
> Cheers,
>
>> [1] 
>> https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/include/public/io/displif.h;h=cc5de9cb1f35dedc99c866d73d086b19e496852a;hb=HEAD#l756 
>>
>

