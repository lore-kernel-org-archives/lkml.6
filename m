Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A648BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A7720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A7720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeKHEDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:03:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37580 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbeKHEDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:03:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id w66-v6so14669833oiw.4;
        Wed, 07 Nov 2018 10:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=k4ODDZ4JP3C0tkLIMDCp8lhMViwFxXREX9PD/6LTVewoRZ3GDPXYnK7Qx6r4H1EmQZ
         RduNl/mwK5iew2OSmXobM+BwTtt2B4xQfrzDXjchHl2OfVfcpP2SrGl2VwAe96Wz9OU4
         3Rt5dKhRLs519DuaxA0ZkWYcXlg24vQpOYri+0bytuG0vlnKsHJBlBUGswRteomK4e8q
         UFDc04uYo61XdwsyQkvyUALlDwdtt9qF3iBWGPfiebDkmwc4ib3ByuvQbUTeTNdJiN3b
         80LiZqOPiP0A7rb0flB1OHaUbrnH1cACCND9t4XIz0p2kCbS49Tg1LrQAKppQcc+IETA
         +LJw==
X-Gm-Message-State: AGRZ1gK5+PHFNDpyGCnKImZXWi5gHycvoXqg90mUVx9+bUEiLLySK2Ok
        0a1UY+nmBROPxlPE7Mw6Re0=
X-Google-Smtp-Source: AJdET5eh4HuR8nDZpyVed4QAFbshkthxlQusYUmOnQia4dg+mODClUY9FeMrnHIrqu2t5qNq/dv1iA==
X-Received: by 2002:aca:f244:: with SMTP id q65-v6mr770122oih.64.1541615494841;
        Wed, 07 Nov 2018 10:31:34 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c58sm1044014otd.34.2018.11.07.10.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:31:34 -0800 (PST)
Subject: Re: [PATCH v2] block: respect virtual boundary mask in bvecs
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20181107135814.15727-1-jthumshirn@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6b6d391b-3451-96f2-c995-92a32566922f@grimberg.me>
Date:   Wed, 7 Nov 2018 10:31:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107135814.15727-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
