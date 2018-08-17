Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9412154F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOZq5DqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9412154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeHQT0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:26:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56196 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHQT0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:26:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so8101815wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gPG1nFJl4BJUmIpXMFbgVMePRCecCZ4jPuYrD01tUtA=;
        b=UOZq5DqMOO8xVUnpObeF/WdqyGnWmhj5pbVBzsJ/bDFLbx4P/GWEmppm470+WN5fXE
         PMUGJoBUcEu1kO8Q3eBTd2D2zya2l/j4qF9n1K3d5xyKcWm1yK/A/tssRfHMtuEXnxs6
         Mo6qVMz1nB/WN46Z00Jm6Ozr8nabScnkzUjIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gPG1nFJl4BJUmIpXMFbgVMePRCecCZ4jPuYrD01tUtA=;
        b=LdH5I6n+5mjmUR0+jEhbW7iGLCB6LJZ1T843C8e7QUXPDt0uAHwGOLOzfhQMUNLwIA
         LxoQJFrAuwSJ8iI66eYJ+3bON2LwNj/bJ82eTvKG34dcmBUj7kV6Ya07F+X+MHITXE5E
         syKZ8vNAPLJZWnZ1byE/YPpYxC3IYQiazJvHi9iFEmWQy7rrEspHcSpd5/jKCDu7KVrH
         dcBC75gop024r2BWTHENC4VHm1nNrJ2d6/nhrdyWlgCeqg+JEgeReVLn6qNvJOpG7CrL
         3p1FbJTY+PBKld7f4GFuGZbwktkMXnjuQvsdcD0VUYDEnHtyq3pYpkR7HJ9eGpzPeIPq
         6QXQ==
X-Gm-Message-State: AOUpUlGSC7DZmMTa90UlzN/pR+fmrypAjeU2LQgqa8W9UXEXTHF+Fg8g
        G3Toff9OoPDRmGtGK1BmM2eYrQ==
X-Google-Smtp-Source: AA+uWPxCm+bmr2zurlVrsYAV7OEWeTmD1sIuYJYcR148l08Uj5e7kxcTbEMm5LLbTk3JH9/ihdYC5w==
X-Received: by 2002:a1c:3e8e:: with SMTP id l136-v6mr18507504wma.45.1534522919795;
        Fri, 17 Aug 2018 09:21:59 -0700 (PDT)
Received: from [192.168.0.100] (146-241-23-108.dyn.eolo.it. [146.241.23.108])
        by smtp.gmail.com with ESMTPSA id v5-v6sm2253112wrp.87.2018.08.17.09.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 09:21:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/4] bfq: two fixes and one improvement
 related to I/O control
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5ac17a9b-1c38-0664-15e3-ff75c9671388@kernel.dk>
Date:   Fri, 17 Aug 2018 18:21:57 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <4873FEA2-9E53-4C76-A6B9-4AC82CDC8E6E@linaro.org>
References: <20180816165118.17402-1-paolo.valente@linaro.org>
 <5ac17a9b-1c38-0664-15e3-ff75c9671388@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 16 ago 2018, alle ore 21:10, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 8/16/18 10:51 AM, Paolo Valente wrote:
>> Hi Jens,
>>=20
>> while working a little bit on cgroups I/O control, I found two nasty
>> bugs in bfq. They break bandwidth control in simple configurations
>> with one-process groups. These bugs are fixed by the first two =
patches
>> in this series.
>>=20
>> These fixes improved I/O control so much, that I could reduce the
>> write overcharge factor, used by bfq to counter write-induced
>> issues. This reduction is performed by the third patch.
>>=20
>> The fourth patch contains a little code improvement I made in a
>> function that has to do with I/O control.
>>=20
>> I hope we are still in time for 4.19.
>=20
> Patches look fine to me. You are in fact several weeks late for 4.19, =
I
> need to have anything that's going in to 4.19 by -rc6 or -rc7 time
> (depending on whether we have an -rc8 or not). This is to ensure that =
it
> gets plenty of time in linux-next as well. I've queued up patches this
> time (since they were small), but please send them in in due time next
> time.
>=20

Thanks for your patience. Next time I'll respect due time.

Paolo

> --=20
> Jens Axboe
>=20

