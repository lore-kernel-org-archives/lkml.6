Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeDIOqY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:46:24 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38448 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeDIOqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:46:22 -0400
X-Google-Smtp-Source: AIpwx4/EFzWOzJdJgGZhRD1qmMo2WoL47Gv2oBckELplyD9h3N/sX95M7KVXvIktUPjBtb91MjaT4w==
Subject: Re: [PATCH] net: dccp: Replace GFP_ATOMIC with GFP_KERNEL in
 dccp_init
To: Eric Dumazet <eric.dumazet@gmail.com>, gerrit@erg.abdn.ac.uk,
        davem@davemloft.net
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523283004-25581-1-git-send-email-baijiaju1990@gmail.com>
 <8216dee8-5e52-421e-026a-4c75d654be54@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <ab55c4a7-ee67-eead-eeeb-4dc92eaf9aee@gmail.com>
Date: Mon, 9 Apr 2018 22:46:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <8216dee8-5e52-421e-026a-4c75d654be54@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/4/9 22:42, Eric Dumazet wrote:
>
> On 04/09/2018 07:10 AM, Jia-Ju Bai wrote:
>> dccp_init() is never called in atomic context.
>> This function is only set as a parameter of module_init().
>>
>> Despite never getting called from atomic context,
>> dccp_init() calls __get_free_pages() with GFP_ATOMIC,
>> which waits busily for allocation.
> What do you mean by "waits busily" ?
>
> GFP_ATOMIC does not sleep, does not wait.

Sorry, I should modify it to "does not sleep".
Do you think it is okay?


Best wishes,
Jia-Ju Bai
