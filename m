Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22638C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF20720865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+FOcEL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF20720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeJMJlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeJMJlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:41:42 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E052147C
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 02:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539396388;
        bh=jSkH6NrvNPm8NBThAUsEzAceeHM+wsp9wwa97kzXUKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a+FOcEL1/KmQ65+S86P/+13kbtalc2jIpIR0Yl3olQzjEMzZLiQGqkm6htxNYKu+t
         YZglBZjL9iEDjx9r1+f/RT4QOqHGipVDlL/v7dxiCkm+yG+4baQpRJTXUfZfhCWSvC
         3FqzO6oxrEQe7Zokwp0i6fa6ensAdYWk7PohV6MU=
Received: by mail-ed1-f49.google.com with SMTP id y20-v6so13046241eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 19:06:28 -0700 (PDT)
X-Gm-Message-State: ABuFfoivMij0kavZtQ3qdhLCIZR/9XSF/7Ds5qrRx1pVXNfj78k8MpGu
        Hek1P8IS0NY000/tKIefJBe9nsDyOe38OLGL3jw=
X-Google-Smtp-Source: ACcGV63C0YIeF6h6cy66vhIfIrnP8X07NnX2GhNcWa7oofsd16/iRTlyUcLGVEKRnnM+Al6rD+BkbEXgFICVn0+sSm4=
X-Received: by 2002:a17:906:32d9:: with SMTP id k25-v6mr9633390ejk.211.1539396386586;
 Fri, 12 Oct 2018 19:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <1539363052-6143-1-git-send-email-thor.thayer@linux.intel.com>
 <20181012165741.GA12446@kroah.com> <295a966d-5f48-9313-7dc6-47ea49d05a27@linux.intel.com>
 <15E5F4404EBD914E8BCA1FCC37E0A56A189C429C@fmsmsx122.amr.corp.intel.com>
In-Reply-To: <15E5F4404EBD914E8BCA1FCC37E0A56A189C429C@fmsmsx122.amr.corp.intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Fri, 12 Oct 2018 21:05:51 -0500
X-Gmail-Original-Message-ID: <CANk1AXTxm=r6Rg0TAnLA3D4pdTL7VdsgorEDK6GB3ZQhqCS+kg@mail.gmail.com>
Message-ID: <CANk1AXTxm=r6Rg0TAnLA3D4pdTL7VdsgorEDK6GB3ZQhqCS+kg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Replace Vince Bridgers as Altera TSE maintainer
To:     vince.bridgers@intel.com
Cc:     thor.thayer@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        geert+renesas@glider.be, jhogan@kernel.org, bhelgaas@google.com,
        james.hartley@sondrel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Vandervennet, Yves" <yves.vandervennet@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 8:12 PM Bridgers, Vince
<vince.bridgers@intel.com> wrote:
>
>
>
> -----Original Message-----
> From: Thor Thayer <thor.thayer@linux.intel.com>
> Sent: Friday, October 12, 2018 3:49 PM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: geert+renesas@glider.be; jhogan@kernel.org; atull@kernel.org; bhelgaas@google.com; james.hartley@sondrel.com; linux-kernel@vger.kernel.org; Bridgers, Vince <vince.bridgers@intel.com>
> Subject: Re: [PATCH] MAINTAINERS: Replace Vince Bridgers as Altera TSE maintainer
>
> On 10/12/2018 11:57 AM, Greg KH wrote:
> > On Fri, Oct 12, 2018 at 11:50:52AM -0500, thor.thayer@linux.intel.com wrote:
> >> From: Thor Thayer <thor.thayer@linux.intel.com>
> >>
> >> Vince has moved to a different role. Replace him as Altera TSE
> >> maintainer.
> >>
> >> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> >
> > Would be nice if Vince can ack this...
> >
> + Vince (at a new email address)
>
> Thanks Thor,
>
> Acked-by: Vince Bridgers <vince.bridgers@intel.com>

Acked-by:Alan Tull <atull@kernel.org>

Alan
