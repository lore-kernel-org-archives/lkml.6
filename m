Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB57CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A4D2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfvi/iX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeJKGSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:18:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33590 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJKGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:18:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so3204625pge.0;
        Wed, 10 Oct 2018 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTPfIOwUW3Ndg7aqU9pV85ZbCe2a76m5QYiO25t3jK0=;
        b=nfvi/iX0qayuFS2PyfJJKomzj1jGqRSdZK81nhLcefloBWqL5KEiQIexfT9g7sD6Qk
         HPL4ju5fi+4LNDTXr9IWinxXzZmezqlWMQYnDXv0zX9AoYqG5xJLuVaqeQ48jEEpfLeB
         1RmK/8AVb1ToVHNZJbQleAgiqKUO/4gXWoYIdqJX/7OGyanEcimbcglulGj3G22TdlG5
         Bzk/Ag1Lqa+zHpCPpDj2Mv5V8rtv6l3L1uVarwq5jyPuKKpKKZCsj6FMC5eeFqI4vn/D
         /G+EA4IDnIiG0+TsHg9lKRdH+LKjC3RiU3AcM8qJIwdF48q7hBKQGpmp965f0eG/CfWs
         OiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTPfIOwUW3Ndg7aqU9pV85ZbCe2a76m5QYiO25t3jK0=;
        b=FDqr8MuWue+0rGDrjQ0pid9GqYoHL0p4SwlMR87t3XIi6p5ajgJCcCKBzjFj0fpYXf
         Hj/nlE08YaPvI/ddPqnuTYixPyVfQHvx3nW47mnzn9Y7uAawsFkY4bf9DXzuOoq+Idhc
         lskXmb9aUUnwW4m0kXV3tPuJXeyJOBU6GjbyNu3c0rlfuTvu0pIjDy/ePZXuzdIWhwcC
         T/lXR/o67TG5W4NOk3+TZvijqtvElq2ye7nR6pLTMuIohnXCle/HogmfZII9JTMMtjhP
         QVVnnr0Bpi9Q+z0pnqL4m4llBqHJhmm8S2tbzetSZ2/d4hj0L5HS3Xy+k1AZHx1zMVil
         d+TQ==
X-Gm-Message-State: ABuFfoi/tXLPtwR+DUIZMtyvP53lywphWh2Q6xG8nIlXSjutYAA5fKp6
        QGFL6nqsmGITADW9D8GvloEMU81buKvO7JKFuQ4=
X-Google-Smtp-Source: ACcGV61AHuszhtoLCxJfzpEVUNQbb/AcDmPMG1ZYXUZjBQnBbt8Xn9in9XRqhJ/4vW3EEcf9z4myWfMK6AoWr+p1KCM=
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr14704850pgf.58.1539212038772;
 Wed, 10 Oct 2018 15:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
 <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com> <20181010095741.GA14472@e107155-lin>
In-Reply-To: <20181010095741.GA14472@e107155-lin>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Wed, 10 Oct 2018 15:53:47 -0700
Message-ID: <CAA07jV_FWxMRq=4hmTdCXJG6e3=-8AejfpKxmh9KUi9KQDH7yQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Wendy Liang <wendy.liang@xilinx.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 2:59 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 10, 2018 at 12:18:32AM -0700, Wendy Liang wrote:
> > Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> > in ZynqMP SoC used for the communication between various processor
> > systems.
> >
> > Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
>
> [...]
>
> > +Optional properties:
> > +--------------------
> > +- method:              The method of accessing the IPI agent registers.
> > +                       Permitted values are: "smc" and "hvc". Default is
> > +                       "smc".
>
> You are mixing the hardware messaging based mailbox and the software
> "smc/hvc" based mailbox together here. Please keep them separated.
> IIUC smc/hvc based mailcox is used for "tx" or too keep it simple in
> one direction and hardware based is used for "rx" or the other direction
> for communication.
>
Hi Sudeep,

Thanks for your comments.

The IPI hardware block has both buffers and registers. The hardware
block has dedicated
buffers for each mailboxes, and thus, in the implementation, we directly access
the buffers from IPI driver. However, the controller registers are
shared between
mailboxes in the hardware, as the ATF will also access the registers,
we need to use
SMC/HVC to access the registers (control or ISR). And the SMC/HVC here is for
the register access.

I am not clear on smc/hvc based mailbox is used for tx, and hardware
based is used
for  "rx". As for both TX and RX, we need to write/read the registers
(through SMC) and
write/read the buffers provided by the IPI hardware block directly.

Thanks,
Wendy

> You *should not* mix them as single unit. Also lots of other vendor need
> SMC/HVC based mailbox. So make it generic and keep it separate.
>
> --
> Regards,
> Sudeep
