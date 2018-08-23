Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE2CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5D62087A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ADGaPtb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5D62087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeHWSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:45:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36777 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbeHWSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:45:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so5935712wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3TeAnwXfujL0Gk6s0esGlWEKYk9Er2NDH2kjMP4I6w4=;
        b=ADGaPtb1awwAVWFioLTwdGASBDhN+pPvvS4PwGaxqMN5V7EotT9jsR4u9KqW5AZhdS
         0DaWhM3EyuPhpWDUCnFp9+gmmhwnCRCo+Ea5Z45d5tzyGPH9VzxTqRg3o8qzZbB4+iwB
         xtRXEr6JUbylLY2Sgh2+eHuztqmSu5ayLTjz7i2JaDByxxUEoJgOLfiEjkLIyro581i/
         l7cmZiEqu1tDeGUARAxYEYUWsuZ7qZuRNZAlOXT6fUglrt9Ko50Z5Wp3XdbQBCUyd2Uk
         GDPwQdRQwI8bffR+QZtRDZeRCPybAhUXnotAWGyrVf6bR4RmUNO1jyV7EGKyyf5hyJrx
         gyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3TeAnwXfujL0Gk6s0esGlWEKYk9Er2NDH2kjMP4I6w4=;
        b=pjR5vnzOk1UnC5hwqMu3/ms99X2RD/OuRD2Jgf172djpeBudn+mfLSH2jy0ltCByeE
         CuR2OrtdIhZCq9l41tsyoLlQ9b8mgt8J4Qj8lFR418xv33eSfJwCAyWpgcjw51hmuHYU
         8nl7E2wOOIXvfgn7XzWrqbutfqhEnYJv4jtlic6MF1CdqY/gZM2y8XyNc5VcaKxfzoNW
         km9suD30n53Nw4dAiQp/8mT2jHqop952ZL9AJvXNpTFM3Y9HcTKqpvndOirdVn9rsBFW
         rp7iU1ueHhZXcywu9VhNA6/Bb9betXCFqjY06jvHui/KxT+SwBw9EeaHJF72qxOh6+tF
         GxfQ==
X-Gm-Message-State: APzg51ChVspyAOrjXM56oFJBSdnLcaF2wcFJFUQyTCuQSBhx2W2FJpMD
        YH7/Ow6mf83Ya0RJIBkJtIScYZlmaaGRMd3rIFDFGA==
X-Google-Smtp-Source: ANB0VdYzU9kNOmA91gZtm3TroVZy7TMNPAzVz+40opUtOBzv1cR3k9duxZKcw460djJsXrVq2QCuGoTaHOv05JUnI0k=
X-Received: by 2002:a1c:6f4f:: with SMTP id k76-v6mr2167806wmc.107.1535037330235;
 Thu, 23 Aug 2018 08:15:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 08:15:29
 -0700 (PDT)
In-Reply-To: <20180823133726.GA28059@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com> <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com> <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
 <20180821074826.GA28079@infradead.org> <CAAhSdy2NP4raXXPVvEJyAO127=J9jR3NNEHLF=vigBz=v-Qqkw@mail.gmail.com>
 <20180822060353.GA27106@infradead.org> <CAAhSdy1jdn7OS1AxwXYZqejUw-qto-5Afbb6o034ahH26E+vyw@mail.gmail.com>
 <20180823133726.GA28059@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Aug 2018 11:15:29 -0400
Message-ID: <CAAhSdy2E_H-qiyPbpGn68WftTU=2rA6VL7g0PGwyorwQM3kmqw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 9:37 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Aug 22, 2018 at 08:54:51PM +0530, Anup Patel wrote:
>> IMHO, rather than waiting for new CPU ON/OFF methods to come-up we
>> can keep the cpu_operations ready. Also, we are not re-inventing anything
>> here which we might have to discard later because cpu_operations are
>> already tried and hardened for Linux ARM64.
>
> Which is a different cpu architecture, and has shown to actually need
> it.  IFF we end up needing it on riscv we can still copy and paste
> it from AMD64.
>
>
>> I agree with you that in long-term SBI-based CPU ON/OFF will be widely
>> used. Most likely we will have at-least two CPU ON/OFF methods:
>> 1. Existing lottery based spinning
>> 2. New SBI calls
>
> And in this most likely case there is no need for an ops vector,
> a simple if/else will be much simpler and cleaner.

Like Atish mentioned, there is a possibility of existing HW going for
spin-table method instead of lottery based spinning.

This means in future we will have three or more CPU ON/OFF methods:
1. Existing lottery based spinning
2. spin-table
3. New SBI calls

I am fine dropping cpu_operations now but I am sure we will end-up
adding it back eventually.

Regards,
Anup
