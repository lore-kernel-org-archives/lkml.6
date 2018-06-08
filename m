Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DNu/GglFGltmCQAAmS7hNA
	; Fri, 08 Jun 2018 08:58:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DDC44608BA; Fri,  8 Jun 2018 08:58:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6ACC0602FC;
	Fri,  8 Jun 2018 08:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ACC0602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeFHI6l (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:58:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40830 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeFHI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:58:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 58D66286FF3
Subject: Re: [PATCH v3 00/12] cros_ec: Match licenses and switch to SPDX
 identifier.
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        linux-rtc@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <517d33d8219f22126ec8caaf41072c14b5ebf407.camel@perches.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <aee6f480-28e0-4b9f-0e90-35a2b7a37419@collabora.com>
Date: Fri, 8 Jun 2018 10:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <517d33d8219f22126ec8caaf41072c14b5ebf407.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 06/06/18 17:42, Joe Perches wrote:
> On Wed, 2018-06-06 at 17:08 +0200, Enric Balletbo i Serra wrote:
>> Dear all,
>>
>> This patchset is just to adopt the SPDX license identifier for all
>> ChromeOS Embedded Controller related drivers.
> 
> This bit is fine,
> 
>>  The patches touches
>> different subsystems but every patch can be picked from their respective
>> maintainer independently.
>>
>> This third version takes the license note as the valid license (I did
>> the contrary in the second version) so apart from add the SPDX tags it
>> also introduces new patches to match the license.
> 
> But why change any MODULE_LICENSE text?
> 

Because in some cases there is a mismatch between the license note and the
MODULE_LICENSE text.

According to the documentation setting MODULE_LICENSE("GPL") means GNU Public
License v2 or later [1], in the cases where the license note tells explicitly
that is GPL v2 only I think that the MODULE_LICENSE should match and be changed
to "GPL v2".

[1] https://elixir.bootlin.com/linux/v4.17/source/include/linux/module.h#L172

> There are uses of MODULE_LICENSE("GPL") where
> the SPDX license identifier is some GPL variant
> 

Right, but I suppose in such cases is wrong and should be changed too?

> For instance:
> $ git grep -P --name-only
> 'MODULE_LICENSE\s*\("GPL"\s*\)\s*;'| \
>   xargs grep "SPDX-License-
> Identifier:" | \
>   cut -f3- -d: | \
>   sed -r 's@\s*\*/\s*$@@' | \
>   sort |
> uniq -c | sort -rn
>     551  GPL-2.0+
>     281  GPL-2.0
>      13  GPL-1.0+
>     
>   9  GPL-2.0-only
>       2  GPL-2.0 OR MIT
>       1  (GPL-2.0 OR MPL-1.1)
>    
>    1  (GPL-2.0+ OR BSD-3-Clause)
>       1  (GPL-2.0 OR BSD-3-Clause)
> 
> And if you were to do this, please do it tree-wide,
> and ideally via a script
> 
