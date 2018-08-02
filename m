Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69D121564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G1hTk5nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69D121564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbeHBUXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:23:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39047 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbeHBUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:23:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id a11-v6so1599122pgw.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mE3nhT4zrsGgtPhd19DOsVPnnf0sqY/pBKf0DKvvugc=;
        b=G1hTk5ndbtTA1HJ6zNyZyw+dk/D2g1XdwxQUfVPYO8HXdQh8fJZHzeJeDt8P2DcG8r
         t9NZPM7Huf/rIuKonsPJmwBbSfmGscAf2Cevo+sexooxUf8OsrplT43P/L/Zdm42+BPj
         Y3xyGKQymkliXV0+AYtuC6KLtyaDuziO6w2QeahAb91vE6DdLY7P9y/fNPixe5bmEn01
         eoj0A16Wn53AE1FN3oyt4e75tjphKy5ihXLuhORALxBJLp1urCxqiQaDhaE/eSMtv2UU
         I1ZIwywVjLzxagDFwh1Brw/rhdKBey9CCGQLyQokjNEcIx7SmFhuKiLmJNzn1kAkrG7u
         R/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mE3nhT4zrsGgtPhd19DOsVPnnf0sqY/pBKf0DKvvugc=;
        b=cDaV4SuZTXwY5782wDsERDI4xtqd2tHcZq2LGMAdy7v2Y6/plQEOpI58BALLqqL1W8
         N56QSWQbuBjNIN9k8lqWV6dNO03cA0JT8MRVVSB3OYjA/d+ZoOtLkSN3puDBpfBxDbGA
         vG28RKTQc/73H3uW+AZ+dZszC6R72lqMmArbr/lolrFA9d+MchxhVCRDv3uGXAdcTBMb
         KULOr2uRfKZIzEt+tYLhHUEwvYVrdPd3OW3CJtZ17m1aXxrd9Fg9jqXf7Lxxfo6W5lMA
         O3VWzglIYWgrGo8aHmdKh66WmDhvU4V9y8h1jJlC3m6rtrfLrXCbwwSw+DXSNDSuDBbm
         MVLg==
X-Gm-Message-State: AOUpUlG8R5yEc/9vQpPvzR6vL6FR2Vlk8PlYcLipSkNOGP7ZBbkjI1T/
        X0qf363erZQ2CfoKIHUfM79eqg==
X-Google-Smtp-Source: AAOMgpd24IIApoXV4pBUMV2/NweHF1gMkPUcXzti1wVpQMHtw7FnUGSfT7P32wahYlxu9+NeTCI5yA==
X-Received: by 2002:a62:41d6:: with SMTP id g83-v6mr612731pfd.219.1533234654418;
        Thu, 02 Aug 2018 11:30:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l27-v6sm5780917pfi.180.2018.08.02.11.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:30:53 -0700 (PDT)
Date:   Thu, 02 Aug 2018 11:30:53 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Aug 2018 11:28:16 PDT (-0700)
Subject:     Re: Finish the GENERIC_IRQ_MULTI_HANDLER conversion
In-Reply-To: <alpine.DEB.2.21.1806241513260.8650@nanos.tec.linutronix.de>
CC:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Arnd Bergmann <arnd@arndb.de>, keescook@chromium.org,
        vladimir.murzin@arm.com, nicolas.pitre@linaro.org,
        jinb.park7@gmail.com, yamada.masahiro@socionext.com,
        alexandre.belloni@bootlin.com,
        Greg KH <gregkh@linuxfoundation.org>, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, jhogan@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de
Message-ID: <mhng-ef3db5ea-d5f5-4d51-b32c-1b9ca38abccf@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2018 06:15:25 PDT (-0700), tglx@linutronix.de wrote:
> On Thu, 21 Jun 2018, Palmer Dabbelt wrote:
>> A while ago I sent a patch set that adds a GENERIC_IRQ_MULTI_HANDLER,
>> which is an exact copy of the existing IRQ_MULTI_HANDLER support in the
>> arm port, which is being used unconditionally by arm64 and openrisc.
>> GENERIC_IRQ_MULTI_HANDLER is currently being used by the RISC-V port.  I
>> managed to make a few mistakes in my original patch set and as a result
>> my conversion of the other architectures of GENERIC_IRQ_MULTI_HANDLER
>> was dropped.
>>
>> This patch set finishes up my original patch set by converting arm,
>> arm64, and openrisc over to the new GENERIC_IRQ_MULTI_HANDLER support
>> and then removing MULTI_IRQ_HANDLER as it's obselete.
>>
>> At the time I wrote this I gave it fairly extensive build testing, but
>> went I recently rebased it I just tested the full patch set on arm,
>> arm64, and openrisc defconfigs.
>>
>> Various flavors of this patch set have bounced around a few times
>> before, but I'm calling this a whole new patch set as it builds on top
>> of what was merged.
>
> I'll take the whole pile through tip irq/core which probably makes the most
> sense unless there are any objections from architecture maintainers.

Thanks!  Unless I've managed to screw something up I don't see these in your 
tree, but I also don't see any feedback from anyone else.
