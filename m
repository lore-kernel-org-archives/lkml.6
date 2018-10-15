Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B701FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2D820881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MQ7CCpoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2D820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJPBZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:25:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41031 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeJPBZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:25:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id q17-v6so9649577plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=u4qqrI5jy2Nsx6vqJMErCXV+x9CzWtkXUfLAHHyh21s=;
        b=MQ7CCpoTVctWJTJhZAoLydQrq/d8IQGpt0H6UERYdfb1Cwffb1vDPdCW2Gkfqa88Kg
         j2Ll07oLBAALUbDelc2ibLyz7wXbI9sVJQB6cAi32BVVzBpRShP2VKKZkjgBqREvuNTX
         Ad2G137Ya0v8HJ76l3yVHCjGjJ1TzIHI0rR7La/0TgdoMiFK5GzaP44xoesLfovy+W/f
         fwIkXKPi1P7qASnIA1NZ52Gim/eHlKh7UqiNoLmFFzoPN1HYtjvTQ6YeCMH3kzQGhCzf
         fGXLMPg023jq6ACak68LsMyP9ClMB4Iy+qM46puc7lg+75JBqGUbsheXj1HLIxKKn3W6
         WvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=u4qqrI5jy2Nsx6vqJMErCXV+x9CzWtkXUfLAHHyh21s=;
        b=pS+RDG5pRBCkOwTX1wn39cbzIZzuXeFUfmKq3dMOJ3P6OwzvLCWsSr/iVhPfMo9m1O
         ow354Cml8Dmh2kYb6e65ztBajh0zXRsME+x3zAHPBVTkwucOWV1msTB954XQtD50lOXM
         JeNlmaFJ5GuKXh1UqyDb8MiaBdkKJVGmez0CUa9zSGvkumfcvIa2g1/w5RdE2oBjIKRS
         iNEvzy2e4deYTAAzvs1WfCiM63D8Wm0TmXOghQD2QqSmO+5GuvVjNuVzONhP0pirt/Yf
         UDfnT0JB0cyjn0M3XVtB8FL/upWso2ycYNXCYyDRH8ZiNn3NN2822LNMZui5jLF5aVZW
         W0yA==
X-Gm-Message-State: ABuFfojU/2lIKmkc5lS/soL2LGGy7lKGaug9MSFw3b9cImjnSyWD1USE
        c7Md/jz/kcGDvkdXcvYasomOGg==
X-Google-Smtp-Source: ACcGV60yRmG72YY1S7+8mvD3ZovWgtM99ZNjvMAc5wontyhUxLXC68qdWGf04P9/gTVOhWh9BTIFTQ==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20-v6mr5797372plp.115.1539625170835;
        Mon, 15 Oct 2018 10:39:30 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a16-v6sm13793080pfi.49.2018.10.15.10.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 10:39:29 -0700 (PDT)
Date:   Mon, 15 Oct 2018 10:39:29 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:39:01 PDT (-0700)
Subject:     Re: [PATCH 5/5] RISC-V: Implement sparsemem
In-Reply-To: <15C8B877-4BBE-47E1-98D1-945E9355E757@raithlin.com>
CC:     logang@deltatee.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        aou@eecs.berkeley.edu, Christoph Hellwig <hch@lst.de>,
        logang@deltatee.com, Andrew Waterman <andrew@sifive.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Clark <michaeljclark@mac.com>, robh@kernel.org,
        zong@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     sbates@raithlin.com
Message-ID: <mhng-d8f1905a-8985-4797-b05b-b165b4ce91f1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 05:18:20 PDT (-0700), sbates@raithlin.com wrote:
> Palmer
> 
>> I don't really know anything about this, but you're welcome to add a
>>    
>>    Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> 
> Thanks. I think it would be good to get someone who's familiar with linux/mm to take a look.
>     
>> if you think it'll help.  I'm assuming you're targeting a different tree for 
>> the patch set, in which case it's probably best to keep this together with the 
>> rest of it.
> 
> No I think this series should be pulled by the RISC-V maintainer. The other patches in this series just refactor some code and need to be ACK'ed by their ARCH developers but I suspect the series should be pulled into RISC-V. That said since it does touch other arch should it be pulled by mm? 
> 
> BTW note that RISC-V SPARSEMEM support is pretty useful for all manner of things and not just the p2pdma discussed in the cover.

Ah, OK -- I thought this was adding the support everywhere.  Do you mind 
re-sending the patches with the various acks/reviews and I'll put in on 
for-next?

>     
>> Thanks for porting your stuff to RISC-V!
> 
> You bet ;-)
