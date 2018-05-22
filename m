Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeEVAzr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:55:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60819 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751535AbeEVAzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:55:43 -0400
Subject: Re: [PATCH 05/33] cxgb4: use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-6-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Vcpfeey_womFqoqp_gyy0=jqMHgW+30WJs-BcVTM-vHQA@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ganesh Goudar <ganeshgr@chelsio.com>, netdev <netdev@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <ef794053-e1db-130c-46dd-312907e26b29@huawei.com>
Date: Tue, 22 May 2018 08:55:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcpfeey_womFqoqp_gyy0=jqMHgW+30WJs-BcVTM-vHQA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/5/22 5:39, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
> 
>> -       for (i = 0; i < ARRAY_SIZE(cudbg_region); i++) {
>> -               if (!strcmp(cudbg_region[i], region_name)) {
>> -                       found = 1;
>> -                       idx = i;
>> -                       break;
>> -               }
>> -       }
>> -       if (!found)
>> -               return -EINVAL;
>> +       rc = match_string(cudbg_region, ARRAY_SIZE(cudbg_region), region_name);
>> +       if (rc < 0)
>> +               return rc;
>>
>> -       found = 0;
>> +       idx = rc;
> 
> Is found still in use after this?
> If so, is it initialized properly now?
it is initialized  when define 'found', so no need to be initialized once more.

Thanks
Yisheng

> 
