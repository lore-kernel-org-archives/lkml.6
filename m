Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD23C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2674A2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvtuqWUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbeLTNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:41:26 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45177 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:41:26 -0500
Received: by mail-pg1-f182.google.com with SMTP id y4so905280pgc.12;
        Thu, 20 Dec 2018 05:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=/Qy8aBweUW1wXxSZ5SJE6Xdvh8e8dCOYbchxg7GPjPU=;
        b=VvtuqWUYu92+mlauC5OXbfYVd2cjQqyLNnINHa6JcLyqBTOgOGFj3uqh458VksF4a5
         j5eoGGFuil0b5wnENp1XAvQ4Vzh/Klcn3dPNJkNSDkuf9QiiczbziWh5SVRLQtpYCSiY
         7XBn1EnRIA5swdY2WgGeyr6ad26Udp+pJeDbsjDX9PixsNw/toF7LbL0KLl3i9D2AMz8
         Ysilqmka664fctYmyh5mjufNYTuInmoBWOE8MJzlG+jQWbftoM1mFgwZdSYM8NHqRz10
         SUoeTDvHrCfesTYfSSrKQqAeby8/AUS9dPhG96wRxEcPTJZyH97y6p5v520GQsfLm6CC
         soEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=/Qy8aBweUW1wXxSZ5SJE6Xdvh8e8dCOYbchxg7GPjPU=;
        b=Y+0fc5YIA4nx2i7kAxRoRenNVtlZ8tOmeVWGGhnHqOAhlgF/HlVUMaS5gfFrhXqm6O
         prjMPd/VlE0AOMnV1XcZhHditc3CqYlP06mTMv2R/9JdatVyxiEEU3ECErwAZaszilZQ
         /tpASqwkI5pQJ7d9XXySvUTw7y3i76hkHo4Zd7GfPBV4YBFPCHWHumN6Cl6P3/Tg9FOr
         xyO37JldpXFipQ+RCE1Lwtjge1JhpzC4nj9q00t9Lpww6+NjdyW3BhcxCtvU1zWb4aK9
         wes/qHbR6Cz/bVzXvX2nVIqPJVjr7xU3re0m6vJEHehopuuTiOEiVQDRG3b+SqNzkgtU
         EeZQ==
X-Gm-Message-State: AA+aEWYjC+9jdlgeGysHX54aPCotpzWmcjiM43/L6WJyuyFWI6GlL8BW
        D5LTdacRTgn8yj3UdLHqEeQ5/4sr
X-Google-Smtp-Source: AFSGD/WuT991F6pHDAH/rQ7i5EbbJuwzi29Kw2aAHM4+RyMHmLcbc3A3DrjPgQJnhVPeTb881ZtMaw==
X-Received: by 2002:a63:5907:: with SMTP id n7mr22934921pgb.435.1545313285417;
        Thu, 20 Dec 2018 05:41:25 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.24? ([2402:f000:1:1501:200:5efe:a66f:4718])
        by smtp.gmail.com with ESMTPSA id e23sm31978761pfh.68.2018.12.20.05.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:41:24 -0800 (PST)
To:     Johan Hovold <johan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] usb: serial: garmin_gps: A possible concurrency use-after-free
 bug
Message-ID: <8b24e2fc-df9a-8e06-aa49-a27675fd36e9@gmail.com>
Date:   Thu, 20 Dec 2018 21:41:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/usb/serial/garmin_gps.c,
the functions garmin_read_bulk_callback() and garmin_write_bulk_callback()
may be concurrently executed.

In garmin_write_bulk_callback() on line 969:
     kfree(urb->transfer_buffer);
In garmin_read_bulk_callback() on line 1165:
     unsigned char *data = urb->transfer_buffer;
Thus, a concurrency use-after-free bug may occur.

This possible bug is found by a static analysis tool written by myself.


Best wishes,
Jia-Ju Bai
