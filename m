Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A3ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD52F21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoRy9rZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD52F21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbeIUGvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:51:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35296 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUGvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:51:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so1398485wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FYZTzctddrxTEen9pecgmX5HGBIzN6H+JM/xBDI3BZI=;
        b=eoRy9rZr2dxYko9/UA4IljtR546a/2Nrcmo9785dZcJw74k2Q1hfkPVWgVwcQAgY2d
         n+ooPrgt4oi1wKo3cJHTRG4e8/D4YRMstkwPptPq6Y14FZ3Hj6H9NUAFep6IuisFy9qx
         V3CyLQWyzpCCK51PZJoqZGNWXryO2rgX9C9Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FYZTzctddrxTEen9pecgmX5HGBIzN6H+JM/xBDI3BZI=;
        b=n6++sPNq7ePYaw1rNySNcwTiE8eFb1WTOkcCS7KN0/JX2eJ9HXj0z1KeYEwu0yHRxy
         6oOnjN5RxX7PdfK9Zq4Mr0E83wCqjufOt5QmLm1iZJLeSji2339efsTwLycZrHp7OMs9
         FLqNR3Vy0NIxYEyfD+SBgxHYkdcFg1cP0CwPVHMwJIzCOpg9uPUyOFd8wkoOnCmmv+nX
         g/6jOCUvsxkkCJDB9t7Wm1xi75n54UBYt/bt5Wz3aYq27CZ5mrxSsTuXj3zh3W0Y+Nsy
         LG9cp83dqxJLQ2emtDx65wR/1ER1O4nA1Ao1jX9TQqJ+2Sf2FwXtapr1zD6nPL9OZZh9
         28rQ==
X-Gm-Message-State: APzg51DcpTlJdbn5ui65IrJOurUuK2aqTR4LtPVoMiqLTzyw6eYqzzX+
        MFC2CqAZHD/J6rREhiKSWcIFZKdIphxSNynkRMQmMw==
X-Google-Smtp-Source: ANB0VdaMAZ3YBE8JectABgPs/LJnzc0Zl1afUa+j+2ml7OvNslBCfuX0vbaEIXkgU5lOC/lzirq5lyiKWwTSUMK6qp4=
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr4792487wme.54.1537491933383;
 Thu, 20 Sep 2018 18:05:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:a986:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 18:05:32
 -0700 (PDT)
In-Reply-To: <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com> <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 20 Sep 2018 18:05:32 -0700
Message-ID: <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down feature
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
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

On Thu, Sep 20, 2018 at 7:17 AM, Artur Petrosyan
<Arthur.Petrosyan@synopsys.com> wrote:
> On 5/23/2018 01:57, John Stultz wrote:
>> Its done automatically, when the OTG cable is detected it the host
>> ports are disabled and when the OTG port is empty the host ports are
>> enabled.
>>
>> Let me know if you need anything else!
>>
>
> Please apply the patch set with this cover letter "[PATCH 0/3] usb:
> dwc2: Fix hibernation for switching between host and device modes."

Sorry, can you send the patches to me, or point me to a git tree? I'm
not seeing that thread in my mailbox or on google.

> Enable the power down on his devices. Let me know if you still see any
> issue. If there is no issue, please provide Tested-by tag.

Would be happy to test it, thought I'm traveling tomorrow, so I may
not be able to validate till monday.

thanks
-john
