Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DAA7DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863DD208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHsLXVn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863DD208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933395AbeFLK3y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:29:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46686 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeFLK3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:29:52 -0400
Received: by mail-io0-f195.google.com with SMTP id d22-v6so27394377iof.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QJHgqkFvLTsM8STc/8YPQoKD29IzA3g5gEvJetaqwOc=;
        b=kHsLXVn//mvh0vWOyQ0e45u4z7HrmYFSC6Y6AvEQ952UsgorYzcL40ERqGsYtDsS+B
         jlDmR/BzM173tMgeVViKissUV6rQsX6lrLkFm5rLsmfUXosy5s/hd4+Wjdofc20qaG1f
         jaL2Fo5djYNthWh1qwwdZzHDkP8m4qfBA5obI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QJHgqkFvLTsM8STc/8YPQoKD29IzA3g5gEvJetaqwOc=;
        b=tq8IbM4CNyaF9Slc/r7JLXy+cIGgr7ZdyWLPupzGK0NJOy8Pn+6vzTdIUk+bZplly7
         nRs0dlvppnjkEmoY6eulWH1g5VzUwohXKdZ5B1y2zT1p3QFsjIqtlbveJTkXBgVv0zjI
         cX1vDJaRCulCV6XjmkMpfAOHMUl4oXcbVNVjMlv+zVsH6t3MF07NB8s9NWDiB3sqJ8Om
         OI08gSdpIli3S6c/swsbckzq9ZMVtckPEZ9jS6m2TOyC4dedQ9peXietf4E7/1KMW8bh
         zd/yJ3R4hOqJnfei9KXKhd2QAFCY8sdMqzI90Hq2YB9I25uxGmpsdtgBYFrMztz+Ew70
         zmGg==
X-Gm-Message-State: APt69E3mjfTAT43Sb055aH4PapSxQyvW4jsZ4wHEHT+fz5djIi6FUNB2
        sBU5etv3nfJzvn2TLdxLb669+zE0dlXQ7Y9f32YLGg==
X-Google-Smtp-Source: ADUXVKKebfCZ9uZogQR0ccpCSz/iL7ymuL097a2BBQPgQPSABdW+bxRanxptTsM6CM276tJJ4CKaBAqHVi4Lm+gtWKc=
X-Received: by 2002:a6b:1410:: with SMTP id 16-v6mr2658318iou.218.1528799391442;
 Tue, 12 Jun 2018 03:29:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 03:29:50
 -0700 (PDT)
In-Reply-To: <20180612084234.gjzq66xsqblryrkm@shbuild888>
References: <20180608095154.22413-1-feng.tang@intel.com> <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
 <20180612084234.gjzq66xsqblryrkm@shbuild888>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jun 2018 12:29:50 +0200
Message-ID: <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
To:     Feng Tang <feng.tang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 10:42, Feng Tang <feng.tang@intel.com> wrote:
> Hi Ulf,
>
> Thanks for the review.
>
> On Tue, Jun 12, 2018 at 08:25:44AM +0200, Ulf Hansson wrote:
>> On 8 June 2018 at 11:51, Feng Tang <feng.tang@intel.com> wrote:
>> > When doing some boot time optimization for an eMMC rootfs NUCs,
>> > we found the rootfs may spend around 100 microseconds waiting
>> > for eMMC card to be initialized, then the rootfs could be
>> > mounted.
>> >         [    1.216561] Waiting for root device /dev/mmcblk1p1...
>> >         [    1.289262] mmc1: new HS400 MMC card at address 0001
>> >         [    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
>> >         [    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
>> >         [    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
>> >         [    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
>> >         [    1.292798]  mmcblk1: p1 p2 p3
>> >         [    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
>> >         [    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities
>> >
>> > And this is a common problem for smartphones, tablets, embedded
>> > devices and automotive products. This patch will make the eMMC/SD
>> > card  start initializing earlier, by changing its order in drivers/Makefile.
>> >
>> > On our platform, the waiting for eMMC card is almost eliminated with the patch,
>> > which is critical to boot time.
>>
>> I am wondering what kernel version you are running here. There have
>> been some changes to the mmc initialization path, which perhaps can
>> help.
> These logs in commit msg are based on kernel 4.14, and the patch is generated
> against kernel 4.17.

Right. So it's quite recent, even if lot's of changes have been made
to the mmc core since then.

A few things (old/new) that is important.
1) Check if your mmc host driver support MMC_CAP_WAIT_WHILE_BUSY. That
should have some effect, avoiding unnecessary polling.

2) Since 4.18 rc1, you will be able to configure an over estimated
"power on" delay (via DT as well). Look at commit
6d796c68cd15234a33a4bd2ef7231125fea2dc6c.

3) If you use a DT based platform, I think what people do is to
re-organize the order of device nodes, such that as many as possible
-EPROBE_DEFER is avoided to be returned by drivers. This is also not a
good solution, but the best we have at this moment.

>
>>
>> >
>> > Signed-off-by: Feng Tang <feng.tang@intel.com>
>> > ---
>> >  drivers/Makefile | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/Makefile b/drivers/Makefile
>> > index 24cd47014657..c473afd3c688 100644
>> > --- a/drivers/Makefile
>> > +++ b/drivers/Makefile
>> > @@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)               += regulator/
>> >  # reset controllers early, since gpu drivers might rely on them to initialize
>> >  obj-$(CONFIG_RESET_CONTROLLER) += reset/
>> >
>> > +# put mmc early as many morden devices use emm/sd card as rootfs storage
>> > +obj-y                          += mmc/
>> > +
>>
>> Your suggested approach isn't really a solution, as it may work for
>> your particular case but not for everybody else.
>
> Do you mean the patch may break some platforms? Yes, I only tested on
> some IA based NUCs, and I did think about other architectures, things
> that may affect MMC are gpio/clk/pinctrl, and those are still earlier
> than mmc after change.

I don't know if it breaks things, potentially it could, if drivers
don't implement support for -EPROBE_DEFER properly.

However, more importantly, it's not real fix to the problem, just
something that seems to work for you.

Kind regards
Uffe
