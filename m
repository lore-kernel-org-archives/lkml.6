Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7FAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C67820700
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991262;
	bh=MeHHuPu0Pdq3s5h/Max33zQatHui0w5NnFPlRdmJvjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hj6M/NU83nZ93Qva6q3L+vfd7vWm/qC6OPj9bbKyZawdrFboYvqS1QVvVb5MJ7wQn
	 Z0mNlee55qBojwDq5/z3oJD2EnS0zIq1hiR/jLD1CAamrY9lM5NLsmZ7iTbhJbsA4W
	 9ZHfroRHIQ/bUXn6rCAcYsGXwqo5DE5WeiQvoLfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfBLRHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfBLRHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:07:40 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E40F20700;
        Tue, 12 Feb 2019 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991259;
        bh=MeHHuPu0Pdq3s5h/Max33zQatHui0w5NnFPlRdmJvjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CrvdDpAxKtvjcZ8SOHhIFk/vPkNSnQfJ6UX4p3e/U7lbr6MfDWwqF3mNgZZkRPHKu
         mu3lZhgwybhPPTjmeEiay+kEpjEL/NJheamn/S8XH52/66hJjyiB0m+YMrt82KT/BF
         MrI/K9vzM81soqoUHEZqss8X3zclg+1aLdObkhAo=
Received: by mail-ed1-f53.google.com with SMTP id b3so2874341ede.1;
        Tue, 12 Feb 2019 09:07:39 -0800 (PST)
X-Gm-Message-State: AHQUAuYOa9GmJwbkfPhC4cP23vg0W3aT/0g7MaX7hbt3uQVuxlv7QE1i
        bMft92Ixk6rid3tXSp3ClT9/8P7wrSVXr+b/ofs=
X-Google-Smtp-Source: AHgI3IYqn69oQbKy3U6QIxj4nGb7YIBe/HEIXeOgvT9NZ/n7BRrrSAv19XXFH4OzqVWX+meaVfNi0ZFjDqiteW2+8AA=
X-Received: by 2002:a17:906:49a:: with SMTP id f26mr3514106eja.15.1549991257931;
 Tue, 12 Feb 2019 09:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20190211161754.23902-1-nava.manne@xilinx.com> <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
In-Reply-To: <CAAtXAHfXaerVYzfdnA_09rK5AgLVJAiRcE2KEqosfrMZBuO3xQ@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 12 Feb 2019 11:07:01 -0600
X-Gmail-Original-Message-ID: <CANk1AXTSE+JXn1rinhdxeuOHgFZKga6SvGvTcNwN1knSNxwjjQ@mail.gmail.com>
Message-ID: <CANk1AXTSE+JXn1rinhdxeuOHgFZKga6SvGvTcNwN1knSNxwjjQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajanv@xilinx.com>, Jolly Shah <jollys@xilinx.com>,
        linux-fpga@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 5:06 AM Moritz Fischer <moritz.fischer@ettus.com> wrote:

Hi Nava,

> > +       mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> > +                             &zynqmp_fpga_ops, priv);

Please use the new devm_fpga_mgr_create()

> > +       if (!mgr)
> > +               return -ENOMEM;
> > +
> > +       platform_set_drvdata(pdev, mgr);
> > +
> > +       err = fpga_mgr_register(mgr);
> vs here.
> > +       if (err) {
> > +               dev_err(dev, "unable to register FPGA manager");
> > +               fpga_mgr_free(mgr);

With devm_fpga_mgr_create(), this fpga_mgr_free() can go away.

> > +               return err;
> > +       }
> > +
> > +       return 0;

Thanks,
Alan
