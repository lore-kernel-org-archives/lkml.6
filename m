Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43F7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0172080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDBGcnPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBHPcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:32:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46075 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfBHPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:32:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so4257020qtr.12;
        Fri, 08 Feb 2019 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=JagG3AFpkfVNGhNzWWihACo1JtrrW5GWbzViUY/vBcI=;
        b=hDBGcnPU4t1N2t6rK+qeexjligNGmHajGj3lvo0DRJlwPY0GqRuYJa0Fm29NVYQGSC
         9/u45vmhqTtzf6qeDgbCUJcjFoOW9/cQuaiwcbpi1oW/s93LXBKeuYL/I4w60UuhqeH5
         yxQi5yVFil6FviOACtAmao9kghMOTjlvaQc8LtiwU6onl16v5bg1KmAEDxED35PIJBXW
         a25LmjNfgjKuxFVXhWm2ws61F26KpaLrGPPj7acoj9aCWhTjV1u1OpQr69ZfolujcdzA
         3L0ugmZRCd9BXgi1n/lF79sOe66vnG/404AqBVOwl+Hrp4PT/4b+RxY1HIgIBNbBphPe
         4AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=JagG3AFpkfVNGhNzWWihACo1JtrrW5GWbzViUY/vBcI=;
        b=eRZg1TaHHLZNU7Usk+MTk4obg9NNv9c+/mEqDGRrKJ6/POxaMvqxlgr48NZ7lqxnK/
         q2CvyqCRBYlg/BToxAcWLTkRb15hmRtxMRpshieWFyVbhjvSiBhdPHUTNbqOnsmDQwv1
         VDQ2ATc8L4BSYTgkyvMoX1I2Al7EuLoUcrm5WzBJ/GFlMelieYiAbcod7uQr0bFhWnq4
         3+3JLkNrqCLKYfoj226VQXuZQNZB9zBHE3SBypMvzsPvHqxVhZ+5T841X+jtHgVmW2nt
         GPqt1jJRFh/91cP3VifnF0wkFuhipn86D2VvcWvHJmaYjSTHlq7L/teCfyapKInRuELo
         4wLA==
X-Gm-Message-State: AHQUAubD0lAcLD5j11QqwXDvEvT6XIkRGRwuOnHa6QFiorNy2bF/F5tr
        QvD8nO8uT7KaLCQWnn3ebKM=
X-Google-Smtp-Source: AHgI3IZSJKVBFKASAqkDqGc6Nsi9BTX1zavtDYwV3civd7r40/jwO1WD68LkpWxACCvne7+f26Pyvw==
X-Received: by 2002:aed:3a69:: with SMTP id n96mr17069794qte.246.1549639961596;
        Fri, 08 Feb 2019 07:32:41 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id o42sm1883028qtc.90.2019.02.08.07.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 07:32:40 -0800 (PST)
Date:   Fri, 8 Feb 2019 10:32:39 -0500
Message-ID: <20190208103239.GB26387@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH net-next] net: dsa: use struct_size() in devm_kzalloc()
In-Reply-To: <20190208011603.GA927@embeddedor>
References: <20190208011603.GA927@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 19:16:03 -0600, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = alloc(size, GFP_KERNEL)
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = alloc(struct_size(instance, entry, count), GFP_KERNEL)
> 
> Notice that, in this case, variable size is not necessary, hence it is
> removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
