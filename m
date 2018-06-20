Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB32C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D1920872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAqBMlYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D1920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeFTFii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:38:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39121 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFTFih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:38:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so4324177wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bOJwD1M/0G3qWCAda8g7k4D9wDFaISizLW8dWZgbifk=;
        b=nAqBMlYakjb6cjApRexSwfn8380uBd34YfO6NURI0v9O6YY09H9pScxV8Ydm0socM4
         JmXVOwXzV4wzoGcPbHHTkFpXLmyp1QHz1entHUO4peHVxwSXtPaOx6PHo+W1xv3lfWwi
         RiA5U9rR1X9uM/KPRyA5O+FvbPdCuS76RnjZqIJxCvtyLio14Fg0MjmuGxtntexVAlbi
         AmoWimlYv2p4NDtgmqP2yseud/K28ET4MfEdxJLMhsR4OjBss6MsuE3mpdh4Qm46x7+L
         HJ7R+xVRUJi0HRl1Mhyo0cewb+EwrTk0RBZtJAY6uiELZAQ07N5s8DSnscxDc7CXqqip
         ea1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bOJwD1M/0G3qWCAda8g7k4D9wDFaISizLW8dWZgbifk=;
        b=ey4w7ZdFmlgW5UBRFkjCNiZdbd4U7kkoegRFhONFmqtzW/DEQ/O7OX0tS1/HOi66qv
         A2MWQJPtqRjzUDRSMRoq2TKuvmmj8fZmldSK1eWBO4qFtaDOu2FYqtTfIWohaNIVZLrO
         883/DdKme5bjqEVVD4quLd1QUMv3863l9L9ekJINwlyWKTdlx5rdbStJpiJVGRA0Grji
         LNl1gfspM0U1ZOIvTKKZCAYWQJY9X+wQw6R6p3GyiLO3ubl2ZjQGvlPbdEXKuIXa6Wvw
         1Ac+F3jE7YgP5Tdo1JtIP5ucbWlUw8792w+/ylSwGYtwlCWGRCjXQn4gDo1QpNfJIG84
         xZxg==
X-Gm-Message-State: APt69E3Qxco/eH6i7smHV0X5XLVtnrKj63Jbe/oeT5oKlK3yXCTTH9Bw
        8TOlzqWisJuk1EeQfCAVjVO0a4v0B+wDuwIdmfc=
X-Google-Smtp-Source: ADUXVKIlkyGPEr7OhcZ2rfTDGgN/lFnP734tmFOo8nFowrqCEpwQLH+LnFz56JmEl4CGRfc4vV0szFpZ72/eLHv2Dvk=
X-Received: by 2002:a1c:6fd3:: with SMTP id c80-v6mr446421wmi.151.1529473116003;
 Tue, 19 Jun 2018 22:38:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8271:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 22:38:35
 -0700 (PDT)
In-Reply-To: <1281343974.18398.13.camel@wall-e.seibold.net>
References: <1281342353-18180-1-git-send-email-stefani@seibold.net>
 <1281343038.12908.25.camel@localhost> <1281343974.18398.13.camel@wall-e.seibold.net>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 20 Jun 2018 07:38:35 +0200
Message-ID: <CAFLxGvyHVhEfxa0Qm=sivMgisB1N71HGymT4zpVSrQ4zOnrjNA@mail.gmail.com>
Subject: Re: [PATCH] Add quick erase format option
To:     Stefani Seibold <stefani@seibold.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2010 at 10:52 AM, Stefani Seibold <stefani@seibold.net> wrote:
> Am Montag, den 09.08.2010, 09:37 +0100 schrieb David Woodhouse:
>> On Mon, 2010-08-09 at 09:25 +0100, stefani@seibold.net wrote:
>> > From: Stefani Seibold <stefani@seibold.net>
>> >
>> > This patch add a quick format option which skips erasing of already erased
>> > flash blocks. This is useful for first time production environments where
>> > the flash arrived erased.
>> >
>> > Signed-off-by: Stefani Seibold <stefani@seibold.net>
>>
>> This scares me, given the lengths we had to go to in JFFS2 to cope with
>> blocks which *look* like they're erased, but which actually start losing
>> data as soon as you start writing to them because the erase didn't
>> complete.
>>
>
> I know the drawback. This is why it is only an option which must be
> enabled. And in most use cases there is a subsequent ubimkvol, which
> will fail if the flash is not correct initialized.
>
> Flash are normally delivered erased. So this save in our production
> environment (Nokia Siemens Networks) about 5 minutes per device (256 MB
> NOR CFI Flash).
>
> The old JFFS2 was very fast to install the first time on a flash, it was
> only a simple mount of the MTD partition.
>
> Which the quick format option i have now only a slightly first time
> installation overhead compared to JFFS2. Without this option the
> overhead is more than 5 minutes.

This mail arrived now?!
David, was it delayed by mailman for 8 years?

-- 
Thanks,
//richard
