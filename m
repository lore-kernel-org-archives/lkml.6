Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8FBC3C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5019520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5019520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeFMH2U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:28:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54519 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFMH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:28:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id o13-v6so2850992wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 00:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYlePa8JYKlNPl+mcjIKhGlSpKnCP0N61O+RkXVhDOo=;
        b=iJYTwegrtkN5Ri08g6aPOdBfIVuzqYQ2rYu+UMZxAQqeGeZNhQMNGcabdVuTJ+ChS5
         +PqYRjb4e7nYstiicfprLjvuLKqn3e5tQAtVOaAnGwSrXl95SvdbKPmBWnhO3LeZYsIt
         r0vtz+9osWQ8aVSHGrQa3XX+5CheEISn8oEK46Uq8brWvKb5sSM41ftNEmVwDVvOmLOg
         O3wWVIRRpB5yis13Snz03jnhz/pi1rXo7RACZYaS5Z+tRH705y/B8TuVrjuoyriAiqVV
         5TRkYA/bBUBrOv1dRBQDFUaBrmgSsFbPWa2vKBlEUqjka4uveLs7n/VPlhz5E8wdWafI
         Ce/A==
X-Gm-Message-State: APt69E1HK6wsqCDZCDu7YFhohYLAES/CetFJoduRV7xfBSy5saTmRySn
        fWNFVktrrvtwaDQ0lZbndHKaW4mKnFo=
X-Google-Smtp-Source: ADUXVKLgR8J02nutmU6BdiS1SboNh4ECtp5r7ms9UHMB+gezmWNtYtbQ+5pz0J5WE9K371AWWbdsZQ==
X-Received: by 2002:a50:9772:: with SMTP id d47-v6mr2961482edb.174.1528874897352;
        Wed, 13 Jun 2018 00:28:17 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x15-v6sm1046744edd.90.2018.06.13.00.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 00:28:16 -0700 (PDT)
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm: sun4i: Add support for Pengpod
 1000 tablet
To:     Bob Ham <rah@settrans.net>, maxime.ripard@bootlin.com
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
 <20180605145038.qptdlcphdbnw6jyg@flea>
 <e2787b2a-230d-ea3c-89b9-316ddcd20f67@settrans.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4d041794-ba90-a9a6-0886-0ca18dab62b9@redhat.com>
Date:   Wed, 13 Jun 2018 09:28:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e2787b2a-230d-ea3c-89b9-316ddcd20f67@settrans.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-06-18 20:18, Bob Ham wrote:
> On 05/06/18 15:50, Maxime Ripard wrote:
>> On Mon, Jun 04, 2018 at 06:33:02PM +0100, Bob Ham wrote:
>>> On 04/06/18 09:13, Maxime Ripard wrote:
>>>> On Sat, Jun 02, 2018 at 05:03:13PM +0100, Bob Ham wrote:
>>>
>>>>> + * This file is dual-licensed: you can use it either under the terms
>>>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>>>> + * licensing only applies to this file, and not this project as a
>>>>> + * whole.
>>>
>>>>> + *     The above copyright notice and this permission notice shall be
>>>>> + *     included in all copies or substantial portions of the Software.
>>>
>>>> And this is redundant with the SPDX header.
>>>
>>> The X11 license notice states explicitly that the notice has to be
>>> included in the file.  Wouldn't removing it be a violation of the license?
>>
>> The SPDX header is explicitly here to remove the license text and
>> create a tag that is in a indirect reference to the license text in
>> LICENSES. It's not going away.
> 
> Well, the top bit that I quoted above says that the licenses refer to
> only that one file in particular and not the project as a whole.  Then
> the X11 license states that the notice can't be removed from 'this
> software and associated documentation files (the "Software")' which
> would seem to refer to the single file.  Therefore, removing the notice
> from the single file and replacing it with an SPDX header would seem to
> violate the license.
> 
> It's a fine point but it makes me nervous.  I originally based my .dts
> on sun4i-a10-inet1.dts.  I've CC'd the original copyright holder, Hans
> de Goede.  Hans, are you willing to give permission for the license
> notice to be replaced with just an SPDX header indicating the dual
> licensing?

Yes that is fine by me and you've my permission to switch to using
just the SPDX header.

FWIW I do not believe the "can't be removed from 'this software and
associated documentation files (the "Software")'" language
applies to the software as a whole and not individual files.

> While we're at it, there are a number of other files with the same
> license text.  Hans, are you prepared to give permission for your other
> license notices to be replaced with SPDX headers?

Yes you may make the same change to all files with my copyright.

Regards,

Hans

