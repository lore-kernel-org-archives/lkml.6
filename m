Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DEDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A15721571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pvsv1txO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A15721571
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeI0VkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:40:03 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41772 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0VkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:40:03 -0400
Received: by mail-vk1-f195.google.com with SMTP id j14-v6so674321vke.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=si9pxhw5KruNhYwgMx5FX+vsyfkmm9WWF9lrLjFqAME=;
        b=Pvsv1txOPw9Djm+RGylWq2Qprpu9Tcz89T/GKGLrksGp/akt98fVx3WHYTxPetR0IM
         qHj1F46Z12boJPO4DIpXDVZWwAukb9Qmzmi4448ujZS/Emcai+6diBHFpWqMPAHpccMu
         b1kYUawQV1pDafzQW4zSeE5CZbzozaagyS4w+TxlD9X1enqWyR7bK9otU3rUrlMp0im2
         Sgl4WDMOuR7tkYZgFHuj6X77CaXtyZXeMLBhGdy7+g35wiV3GetWZ1uBh8YXPNBELf1x
         kSIX28avUpBATwzSrWeF3h1cDKFwgYEdozGE5y8CxpCPBsGZTUhL7EWTVFwLmV7p2JXs
         js4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=si9pxhw5KruNhYwgMx5FX+vsyfkmm9WWF9lrLjFqAME=;
        b=CdkpIwJ+9AhAIEVU8CvUu3wkxeriFTtHlT75VSUKz+ydwpgIhVv3AWqv0cB3rJOTrZ
         RvWmjWSAXA9QHaC95h3qaRwmc+rUku2K278iE/wBU7+EM91QBDqSr2P/NXBXqyyp+8sZ
         +4BfzRC91KrqV+6Q0cu+fJP6EXf+BrsMuj1n2ty6H5PLuSdk4Ih2u5iZg6FtxA2fX3DK
         RQMx0UnYZac/C8Ak042rr04fvZDa/GHHP6g+WfzNJcLOwKU8rmSVC3RCBekXSM2txPB9
         8UFByIUJKhGRPu8bG57Akfbvtx7OXAOYGrQ36aDUgK+t05/REnF8snUi94t95SGLkIi1
         esTg==
X-Gm-Message-State: ABuFfoiXXKfCKJszHmlqDweg566vBPeo22C3jE7Hj64WUxSXLj007DPN
        w7IeEJ/qmbeVjFOdU1gUh6B7D4sTFMzsmvxL/6s4WA==
X-Google-Smtp-Source: ACcGV626Itv076D3Z9bJjiXNh+O2OsqBp4BPbX/l7eW+3rUUNhTG8PgtCN1B6a9At2ZUJOONqPqKqZQ9wcTfMWHMkVw=
X-Received: by 2002:a1f:9b52:: with SMTP id d79-v6mr3604210vke.79.1538061676759;
 Thu, 27 Sep 2018 08:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
 <1537887875-29494-3-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=VxLR6v3vyimjznrqa1Tj5rPziPQX7Pt+wJRR+xm1N-0A@mail.gmail.com> <e6f0c8c6-cd0f-33b9-30da-ab09953449ca@codeaurora.org>
In-Reply-To: <e6f0c8c6-cd0f-33b9-30da-ab09953449ca@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 27 Sep 2018 08:21:03 -0700
Message-ID: <CAD=FV=ULtdGkpRfmAZRbM0VQu6sJ37_bPBRHKFReK4X+jYjT_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
To:     vbadigan@codeaurora.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Sep 27, 2018 at 4:00 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Hi Doug,
>
>
> On 9/26/2018 3:58 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Sep 25, 2018 at 8:05 AM Veerabhadrarao Badiganti
> > <vbadigan@codeaurora.org> wrote:
> >> +       /*
> >> +        * Whenever core-clock is gated dynamically, it's needed to
> >> +        * re-initialize the DLL when the clock is ungated.
> >> +        */
> >> +       if (msm_host->restore_dll_cfg_needed && msm_host->clk_rate) {
> >> +               msm_host->restore_dll_cfg = true;
> >> +               mmc_retune_needed(host->mmc);
> > Using the boolean "restore_dll_cfg" to communicate like this seems
> > really fragile.  I have no basis in fact, but I worry that something
> > will happen in the meantime that really ought to invalidate the
> > "saved_tuning_phase" but the boolean will still be set.
> >
> > Is there a reason you can't just call msm_config_cm_dll_phase()
> > directly from sdhci_msm_runtime_resume()?  Perhaps after the
> > clk_bulk_prepare_enable() call below?
>
> I can do that.
>
> But we don't need to restore the clock phase for all speed modes since
> every mode
> doesn't use DLL. Only few speed modes (only SDR104 mode for SD card)
> would need to restore DLL setting. So I would need to do some extra checks
> for performing this operation for only required speed modes.
> And we should re-initialize the DLL first before programming the phase.
>
> I wanted to reuse the existing logic which does all these things. So did
> this way.

Personally I'd rather see the extra checks or even restore the DLL
settings some cases when it wasn't truly needed.

In theory, though, I'd expect that there's a hardware register
somewhere that says whether the DLL settings matter or not.  Can't you
just key off of that?  ...or if that register is also lost when the
clock turns off then whenever you change that register to turn the DLL
off then clear your saved phase?


-Doug
