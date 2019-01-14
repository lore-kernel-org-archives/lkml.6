Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF37C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F12086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fj4vsC/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfANJKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:10:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43708 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:10:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so21872010wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OZkvVaIuQXs7x+OtOg/xeKYLbQAMBdgYeO08jpaQGtk=;
        b=Fj4vsC/kiUK8IgILrYdxpwtxOF+wOiWrpOTsx+niZd6Rq7SI6nsZeoaW+MR5KqRCdf
         uYLy3rY58+cM/uRK3yqvgMJlRUSSEvlYmxc1yU61QppvgVweoUbLXAYlAYqVJ0a4pzVl
         lf54quhZNLgoeVW/LnLVeEARI/rVFeIH0LTqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OZkvVaIuQXs7x+OtOg/xeKYLbQAMBdgYeO08jpaQGtk=;
        b=lfS2CfkhERa8tBoFzx5F6Gn+eYIZcVH1T9Pct6nZcFX2Extx020q7HdE3FOUQiciiC
         P10hlLUg4kGHknZ83abWkPmKt1SB3Z2uXm2IxX+4cXURPgIOeedigyHkj6ZdKKCFxcEz
         vfvF1dGxivPyfkVxu65XrRMaDGGEkAHF8uf0YpZ1Fjxhb3QnWbXeJB0tRxTIXuN+Ygok
         f3mnc466KmrC9BFDRHR7upEnO2QB85COsHg9yALmkU7khJLvQI2k1fom1aYSyvqr68pF
         JZTpATcY8xdiierJ49T8VWgpF/5gbSdVkHAdwzIsuOC1fiW4OMQfUQ9posE3uCQIbXIL
         T9nw==
X-Gm-Message-State: AJcUukf0laOFNH9f7+lDmQ6/9CTr3dP2sRBml2fPjbH2UrZE8BqzaFM1
        eqTOEB0UnR0uGmrZSYAduw+VHw==
X-Google-Smtp-Source: ALg8bN7jeh7FPcuwx+tSzAARqWs3NqtH3caNRbpGpor4Id2plYKvBsXt7b9tSs5ng+G5DPOr/Vvz2w==
X-Received: by 2002:adf:b102:: with SMTP id l2mr22658031wra.296.1547457000606;
        Mon, 14 Jan 2019 01:10:00 -0800 (PST)
Received: from [192.168.43.112] ([37.162.53.58])
        by smtp.gmail.com with ESMTPSA id g9sm24921670wmg.44.2019.01.14.01.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 01:10:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BUGFIX 0/2] bfq: fix unbalanced decrements causing loss of
 throughput
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <16d4065e-c0d1-7a85-3d9a-242bfd92923e@kernel.dk>
Date:   Mon, 14 Jan 2019 10:09:57 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7FF3405-74FF-40C3-8C0E-12108170CEF0@linaro.org>
References: <20181206181819.11148-1-paolo.valente@linaro.org>
 <09393ef1-9559-2042-6c83-75ed3fd529d3@kernel.dk>
 <8753C347-2BFD-40D4-A97E-DA955BC0207C@linaro.org>
 <16d4065e-c0d1-7a85-3d9a-242bfd92923e@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 7 dic 2018, alle ore 15:40, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/7/18 3:01 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 7 dic 2018, alle ore 03:23, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>=20
>>> On 12/6/18 11:18 AM, Paolo Valente wrote:
>>>> Hi Jens,
>>>> the first patch in this series fixes an error in the decrementing =
of
>>>> the counter of the number of groups with pending I/O. This wrong
>>>> decrement caused loss of throughput or, less likely, of control on
>>>> I/O. The second patch is a fix of some wrong comments, which =
somehow
>>>> contributed to making the above bug more difficult to find.
>>>=20
>>> Are you fine with this going into 4.21? I can't quite tell what your
>>> intent is. The first patch has a Fixes for something
>>=20
>> yep, that fixes a serious error.
>>=20
>>> that went into
>>> this series, but then patch 2 is a comment update that would not
>>> normally be something to be applied at this stage.
>>>=20
>>=20
>> and yes, only comments changed by the second one
>>=20
>> May it make sense to apply them in two steps, one in the 4.20 and the =
other one in the 4.21?
>=20
> I think so, I'll do that.

Hi Jens,
is the second patch still queued?

Thanks,
Paolo

>=20
> --=20
> Jens Axboe

