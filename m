Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAC8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4221C20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO5q3O5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4221C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeKJDLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeKJDLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:11:48 -0500
Received: from localhost (unknown [131.107.159.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07AB720825;
        Fri,  9 Nov 2018 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541784616;
        bh=iyI/hbmy46o35RqNWVQfJMo632zfTpKvxFoQw538i8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LO5q3O5BdE9txruBXs1J7l+8XT4pZ9boGJiavtegdltBZvt00fM7cYQaKqSn0yzRy
         JCUyEyXzOZ9qtCyUHb5miSOLLyzINcHhmQyh3CkbkXR854/nQIrQBizt/agg3VAP7D
         BwaU/hlhajeQuq5eIlZ191CAJS7VtA8VwOxZguBI=
Date:   Fri, 9 Nov 2018 12:30:15 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bunk@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "Chiang, AlanX" <alanx.chiang@intel.com>,
        "Yeh, Andy" <andy.yeh@intel.com>
Subject: Re: [PATCH 4.14 01/31] eeprom: at24: Add support for address-width
 property
Message-ID: <20181109173015.GD14882@sasha-vm>
References: <20181108215129.641434673@linuxfoundation.org>
 <20181108215129.753982396@linuxfoundation.org>
 <CAMRc=MdckdCj=dwn8J6Y5O1gPPykGrzK50td24_iFOa-MwEEJQ@mail.gmail.com>
 <20181109111604.GB26335@kroah.com>
 <CAMRc=Mep_vQfKjep4Z3Qf_=b5dCkuNqSY7-4RdfkUB96Cc5RvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mep_vQfKjep4Z3Qf_=b5dCkuNqSY7-4RdfkUB96Cc5RvA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 12:25:34PM +0100, Bartosz Golaszewski wrote:
>pt., 9 lis 2018 o 12:16 Greg Kroah-Hartman
><gregkh@linuxfoundation.org> napisał(a):
>>
>> On Fri, Nov 09, 2018 at 08:48:32AM +0100, Bartosz Golaszewski wrote:
>> > czw., 8 lis 2018 o 23:08 Greg Kroah-Hartman
>> > <gregkh@linuxfoundation.org> napisał(a):
>> > >
>> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
>> > >
>> >
>> > Hi Greg,
>> >
>> > this looks like a new feature, not a fix. Are you sure this should go
>> > into the stable branch?
>>
>> Adrian Bunk asked for it to be included as he said it was a good "quirk"
>> support for some hardware enablement issues.
>>
>> If you think it should be dropped, I'll be glad to do so, but it seems
>> harmless to me.
>>
>
>Nah I'm fine, it just seemed like it didn't really fulfill the
>requirements for stable.

From my understanding this patch enabled the use of new devices, even
though the description of the patch doesn't specify that.

--
Thanks,
Sasha
