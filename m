Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEBK2O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:28:14 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39064 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeEBK2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:28:09 -0400
X-Google-Smtp-Source: AB8JxZo30+mmdwgwgtsiubrS5TeY4sZllUG8fKTdm35jgxn49g8SY7w10B+rMlB+rNpuclqLchV9iQ==
Subject: Re: [v2 PATCH 1/1] tg3: fix meaningless hw_stats reading after
 tg3_halt memset 0 hw_stats
To: Michael Chan <michael.chan@broadcom.com>
References: <20180502004234.230662-1-zumeng.chen@gmail.com>
 <CACKFLikg+p_1iDQtd0XN8tJaKtAgX0jfxGXuoqxhDJZ922UkUg@mail.gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        David Miller <davem@davemloft.net>,
        Zumeng Chen <zumeng.chen@windriver.com>
From: Zumeng Chen <zumeng.chen@gmail.com>
Message-ID: <5af186f8-9718-c295-4e34-e84dd78ea157@gmail.com>
Date: Wed, 2 May 2018 18:27:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <CACKFLikg+p_1iDQtd0XN8tJaKtAgX0jfxGXuoqxhDJZ922UkUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018年05月02日 13:12, Michael Chan wrote:
> On Tue, May 1, 2018 at 5:42 PM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>
>> diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
>> index 3b5e98e..c61d83c 100644
>> --- a/drivers/net/ethernet/broadcom/tg3.h
>> +++ b/drivers/net/ethernet/broadcom/tg3.h
>> @@ -3102,6 +3102,7 @@ enum TG3_FLAGS {
>>          TG3_FLAG_ROBOSWITCH,
>>          TG3_FLAG_ONE_DMA_AT_ONCE,
>>          TG3_FLAG_RGMII_MODE,
>> +       TG3_FLAG_HALT,
> I think you should be able to use the existing INIT_COMPLETE flag

No,  it will bring the uncertain factors into the existed complicate 
logic of INIT_COMPLETE.
And I think it's very simple logic here to fix the meaningless hw_stats 
reading and the problem
of commit f5992b72. I even suspect if you have read INIT_COMPLETE 
related codes carefully.

Cheers,
Zumeng
> and
> not have to add a new flag.
>
>>          /* Add new flags before this comment and TG3_FLAG_NUMBER_OF_FLAGS */
>>          TG3_FLAG_NUMBER_OF_FLAGS,       /* Last entry in enum TG3_FLAGS */
>> --
>> 2.9.3
>>
