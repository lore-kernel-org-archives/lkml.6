Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D1D2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FlgxZkii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfBSV4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:56:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38912 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfBSV4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:56:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so419335pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zwftrmOanSdXzGc8vLBd3uz4NYesZr6TcF6+HO5ue/8=;
        b=FlgxZkii1ql/ihK9/mTDXJZxMuqUGxQwjTuD6Js76dnbctgvl2vSAe73VTxWX0xlb7
         BKd877LCMLLdk6LW8f4WKDe/gS9oAlDjgZYEe1IMhhBkQXAL3XEUweP90fm9CSEfFhzZ
         BCv/zekDCVH2tH45qJ0Dmo3Lo8Q17+hY7POGQaiA9MhIacwSqf8DXZxWUGDzGrCo7n4P
         TdJEoZjKEOWaP6NY6P5BVye0gnsh9Hwh8MNOS0MNih3UBfYeTrenAdbJzcn6HJIrgM9Q
         fKIG8nwg8X6c+GdKIPT7yl4iXDtkQAxswC5ygIPe8949hzgOefWv54XIb1CmDmkhQUkx
         Ss9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zwftrmOanSdXzGc8vLBd3uz4NYesZr6TcF6+HO5ue/8=;
        b=A8XtNSD+7CoAsoJLuquAFlDIipX01f9EWeGveKqTvqeHhkeb8sH1K3Ucfg732b1GFO
         ezgKyINBdzUZHNuA0u16+5jwBjKvVmaHXKK0FMYnF1fl/36uArPKGA1VE3lB0n7JYxmu
         V7hC1qM/z8kBEseyGqyto2X9hBjeUBGXQxfbIUJ7BHvaMEMiZ2HvZqpOq0uV+78jJITm
         WK200836KB2teTOsmXH5xcuQaAh//Gl0xtOJaT9IiPrm+JRLOpnqDBbbjyNuLVq5YtIC
         VaILDshNS7bVlnlD0vMcpYf3kol05gaMA4HG1jnpPY/rlKH5qJYv3M6wgMYVXaG4eAgS
         iXKQ==
X-Gm-Message-State: AHQUAuZaSbjSfFgzyg/iznfXPzfPML/fU6b+6a8XsgTyzIcz3c5Kq2wv
        n14Tpw8/x0fxxUpDb95srLgxeA==
X-Google-Smtp-Source: AHgI3IbO71j/yAEHBSC/UTbub00j189AuzZZ0wQvGAVS08M3quqG9okfN46WWJ73A48emt4TkHOIYg==
X-Received: by 2002:a63:5b1c:: with SMTP id p28mr25442696pgb.73.1550613359530;
        Tue, 19 Feb 2019 13:55:59 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u2sm21380550pfh.134.2019.02.19.13.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 13:55:58 -0800 (PST)
Date:   Tue, 19 Feb 2019 13:55:58 -0800 (PST)
X-Google-Original-Date: Tue, 19 Feb 2019 13:55:45 PST (-0800)
Subject:     Re: [PATCH 02/11] riscv: remove the HAVE_KPROBES option
In-Reply-To: <20190219151759.GD4121@lst.de>
CC:     yamada.masahiro@socionext.com, Christoph Hellwig <hch@lst.de>,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-a73ea6c9-683c-4ee0-991e-24a6608b6887@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 07:17:59 PST (-0800), Christoph Hellwig wrote:
> On Fri, Feb 15, 2019 at 06:32:07PM +0900, Masahiro Yamada wrote:
>> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>> >
>> > HAVE_KPROBES is defined genericly in arch/Kconfig and architectures
>> > should just select it if supported.
>> >
>> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Do you want this patch picked up by me?
>>
>> Or, by Palmer?
>
> Given that I don't think I'll have the rest of this series respun in time
> for this merge window:  Palmer, can you pick it up?

It's on my for-next.
