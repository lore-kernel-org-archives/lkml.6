Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1077CC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05052081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WPojO0Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05052081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeJaJBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:01:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44069 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeJaJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:01:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id m18-v6so10296147lfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 17:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HGKQkZ0x9VDbHVEWHqz1X0ZBPrUJKkfMPJCs5/d60I=;
        b=WPojO0Ya00bA4iWF9MZRlRSEHl8/slpLTdYMI6ZLlaAoBD0XWV31qihIBNvgvpehXn
         53keo9sYp+rFG/hw1ujqdMpth4lSbvAWXoj2KhZMUkc+gKBVDqIDQzRdUZPqURyhL4jS
         KAERDMFWUdRdFA+/4PzFQtrxITDV/3dS8PHzxsdpSegzpDSAUaBqd/umupWvoQo2HTUw
         EOY6/t66f4JdoSDB9V+ssNTA0hLmEkEnDlGH9AZIo2pfg4agXOEAAQqz9Mkwx+LD4Lhu
         SjVZ5C19b7TinCNOgyAAcX0uDB5tmlVvafjTw4k/Q5AWh7N/PiIvRZIdC+KGRAjEBKUl
         9cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HGKQkZ0x9VDbHVEWHqz1X0ZBPrUJKkfMPJCs5/d60I=;
        b=WVFdNIrD3yZZLPiFWI76V/UoP7hT5n5rBMZjKA+rQEwjeCK/hrbM68Jp26SJExDPRs
         twRDleCD2sCZ6vsu0Ca2GuSiKT3NzKhlC6+/r5Zd1GH1TaJ9KbvuOw1M67Cf25gX+uGX
         vq4TUf2NC0jlyfCIOs4bCvO9FN0V0U4AJQJ+OHfx3X1p5L3D9yDsUddJnWB6Ar7nr3TG
         AOOaGJLEPb+WIJgSGyFzL/ivq/JVwJ1a/l1A8Wo3Pa8qbFAo2hiAsyFhpLxyYZKfbbDv
         UY9v3qH+glcMl0jh+IOCCMaQ9jwOD5RrkazGyOkA+R0IiolRBoOWHRdWPxPNgaifM4Kv
         rBgg==
X-Gm-Message-State: AGRZ1gKtSPzSCMfm3ufDjz0+5Uo3HMSemWVIrLUzCByViQBkSLopZqM0
        0+qT4I55o3aMweSwrO1Bdlrw20w3IqkUmDDEhsCqKg==
X-Google-Smtp-Source: AJdET5fajFyox5n/k/jGYa5UwDThDBSyzxFQxIx0qqgp4SNufc5lz0f1LUTF9ZbD+l+U6KPrQAIrgRCANC00oleR0xw=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr469719lfe.87.1540944331471;
 Tue, 30 Oct 2018 17:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181031000413.30123-1-olof@lixom.net>
In-Reply-To: <20181031000413.30123-1-olof@lixom.net>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 30 Oct 2018 17:05:19 -0700
Message-ID: <CAOesGMg6L8+=ZFbH_ThUG3VrePrbBY0Bg5HWi+AiaEbNSOn_qA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: lib: Fix build error for 64-bit
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 5:04 PM Olof Johansson <olof@lixom.net> wrote:
>
> Fixes the following build error from tinyconfig:
>
> riscv64-unknown-linux-gnu-ld: kernel/sched/fair.o: in function `.L8':
> fair.c:(.text+0x70): undefined reference to `__lshrti3'
> riscv64-unknown-linux-gnu-ld: kernel/time/clocksource.o: in function `.L0 ':
> clocksource.c:(.text+0x334): undefined reference to `__lshrti3'

Err, fixed the whitespace in tishift.S while I was at it. Undo if you want.


-Olof
