Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754857AbeBUQvz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:51:55 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34270 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbeBUQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:51:50 -0500
X-Google-Smtp-Source: AH8x226WrHg9NQicnE4k7OrTx1hyLYYgdmE+oFRiB1wlULzAXjZeNmsc/4aZaeyv5PToB5ViSLlOM8vbDCLfKEU3/Fo=
MIME-Version: 1.0
In-Reply-To: <20180219193426.darxcui4g4oxyf32@rob-hp-laptop>
References: <20180216060503.22006-1-rnayak@codeaurora.org> <20180216060503.22006-3-rnayak@codeaurora.org>
 <20180219193426.darxcui4g4oxyf32@rob-hp-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 21 Feb 2018 08:51:48 -0800
X-Google-Sender-Auth: 2gOo4duolSv5fHZXlsMBjsenOLQ
Message-ID: <CAD=FV=UWUD4VMN4gLxBLsSEnsTnOot+ydsaOiFqvD-B2e_RQAg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: qcom: Add SDM845 bindings
To: Rob Herring <robh@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On Mon, Feb 19, 2018 at 11:34 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Feb 16, 2018 at 11:35:01AM +0530, Rajendra Nayak wrote:
>> Add a SoC string 'sdm845' for the qualcomm SDM845 SoC
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
>> index 0ed4d39d7fe1..ee532e705d6c 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.txt
>> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
>> @@ -26,6 +26,7 @@ The 'SoC' element must be one of the following strings:
>>       msm8996
>>       mdm9615
>>       ipq8074
>> +     sdm845
>
> These should really be the full string with 'qcom,', but you don't have
> to fix that now.
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review!  I agree that we should land this and then make
further progress in additional patches.


Are you suggesting to rewriting this whole bindings doc to not specify
things in an "M x N" type of way?  AKA the top of this doc says:

> Each board must specify a top-level board compatible string with the following
> format:
>         compatible = "qcom,<SoC>[-<soc_version>][-<foundry_id>]-<board>[/<subtype>][-<board_version>]"
> The 'SoC' and 'board' elements are required. All other elements are optional.

...and then the doc goes on to give lists of known SoC and board values.


Presumably if someone were to fix this then they'd need to try to
track down existing boards so they could enumerate every known
combination?


-Doug
