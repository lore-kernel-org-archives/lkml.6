Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCUHBh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:01:37 -0400
Received: from mleia.com ([178.79.152.223]:60720 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbeCUHBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:01:35 -0400
Subject: Re: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
To: Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org, Ken Chen <chen.kenyy@inventec.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-4-peda@axentia.se>
 <bc464354-660a-00ed-e713-eec987407695@mleia.com>
 <3cfc6e53-a86d-8ef1-b83d-9f3c1b3d7b9c@roeck-us.net>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <67f0b5fb-5df7-0354-bfd6-5969b6fc7bb1@mleia.com>
Date: Wed, 21 Mar 2018 09:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3cfc6e53-a86d-8ef1-b83d-9f3c1b3d7b9c@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180321_070134_659556_A728466F 
X-CRM114-Status: GOOD (  12.83  )
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 03:19 AM, Guenter Roeck wrote:
> On 03/20/2018 04:17 PM, Vladimir Zapolskiy wrote:
>> Hi Peter, Ken,
>>
>> On 03/20/2018 11:32 AM, Peter Rosin wrote:
>>> Make the arbitrate and release_bus implementation chip specific.
>>>
>>
>> by chance I took a look at the original implementation done by Ken, and
>> I would say that this 3/3 change is an overkill as a too generic one.
>> Is there any next observable extension? And do two abstracted (*arbitrate)
>> and (*release_bus) cover it well? Probably no.
>>
>> At first it would be simpler to add a new chip id field into struct pca9541
>> (struct rename would be needed of course), and do a selection of specific
>> pca9x41_arbitrate() and pca9x41_release_bus() depending on it:
>>
> 
> FWIW, I very much prefer Peter's code. I think it is much cleaner.

Peter's code is generic, and it makes the change about 3 times longer in lines
of code, and the following pca9641 change on top of it will be larger as well,
because generalization requires service.

My main concern is that if such generalization is really needed in the driver.

--
With best wishes,
Vladimir
