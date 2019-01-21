Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423BBC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA520823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfAUO2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:28:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:12640 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfAUO17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:27:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 06:27:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="313554180"
Received: from epg-ubt28.iil.intel.com (HELO [143.185.152.137]) ([143.185.152.137])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2019 06:27:57 -0800
Subject: Re: pinctrl: -EAGAIN not supported but documented
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <94b9acab-a739-a014-b068-768f40de38ec@linux.intel.com>
 <CACRpkdYPBf6sYzbk1W-znYxaaaGvvO=tT_rXt7SXBwDRa6fJ1w@mail.gmail.com>
From:   Ramon Fried <ramon.fried@linux.intel.com>
Message-ID: <81fc986c-10b1-d1b1-9f60-241ec2abd446@linux.intel.com>
Date:   Mon, 21 Jan 2019 16:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdYPBf6sYzbk1W-znYxaaaGvvO=tT_rXt7SXBwDRa6fJ1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/19 4:26 PM, Linus Walleij wrote:
> On Mon, Jan 21, 2019 at 2:28 PM Ramon Fried <ramon.fried@linux.intel.com> wrote:
>
>> Stated in Documentation/driver-api/pinctl.rst:
>>
>> Since some controllers have special logic for handling entire groups of pins
>> they can exploit the special whole-group pin control function. The
>> pin_config_group_set() callback is allowed to return the error code -EAGAIN,
>> for groups it does not want to handle, or if it just wants to do some
>> group-level handling and then fall through to iterate over all pins, in
>> which
>> case each individual pin will be treated by separate pin_config_set()
>> calls as
>> well.
>>
>> ----
>>
>> This is not supported, and there's no code for handling it.
>>
>> Should we add the necessary code or just remove the wrong documentation.
> The idea was removed in:
> commit ad42fc6c84795d19972e7f7dee70fe74bec4c2d8
> "pinctrl: rip out the direct pinconf API"
>
> I think we should just remove the documentation.
>
> Do you want me to look into it or do you want to send a patch?
>
> Yours,
> Linus Walleij

I'll send a patch shortly.

Thanks.

Ramon.

