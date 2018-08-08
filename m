Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3D2151B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="WGj5/S5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE3D2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeHHXLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:11:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36579 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730169AbeHHXLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:11:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id h12-v6so1641615pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+aRGBqXRle3H6HQ5R6HLNTLox+aUx02NaQOy9L8dSO4=;
        b=WGj5/S5bPTreFdAVNCSAS1aC6f7WBdwsxgTxhPR4rNYKDTHUf8/eTvbs4O+nuE41HE
         f6AHgbPzm27hr9vk0ud98mnaVxOWgdpQZlNumt6YaWd/1N0HtaonlPH+i+N0aWIEvhsT
         DMTLEVPMmPw9NJeurWMO+udndk6uvLuOrbnBfhU33EHzquOR0mTWMgJ3Qs7B4EFkyzh8
         zhOtZKIQuSY57ezlP3MRI0KE/r0hWTh+/GnTk8aNCKdHuEQ+zIcfp+k9Al/4MeGUY3v5
         6sH1hMIurpiYKh0tQU6XdDmpZiHdMH1UTLpVsbPuQ0T6bcz3NNN6CKnLYZY/xkDbYu31
         ZiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+aRGBqXRle3H6HQ5R6HLNTLox+aUx02NaQOy9L8dSO4=;
        b=QKqMi9SE4ah6XWqHwc0eu/6mBYxcMCNF2M94K2qXuqkpc+qgyGB6RF26T0s+cv2+ex
         KunVPUMYbb0w0nxQdoxCZDn9DiD7zNNIEPKOeJbyP6+oy4eNuf1/SxcEOBQFQQjhj2zq
         uILOV5TTiXGiqm852vaVGcGyR14UASK0cxgRy5ek38V72XE3E00K3Pqy/OuvEDkUcneH
         yocwFS6DgN9rez4eqH6ZnDefeA9Haxe58Gsrna4Qls1GGpkmlojwC6mT1jW0lPjFS/Zu
         TrXxWOD0ttNyRPPaHjOV8BHpsn+AQcIj0djrsxjL/L23Q73AoLBcGwHB6r3pUOYLMg5b
         m+MQ==
X-Gm-Message-State: AOUpUlH8cxE3RF0aBPB+TaBzb8a8j49E4tRa7MQLps3w9T08KsmoQ+SH
        CSRk35q1Hu1U3+uwYklM+fsGmQ==
X-Google-Smtp-Source: AA+uWPxoVXZXvud72uJpcxUmQr9Ks059ob3MRG46LWRykdyQwa929V0FPEvveIRn3FvEin8MmZi/EQ==
X-Received: by 2002:a63:a042:: with SMTP id u2-v6mr3904644pgn.80.1533761377625;
        Wed, 08 Aug 2018 13:49:37 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p11-v6sm8110866pfj.72.2018.08.08.13.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 13:49:37 -0700 (PDT)
Date:   Wed, 08 Aug 2018 13:49:37 -0700 (PDT)
X-Google-Original-Date: Wed, 08 Aug 2018 13:25:11 PDT (-0700)
Subject:     Re: [PATCH 6/8] dt-bindings: interrupt-controller: RISC-V PLIC documentation
In-Reply-To: <CAL_JsqKgawQA5V2W1e9QFb_Ri+Aka-08WizeSD9kdxyBdcwpEQ@mail.gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, mark.rutland@arm.com,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-b80154dd-ceb2-4cc1-ac17-05b3c30506e2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Aug 2018 09:15:58 PDT (-0700), robh+dt@kernel.org wrote:
> On Wed, Aug 8, 2018 at 8:59 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Wed, Aug 08, 2018 at 08:29:50AM -0600, Rob Herring wrote:
>> > Version numbers on the individual patches would be nice...
>>
>> We've never done these in the subsystems I'm involved with.  Too
>> much clutter in the subject lines for information that is easily
>> deductable.
>
> Unfortunately not in Gmail which doesn't thread properly. But
> patchwork also provides the version tag which I use to sort my
> reviews.
>
>> > > +Example:
>> > > +
>> > > +       plic: interrupt-controller@c000000 {
>> > > +               #address-cells = <0>;
>> > > +               #interrupt-cells = <1>;
>> > > +               compatible = "riscv,plic0";
>> > > +               interrupt-controller;
>> > > +               interrupts-extended = <
>> > > +                       &cpu0-intc 11
>> > > +                       &cpu1-intc 11 &cpu1-intc 9
>> > > +                       &cpu2-intc 11 &cpu2-intc 9
>> > > +                       &cpu3-intc 11 &cpu3-intc 9
>> > > +                       &cpu4-intc 11 &cpu4-intc 9>;
>> >
>> > I'm confused why this is still here if you are dropping the cpu intc binding?
>>
>> We need some parent that identifies the core (hart in RISC-V terminology).
>> The way the code now works is that it just walks up the parent chain
>> until it finds a CPU node, so it either accepts the legacy intc node
>> inbetween, or it accepts the cpu node directly as the intc node is pointless.
>>
>> I guess for the documentation we should instead just point to the
>> "riscv" cpu nodes instead?
>
> That's not valid and dtc will tell you that. 'interrupts' (via
> interrupt-parent) or 'interrupts-extended' has to point to an
> 'interrupt-controller' node. I guess you could make the cpu nodes
> interrupt-controllers. That's a bit strange, but I can't think of a
> reason why that wouldn't work.
>
> Just because the cpu-intc is not made to be an irqchip in the kernel
> doesn't mean it can't still be represented as an interrupt-controller
> in DT. It shouldn't be designed just around how some OS happens to
> implement things.

FWIW, I like this approach.  There is an interrupt widget in the hardware, so 
having the device tree represent it seems like a good idea.

>> > I also noticed the cpu binding refers to "riscv,cpu-intc" as well.
>> > That needs to be fixed too if there's a change.
>>
>> Only in the examples.  I'd be fine with dropping them, but let's keep
>> that separate from the interrupt support.
>
> You need to sort out how this is all tied together and works because
> right now you are supporting 2 ways and one is undocumented and the
> other is invalid. Changing things later is only going to be more
> painful.
>
> Rob
