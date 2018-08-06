Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C28C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F4621A15
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S5rRknY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F4621A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeHFXJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:09:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44481 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:09:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so7416404pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=oXCCAx54Hsht1v2cjNkJseZz56G/MpTfwTA1B8wBIvA=;
        b=S5rRknY16Jy4cuOwf2WrWIMwP17Xpl225g6xFZyfIXczMMuowgjQWeCxGfIbxYlLvC
         V7F053eMgLoQ5KyM27DISXCKmqjJ2k6jUdQ57mKZaECdlpUpMC5ftMeleEi1Ws4HBkmC
         bvq7+Y+Nea7sqpbBnkP0A0tt9pBNNAJJ7l/UIuSppo8Zj+akNb44PHcUeIn8Gjsm9Lq1
         F5W+jL7GWkOnVv4rlwY/8oFK+mRXryOGo3vl3+be6aVGmUIutOYMhOjPM8jLdFYdJsv6
         gkkyN2WlIFtIvrG/8/zQJLo0gPWygzaRYaepNTSCFfCGgwmRrc9aFMpdbZv9Dn/Z5nur
         sC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=oXCCAx54Hsht1v2cjNkJseZz56G/MpTfwTA1B8wBIvA=;
        b=hODjPHTgrox1ke8e4f2FxKAgjoMST813llA3eDfVUBbgMNSwKsGIuEYqoFICLEg/rn
         kF1vGvXJ83N1JIV4ZC1GAmf1tKU4Uam/a6LSwG2s6rJralYTqqX+P0HuHq9Am4oJSaPR
         OPa6ItgojSTNjbClKtASSOeNlDRcGj5A1dWGOb3iJjhrZUjclisr9oHkBSHjgp9i0dDZ
         if9JAESQREe2sJ/0cuagkGGw6RSVMqS2OhWiZwP8XH4AJsjNbS0TAucFCkKh2pFucx7Z
         KYBilIII7rgtkrdXP/KVfgWFLU6BJHySGivuvacb3X7GbEEDO9JZtzc9WKTwvU6zMYiR
         4Hlg==
X-Gm-Message-State: AOUpUlFp6CWAPIz38aUtRbe95TraylBOAKXq72MfOWLV/YDFx66xc/4Q
        kff4kzHIOZJYj14VF6kGP+z+TQ==
X-Google-Smtp-Source: AAOMgpfXBmydQEZ96DIF2q4VH6+tRwaJwCdwLR5szZUFp6XiWaFDmEbbgG+pLyw78xTwJDyQArkCxA==
X-Received: by 2002:a62:dec1:: with SMTP id h184-v6mr12130399pfg.197.1533589131647;
        Mon, 06 Aug 2018 13:58:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e82-v6sm25722848pfd.40.2018.08.06.13.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 13:58:50 -0700 (PDT)
Subject: Re: RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
Date:   Mon,  6 Aug 2018 13:42:57 -0700
Message-Id: <20180806204258.22280-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180804085438.GA15840@infradead.org>
References: <20180804085438.GA15840@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Aug 2018 01:54:38 PDT (-0700), Christoph Hellwig wrote:
>> index 818655b0d535..882a6aa09a33 100644
>> --- a/arch/riscv/include/uapi/asm/syscalls.h
>> +++ b/arch/riscv/include/uapi/asm/syscalls.h
>> @@ -1,10 +1,11 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +// SPDX-License-Identifier: GPL-2.0
>
> /* */ is the required style for headers, // is only for other files.
>
>> +/* There is explicitly no include guard here because this file is expected to
>> + * be included multiple times in order to define the syscall macros via
>> + * __SYSCALL. */
>
> Normal Linux comment style would be:
>
> /*
>  * There is explicitly no include guard here because this file is expected to
>  * be included multiple times in order to define the syscall macros via
>  * __SYSCALL.
>  */
>
> Also syscalls.h isn't included directly anywhere, but through
> <asm/unistd.h>, so we'll probably need a similar comment there as well.

I've attached a v2 with both of these fixed.  Thanks!
