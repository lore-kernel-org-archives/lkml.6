Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A4CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689A82081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgnVRXai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689A82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeKHW7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:59:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39567 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHW7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:59:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id e4so26333826qkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJuanfEUOAheXTh85eXcZPXVfxYk5Eh/JgKfbZC6UHc=;
        b=GgnVRXaiWmmWvUrrjZiXOgJshUkSct1ojEiIHz+m65AreYCkQmBm6vrryALYIsYtkO
         lHrQuS7oJB176nZgUDzsO0hmm9CGKn+DAvpsLCHGgDY5Y6Cq5CvRY2Sq0lbbdB6t5amz
         ZELNLVwl+wl82d8mYpwFr88h34WJh8kS1qGpeEPAjRQzPw+J8HUeSbplFFXT5Jyn+fd4
         inKTQ3mMZ1qUcEvNPCYiMAAXLTp2o00PA4kSBNtqEJQwVqASaHVCYzpfvC48KbTwNvap
         QPJCoSD48Uq4wMEcJJlPKKeppyPGUjdFgyZunitUp6COXjNhB9PpUyYZvdqlvMcCN0gr
         Nnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJuanfEUOAheXTh85eXcZPXVfxYk5Eh/JgKfbZC6UHc=;
        b=mb9RQrtaE/jfbfF6HbUvOnk6PXm5kvE+Fl9g31AOTB666LjgQl//hf8JFHJHsLmb71
         QB1jXPqr1aZUCKCJcjfJPVAXXYnvqu2rQs5O9hDGsW/vuP8JTHzLs0EkYZwmlnpiKkHI
         ylS18D6z8jwGTJaEtdRPIa/fq+2GR4TFNOQ31y+rrHzavuyCBZ3DOyH3FKgj+sejpY1k
         D0uoEM9kfSnsDDVbbi6yiGnYLoRLzAMQnoOT7aKZRzdtZGZNNTEMs+hv2UfRg4NG60oL
         rF/DBwDA9BTDvenAeEGRa/tnw+60audEfsGTVwf/0r5I7r2RN8IBTEHt5VlykDB1ZiPI
         6RXw==
X-Gm-Message-State: AGRZ1gLyPzHgkArjL4omoDldolvZYFezViH5+BgvWDjwxmvbhsfUcndX
        vU5FyvBwRyCalZ6dt4XqzMZsuhDEga73yCquAqye3kRvhyw=
X-Google-Smtp-Source: AJdET5dxbAPyaXuGnvnThwg8CZv9unpBZcHBNHbb1sa1s7sE1V6eJuvJYbI8Dbrr1ei2xqBuPEETGcevfCp5Kal04pI=
X-Received: by 2002:a37:3892:: with SMTP id f140mr4092114qka.214.1541683420888;
 Thu, 08 Nov 2018 05:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20181108131733.45720-1-smuchun@gmail.com>
In-Reply-To: <20181108131733.45720-1-smuchun@gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Thu, 8 Nov 2018 21:23:30 +0800
Message-ID: <CAPSr9jE2XJ7hg7LiQ4ZUkmjbe0J_AH53JU1wAYkqwFoWgO92cw@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Introduce prio_lower() helper for comparing RT
 task prority
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

This is v2 patch. I'm sorry that I forgot to add the
word "v2" to the subject.

Yours,
Muchun Song
