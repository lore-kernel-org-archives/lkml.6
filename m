Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeEVDnK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:43:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60276 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751557AbeEVDnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:43:07 -0400
Subject: Re: [PATCH 12/33] clk: bcm2835: use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Vf6rDpFQCt+qG3DSWKZm36F1hkAVPtGzr6NHPuQg4vhXQ@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Eric Anholt" <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>, <linux-clk@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <00acb90b-1c2c-a855-2a8f-f60a859a0f85@huawei.com>
Date: Tue, 22 May 2018 11:42:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf6rDpFQCt+qG3DSWKZm36F1hkAVPtGzr6NHPuQg4vhXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/5/22 5:50, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
>>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: linux-clk@vger.kernel.org
>> Cc: linux-rpi-kernel@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> 
>> -       size_t i, j;
>> -       int ret;
>> +       int i, ret;
> 
> I do not see any need to change type for i.

Right, I just want to smaller the line of code, for unsinged int is also OK for i.
Anyway, I can change it as your suggestion in next version.

Thanks
Yisheng

> 
>> +               ret = match_string(cprman_parent_names,
>> +                                  ARRAY_SIZE(cprman_parent_names),
>> +                                  parents[i]);
>> +               if (ret >= 0)
>> +                       parents[i] = cprman->real_parent_names[ret];
> 
> 
