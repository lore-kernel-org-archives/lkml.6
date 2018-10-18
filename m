Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C3FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F15A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F15A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeJRSva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:51:30 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52162 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJRSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:51:29 -0400
Received: by mail-wm1-f52.google.com with SMTP id 143-v6so4929183wmf.1;
        Thu, 18 Oct 2018 03:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaEGCjC741drT6eSjbQcIs4RFXQBSjUHB2s3HvHGdqU=;
        b=oe3nt0AvdgeT9ONM2LwFJpv18wfJrbmq6j/62KtdAbOI+V+qak5+Mm+IBUWK5mSm0S
         lbZ83UyybFlA8cR+dhr88D+huGquv0FCy3nwLcVkIaOcWS0fFr3kXLLQnFdY1F1qqL3j
         aFGHkXRbhVS2zMtoPU1zrZU3B4EzmrFshP1BUuEcctpdgq2GrrDhTpHiZxAcBj22XKsR
         0WZNTOkWZIg4EDNtufncsch2MNnAzgAcR1eASDw7EWxia8hqFUnmbrzcxraoQd8fybuu
         ANXPFPMIFCLFFse24643SX/C6Fw3VX+LPhQ9jumVljiwBcXPfdBLx0BsH95vsozMf/LF
         I6DQ==
X-Gm-Message-State: ABuFfohyDSjhBMJNGWk2u/BvceUpTOKF4r/hZ0hJ2vGnYvytEENyPxb9
        yY1IEEmzPAo82DWhMepDGQ+Ra1jLiID35ndobVWGz+dS
X-Google-Smtp-Source: ACcGV60qRmONrSMN4JjheqhhcQfgXm+nJTIv10mziOQwnVdLJBU2TqMJc0uGhb/dnHIgy6Z+PUOxvxddG9Gf9kl4PU8=
X-Received: by 2002:a1c:e4c6:: with SMTP id b189-v6mr6904377wmh.114.1539859862771;
 Thu, 18 Oct 2018 03:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
 <33FDF48F-4B64-4CE4-BC95-43BAB70B6C37@goldelico.com> <7a765a99-f273-e92c-1437-f3e5535fbaaf@ti.com>
In-Reply-To: <7a765a99-f273-e92c-1437-f3e5535fbaaf@ti.com>
From:   Felipe Balbi <balbi@kernel.org>
Date:   Thu, 18 Oct 2018 13:50:51 +0300
Message-ID: <CAH8TKc-0wDXg4VaOho3_uat3JGQSGa=dQyMu7fJEwi6Tce2Z3g@mail.gmail.com>
Subject: Re: omap5: dwc3 interface status in /sys
To:     Roger Quadros <rogerq@ti.com>
Cc:     hns@goldelico.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        kernel@pyra-handheld.com, letux-kernel@openphoenux.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 16, 2018 at 1:27 PM Roger Quadros <rogerq@ti.com> wrote:
>
> Felipe,
>
> On 16/10/2018 12:29, H. Nikolaus Schaller wrote:
> > Hi,
> >
> >> Am 17.09.2018 um 10:24 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> >>
> >> Hi Felipe,
> >> I have made otg mode work on the omap5-uevm with help from Roger
> >> and now I wonder how to read the interface status for GUI display.
> >>
> >> On omap3/twl4030 systems we can simply read
> >>
> >>      /sys/bus/platform/devices/musb-hdrc.0.auto/mode
> >>
> >> and get reports e.g. "b_peripheral", "a_host", "b_idle" etc. which can easily
> >> be translated into icons for GUI display.
> >>
> >> We have not found a similar attribute for dwc3 (except part of this information
> >> in
> >>
> >>      /sys/kernel/debug/4a030000.dwc3
> >>
> >> but mounting debugfs for GUI purposes isn't a good idea).
> >>
> >> So do you think it is possible to provide such information to
> >>
> >>      /sys/devices/platform/44000000.ocp/4a020000.omap_dwc3/4a030000.dwc3?
> >
> > any suggestions?
>
> This question is not specific to omap5.
> What is your opinion? If you think it is OK, I can provide a patch for it.

sounds like this should be part of DRD/OTG core, no?

cheers
