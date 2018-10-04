Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC9DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C02D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C02D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeJDVhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:37:10 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:47249 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDVhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:37:10 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:57382 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1g84qh-0004xU-MS; Thu, 04 Oct 2018 16:43:31 +0200
Subject: Re: [PATCH] drm/imx: move 'legacyfb_depth' definition out of #ifdef
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Dave Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181002205836.2323084-1-arnd@arndb.de>
 <123f7e1c-8f2b-5797-de16-650ec01d0b24@tronnes.org>
 <20181003161326.GD31561@phenom.ffwll.local>
 <CAK8P3a1gKxXEthLvUxSxOrt6+1qzZE9Jba+vH_qFepv3KXba9g@mail.gmail.com>
 <CAKMK7uFn=u+04=HQvzkSNdE8_9p=3eX14-h=0nOJ7QKPJSrdmw@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <af5994a3-5739-ed7f-4374-85e9d19d2408@tronnes.org>
Date:   Thu, 4 Oct 2018 16:43:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFn=u+04=HQvzkSNdE8_9p=3eX14-h=0nOJ7QKPJSrdmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 04.10.2018 09.48, skrev Daniel Vetter:
> On Wed, Oct 3, 2018 at 9:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Oct 3, 2018 at 6:13 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Wed, Oct 03, 2018 at 05:49:32PM +0200, Noralf Trønnes wrote:
>>>>
>>>> Den 02.10.2018 22.58, skrev Arnd Bergmann:
>>>>> The variable is now referenced unconditionally, but still
>>>>> declared in an #ifdef:
>>>>>
>>>>> drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
>>>>> drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?
>>>>>
>>>>> Remove the #ifdef so it can always be accessed.
>>>>>
>>>>> Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>>> ---
>>>> I've already applied the previous one you sent:
>>>> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=064b06bbf117f8b5e64a5143e970d5a1cf602fd6
>>>>
>>>> Not sure when it reaches linux-next now that we are past rc6.
>>> Only once we're past -rc1.
>> Can we revert f53705fd9803 in linux-next then to prevent the regression from
>> making it into 4.20?
> Probably simpler to cherry pick the fix from drm-misc-next to
> drm-misc-next-fixes. Noralf, can you pls do that?

Would this be the correct procudure:

     dim update-branches
     dim create-workdir drm-misc-next-fixes
     <build>
     CONFIG_DRM_FBDEV_EMULATION=n
     <build will break>
     git cherry-pick 064b06bbf117f8b5e64a5143e970d5a1cf602fd6
     <build passes>
     dim push-branch drm-misc-next-fixes

I read that cherry picking creates a new commit with a new hash.
But since you ask me to do this, I assume git will handle this when
branches are merged?

Noralf.

