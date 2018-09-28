Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714FD20676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="qfX+MGKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714FD20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeI1XtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:49:22 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:45880 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1XtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:49:21 -0400
Received: by mail-pf1-f182.google.com with SMTP id a23-v6so4741927pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xDdWQyI7c7VJUWD7g3LwWPDEzAEWcJr9mHA0Er6dvwI=;
        b=qfX+MGKsjKQJceH22ZrXtXglwfoh2mXpFrb+tXXWA+8HCmkAUNRzysYNtbns4GAVZH
         s3EDjtWjtHLX1VbckjJczRuS36kZyxw/zVk82VgKhYNoUjoXCU4Y3buCxmPhuXqJ+rWA
         ZTk0P9bxXc2G6C+RRYq6jTZZaEAJ2sD1p9hU6DFLd3nDtyJZRx1b3QxWoAgR1vmNOljL
         qvvrGQwP0dS78DwihsZIQGKyeB+WW+8g83i/SP9+fOCUzNPu4Hw2AjmpJ09ez8I1mfiF
         I25IGrH2X7aVSkieQHGzSw7wysP5zc3WAiBDw4SmSoXAR6TvhUjjkCA1t6mbsCsmR8tG
         bXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xDdWQyI7c7VJUWD7g3LwWPDEzAEWcJr9mHA0Er6dvwI=;
        b=UXCshb82noGxgfXLMLWwgttfhh/QYZZk8vzeQIesT1nnnO/YLDfqk4d/dtgKznNG3L
         iquKR1iG3vjwVV2FHZpzs88XCo6JAMaGaXlfpSyzS47Zgie5arw6NS/IJzzpNrD/p74m
         TtSSDxlVAqidbTnOVlZGbd4098FHKmGoRddZivuKJi1LTRbLdpwku0yrCZgJmaHbZ+fC
         W9M5d8PuSKpTERBOp5wkMmiBSlnSMt14xCDUVBrcMWv+Kigbs8IWzrQRxqi9dvsqQ2sl
         qEqfqMF/ks3DTFo/0aKerNGCTgZZVtdO3AQeNc5+ll8W3Af7W5/Cqi4iJ9kq7ZyHE8N5
         cx0g==
X-Gm-Message-State: ABuFfogKbX96L8sVNPVnoUhAAjWtOW4V0vTt/tbnomu6eDC21Bjk3JSx
        AmKXdHSJIHZQ8RAVHH17Tws2SQ==
X-Google-Smtp-Source: ACcGV634wShZKH/SBDBA8pUwdKBnPbiGPzj+5qoKP/w6k0BbQoy4F5p7y7YLDdah0K7uuabHtuqZNw==
X-Received: by 2002:a62:e511:: with SMTP id n17-v6mr17662238pff.210.1538155475900;
        Fri, 28 Sep 2018 10:24:35 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id r64-v6sm13126643pfk.157.2018.09.28.10.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 10:24:35 -0700 (PDT)
Subject: Re: ovl: hash non-dir by lower inode for fsnotify
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        kernel <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
References: <2630a5c0-ef57-a4cf-a6f4-b4996c64043b@android.com>
 <20180802060549.GB3272@kroah.com>
 <8c38c2fc-36e6-9aa7-5924-51d7bc2c3d73@android.com>
 <20180907095132.GC13327@kroah.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <2ec8884f-4572-967e-c16c-cb59cfc5f352@android.com>
Date:   Fri, 28 Sep 2018 10:24:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907095132.GC13327@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:51 AM, Greg KH wrote:
> As this patch is deemed "good", can you please resend it in a
> non-corrupted way so that I can apply it to the 4.14.y tree?
>
> thanks,
>
> greg k-h

The toll of numerous vacations, and manic priorities that resulted, 
sorry for the delay, composed and resent.

-- Mark


