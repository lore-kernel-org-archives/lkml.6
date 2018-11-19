Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E7820685
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPFO9Pt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E7820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeKTFcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:32:12 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51596 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKTFcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:32:12 -0500
Received: by mail-wm1-f43.google.com with SMTP id w7-v6so6436375wmc.1;
        Mon, 19 Nov 2018 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hng4BeWsUtJgYaAF9PwTx35CYxuIwNbCoSvO9kgtPYk=;
        b=kPFO9Pt2Z4JmOTEXzk96w5kLati8XNOp5YbL4Xpxkd98FFs9jo7D1xDWQF7PJBoB/y
         3sVx1FWNJABM1nRgtMSM7t0BvYJ3Vb5EVVsymM4ejMB8kwV6T1McO3idZ9KroUvEAKWS
         o7CLwQtud4h/QicYYGj525oOPr1KThvlnIIchgY2pelROgb2nACJsrf8tFEWHq0srUL3
         +elhE8LTe1HSITkWmh4cHPWsNxFlCBOoVq6k5v55siuzx0opMjv6+LWJ57DFU5/7VKCg
         gxkyg2fVOE9Jmvyo+2h2trIpfA44h4xAc23P3s7wxqUtGajSV9ngopeQTgGS1JUBU94R
         JVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hng4BeWsUtJgYaAF9PwTx35CYxuIwNbCoSvO9kgtPYk=;
        b=NnOWwnzh16YZSKaVegnvaSMWhnnHuPY2TLZG3Ey9E6W7CHfLoT8EFQjgXcXAXZwEs/
         ciAcInehIoBDaDWq5y+urAFXNvXkzi5itZNEio8U16/fUWroOtBmkSwWlcgnuL2H91dP
         OauxN6/TwRmQtLvmLYvMLCi4va54IheWBL+c2LvFyNdntUpyopXwIyvs7zSf+zhRnAD6
         Rwa+c0XdBEM05SbtWwB6NtGZ+ahF7lP4wFocVYkuvTu1Ev9W0kTwFVnvVnGWMyp0OaWD
         ZIcffA+CvqaSAxgRYXQtTf+US+DHIgkuyjxtte/psnQeGeKgwaQD9ADf0HpMG1YtQ2dq
         MNnw==
X-Gm-Message-State: AGRZ1gKWBOEhn4W3/RIzob02TNgFc9TYNcQjRr2wEVcprKHWndf3GWf3
        +UpTYQ3EwrERWHApuRZJqznOd2Xj
X-Google-Smtp-Source: AJdET5fL47o5NHFwplDpIba6dQSINOfzIpWDjQ3S0DpefZ45MkxDOUP8OL4Di38/NCDap8fjKkPxfA==
X-Received: by 2002:a1c:a754:: with SMTP id q81mr7652017wme.132.1542654432638;
        Mon, 19 Nov 2018 11:07:12 -0800 (PST)
Received: from [192.168.43.227] (94.197.120.61.threembb.co.uk. [94.197.120.61])
        by smtp.gmail.com with ESMTPSA id s16sm21652593wrt.77.2018.11.19.11.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:07:10 -0800 (PST)
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Stakanov Schufter <stakanov@freenet.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5hbm6l5cdi.wl-tiwai@suse.de> <20181119155326.24f6083f@coco.lan>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <b5291f02-a40b-52f9-8824-5aa2ef0f1dcc@gmail.com>
Date:   Mon, 19 Nov 2018 19:07:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119155326.24f6083f@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

On 19/11/2018 17:53, Mauro Carvalho Chehab wrote:
> Hi Takashi,
> 
> Em Mon, 19 Nov 2018 16:13:29 +0100
> Takashi Iwai <tiwai@suse.de> escreveu:
> 
>> Hi,
>>
>> we've got a regression report on openSUSE Bugzilla regarding DVB-S PCI
>> card:
>>   https://bugzilla.opensuse.org/show_bug.cgi?id=1116374
>>
>> According to the reporter (Stakanov, Cc'ed), the card worked fine on
>> 4.18.15, but since 4.19, it doesn't give any channels, sound nor
>> picture, but only EPG is received.
> 
> Receiving just EPG is weird.
> 
>>
>> The following errors might be relevant:
>>
>> ================
>> [    4.845180] b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver chip loaded successfully
>> [    4.869703] b2c2-flexcop: MAC address = xx:xx:xx:xx:xx:xx
>> [    5.100318] b2c2-flexcop: found 'ST STV0299 DVB-S' .
>> [    5.100323] b2c2_flexcop_pci 0000:06:06.0: DVB: registering adapter 0 frontend 0 (ST STV0299 DVB-S)...
>> [    5.100370] b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DVB-S rev 2.6' at the 'PCI' bus controlled by a 'FlexCopIIb' complete
> 
> 
>> [  117.513086] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0 frequency 1549000 out of range (950000..2150)
>> [  124.905222] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0 frequency 1880000 out of range (950000..2150)
>> [  127.337079] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0 frequency 1353500 out of range (950000..2150)
> 
> That indicates that it is trying to tune to an unsupported frequency. For
> DVB-S, all frequencies above should be in kHz.

Kaffeine reports the wrong LNB frequency ranges for universal Europe... I just use Astra 1E settings instead which I am pretty sure is the same?

I am using the stv0299 / dvb_pll(opera1) combi and not reporting any problems other than the streaming issue with dvb-usb-v2 which I don't think this uses?

Regards

Malcolm
