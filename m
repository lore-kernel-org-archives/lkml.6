Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E59021A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="KMiZrihS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E59021A5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbeHFWpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:45:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46823 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeHFWpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:45:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so6103013ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/SIi06och/J4rq+55NDnmt6+wnMN2uj+Z35u/gBo6Bk=;
        b=KMiZrihShMzp/zTyytMtpz0+2SYHiSx+BkXjBuwnhqsM+Kq9NnMhxdZAp8h+D8kARO
         mfCoyWzqK1mm7gkTFTU96Uk6MYn8ooGdnBhmN7nFDXAVKvxqpy4dVvX+UNkSML34KMO6
         c3ouCrM0oyBoVZObTMtkGVAOpqbDczXK1O6oDm+0lxApmmnlOd5ApUwXvammD7wZZ00k
         PI8KhZdHT6csRuAGVibWNgIiZ9t6i5Q8RIW+WzNHl9kX4tIW1HXphZ4EMsY8dnOVZ2Mm
         +rDv1lch4w+UY12YhV61XKdEQKyAPsfWkMpr07e7hAmE7/QEzdO5kCMPOWRyGBGNMLj2
         yFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/SIi06och/J4rq+55NDnmt6+wnMN2uj+Z35u/gBo6Bk=;
        b=WBSKHsdW+STGgzQKL+ctursjm16PlQnWyr0/IDf3bkFNkmZ4G2g9Y3om5UIZM/CYQH
         zsxEVB2ZU1BXtW7ZQpe8Z39E9+bDKqqIdzreBuz7eXjxVCpCJ6+/8LeUntFEN99VJWbf
         zQHC2+4tOSD0ZbeNgfVv37HpL89ObhMYkMi05bbTtnl9Etwlz8uc9IgJiybAueBXWsg3
         6ulauK3qoEOAIlEKUHxBGAPn0XlIrdiwpsCNyZw/1R17wR7VnSmoO9qbQ0ComgktPRcx
         S15jxGZ9KRxv9V4Xg7I4bm2axaZd0ZHWb0V6yteGMfuIQS600zgE8BcMTcAZu5OcAtdk
         DFwg==
X-Gm-Message-State: AOUpUlHBrKnNc4EMPwYWkfiaIDi7pFriO3uc0aQeVzBOE5WaAPPqIjML
        TUWG8NdwRzZDR9h1N7urtqEsNQ==
X-Google-Smtp-Source: AAOMgpcAV7mi3y/Zy4bve/z/ahQ3K2OIyzmFvG+urkGZfAEw/cB2mG8qlrD+2ZigMZmLLVHQeBj+4Q==
X-Received: by 2002:a17:902:184:: with SMTP id b4-v6mr15497160plb.340.1533587664132;
        Mon, 06 Aug 2018 13:34:24 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m20-v6sm25096182pfg.61.2018.08.06.13.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 13:34:23 -0700 (PDT)
Date:   Mon, 06 Aug 2018 13:34:23 -0700 (PDT)
X-Google-Original-Date: Mon, 06 Aug 2018 12:46:19 PDT (-0700)
Subject:     Re: [PATCH 09/11] RISC-V: Support per-hart timebase-frequency
In-Reply-To: <20180803123357.GC18301@lst.de>
CC:     atish.patra@wdc.com, Christoph Hellwig <hch@lst.de>,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-d315d8a6-c4db-4ec8-927b-fc9f1d8e7872@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2018 05:33:57 PDT (-0700), Christoph Hellwig wrote:
> On Thu, Aug 02, 2018 at 03:19:49PM -0700, Atish Patra wrote:
>> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>>> From: Palmer Dabbelt <palmer@sifive.com>
>>>
>>> Follow the updated DT specs and read the timebase-frequency from the
>>> CPU 0 node.
>>>
>>
>> However, the DT in the HighFive Unleashed has the entry at the wrong place.
>>
>> Even the example in github also at wrong place.
>> https://github.com/riscv/riscv-device-tree-doc/pull/8/commits/2461d481329c55005fcbe684f0d6bdb3b7f0a432
>>
>> DT should be consistent between Documentation and the one in the hardware.
>> I can fix them in bbl & submit a bbl patch. But I am not sure if that's an
>> acceptable way to do it.
>
> I'll need to have comments from Palmer and/or someone else at SiFive
> here.  Personally I really don't care where we document the timebase,
> as this patch supports both locations anywhere.  For now I'll just update
> the commit log to state that more explicitly.

You're welcome to submit a BBL patch to make this all match, but from my 
understanding of the device tree spec putting timebase-frequency in either 
place should be legal so it's not a critical fix.  That said, it's better to 
have them match than not match.
