Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeEBRc5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:32:57 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36465 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEBRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:32:53 -0400
X-Google-Smtp-Source: AB8JxZq8FJD56sWw1ZFtxkLGC6pwDwNnP0B/aMcom0OyZdV2Uk/77OPTWVohlJSafVHUfcewIqZa1BA516FGi/PL/m8=
MIME-Version: 1.0
In-Reply-To: <5af186f8-9718-c295-4e34-e84dd78ea157@gmail.com>
References: <20180502004234.230662-1-zumeng.chen@gmail.com>
 <CACKFLikg+p_1iDQtd0XN8tJaKtAgX0jfxGXuoqxhDJZ922UkUg@mail.gmail.com> <5af186f8-9718-c295-4e34-e84dd78ea157@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 2 May 2018 10:32:52 -0700
Message-ID: <CACKFLinOzi+F9j+gbBHjkGdMdXTqpfMRLUwqx=zUpVg76zGxNA@mail.gmail.com>
Subject: Re: [v2 PATCH 1/1] tg3: fix meaningless hw_stats reading after
 tg3_halt memset 0 hw_stats
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        David Miller <davem@davemloft.net>,
        Zumeng Chen <zumeng.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42HX2Bj008826

On Wed, May 2, 2018 at 3:27 AM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
> On 2018年05月02日 13:12, Michael Chan wrote:
>>
>> On Tue, May 1, 2018 at 5:42 PM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>>
>>> diff --git a/drivers/net/ethernet/broadcom/tg3.h
>>> b/drivers/net/ethernet/broadcom/tg3.h
>>> index 3b5e98e..c61d83c 100644
>>> --- a/drivers/net/ethernet/broadcom/tg3.h
>>> +++ b/drivers/net/ethernet/broadcom/tg3.h
>>> @@ -3102,6 +3102,7 @@ enum TG3_FLAGS {
>>>          TG3_FLAG_ROBOSWITCH,
>>>          TG3_FLAG_ONE_DMA_AT_ONCE,
>>>          TG3_FLAG_RGMII_MODE,
>>> +       TG3_FLAG_HALT,
>>
>> I think you should be able to use the existing INIT_COMPLETE flag
>
>
> No,  it will bring the uncertain factors into the existed complicate logic
> of INIT_COMPLETE.
> And I think it's very simple logic here to fix the meaningless hw_stats
> reading and the problem
> of commit f5992b72. I even suspect if you have read INIT_COMPLETE related
> codes carefully.
>

We should use an existing flag whenever appropriate, instead of adding
yet another flag to do similar things. I've looked at the code briefly
and believe that INIT_COMPLETE will work.  If you think it won't work,
please be specific and point out why it won't work.  Thanks.
