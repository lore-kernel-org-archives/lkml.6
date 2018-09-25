Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3568EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07D021480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiMuyL9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07D021480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeIZAIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:08:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeIZAIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:08:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so14646837wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GunG/pt/t6QEZpuwmdlsezZ8Y/yBcR5pleFloeSDlIo=;
        b=aiMuyL9AXbY4xY5/DX5cQIiJRSL4LbfgQm2gbGPEP+zt++aYSLThp0RDTb6B/t4So9
         HnWz3vi3G94qjyONgmhN/baAT/BAiY4qO1C1Ma+DJcVgYudXkoYUTYLuvL8gJWzLYkhb
         DF9/iQI+TD2+OwG1CVKQ+2yB0omYaNH3j9V6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GunG/pt/t6QEZpuwmdlsezZ8Y/yBcR5pleFloeSDlIo=;
        b=ZGzkJm9Si6qjv7FUbqHnf0u53wdHLva04w+myQXcUcVdQZpQleojKFqAp1daLOBReS
         5OuHUIxoF1zdGOlApW955418kCp3TRhV0pCWSwFFmuCD/FSr5G2VcMcAmh9UhMY0Rvjm
         4GI7GJxpiu/QskpbedP7nmt6WsV7ZJsS2TqLFZqLuyVBA8epnnD7sN+r1p3irttMYMUt
         m99QrHshKjpE+F1xMqF6BvtG3xEtJzPkZKzINfaxFePzKH+5XEPstnkT4EP7lP7f6fCW
         fsi+hXusTB/qyB5B1LiPopWSrifDa/Ky5lIbrfY1iYSDaA2MFvA8jU8gTN5GAKUenArh
         l2kw==
X-Gm-Message-State: ABuFfojfNoiUPaPWLuv9j7/KgZwT6T99nvDwBl1FG7Hag0fxC0cx16sa
        LXd5+C+VrBKV4frIzKp7Gi/uKKBjOB2UgdN893mcAQ==
X-Google-Smtp-Source: ACcGV63BDOhHBG71RJiibN4eC/UMWmPeoXRVopn0sr06eKKYjzfrqD4zU7b7ABxOHr2KKjKIAl+DkE4Tm6aM5lzLHzg=
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr1660334wmb.19.1537898379959;
 Tue, 25 Sep 2018 10:59:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 10:59:38
 -0700 (PDT)
In-Reply-To: <3AD91E696667BF4BA728303C178E8A63532AB5E5@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
 <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
 <CALAqxLXy0YXNLwFQEUZxSsjFKC9boVcGkt+50XwmVfwKCcqsEw@mail.gmail.com> <3AD91E696667BF4BA728303C178E8A63532AB5E5@am04wembxb.internal.synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 25 Sep 2018 10:59:38 -0700
Message-ID: <CALAqxLW=jT+oUASGKxcFghfHZEU7LtFJBiBBkmMM1oarKjSBKw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down feature
To:     Artur Petrosyan <arthur.petrosyan@synopsys.com>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 3:04 AM, Artur Petrosyan
<arthur.petrosyan@synopsys.com> wrote:
> Just a clarification by this commit "[PATCH] usb: dwc2: Fix HiKey
> regression caused by power_down feature"
> https://marc.info/?l=linux-usb&m=152669095513248&w=2
>
> the power_down is disabled setting "p->power_down = false;" in
> "dwc2_set_his_params" function.
>
> Could you please clarify that the testes done for those 3 patches were
> done enabling "p->power_down = true;" in "dwc2_set_his_params" function.

So if I remove the "power_down = true" initialization, USB does not
seem to function.

If I boot w/ the gadget port removed, the USB host ports do work, but
plugging in the gadget cable results in a bunch of:
   dwc2 f72c0000.usb: Waiting for Host Mode, Mode=Peripheral
messages.

If I boot w/ the gadget port plugged in, USB gadget mode doesn't seem
to function at all, and when I remove the gadget cable nothing
happens, it doesn't switch to host mode.

thanks
-john
