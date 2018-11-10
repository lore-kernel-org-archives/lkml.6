Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B6CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB8E2089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkGo+5f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB8E2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKKDdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:33:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41705 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKDdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:33:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id v18-v6so5076826wrt.8;
        Sat, 10 Nov 2018 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmXqsA19dFr1cuIWeWhOpxlRLIpActaup0Ntu9ZTnkE=;
        b=AkGo+5f2UlFEkAI5EzDFSRHE2P133CKTvyxFvKSMe2vqLYbLZK7SwJnXj8KoixucML
         evtgoZtC8YsVZMgFimTG8zWGJnc2DSBc4CrOULclkRLFkaHRXs0YXBuDytRmzZJlgTGS
         I+/Jb9AyhJXYJXvKtI90K3v+tMqTv+CIocB2l0/Sr0dVF95CejcCxjcLEI3hfIlgE5cP
         em9acFjC56SFt7xxYBbKvmcd/6FLtbcWe52l3r2a9VHGnIv+nCUIVV5lw4bNm6o9ozsL
         LU8yz/wBCU4hRfZKYzHUps8NxDZUR0i5TMvttKJhdyDlHLLeiAttGJWnb8uSsCaOh2G+
         ZEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmXqsA19dFr1cuIWeWhOpxlRLIpActaup0Ntu9ZTnkE=;
        b=VPWIh0bd0VoFwp1mIMx6Ml8GgGplIYbXbh1PV3OTpLYGXMd9M/0TDzPSng2oD6GqlS
         XQPuxEiTbf22Q5GxZBAsLv4hIlCC2t4teFJJXDpNQ9Vnw6hNFRqHO+Kz8QOBwN7HIS6f
         fqcTSDQZuTspm60zHat3Ixdb8hfhTPidvJ3Z7PjUftGQs4LZK7OTIlM08Lx5sWNub33M
         75nkB9vjI5fWj5sJnVfSG3xhnASiEgGGYq/jOBD6uIvfT6+GUHN6xpCOScfd9sfjWj+f
         zXt9NWB44W1KlMiO4ljiVwXPXuSBrd1mX/9z0ARY1sNBL33dVFtL/i9X1t6RBVJ36zIn
         83Jw==
X-Gm-Message-State: AGRZ1gLLSHrTbeD900cK2RwbQE/SKNf00TZneNkaJRRAT2LP1BunD+ZB
        C6Vf5lkPDLcWs+DugacFiTmMLkg=
X-Google-Smtp-Source: AJdET5ce/QRn2sahl+8CTEIu7V9S9VK2vJ7bM96iyEfJWmP1Cere6tEOvk9PpsUwiC/6xZGt/zTNrQ==
X-Received: by 2002:adf:f589:: with SMTP id f9-v6mr12398963wro.281.1541872050277;
        Sat, 10 Nov 2018 09:47:30 -0800 (PST)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id i7-v6sm8905622wrs.55.2018.11.10.09.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 09:47:29 -0800 (PST)
Date:   Sat, 10 Nov 2018 20:47:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     gorcunov@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Message-ID: <20181110174727.GA26417@avx2>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109113036.21512-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:30:36AM -0200, Rafael David Tinoco wrote:
> Merge proc-self-map-files tests into one since this test should focus in
> testing readlink in /proc/self/map_files/* only, and not trying to test
> mapping virtual address 0.
> 
> Lowest virtual address for user space mapping in other architectures,
> like arm, is *at least* *(PAGE_SIZE * 2) and NULL hint does not
> guarantee that when MAP_FIXED flag, important to this test, is given.
> This patch also fixes this issue in remaining test.

> -	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE, fd, 0);
> +	p = mmap((void *) (2 * PAGE_SIZE), PAGE_SIZE, PROT_NONE,

I don't know ARM. Is this 2 page limitation a limitation of hardware or
kernel's?
