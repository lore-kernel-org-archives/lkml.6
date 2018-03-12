Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCLP1l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751315AbeCLP1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:27:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D532021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELspCL6s35gEO1QF/GM+PY3NH84Q1tEyg+4BFqUnYy8t/giO+EmBGZifV0O53HzDIrkC3z/UeFXIXbza5WR9w70=
MIME-Version: 1.0
In-Reply-To: <7f0ab50a-8a57-799d-e620-4e7f4fdf039d@gmail.com>
References: <1520548745-25021-1-git-send-email-frowand.list@gmail.com>
 <20180310000213.tonovc6n7jtknycj@rob-hp-laptop> <7f0ab50a-8a57-799d-e620-4e7f4fdf039d@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Mar 2018 10:27:16 -0500
X-Gmail-Original-Message-ID: <CABGGisx3taqjc26Y1r16Y6WxOfXbxn8R_Bu3754GQA-FM8ZzpQ@mail.gmail.com>
Message-ID: <CABGGisx3taqjc26Y1r16Y6WxOfXbxn8R_Bu3754GQA-FM8ZzpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: unittest: remove unneeded local return value variables
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 7:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 03/09/18 16:02, Rob Herring wrote:
>> On Thu, Mar 08, 2018 at 02:39:04PM -0800, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> A common pattern in many unittest functions is to save the return
>>> value of a function in a local variable, then test the value of
>>> the local variable, without using that return value for any further
>>> purpose.  Remove the local return value variable for these cases.
>>>
>>> A second common pattern is:
>>>
>>>    ret = some_test_function(many, parameters, ...);
>>>    if (unittest(ret == 0, "error message format", ...))
>>>       return;
>>>
>>> This pattern is more clear when the local variable 'ret' is used, due
>>> to the long lines caused by the parameters to the test function and
>>> the long format and data parameters of unittest().  The local
>>> variable is retained in these cases.
>>>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>> ---
>>>  drivers/of/unittest.c | 89 ++++++++++++++-------------------------------------
>>>  1 file changed, 24 insertions(+), 65 deletions(-)
>>
>> Doesn't apply. What's it based on?
>>
>> Rob
>>
>
> Sorry, I guess I should have mentioned that.
>
> Based on top of of_overlay_fdt_apply() v7 for 4.17.
>
> It applies with or without Dan's "[PATCH] of: unittest: fix
> an error test in of_unittest_overlay_8()", which made me notice
> the common pattern.

That's what I figured, but I was not on the right branch... Now both
are applied.

Rob
