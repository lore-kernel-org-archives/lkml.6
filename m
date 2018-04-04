Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeDDTUJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:20:09 -0400
Received: from smtp62.i.mail.ru ([217.69.128.42]:52150 "EHLO smtp62.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752424AbeDDTUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:20:07 -0400
Subject: Re: [PATCH v2 1/6] spi: core: handle timeout error from
 transfer_one()
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
 <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
 <20180403161824.GB11578@sirena.org.uk>
 <dad0ea81-2dd6-ccc3-a0c9-cf20ff195b7f@orpaltech.com>
 <20180404070817.6cens44jvlmdaxtm@flea>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <a75ac9e8-e95e-d412-a1f9-15de1d99badd@orpaltech.com>
Date: Wed, 4 Apr 2018 22:19:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404070817.6cens44jvlmdaxtm@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: smtp62.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A56F5296078A3C987776889ED789FDEA0FFC839A7D10C5E1E9725E5C173C3A84C3A1C30C8AFC676C8B9AD636F337C3FD3E5E1C53F199C2BB95B5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917B83A51F760C4735767E24D0D576F94E6069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 10:08 AM, Maxime Ripard wrote:
> On Tue, Apr 03, 2018 at 07:24:11PM +0300, Sergey Suloev wrote:
>> On 04/03/2018 07:18 PM, Mark Brown wrote:
>>> On Tue, Apr 03, 2018 at 07:00:55PM +0300, Sergey Suloev wrote:
>>>> On 04/03/2018 06:52 PM, Mark Brown wrote:
>>>>> On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
>>>>>> As long as sun4i/sun6i SPI drivers have overriden the default
>>>>>> "wait for completion" procedure then we need to properly
>>>>>> handle -ETIMEDOUT error from transfer_one().
>>>>> Why is this connected to those drivers specifically?
>>>> These 2 drivers have their own "waiting" code and not using the code from
>>>> SPI core.
>>> Does this not apply to any other driver - why is this something we only
>>> have to do when these drivers do it?  That's what's setting off alarm
>>> bells.
>> sun4i/sun6i drivers have let's say "smart" waiting while SPI core uses a
>> fixed interval to wait.
>>
>> I can't say for every SPI driver in kernel, that's outside of my area of
>> expertise.
> I'm not sure what's specific about the sun4i / sun6i case here. Your
> patch doesn't have anything to do with the delay before the timeout,
> but the fact that we return -ETIMEDOUT in the first place.
>
> And I'm pretty sure that papering over an error returned by a driver
> is not the right thing to do.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

do you mean the changes in spi.c are not required at all ?

My point was to eat ETIMEDOUT error from transfer_one() as it is just a 
mark and

shouldn't be handled as a normal error.
