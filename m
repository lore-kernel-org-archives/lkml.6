Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E95C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17BC20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irZ2W0Sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17BC20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeG0DUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:20:06 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46294 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbeG0DUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:20:06 -0400
Received: by mail-pg1-f174.google.com with SMTP id p23-v6so2255719pgv.13;
        Thu, 26 Jul 2018 19:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6+rxktQ0QiQizABkCvSDIAhiOxxb4YXLK1mpwqKGkn0=;
        b=irZ2W0SkFWxZWaVJQngwohrmU9q9V4lTsg6iOmqYH4HIcvV4zy9JpuNRoktO3taAwR
         907pte2HhFFvP627sBy5pfBits0ODi37yDkGHsE+Buj4pHtDqrTqaVd5fyomvnAStVJg
         FatMXNLWCmGNLBx3jhFOoRUc01aK8yn8/sS2cyi1BUd2nDc7wTxoHFqrGvjC0+eFKlJk
         oM163ze9fevbQAcGp+xaT+kfITocbOPlNw+ihfDVkwWn+2QnLra6SwIDilUi8Uua8d/P
         es4OY5YEDmn+GllMnaXhY9zhKsV1rM1sp+EVB+o1XSnZRovnkEHtkPFq+8HAEOp+v9hS
         J7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6+rxktQ0QiQizABkCvSDIAhiOxxb4YXLK1mpwqKGkn0=;
        b=U1Ybn8kLV299J1fqmSFPOJVem0+W7zII0Dlec10TDR/WX/P5G4mHcc2H4Y58Plgbzg
         nOJHqE4K55oT/nXDWExF51aReluAzIBpA2nDiZSPscCGDAS+kfBIwhq/3A89JHe3Iv1Q
         rkGEtizyD9DwqYJTh5F0Y9/WR57yxTiPRBEjO4M2X58ltNpa9wkCMHo0jCo11gG+TOBM
         gtqpMSUXRkAEftNEGC/1THEoKa6m2Pnpsvdp2Oc3X6cNiu+RengwaE7EkGkU8AAB1wMi
         wPbIue+aXZH0/esuN/uB9FQ03IEljA/YiuEuTK9bAoE9P7EoQ2IE+QUS/n0sFyVm+t9Y
         /rUw==
X-Gm-Message-State: AOUpUlHolm3bLoOR42Eg/9bmRAcCSp6BH2zp6JTUUdIWuRZnywww2rfS
        /sLsMiIyJ6ew5Dr/Nim1K5E=
X-Google-Smtp-Source: AAOMgpdHrQc5iRWTQD+HVmYj1ucZEOSHgOHpPzso/a7SMYvv+fnYG+dAiJVYgKajRTnjw3jZFA85uA==
X-Received: by 2002:a62:9f85:: with SMTP id v5-v6mr4515611pfk.27.1532656836367;
        Thu, 26 Jul 2018 19:00:36 -0700 (PDT)
Received: from [192.168.3.4] (softbank219203027033.bbtec.net. [219.203.27.33])
        by smtp.gmail.com with ESMTPSA id y3-v6sm8570217pfi.24.2018.07.26.19.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:00:35 -0700 (PDT)
Subject: Re: media: dvb-usb-v2/gl861: ensure USB message buffers DMA'able
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-media@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mika.batsman@gmail.com
References: <8308d9f0-2257-101c-69e3-8fe165de9348@canonical.com>
 <d2465376-4b3e-7d3d-86d2-0cd8d7543520@gmail.com>
 <20180725105701.4f3b429b@coco.lan>
From:   Akihiro TSUKADA <tskd08@gmail.com>
Message-ID: <75be710b-3eda-e077-7c90-beec059d83b2@gmail.com>
Date:   Fri, 27 Jul 2018 11:00:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725105701.4f3b429b@coco.lan>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018年07月25日 22:57, Mauro Carvalho Chehab wrote:
...
> There was another patch proposed to fix this issue with does the
> right thing when rlen == 0. I rebased it on the top of the current
> tree:
> 	https://git.linuxtv.org/media_tree.git/commit/?id=0b666e1c8120c0b17a8a68aaed58e22011f06ab3
> 
> That should cover both cases.

When wlen is checked to be <= 2 and
wbuf[0],wbuf[1] are already used in 'index','value',
why this patch copys wbuf and passes it again in usb_control_msg when wo==1 ?
(just to silence static analiyzers?)

Furthermore, 
I am afraid that a static analyzer might warn on a possible
buffer overrun in usb_control_msg in the case of rbuf == NULL && rlen > 2,
since buf's length is passed as rlen but is actually wlen.

regards,
Akihiro 
