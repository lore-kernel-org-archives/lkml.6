Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0ABECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1845921480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVg4niwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1845921480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbeIYAz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:55:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39358 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbeIYAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:55:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so20741480wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F5hwQIp5QDwCNz13gbUW1hiWFpLR0PBEgPghhdRvnLw=;
        b=RVg4niwUYnFXiXf35v9I/xiGB83UkqLT3Cy7tMJx2Ju/+bjVTmDS7w1cGpohziMO1Y
         NyV8S3QNgytyQyRT7YzFyPMhQYK7KKO62z4gPF4mELDqcjZn7TzxxHC83mUetglsvDJd
         f5HMCc5HpsKXp6PVi/bslWMZWuMAKPRcDOjw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F5hwQIp5QDwCNz13gbUW1hiWFpLR0PBEgPghhdRvnLw=;
        b=hIzdFht0VcgcFjH87kyvx9KqcIFVmm9Ps9cYt9u0/JjnnahBgd3rJeGQCZMl9HU9dL
         gDMYFctld7y53jqcFkrAyh5IlEpjDmLA9ofE5IdB6Zh/C7ahiQgosmKhwgMa3T0JeIK1
         0Uoql4W6Ic4ufnv1O0Mh92ucgwj7zX5UTay5ViY5p4ZzEn6TANuGu6TD0NNVZ9tsA2vL
         Hvl8fzMunOTy50CU/RuS5Hm5d8jtNSndZAlBooYBNTV409yq0SywQ8GBQvNw55bJh51J
         8+czPfj9ccslKYyVlIOGJymedFlDR90LAT2Rqd/bqAjPZmPoLMkZm4hkhGsMItC0/D1Y
         MDSQ==
X-Gm-Message-State: ABuFfog1T903wEb0w3eHst7/bZYzuNHLzI/vqiHTFcgm3F0Z4wuSe33N
        eJy4Wre/4mY3/HRaqSl5xlbdGY3bF2pJcwOyOYxWLA==
X-Google-Smtp-Source: ACcGV61MGLzBVyOJ2C6bzhNBQd0cHKAzJRBdJEz1kWT0VSxYGYbCDQlX4FbX0qUl/+FS8L+6heZb46zL+JbFgM2KkFU=
X-Received: by 2002:a5d:484f:: with SMTP id n15-v6mr109106wrs.234.1537815113200;
 Mon, 24 Sep 2018 11:51:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 11:51:52
 -0700 (PDT)
In-Reply-To: <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
 <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com> <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 24 Sep 2018 11:51:52 -0700
Message-ID: <CALAqxLXy0YXNLwFQEUZxSsjFKC9boVcGkt+50XwmVfwKCcqsEw@mail.gmail.com>
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

On Sun, Sep 23, 2018 at 10:57 PM, Artur Petrosyan
<arthur.petrosyan@synopsys.com> wrote:
> Hi John,
>
> On 9/21/2018 05:05, John Stultz wrote:
>> On Thu, Sep 20, 2018 at 7:17 AM, Artur Petrosyan
>> <Arthur.Petrosyan@synopsys.com> wrote:
>>> On 5/23/2018 01:57, John Stultz wrote:
>>>> Its done automatically, when the OTG cable is detected it the host
>>>> ports are disabled and when the OTG port is empty the host ports are
>>>> enabled.
>>>>
>>>> Let me know if you need anything else!
>>>>
>>>
>>> Please apply the patch set with this cover letter "[PATCH 0/3] usb:
>>> dwc2: Fix hibernation for switching between host and device modes."
>>
>> Sorry, can you send the patches to me, or point me to a git tree? I'm
>> not seeing that thread in my mailbox or on google.
>>
>>> Enable the power down on his devices. Let me know if you still see any
>>> issue. If there is no issue, please provide Tested-by tag.
>>
>> Would be happy to test it, thought I'm traveling tomorrow, so I may
>> not be able to validate till monday.
>>
>> thanks
>> -john
>>
>
> You can find the patch set following to this link.
>
> https://marc.info/?l=linux-usb&m=153745139408236&w=2

I applied those three patches, and it seems to work ok.

Just to be clear, was there anything else I was needing to do while testing it?

Otherwise,
Tested-by: John Stultz <john.stultz@linaro.org>   #On HiKey

thanks
-john
