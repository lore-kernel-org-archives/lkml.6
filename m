Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45A9204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6MnRUdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfARKsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:48:45 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41956 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfARKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:48:45 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so8129613vsc.8;
        Fri, 18 Jan 2019 02:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6xliivq0weCXLfwCUUU2y3nNNwTp933/QmOo/bU0eY=;
        b=C6MnRUdvpvjVi5Kc8Lceq9DKjFe5J546YEJCUr3Sbn1TcFwfxAzTWbjASQrCNA6aGh
         Nu/6WGPZxYRxA/SP6he88jxtClUyBRL+kl2le9yc41CozxPqdcpzZtFWFFtmSk9q/IrS
         HHahJkKxV2iH2vPXAwYh3qMunjbO0J2LEhLf8NG3QzP8ns6wtmr5u32u7kKLP3eWButc
         TZ8XelSo1gGw4j3PnEwKa80b1ml+h4JXNIkIuun5HIV0fRllQsNUfe7GN9YlNKAObGGo
         kM32yguM1ceiCrAWAVr68YUwEHv2cai2UhJ0xo8+YTnRF8yU+9/mncUtqtLonPnGQH8M
         kfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6xliivq0weCXLfwCUUU2y3nNNwTp933/QmOo/bU0eY=;
        b=At48QkHYVBHDt9gVQQ3YXMNtdPYrLdFrYFMWvsVqginPkaKHXZ/S0qEdb3wWX3ExAB
         yeUVOD5qkVMkgAM6WNlj2EqUQPxmvVxx4t30N3bcFKiw8K4sngW+ZqMe3ykoRKuw5FXF
         UNznfr9VzV2OQMTgjZwyN6To9RMfDzSe0w4YYMNC61Ui1KXq07zZCmDW+H25F43aogXE
         KnXNaNlQ5qHYHv/2TlgbxHlv+PzKV7GRoKlOwwn/cx7sG8mRk25tNU1unKWh7HsSIeMW
         cawxLrlTr/doCBFBaGIDe7WRltZWWhrNmj19tIdZO/D/P/wICszUVmuVWz+QiZykNDtk
         9PPg==
X-Gm-Message-State: AJcUukeF68imL5RzxGrVjvVy/OZPs5XPTFPsEP4bc1F7bJex1Yt1p/Jt
        OYIC6nOkTTEEC7Ugb3qkQ0HFpCTa9Y4dfk1bWME=
X-Google-Smtp-Source: ALg8bN7HsppUgj5spIWajytKcejIfmTNluhxxl0gRonQb5lcTa162V7q5iApGv92T5XidVHBMY1/wVNcnfaji/TcPRo=
X-Received: by 2002:a67:f793:: with SMTP id j19mr6934457vso.196.1547808523523;
 Fri, 18 Jan 2019 02:48:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
 <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
In-Reply-To: <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 18 Jan 2019 16:18:32 +0530
Message-ID: <CAOuPNLiNtPFksCuZF_vL6+YuLG0i0umzQhMCyEN69h9tySn2Vw@mail.gmail.com>
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:54 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Pintu-san,
>
> On 1/18/2019 3:38 PM, Pintu Agarwal wrote:
> > Hi All,
> >
> > Currently, I am trying to debug a boot up crash on some qualcomm
> > snapdragon arm64 board with kernel 4.9.
> > I could find the cause of the failure, but I am unable to locate from
> > which subsystem/drivers this is getting triggered.
> > If you have any ideas or suggestions to locate the issue, please let me know.
> >
> > This is the snapshot of crash logs:
> > [    6.907065] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000
> > [    6.973938] PC is at 0x0
> > [    6.976503] LR is at __ipipe_ack_fasteoi_irq+0x28/0x38
> > [    7.151078] Process qmp_aop (pid: 24, stack limit = 0xfffffffbedc18000)
> > [    7.242668] [<          (null)>]           (null)
> > [    7.247416] [<ffffff9469f8d2e0>] __ipipe_dispatch_irq+0x78/0x340
> > [    7.253469] [<ffffff9469e81564>] __ipipe_grab_irq+0x5c/0xd0
> > [    7.341538] [<ffffff9469e81d68>] gic_handle_irq+0xc0/0x154
> >
> > [    6.288581] [PINTU]: __ipipe_ack_fasteoi_irq - called
> > [    6.293698] [PINTU]: __ipipe_ack_fasteoi_irq:
> > desc->irq_data.chip->irq_hold is NULL
> >
> > When I check, I found that the irq_hold implementation is missing in
> > one of the irq_chip driver (expected by ipipe), which I am supposed to
> > implement.
> >
> > But I am unable to locate which irq_chip driver.
> > If there are any good techniques to locate this in kernel, please help.
> >
>
> Could you please tell which QCOM SoC this board is based on?
>

Snapdragon 845 with kernel 4.9.x
I want to know from which subsystem it is triggered:drivers/soc/qcom/

>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
