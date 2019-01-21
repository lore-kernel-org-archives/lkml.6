Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE81C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7A21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VafRxOSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfAUVho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:37:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40884 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfAUVho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:37:44 -0500
Received: by mail-io1-f67.google.com with SMTP id k2so17494715iog.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 13:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hsPLb+YVxxq1iAPjhdrsVW0TYSbk8tR9OwWdd6vyzE=;
        b=VafRxOSpCYUSBK7FET5zdnwyCl/ozjapVhWrY2P+i1eQJchzbea9mwTb5G5WBTKBjz
         rrgKscDG8lEqO2hPOouoq777O/+ofIMzpm56Ot/peyyc0xR//f3+IZreLvNb9id6Wmuq
         7GW58hspu4k6od70xVdy35jTkoQlSdOJyF3lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hsPLb+YVxxq1iAPjhdrsVW0TYSbk8tR9OwWdd6vyzE=;
        b=DpEVcmfs3xOLBE56whferaDTZuCXG3w3exC5+4iGwgfAZ0JA4xIKjnGZZAdGFtkKb8
         Tvg0wG7+UlSUtEVxtEpnGupBIeFK+GC0Ssa44+TIxiSUh61fOw4KaXWjS0+hX3u2QTpS
         WdrGZ8J7DAurfI7q16mNaTBEijmWlveVZ4eDBvZKRKzc9tvLZjEzqkFsMUjJ7hilde15
         HDn9Dqt7gOHEdb4HXbzmdI/IqohD2D0pbHNm8ZRfbEcVgGNwcyWtvummm+WhWTWPTQts
         rEUhWiU5rbjQE2iVxA8dVv8uW2wAjk4BPQh9hyNhDQvDnYaKiOoxMCiAbbPEHjXyiJXr
         A/IQ==
X-Gm-Message-State: AJcUukebnnRe7BgLZSxYaxk2My3YdtnMrtMAmm+H9E62dqLEmEhHRyUR
        mbDaHj+NXysbIDSXv+1LnQs9nGdCTSQOD65QBJbncazhvbE=
X-Google-Smtp-Source: ALg8bN4a5xfHBNLlF9UDwiMCQBHS8irpSBxYfKNdlG1HNBebRO4B3EVu2zVZmUXDe/kzQyizUkAfJXwChn0xSCtIhKA=
X-Received: by 2002:a5d:9459:: with SMTP id x25mr6434890ior.293.1548106663208;
 Mon, 21 Jan 2019 13:37:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <d52546764f8570e8c07ac8e3e2841e087e66648c.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <cc71cfa9-8a11-9356-ac41-e27564a9f7b4@codeaurora.org> <20190121184831.GB14049@xps15>
In-Reply-To: <20190121184831.GB14049@xps15>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 21 Jan 2019 14:37:32 -0700
Message-ID: <CANLsYkw5h+-fWhiit+kNJHnGPF__Bz1MHc94sG=WOyfTPHi_NQ@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] coresight: etm4x: Add support to enable ETMv4.2
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 11:48, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Mon, Jan 21, 2019 at 04:18:36PM +0530, Vivek Gautam wrote:
> >
> > On 1/18/2019 5:52 PM, Sai Prakash Ranjan wrote:
> > > SDM845 has ETMv4.2 and can use the existing etm4x driver.
> > > But the current etm driver checks only for ETMv4.0 and
> > > errors out for other etm4x versions. This patch adds this
> > > missing support to enable SoC's with ETMv4x to use same
> > > driver by checking only the ETM architecture major version
> > > number.
> > >
> > > Without this change, we get below error during etm probe:
> > >
> > > / # dmesg | grep etm
> > > [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
> > > [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
> > > [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
> > > [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
> > > [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
> > > [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
> > > [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
> > > [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
> > >
> > > With this change, etm probe is successful:
> > >
> > > / # dmesg | grep coresight
> > > [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
> > > [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
> > > [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
> > > [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
> > > [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
> > > [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
> > > [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
> > > [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
> > >
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
> > >   drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> > > index 53e2fb6e86f6..93d5f1f3145e 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> > > @@ -55,7 +55,7 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
> > >   static bool etm4_arch_supported(u8 arch)
> > >   {
> > > -   switch (arch) {
> > > +   switch (arch >> 4) {
> >
> >
> > While this looks good, from what it looks like arch is a combination of
> > major version
> > minor version. So, will it be better to masks, and shifts macros instead of
> > a magic
> > number shift.
> > But, frankly it's upto Mathieu to decide the readability of this. So, I
> > leave it to him.
>
> The layout of the architecture is already well defined in etm4_init_arch_data()
> [1].  As such just doing the following would be fine with me:
>
>         /* Mask out the minor version nuber */
>         switch (arch & 0xf) {

s/0xf/0xf0

Apologies for the confusion.

>
> Of course by proceeding this way we don't need to modify the define in
> coresight-etm4x.h.
>
> Regards,
> Mathieu
>
> [1]. https://elixir.bootlin.com/linux/latest/source/drivers/hwtracing/coresight/coresight-etm4x.c#L508
>
> >
> > Thanks
> > Vivek
> >
> > >     case ETM_ARCH_V4:
> > >             break;
> > >     default:
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> > > index 52786e9d8926..05d4bd330881 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > > @@ -136,7 +136,7 @@
> > >   #define ETM_MAX_RES_SEL                   16
> > >   #define ETM_MAX_SS_CMP                    8
> > > -#define ETM_ARCH_V4                        0x40
> > > +#define ETM_ARCH_V4                        0x4
> > >   #define ETMv4_SYNC_MASK                   0x1F
> > >   #define ETM_CYC_THRESHOLD_MASK            0xFFF
> > >   #define ETM_CYC_THRESHOLD_DEFAULT       0x100
