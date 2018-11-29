Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692682081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SECyZyg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692682081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeK2VP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:15:27 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36997 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeK2VP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:15:26 -0500
Received: by mail-yb1-f195.google.com with SMTP id d18-v6so516658yba.4;
        Thu, 29 Nov 2018 02:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gr+ATf/O2khom4hddu5odHSvUoa8/KuFvkBwshtPzY=;
        b=SECyZyg3C5C0AyqcokL+DIM4VrR90v9T5jvzKmQRVho6K/ozO1JdsFQ60zOhhcA2kI
         VBYpqaotI4lXuD05Wy60txvo5XZXdIS6k03MePe6Gci0nOxgVrJtxXtjdge1UtPi8/VN
         AAjz8tP5YfdxrsL+FUIhJgjnMQnwNsXWm5qWzwaW1kIQ8YkBgXYtJC3bgeNTYv+zrtjO
         DuX5tTtN/+wIkmjyWfz/CykN3G7D47mHgHG/BLaUG/Wi+yqv3yBGtsk2+lOpRzvYhBwM
         SXRrRVj7/ZKe8YfYCvfyC4pChwGN3cx/hAPZm/AkkjFZujVUhaiZD8FW9egy/RkCouji
         P0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gr+ATf/O2khom4hddu5odHSvUoa8/KuFvkBwshtPzY=;
        b=toe7zpBRo1HkkT5SXHey0Kz0pfE3BjaKMtnDYqNGPu20gwxX+nnhRIKrRV+8Ja6wor
         TJUQ+Pq6Gt5Nm7PpHS9JS1wpSlQGKWTO1lf+LDo4qSWnjJf+LD4/ugrhswlYuSq9dBeS
         xoOCWqHwpKPZ3a11vHojZSA7LrHR37ueElECb+V11uwtTapYtZ6KHOG71/Gk9ygvSx3e
         ySJHoa81IR8Oqnr5SNIssplUxgAreg0euPNP8VuuxA7hKtfMULppLA27qHVWPP3Io65R
         L2nhdW7P0g/+s7Hdr4KekkJ0GavXIANiIwDTjCwau2G/OmehEsfpeKF0zL9c7pi/zKgj
         6zaw==
X-Gm-Message-State: AA+aEWYRPHx1yoxZMTCB/wTfLd+k0yiEuq/UoFyxVVp933AmEk17J2eK
        ZDueCLFZ6loujG3MHvTAh7JytfVW4OHYLIQUbX4=
X-Google-Smtp-Source: AFSGD/WQPP5P3lxJjjCtgW3X04e5FiM1lBWR4mnXfb7/yFSfV3J7u+I42XO+fHHD58qW5DcvRBUEndJSeVgZ5Mttcvs=
X-Received: by 2002:a5b:d06:: with SMTP id y6-v6mr623868ybp.147.1543486236407;
 Thu, 29 Nov 2018 02:10:36 -0800 (PST)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
 <1538332682-12018-5-git-send-email-andy.gross@linaro.org> <CAK8P3a3SVftnc83sxe1NCsLbu23Buc+SHOpn9JUQJCZ=MXDuJw@mail.gmail.com>
In-Reply-To: <CAK8P3a3SVftnc83sxe1NCsLbu23Buc+SHOpn9JUQJCZ=MXDuJw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 29 Nov 2018 11:10:25 +0100
Message-ID: <CAJiuCcf0S97GoPt_p1R8F=35BJPw=mv=BExkLyt2CDcqs7_vLA@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Device Tree updates for 4.20
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     andy.gross@linaro.org, arm@kernel.org, khilman@baylibre.com,
        olof@lixom.net, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        bjorn.andersson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Arnd,

On Tue, 2 Oct 2018 at 11:38, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Sep 30, 2018 at 8:38 PM Andy Gross <andy.gross@linaro.org> wrote:
> >
> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> >
> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.20
> >
> > for you to fetch changes up to ca02f96b95ca1a50344e7e2a7bb43fbb825aa3a2:
> >
> >   ARM: dts: qcom: Update coresight bindings for hardware ports (2018-09-30 13:14:05 -0500)
> >
> > ----------------------------------------------------------------
> > Qualcomm Device Tree Changes for v4.20
> >
> > * Fix IRQ constants usage on MSM8974
> > * Add led, gpio-button, sdcc, and pcie nodes for IPQ8064
> > * Move/cleanup common nodes for IPQ8064
> > * Add i2c sensor nodes for MSM8974 Hammerhead
> > * Fixes for SAW, kpss, opp, pci range, and space/tab on IPQ4019
> > * Update coresight bindings
>
> Some of the ipq4019 changes look like important fixes, should
> they be applied for linux-4.19 and possibly backported to stable?

Just want to point that it has not been backported to 4.19 is it expected ?

Thanks,
Clement

> If so, please submit them again for the fixes branch.
>
> I also get this one warning (both with and without your patches):
>
> arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning
> (graph_endpoint): /soc/mdp@5100000/ports/port@3/endpoint: graph
> connection to node '/soc/hdmi-tx@4a00000/ports/port@0/endpoint' is not
> bidirectional
>
> Can you have a look and see if it can be fixed in a follow-up?
>
> I pulled this version into next/dt for now, thanks!
>
>       Arnd
