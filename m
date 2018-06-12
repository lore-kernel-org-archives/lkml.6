Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5198BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F259E208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="L2/A980/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iLMmNscB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F259E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932726AbeFLFWY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:22:24 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45108 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeFLFWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:22:21 -0400
Received: by mail-ua0-f196.google.com with SMTP id k14-v6so15087383uao.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AuQJdHKfNlkwjqW5z/3W+J/a+l+/wucTc1oE8fbLAwk=;
        b=L2/A980/tWVIZODb81HC7sbWwf/1dyDLTZjHQta/wITv1xmtAyvCjPXywaQt/16Whg
         sm/rrvdqZVSTzHmGqeYR5r0eklRKuZvXmY8ICXHue+gL0S/8wmoDWJPw9QvvWWlOoes9
         6ib3iZldgzey72Y6P2PjpRdtGVEXnvNp9ZvsQqpsQT7MPDZeCbJ3SbY8r5uXfy8Ff9yg
         5qRzGPYEYbwChromHfwZyjD3h/LERWpmOg3/MMvVZWTpZB+jiXJoZ63CO+uYM+E8W8Qn
         P7IoJz17YwnBvv5qGoM1ISkvSHiqP38zz79D723iHVgu685uApbxYE8lVv8auH1HZOwq
         ED3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AuQJdHKfNlkwjqW5z/3W+J/a+l+/wucTc1oE8fbLAwk=;
        b=iLMmNscBqKdt2hhi2AlFBlmKT/2vlMGjWJ/Tqu1KnvT7yErBYQpQKjFIdIOBC4hrGM
         WJNrIp0bu5xspqwbruR0l2ViMU2lGu0coEx6se4cnDEdadJeuhVXzRHNFRuS6ZvJcOWF
         jku5Z6n+t77N9+cU1pOO6xOyrLNCK3tMjBwFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AuQJdHKfNlkwjqW5z/3W+J/a+l+/wucTc1oE8fbLAwk=;
        b=S0jhttZnJJNNvCcX8G7adk85H683O+2+lS7GIKU/NjShzpuJCx7aJafA6UNZfqQW9H
         DW5MFAIz5DXFoiG7yXszqxm94kgW7eiRTS97NRlsWwnTqvLISyOb7X5oEnjimr1K5++g
         x/MLt6GUceJ0MQ0zU9IdKzXnSM+DsrfopGWTJsDCqNC9/e8k0sOcpMcX6pNgTZWQUM3n
         pKzAeOl6UVN7U3QTD1ja6Ruu+zg17StmCdqp8qUZ0ZU6ikVSEmmukyh6Zsnl+FB0uTEM
         3TGTFV17mAy7bM/Ni1iMmNHR4HgTgrhIA2WHnJBcooUqI/MPWhUgoWzTCzkyE+jOHkDx
         nKCw==
X-Gm-Message-State: APt69E0NjEVk2Yn/7D0c14x4SkAd64STAHhmIbw85VI2dNCHgfcbeikI
        tXhz2kK+3rS1tOQyQqy0fDJZQnZS2o5S6IFWlnpe+A==
X-Google-Smtp-Source: ADUXVKLjnq/3c+g5DNGW2NtJHgJIM3sHVpG8zEaPIYXcF58me5fdLm+drMGaom9qK5T1CRNzxc1+SnpMEz525hG2XBk=
X-Received: by 2002:ab0:17d2:: with SMTP id p18-v6mr1286055uaf.121.1528780940338;
 Mon, 11 Jun 2018 22:22:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 22:22:19
 -0700 (PDT)
In-Reply-To: <20180612050108.GU510@tuxbook-pro>
References: <20180607204608.27688-1-dianders@chromium.org> <20180612050108.GU510@tuxbook-pro>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jun 2018 22:22:19 -0700
X-Google-Sender-Auth: S-OzctXcq_ROHq8Ixi8N0iSF-A4
Message-ID: <CAD=FV=X4X+-oAX9YJ3rQkGXeWwu7XT_9-xNSG5ooJwm027ygAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 11, 2018 at 10:01 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Thu 07 Jun 13:46 PDT 2018, Douglas Anderson wrote:
>
>> This adds nodes to SDM845-dtsi for all the I2C ports, all the SPI
>> ports, and UART9.  Note that I2C / SPI / UART are a bit strange on
>> sdm845 because each "serial engine" has 4 pins associated with it and
>> depending on which firmware has been loaded into the serial engine
>> (loaded by the BIOS) the serial engine can behave like an I2C port, a
>> SPI port, or a UART.  As per the landed bindings that means that we
>> need to create one node for each possible mode that the port could be
>> in.  With 16 serial engines that means 16 x 3 = 48 nodes.
>>
>> We get away with only creating 33 nodes for now because it seems very
>> likely that SDM845-based boards will actually all use the same UART
>> (UART 9) for debug purposes.  While another UART could be used for
>> something like Bluetooth communication we can cross that path when we
>> come to it.  Some documentation that I saw implied that using a UART
>> for "high speed" communications actually needs yet another different
>> serial engine firmware anyway.
>>
>> Note that quick measurements adding all these nodes adds ~10k of extra
>> space per dtb that they're included with.  If this becomes a problem
>> we may need to think of a different way to structure this so that
>> boards only get the nodes they need (or figure out how to get dtc to
>> strip 'disabled' nodes).  For now it seems OK.
>>
>> These nodes were programmatically generated with a fairly dumb python
>> script.  See http://crosreview.com/1091631 for the source.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks for the review!

One note is that I have since come to find that it might not be so
wise to define the sleep pinctrl state here.  For the SPI driver at
least I dug in and I saw the the sleep state is selected when we're
runtime PMed.  ...and with the currently posted SPI driver that can
happen in some cases even when the chip select is supposed to be kept
low.  For now it's more prudent to keep the "sleep" state out of the
device tree and we can always add it in later.

I'll plan to re-spin the patch on Wednesday (I'm unavailable tomorrow).

For other's reference: I chatted offline with Bjorn offline and this
sounded fine to him.


-Doug
