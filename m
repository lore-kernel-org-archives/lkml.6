Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF18C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7053820846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRlPUL/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7053820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeGZHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeGZHwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:52:24 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD64220895;
        Thu, 26 Jul 2018 06:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532587025;
        bh=LU1qt3mTpaLplACYWYu/zYE2ByP1yBQ4Zy34t/puelw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tRlPUL/Qge2ufYW37MByjsO4P813qjsa2moHmz2Ham6K/rW6RiO2yJh/yz8iVUN/X
         /Y0D1+URH+83QlfFji4/vqBhsxHfjHuDf4dQGNrgmStuL39buOdWDHwh9GkbYavGyP
         YFJEitx0rfWzIodg4IIao4vpj60TbF6jU3Dnvwd8=
Received: by mail-wr1-f43.google.com with SMTP id r16-v6so493799wrt.11;
        Wed, 25 Jul 2018 23:37:04 -0700 (PDT)
X-Gm-Message-State: AOUpUlGr9kd9gSBZMFmW1XyBLL1ZqlEAWTsobM9rvkR6n4wpgnnTBcRj
        LvCqMub0kwqxjmnegv/+giVeUIKaCAKEpGKhxLc=
X-Google-Smtp-Source: AAOMgpeJyJxsA/H0sbgsGS6m1Tk1PYyfPMWxKioXWhHKDYNTe+Xv6LNgFIQj1gOS409KpczIFK9Sw5Zt14FatbvT238=
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr454708wro.279.1532587023237;
 Wed, 25 Jul 2018 23:37:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 23:37:02
 -0700 (PDT)
In-Reply-To: <cdfed37dd6a24a4afffc0d880601e2c7@www.akkea.ca>
References: <20180723135117.2090-1-angus@akkea.ca> <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <cdfed37dd6a24a4afffc0d880601e2c7@www.akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 26 Jul 2018 08:37:02 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd1NZtyDmBnLnsQafH2AKufAsB-p78JM0s6kBXK3APhuA@mail.gmail.com>
Message-ID: <CAJKOXPd1NZtyDmBnLnsQafH2AKufAsB-p78JM0s6kBXK3APhuA@mail.gmail.com>
Subject: Re: [PATCH] bq25890_charger.c : add the BQ25896 part
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus.ainslie@puri.sm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 14:17, Angus Ainslie <angus@akkea.ca> wrote:
> Hi Krzysztof,
>
> On 2018-07-25 03:58, Krzysztof Kozlowski wrote:
>>
>> On 23 July 2018 at 15:51, Angus Ainslie <angus@akkea.ca> wrote:
>>>
>>> Add some debugging to be able to check the proper initialization
>>> of the BQ25896 part.
>>
>>
>> Hi,
>>
>> This should be split into separate patchset. Do not mix two features
>> in one commit.
>>
>
> Ok, I'll take it apart
>
>>> Enable the BQ25896 part.
>>>
>>> Add 2 new parameters "voltage_now" and "model_name".
>>>
>>> Signed-off-by: Angus Ainslie <angus.ainslie@puri.sm>
>>
>>
>> Your signed-off-by does not match From address.
>>
>
> That was intentional as I wanted Purism to get credit for it. I'm guessing
> that's not the correct way of doing it.

The author of patch (appearing as "From") should match Signed-off-by.
You might however easily create commit and signed it with your Purism
email. If you send such email, you will notice that "From" field is
visible in the mail message and it differs from Sender.

Best regards,
Krzysztof
