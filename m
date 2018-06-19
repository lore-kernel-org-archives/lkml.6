Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D6FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEFF2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+q5HHXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEFF2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756575AbeFSIJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:09:07 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41538 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756535AbeFSIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:09:05 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so28715012lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pgITfR1LCt7o3P6uj5BDGBifDaW2vF7n4ElX8J9sYJ4=;
        b=a+q5HHXWydPwHW/DbvB6mxFsgyQvvSEAyW7YbhM28f77SLbHoO7B9HwfkWJxrrLizW
         KKzqVQVIaLAvZrQRZzTzNuIV19mor2mwfY/M9sH6Ij0G34MdBGGtH+pnf37tmHeYEltt
         BESAzMAmx3qEYt1BsyoP6P8yM/HiEgvif4YzZjGM9TIEJ8vYEN6eVwKlwAM1ZsD66QL6
         EY3uCXzRbjYHMUHZoxJwqtj3X/27dbCDGeJj65uYeVcFIt7v9KluATJvSWY8jZzdYFeZ
         Y+ymeaOC2N9cYFnhFT1bDvAyOErQyy/ThOzbWoKEwIKN6jkweRulATwVQOJ5uFObjXJ3
         TTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pgITfR1LCt7o3P6uj5BDGBifDaW2vF7n4ElX8J9sYJ4=;
        b=chWU/fB/WFsA9p4i4iWT9/XFBu9K4AlwV49mYzU2xv6FFy9Plxw51LJWXj8O8ZPtzK
         Qge8ArDUqabQlfJeYllnsb4wKNVzsh9BryusjyYplXsTmIP32v+p45xGO/sQ660ewKoj
         ca6wSSFosDiUBWXOVYTJD5nhSQDt7UrBdIF5gmUrGot5FKrbxXqUKk7maqBRKrUxusAV
         stP5gb4EkaIn1IzzPnmYTDM/nl1mgOdFTtKQd522/On7/KJMb0LnKPgLWD8aT48qzS4k
         HMJL1JUeR4at6L7rdZxxI3A5vzHzXtZSvwRb7RlQ34MTcuoCq8LdvyxtLS3wEZGWJ+AA
         wIdA==
X-Gm-Message-State: APt69E1jIWOJf6u2OOPrRqLN5qfOWkONU2B+dGo4PX+W6p2HWx3Rho82
        WlFl5yoA6kuGmzL05acfwl3H0Yy8+OfmyrIgWjeVqQ==
X-Google-Smtp-Source: ADUXVKJLYc91X+yd1EZzDm9Tqeh6dvuTsR8y37zB8mnmQ1wGOCo4J1f1Y6VtyticxTC/HGYlNK4VVn8/+tNSYGSUr9A=
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr10250711ljg.22.1529395743668;
 Tue, 19 Jun 2018 01:09:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 01:09:03
 -0700 (PDT)
In-Reply-To: <20180619071828.e3ahbyprthi6i6t4@kahja.local>
References: <20180618150717.1066151-1-arnd@arndb.de> <20180619071828.e3ahbyprthi6i6t4@kahja.local>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 10:09:03 +0200
X-Google-Sender-Auth: jZog-Nw80f25iGSGTF_H1kDzzUc
Message-ID: <CAK8P3a03_CdgLCfov7Ynn69-V3L7RKoJ=6jxsoTWf7+NM_8-Aw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove get_monotonic_boottime()
To:     Quytelda Kahja <quytelda@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:18 AM, Quytelda Kahja <quytelda@gmail.com> wrote:
> I'm fairly sure this doesn't matter functionally (yet), but perhaps
> 'notify_timestamp' should be updated to an 's64' type since ktime_to_us()
> returns a signed type?

I think it's fine either way, ktime_t is only signed to deal with
differences between
times and the theoretical case of running with local time set to a
date before 1970
(which I'm sure fails for a number of other reasons), but boottime is guaranteed
to be positive as well as monotonically increasing, so an unsigned
type is fine here.

> That note aside, I think this is good.

> Reviewed-by: Quytelda Kahja <quytelda@tamalin.org>

Thanks for taking a look!

     Arnd
