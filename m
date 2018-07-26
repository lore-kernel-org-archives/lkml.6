Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887F1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E2206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gmkmeryE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRlQn2H2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412E2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeGZV3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:29:40 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33566 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbeGZV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:29:39 -0400
Received: by mail-ua0-f195.google.com with SMTP id i4-v6so1923649uak.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CCDdoDPiIf1rjjGOpcLo14Fu2KiK4Jt6zjEYVbtWCFA=;
        b=gmkmeryEGFbtH63LQ8RqD0H5+MW4RO91eG80FpUeSiJl5//9jK7FTfzQ2d+1/ratDd
         8ZHayfjxmKPV9mvYCZvgWYFhv1Cor4NBbL70YcbOcZfgDeJUfWnlAJiQfzgER7ntKub6
         E+Lh4ZkAalkbulLABISu5CAke1JH2y0trHsvnCFoXqAxID4LaTUdWZVQr+SLaMm36cHU
         78Ts1d5fPvsd5P4JAeou99dfdS1HLLAwfDwrClKANQMN4EEQpoOHTkWUTpDJbkvw4VtO
         RoWCB1m0DKBUsOftZfhE0RxfWq/0tk1rt4vzkCwDExy0iJmKyeNgJH6s3QZsfMNFGuxD
         qsmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CCDdoDPiIf1rjjGOpcLo14Fu2KiK4Jt6zjEYVbtWCFA=;
        b=VRlQn2H2Hlm55ijyub4SK0uWxbZVW7qVvmCOr5rM9sXdjPgyjikNRFyLuAkjkkvF1L
         UMNsZkBMNApSWxc7Ew9m76BX8/HbDx/Wey/koxH9EpMHm8q1LOwMA+ZhILEfQl0h2VuN
         Nz/vq/WxWwjGtW+2O2GTBlS9C3DuzzGaC8TAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CCDdoDPiIf1rjjGOpcLo14Fu2KiK4Jt6zjEYVbtWCFA=;
        b=rPmvFx9pgmBh2ON4d0RltXuVcBkLehY1v/hZON8BQBzfzKDrDu9snSZo5aMvwiKbip
         Z8e7J3wu/MFh1KSMDCswupAa2hT3/vbeqVFwlNtI4ofS6okKk/YWqrnuG0ygogjK6Jh0
         taiy0xYa9Lu349a2DPEEByIqzIetui7va7h87PfZh7Hu2ZqhHQRbx1F4G40tx8zUjLr8
         LrXl3gtZDCCtKN5cxwRjOHFjckywhKm2t7AjzkJ630QPGN7bGCKXxAFO1H+RBWgPIN+B
         FDGXm81foZk2upIOWFwZfYT50IQcP2d25PBBuEq+7fZEGLhjvKiJibkkRgOpfxc3efHZ
         QbDw==
X-Gm-Message-State: AOUpUlEapc7efvpDxDgfXmblhpJZ0XOUoKjtf57nN4Zkg1fPpNsylNU5
        JStsUxomk/vhqq6mAd+248416Lzw2lhY6YT2xONEpQ==
X-Google-Smtp-Source: AAOMgpeZEZimL4Mf01sz+vrku9FDnoYjlIMj21oXkvlowb1zNa64S/5Txl2VbhP6cuCv4rVg5PVM7LvWfV2loi/IaWY=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr2415399uac.191.1532635872217;
 Thu, 26 Jul 2018 13:11:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 13:11:11 -0700 (PDT)
In-Reply-To: <87o9eu1cup.fsf@linux.intel.com>
References: <20180706162154.196345-1-dianders@chromium.org> <87o9eu1cup.fsf@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Jul 2018 13:11:11 -0700
X-Google-Sender-Auth: bts8xwr8j819LetTErVe8Vk-UfI
Message-ID: <CAD=FV=WjMVhc=h+YJLmW6jQ0aS+qc1ZQU5DCx2F8B7hKc4v8ZA@mail.gmail.com>
Subject: Re: [RFT PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 26, 2018 at 3:59 AM, Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
> Douglas Anderson <dianders@chromium.org> writes:
>
>> While looking at a dwc2 recently, I noticed that some platforms still
>> have the uframe scheduler off.  As far as I know, nothing good can
>> come out of having the uframe scheduler off.  Let's turn it on
>> everywhere.  Assuming this all works out then some time in the future
>> we can gut all the old code that handles the old non-uframe scheduler
>> and make everything simpler.
>>
>> NOTE: I don't have access to any of the platforms that I'm changing
>> here, so I'm hoping to see a Tested-by from those on the list.
>>
>>
>> Douglas Anderson (4):
>>   usb: dwc2: Turn on uframe_sched on "bcm" platforms
>>   usb: dwc2: Turn on uframe_sched on "his" platforms
>>   usb: dwc2: Turn on uframe_sched on "amlogic" platforms
>>   usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms
>
> care to resend without RFT prefix and with collected acks, tested-bys, etc?

Done with a prefix of 'REPOST' to hopefully make it obvious nothing
changed between the RFT and this version.  There were only two
test-by, but as mentioned in the updated cover letter:

Since there should be nothing platform specific about the uFrame
scheduler presumably this should mean we're good to go?  Specificaly
note that in at least one of the "Tested-by" reports this patch caused
a notable improvement.


BTW: I'm pleased to have you apply the patches, but I notice that
get_maintainer no longer flags you as the person to post dwc2 patches
to.  From linux-next:

$ ./scripts/get_maintainer.pl -f drivers/usb/dwc2
Minas Harutyunyan <hminas@synopsys.com> (maintainer:DESIGNWARE USB2
DRD IP DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
linux-usb@vger.kernel.org (open list:DESIGNWARE USB2 DRD IP DRIVER)
linux-kernel@vger.kernel.org (open list)


-Doug
