Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDE421473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzU6jpKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDE421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeJFAoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:44:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34542 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFAoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:44:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id f18-v6so7157702plr.1;
        Fri, 05 Oct 2018 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=blmY1YigMdSVaOfUEVOMY5Ed81TeEw52CpvqTXlzcWM=;
        b=RzU6jpKwPkuZxnAeneKvMTMZxdyVndotCyumLOCevjdGBBOf9fSL7yvr5ckhwtiabC
         QGlZJHjjf87DQwqtNMjeN8orrekMjSYnrnS/eNVaZEIb77FHDm9Ftj3FCxOTKpPODl/r
         +nvxtF2y1iF7Ezfj0UELebScd1lpo8pk5LTOSOc9COJFXlUMkZLlBmRyQYrU2xURXxDR
         2JP2sSuv20gnZyjN2pJaEirpX3+Rla1uzd7Wdwhv+/3aLlJMUB5KXhTJuXAT5quWNru9
         06Lkl6sKGNpkY11sUkqvZkHGCqF8X3kJXJUwA+rA917e+zZcz2hK6aXmbOgLM5xriUpo
         7rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=blmY1YigMdSVaOfUEVOMY5Ed81TeEw52CpvqTXlzcWM=;
        b=D1Ogrw+i0/C5j3XycrpuDvibmkpicOXCsblPi9J6PtdBIoOcUopnd/Gq3zPb0SEMKg
         5pWML2StW0eDP+gyX4SWfnkHkAQGw1EOyEsthylHyAo+puLG4/l59UNilk/+z+Q9ATrE
         IhPOGVsgfp5WbI+njPWvPWvqSjUcGb9SXYqJgaZq/j3dNgOquDY5wsZZcqQ7jSuKVlYy
         zLBaCwLh3Ov6ZIfUmXXhAoZHRSEFVJMGKa5ZTlaMeDYy22jpRRLvf7o3fybAoloBobMi
         aa0eAiVMM4ovdqRiMLFkYnn1PxvIanyCsxf9H+z8JiLGCF1OQgmi5QoxgqvUMtHBZsSD
         XxmA==
X-Gm-Message-State: ABuFfohHlg9Fm8FlA582OjxR2Y95YeVKrlNemc+9giNMqlZg96RalfI8
        cg7vu36MLetHW/cuQrOXQQI=
X-Google-Smtp-Source: ACcGV6067Su1OlicmeQWNASlO8dlp/CdCDyafcCjlhDmoMjrAJr1W7r1yE8exVrPF6Um0oMVfqz+vQ==
X-Received: by 2002:a17:902:e28a:: with SMTP id cf10-v6mr12648530plb.4.1538761478901;
        Fri, 05 Oct 2018 10:44:38 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id b10-v6sm11325515pfe.148.2018.10.05.10.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 10:44:37 -0700 (PDT)
Subject: Re: [PATCH net 2/2] rxrpc: Fix the data_ready handler
To:     David Howells <dhowells@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <80cf9647-ffdf-210a-7b0e-22bf35a57239@gmail.com>
 <bf1d0734-d73a-83e9-c8e5-0fa4d447bc51@gmail.com>
 <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk>
 <153874699086.18195.6819270943388841145.stgit@warthog.procyon.org.uk>
 <15184.1538749081@warthog.procyon.org.uk>
 <25989.1538757200@warthog.procyon.org.uk>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f423612c-db54-b59d-d2f1-9449bb997106@gmail.com>
Date:   Fri, 5 Oct 2018 10:44:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <25989.1538757200@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 09:33 AM, David Howells wrote:
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
>> sk_data_ready is not meant to process packets, it is meant to signal
>> to another entity (preferably running in process context and thus with proper
>> schedule points, and not blocking BH) that there is data ready to be consumed.
> 
> The issue is that I need to route the packets to the appropriate call, and the
> BH appears to be the right place to do this, especially as I can quickly parse
> and discard certain types of packet right there.
> 
> If I move all of this to process context then that adds extra context switches
> between the routing process and the destination process.
> 
>> Under DOS, it is possible multiple cpus will sk_data_ready in parallel.
> 
> Ummm...  I've been led to believe that sk_data_ready will *not* be called in
> parallel and that the code it calls can assume non-reentrancy.  Is this not
> the case.

Certainly not for UDP.

TCP input processing uses the socket lock, but UDP is fully parallel.

> 
> What about the patch I attached, whereby I use the encap_rcv() hook.  Do you
> say that won't work?

I am kind of busy today, will look at it next week.

