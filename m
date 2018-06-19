Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D67C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA32083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tOpTCz8F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kcnWj7vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFA32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030476AbeFSVjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:39:05 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37028 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937661AbeFSVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:39:00 -0400
Received: by mail-vk0-f65.google.com with SMTP id w8-v6so734351vkh.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CCHNX741+saiQLsyIU9KzmY+5ev+1EhGixPLm6eQfL8=;
        b=tOpTCz8FHkOMkm68P7m2bp/UU8CN8z5o/dMGUcsbgy5MAIlueYgtHc3n4TxuIpJjit
         XTeleDnQLBmNMYcQiED1Fv8ncHM0vmH/hBXXiBA5nbK2DTOCSCG0mD7/uMWICxInqZuS
         XY6Ab/4sR3H0bAcoaOMFyrYoQ0RQsOy322XT7Vx4uQkaWbQLsj5oaSR5xQv7xLnFw1XT
         ETQ/cKIIVLvauvI7FL2HGVViII8Oi4FldiZruuR3cafDZ1/oWcsETUmM8ZqhObuESoTe
         kiuVByFayF00tUSRLPBLYtoMX/7lf0UfDznP/ltiXqsIPygeiFa5sFscEajZrzTGyv8L
         TQVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CCHNX741+saiQLsyIU9KzmY+5ev+1EhGixPLm6eQfL8=;
        b=kcnWj7vr76aaapdqgeS8DX9UsNsMmLsI4YMywVKDpOD8MHws9goE9l79ldMFVhkFa6
         19CTxWHlMDEAVm6eHm/BG3D3bwizP5PhqGNuFc0DKwnFt9huBqhrqq8QUpOXptJEdwQR
         UZRacwWnpjRfWXaLCwjALHDOkFLYjtKjW7IIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CCHNX741+saiQLsyIU9KzmY+5ev+1EhGixPLm6eQfL8=;
        b=DMcIc98C/UK2aHR6Ca6ZfQcBMUo4gamVzNIsjFBWnQ4DqlyT6XzaLdq4NEkBi7avy4
         c1x83fGGNJCO89qEuTpkN8qMdsTS9TJSR4mG8YLAljqtR9ro8tQ0+risuyuXhuzPxoh7
         bpkjk3TAFW7vR1Sk6otiu7d1FoTGkSTqeDh19qQAsj2eRVu1mhyn0HH5Q9E3IRwuF7F6
         vP8toVtq9Bhnjv7W1zQFysxOuBpJERL1yLuH0fsF50FEGUovoVRRwhQ13Jy2XZDQSWCO
         uajH58t8/uiux3b/eHOSfCkcSWbK512bJwCwGG5iFg5D5JbdG/34MXtV5HNTLyaZv3Eb
         ogOg==
X-Gm-Message-State: APt69E0oRvJsxM7W4I2j3Mkn76cUxvqTHL3DvmuzvaqWPmhl1XALoNFA
        JXqli6tGp8TTOw9zxLXuCxPferbZbBZDa7ZO8zkvzxmahEM=
X-Google-Smtp-Source: ADUXVKLP7pShquZlOHOtQ5FY7K3Vd2pBqqGxSRkHpf3+onOdRhdaZjUifwOJGIOkJ4EEjaiHAgCaVQmc5NyHGN0jvA0=
X-Received: by 2002:a1f:cd03:: with SMTP id d3-v6mr10761224vkg.101.1529444338224;
 Tue, 19 Jun 2018 14:38:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 14:38:57
 -0700 (PDT)
In-Reply-To: <152944311714.16708.13638961630238512631@swboyd.mtv.corp.google.com>
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-3-swboyd@chromium.org>
 <CAD=FV=VpFR4hpREnWpvG2MQAONheKtNfLkyNM8-AFXMcGD7OPQ@mail.gmail.com> <152944311714.16708.13638961630238512631@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Jun 2018 14:38:57 -0700
X-Google-Sender-Auth: D74xia_HXVnF5KPMftfS5Xs5hWE
Message-ID: <CAD=FV=VjqvPQA5jTUyiMzmetk2br-4fiPQdM4cVzb6ivWcta9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 19, 2018 at 2:18 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Doug Anderson (2018-06-18 16:54:49)
>> Hi,
>>
>> On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wrote:
>> > We rely on devices to use pinmuxing configurations in DT to select the
>> > GPIO function (function 0) if they're going to use the gpio in GPIO
>> > mode. Let's simplify things for driver authors by implementing
>> > gpio_request_enable() for this pinctrl driver to mux out the GPIO
>> > function when the gpio is use from gpiolib.
>> >
>> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> > Cc: Doug Anderson <dianders@chromium.org>
>> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> > ---
>> >  drivers/pinctrl/qcom/pinctrl-msm.c | 16 ++++++++++++++++
>> >  1 file changed, 16 insertions(+)
>> >
>> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> > index 3563c4394837..eacfc5b85f7f 100644
>> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> > @@ -176,11 +176,27 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
>> >         return 0;
>> >  }
>> >
>> > +static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
>> > +                                  struct pinctrl_gpio_range *range,
>> > +                                  unsigned offset)
>> > +{
>> > +       struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>> > +       const struct msm_pingroup *g = &pctrl->soc->groups[offset];
>> > +
>> > +       /* No funcs? Probably ACPI so can't do anything here */
>> > +       if (!g->nfuncs)
>> > +               return 0;
>>
>> Is there a reason why you'd want to return 0 instead of some sort of
>> error code?  Wouldn't you want to know that this pin can't be a GPIO?
>
> On ACPI there aren't any functions and thus all pins are GPIO mode and
> only GPIO mode if they're used as GPIOs. At least that's my
> understanding of how the ACPI version of this driver works.

OK.  I have no understanding of how the ACPI version of this driver
works, so your understanding is much more likely to be right than
mine.  I guess this is just "pinctrl-qdf2xxx.c"?


>> Another non-ACPI example is sdc2 on sdm845 and it seems like you'd
>> want to know if someone tried to set one of those as a GPIO.
>>
>> ...oh, but I guess ufs_reset also has no funcs but it still probably
>> wants to use the GPIO framework to write something.  Hrmmm...  Maybe
>> check if either in_bit or out_bit is not -1?
>
> ufs_reset and sdc2 aren't in the GPIO chip's numberspace so I don't
> think we need to care? At least I can't convince myself that those pins
> would eventually call into the this function. We could check if offset
> is greater than ngpios for the chip but that seems useless if higher
> layers are handling this already.

Ah, I see what you mean.  These pins do have numbers in the code:

PINCTRL_PIN(150, "SDC2_CLK"),
PINCTRL_PIN(151, "SDC2_CMD"),
PINCTRL_PIN(152, "SDC2_DATA"),
PINCTRL_PIN(153, "UFS_RESET"),

...but those are effectively made up numbers and they are all past the
"ngpios" (150).  ...and the higher level code seems to be already
checking that.


OK, thought I've already proven my cluelessness about this driver,
FWIW this patch makes sense to me now so FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
