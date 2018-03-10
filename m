Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeCJB2Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 20:28:16 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35925 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCJB2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 20:28:14 -0500
X-Google-Smtp-Source: AG47ELsvcuC1VN4NvXCxN9qWrPe8A4nmWzM5Sup7tINlVo9p6Jx4RIFO9M8Ab4z83XLwYiZmcuKAFw==
Subject: Re: [PATCH 1/2] of: unittest: remove unneeded local return value
 variables
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1520548745-25021-1-git-send-email-frowand.list@gmail.com>
 <20180310000213.tonovc6n7jtknycj@rob-hp-laptop>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <7f0ab50a-8a57-799d-e620-4e7f4fdf039d@gmail.com>
Date: Fri, 9 Mar 2018 17:28:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310000213.tonovc6n7jtknycj@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/18 16:02, Rob Herring wrote:
> On Thu, Mar 08, 2018 at 02:39:04PM -0800, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> A common pattern in many unittest functions is to save the return
>> value of a function in a local variable, then test the value of
>> the local variable, without using that return value for any further
>> purpose.  Remove the local return value variable for these cases.
>>
>> A second common pattern is:
>>
>>    ret = some_test_function(many, parameters, ...);
>>    if (unittest(ret == 0, "error message format", ...))
>>       return;
>>
>> This pattern is more clear when the local variable 'ret' is used, due
>> to the long lines caused by the parameters to the test function and
>> the long format and data parameters of unittest().  The local
>> variable is retained in these cases.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/unittest.c | 89 ++++++++++++++-------------------------------------
>>  1 file changed, 24 insertions(+), 65 deletions(-)
> 
> Doesn't apply. What's it based on?
> 
> Rob
> 

Sorry, I guess I should have mentioned that.

Based on top of of_overlay_fdt_apply() v7 for 4.17.

It applies with or without Dan's "[PATCH] of: unittest: fix
an error test in of_unittest_overlay_8()", which made me notice
the common pattern.

-Frank
