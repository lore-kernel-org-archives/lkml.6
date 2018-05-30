Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbeE3Vs4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:48:56 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35311 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeE3Vsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:48:54 -0400
X-Google-Smtp-Source: ADUXVKKo+z5clayMNve3gGqBXiWNtTRNWTl7B+ffPatAEVb7kDsXVvIUwHQVT+b0orUquhTXu1lYDD61pAzHiEJx4yM=
MIME-Version: 1.0
In-Reply-To: <bb2d3dfb-08be-de3e-c18f-616ee27fa2e9@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org> <20180509170159.29682-10-ilina@codeaurora.org>
 <CAD=FV=Xvi8V43+J9v-mosU5WUDQtabg8gUbrkn6SCoNEYFtjUQ@mail.gmail.com> <bb2d3dfb-08be-de3e-c18f-616ee27fa2e9@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 14:48:51 -0700
X-Google-Sender-Auth: FT_IA3PxpCwFcNYkQ5igvyvcGEA
Message-ID: <CAD=FV=XrhG0N33YF8Uo16Lpq904TEGz8=S7Eb=P=sX52dTtVuA@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] drivers: qcom: rpmh: add support for batch RPMH request
To: Raju P L S S S N <rplsssn@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, msivasub@codeaurora.org,
        mkshah@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 23, 2018 at 6:27 AM, Raju P L S S S N
<rplsssn@codeaurora.org> wrote:
>>> +                       break;
>>
>>
>> "break" seems wrong here.  You'll end up waiting for the completion,
>> then I guess timing out, then returning -ETIMEDOUT?
>
>
> As the loop above break runs for remaining count, completion will be
> notified so there will not be waiting.

Ah, I see.  I missed that.

...oh, I guess you need to wait because any requests you might have
made will try to signal your completion which is on the stack...
