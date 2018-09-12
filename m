Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8B0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31D420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="nDsarqaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31D420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeILOIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:08:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35508 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeILOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:08:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id q13-v6so1018724lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SQ4djfH15Y6cvUUbrSQWMhBh8y69o6NwSOK5aJODhx8=;
        b=nDsarqaUnvAlOFJ3+wZadjB28ZDoANjx++Gnr1bqGR/Cprp0LZUnLEMHuOSwnKoS2q
         WOF1vn0c7LuruCeGVxC0DvEJhlkA045ybkTtTUbbSrjibzncde4w228w6bOb4aUnjUsq
         jyUaz7ZXdeEzLqDg/RCqV4sGf/FjViCPKu6PWEL+9zWqBRei1SzNckMtiNBciU0LCoMz
         Ww4megspXkAwoSwHeIriu4ezLRPczF40Q7Kcy4BtgMlLt+hjCv1SUcSnBwobcnm4Fj1E
         LasXtCYsPwYOGGM8m2q3zDPP5H0om3lWgsOO53n0IA5nl1h0tntkTacbBqxOUYbashLq
         Kvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SQ4djfH15Y6cvUUbrSQWMhBh8y69o6NwSOK5aJODhx8=;
        b=mqp9QwNp7fY+cqb9C8JQwRR/hwSNhAKLUVJBQWL6+2ncXBRb96dLAnF7XpXUjSSDGT
         ZfdqyGq6oZa4H6JHuflu27pqp1cSM2VeSY7wmBvfgfikfG3GLVLrsHm3ldFPybgfYJjM
         ySHR1TJgxYgGmoXxq5zFOBtsj2O4kfmqKkMp6+3ZADdNyUwHfAgltH+SMmFih+E6A2w6
         d714KhAcsG3bB2XHOPMeXrp38GR5SGdCWitpFLm54KB3XoD1DW1DzTz1kyszn6X2mkh0
         nm2OO3iUWZXeTnlXOImQGkxevlfAhh4eqmF/Uv48TvAChYqQh9UkR8VLUQyeq5BcQx/H
         WW8A==
X-Gm-Message-State: APzg51CwipLEH0y9ITa21xRlArwl+6Nnl+w3GXW1wjvHymOvt4QLmY1N
        LBt3IPg8GUYVU01EJ3+gFr/EdyCqsR4=
X-Google-Smtp-Source: ANB0VdYqb52ob+THJvA0JZr3l6ioArx7Dixn9Uip5r1keRFWveZ9Rdenfr4xH1ivnrWKzfgPTrR8rw==
X-Received: by 2002:a19:115b:: with SMTP id g88-v6mr724141lfi.57.1536743102330;
        Wed, 12 Sep 2018 02:05:02 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.86.47])
        by smtp.gmail.com with ESMTPSA id e41-v6sm91026lji.37.2018.09.12.02.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 02:05:01 -0700 (PDT)
Subject: Re: [PATCH v2] neighbour: confirm neigh entries when ARP packet is
 received
To:     Vasily Khoruzhick <vasilykh@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jim Westfall <jwestfall@surrealistic.net>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ihar Hrachyshka <ihrachys@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180911180406.31283-1-vasilykh@arista.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <11ed0447-bcf9-8590-94bb-1a4b842ee002@cogentembedded.com>
Date:   Wed, 12 Sep 2018 12:05:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911180406.31283-1-vasilykh@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/11/2018 9:04 PM, Vasily Khoruzhick wrote:

> Update 'confirmed' timestamp when ARP packet is received. It shouldn't
> affect locktime logic and anyway entry can be confirmed by any higher-layer
> protocol. Thus it makes to sense not to confirm it when ARP packet is

    "Makes sense" or "makes no sense"?

> received.
> 
> Fixes: 77d7123342 ("neighbour: update neigh timestamps iff update is
> effective")
> 
> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
[...]

MBR, Sergei

