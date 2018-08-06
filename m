Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4381C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B3A21992
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkotDglN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B3A21992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeHFDzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 23:55:53 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38202 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeHFDzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 23:55:52 -0400
Received: by mail-qk0-f194.google.com with SMTP id 126-v6so7871766qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 18:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/284BYj2sMyavbPNmUY4L77KqFXL29poo2t7uG6M9vk=;
        b=FkotDglN5W/NLMSMs+RFbFxMAm3PiHrmtK5Jd+K3Ki+vitZeZJATNBNIcsZb7e9fxb
         xJGLYQ6qkp2+EomRidUbUxKPhv6c3aFS5P37+34Chfplvn6Q1uFRQMXHdmVX/Gn6gkru
         BKYvHkaRIyo/rP5AIm52FptD4rXY+ZCbewlnTe5ke6w86dW31U+KY9otormRRHykrbcp
         TJFtQEmddEXGM1dOxof2U32C860TvHAPQ7nfv8VN2FbP02KH7J+XpZ287BRDgS+qc/YF
         YYAq7TvLhSMOdtus9NVqTZhI7tIZMNon2ohCCtjfgqM8XyG2gqgE5yFS5oJj+ZIVOxmU
         LVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/284BYj2sMyavbPNmUY4L77KqFXL29poo2t7uG6M9vk=;
        b=Zi5m7wDymS9IhIoj7gUa77brdPzHsHOeKclHMpuNlsSQcvlNrUqckX2Esf2/PmyVxu
         nBCjvXpLBDHYEwC2wps+Z7wiVr+qSiol16jZXmsfD/UHffAe0GA+8Dk0B7Dibpes8kIL
         FVlX21aknaDTSGMWq7xiir/MIvNBnctgCetpqC7hC85nydEw4AigsSfWWa6Tuu7JzujV
         wd1tmfRkG0bVTGNUlqJgeL/MnGvMasbfvtMPCnwRO11UyfMoDySJ99pqBk3gFc924z17
         BHB7gVsJUNHLLsmkf2oRS/2Of2zBrZZIc45iNbOo0BtH+pFT2VqdTf+F0y6QnrsMwiMB
         Sj7A==
X-Gm-Message-State: AOUpUlHjXObS1TcrB01B/y9dejVbP8r69AIl07TPpldzFnf7Z5o3XM71
        naS6E7YdOGjoZt6HJ6hZ0B1Q9+4Ebl3mtKQjkMk=
X-Google-Smtp-Source: AAOMgpflqrBqgRx8uFoM8Otzu68VjDbsEpjkn8yZcys/+XeFevKT9DASTY1jqLde1s5j9XwN9/7BjtnJoE4fuMxUF7E=
X-Received: by 2002:a37:9a16:: with SMTP id c22-v6mr11851631qke.378.1533520149602;
 Sun, 05 Aug 2018 18:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
 <20180801120551.ju6zhxhoef6w5zim@mwanda> <20180801155530.6e824927@xps13> <20180801140447.yw47ynz7bsgfbwb3@mwanda>
In-Reply-To: <20180801140447.yw47ynz7bsgfbwb3@mwanda>
From:   Jheng-Jhong Wu <goodwater.wu@gmail.com>
Date:   Mon, 6 Aug 2018 09:49:01 +0800
Message-ID: <CALtPoQDadUE2qD0yVHO7yDggE1w0mNqteQ3iqYxiEDvorY6d2A@mail.gmail.com>
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
To:     dan.carpenter@oracle.com
Cc:     miquel.raynal@bootlin.com, palle.christensen@microsemi.com,
        devel@driverdev.osuosl.org, boris.brezillon@bootlin.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, arunrasppi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So should I change this into a revert patch, or you will revert commit
6efb21d6d0e7 ("staging:mt29f_spinand: MT29F2G failing as only 16 bits
used for addressing.") by yourself?
Thanks.

Best Regards,
Jheng-Jhong Wu (Victor Wu)
