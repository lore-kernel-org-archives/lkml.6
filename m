Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756070AbeDZNYA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:24:00 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37340 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755405AbeDZNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:23:58 -0400
X-Google-Smtp-Source: AIpwx49jjg728b/RtblX4sIBqeODepcNIhCY2cNNy0Eq8ARNtImIQjgvoJcswpopn3XE8mb/xQOTlRHONd6iQp0gD7w=
MIME-Version: 1.0
In-Reply-To: <20180416100306.5f6bzkzlsx3ufvw7@mani>
References: <20180414031811.11351-1-manivannan.sadhasivam@linaro.org>
 <20180414031811.11351-2-manivannan.sadhasivam@linaro.org> <9acdd412-9b6d-ec63-c5ca-c5fa8d98d489@linaro.org>
 <20180416100306.5f6bzkzlsx3ufvw7@mani>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 15:23:57 +0200
Message-ID: <CACRpkdZxwz5=oTxGWBgVHfy-D9s-f03qqjypUeJj6GrpXQcEcQ@mail.gmail.com>
Subject: Re: [dragonboard] [PATCH 1/1] dts: qcom: db820c: Add gpio-line-names property
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Todor Tomov <todor.tomov@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dragonboard@lists.96boards.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 12:03 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Mon, Apr 16, 2018 at 11:48:59AM +0300, Todor Tomov wrote:

>> > + * When the 96Board naming of a line and the schematic name of
>> > + * the same line are in conflict, the 96Board specification
>> > + * takes precedence, which means that the external UART on the
>> > + * LSEC is named UART0 while the schematic and SoC names this
>> > + * UART3. This is only for the informational lines i.e. "[FOO]",
>>
>> It seems to me that this can lead to some confusion for cases when
>> some schematic names have 96board names and others don't. (An
>> example below.) However I don't really see any better way to do
>> it. I'm wondering whether adding the schematic name in
>> the comment (for gpios which are named with 96board names)
>> can help a little. What do you think? Or any other idea?
>>
>
> Specifying the schematic names in comments is a good idea!
>
> Linus: Do you have any suggestion here?

Go for this.

Generally ask the question: what does the user need?

In this case, especially userspace libraries like mriaa (right name?)
should be able to work out-of-the-box without knowing what
board it is but know it has a 96board connector.

Yours,
Linus Walleij
