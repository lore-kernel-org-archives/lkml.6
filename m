Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9FDC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125012086C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4HtI5rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125012086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeIEGYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:24:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39898 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeIEGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:24:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so2498838plp.6;
        Tue, 04 Sep 2018 18:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4Jl2Ws8bpvtsl/t+RkMjJ6I+CW7keFI/EJcdp6eqLA=;
        b=Y4HtI5rBzEu0Hf/aFXUySHDo7DYX2nvPzqBCkPtr8P5qfBpCeAJkP2xhu+x6hFmB4J
         9zv/CRfRWd0Oij0xTzCOrQcPvDlxDJil+oiY8vmxP6XVLTOpl5NII4omcHsBa3h5+0MO
         58bR0epCHRmQNE0c6efxDaXHuFtIY9SJvnVURFNV6iUJEA+LUEYSytg7n4e/Cs9PQNZj
         d597sEZsnMRfIgymzpL2mohEK4CPolULDZRkKkVa2nDs3NMu1pzsytmMhv7FD6MmZwoO
         KddMuMsista3ZNcnrE08uB1ib/7MDAVkk5Ethg7K1mswwPATg5jrhtHeEeAd1Hj++iOV
         o+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4Jl2Ws8bpvtsl/t+RkMjJ6I+CW7keFI/EJcdp6eqLA=;
        b=VTil8wWqFd25HziaxS3pITQA8XmmDq95zwftUqkslDua4nziUQgay1pblmCytirHiw
         WdwSomx+tUDHzX2TnRITKtpvHAoBwRNEFU9n9T6A2mpwJKSRzGDk9PcnHVFi6sh7gjwu
         oN3LVek9zjEbX9OfVAVYvoA0TWaq//N7dUeBhWR3YWG2eQ9tA40O3ww83lLac/V/4rF0
         HClufSLVlvPDDbZ4Y4IwymXkIGqMM4NLkoBNIKtjry7468t0T4QGH5HjBSLdbLjKLH5R
         0WF3nCoZ7gBnZ6ogwS3KMiDLx2GTEsiAYWAjKTjMAKIdaWuKHrDaKUtVaXGOSIz/dKnp
         8sHQ==
X-Gm-Message-State: APzg51DN5jWI0iOXOhYn3v5qNORKQGVWS2HrAZO41fJxjNo5F5hfcAs0
        TQySNn1jfkzYAa/QjxrqoCA=
X-Google-Smtp-Source: ANB0VdbCKkre5Q71NK9YS2JNud+pt6gt+6HZUHc/vfmxmeSw0F8wna1G/3ZpIeL2YW//I9z+yx0u7Q==
X-Received: by 2002:a17:902:7246:: with SMTP id c6-v6mr36508313pll.28.1536112579297;
        Tue, 04 Sep 2018 18:56:19 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h190-v6sm341040pge.18.2018.09.04.18.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 18:56:18 -0700 (PDT)
Subject: Re: [PATCH 0/3] of: root #{size,address}-cells clean-ups
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20180830190523.31474-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0941c9f1-abd2-0d4f-489c-108c3eff4298@gmail.com>
Date:   Tue, 4 Sep 2018 18:56:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830190523.31474-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 12:05, Rob Herring wrote:
> This is a small restructuring and clean-up of handling root node
> #size-cells and #address-cells (or lack of). As only Sparc needs a 
> different default value and only for #address-cells, we can handle that 
> locally and remove one more dependency on asm/prom.h.
> 
> Rob
> 
> Rob Herring (3):
>   of/fdt: Scan the root node properties earlier
>   of/fdt: avoid re-parsing '#{address,size}-cells' in
>     of_fdt_limit_memory
>   of: make default address and size cells sizes private
> 
>  arch/sparc/include/asm/prom.h |  3 ---
>  drivers/of/fdt.c              | 30 +++++-------------------------
>  drivers/of/of_private.h       |  8 ++++++++
>  include/linux/of.h            |  6 ------
>  4 files changed, 13 insertions(+), 34 deletions(-)
> 

Nice cleanup!

-Frank
