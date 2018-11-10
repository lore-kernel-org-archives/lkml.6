Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F9C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A704320854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWufW7qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A704320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKKBvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:51:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39130 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeKKBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:51:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id e4so6826762qkh.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 08:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EcdW/U7hU0q6Sujkw5k1W9H2/xacK57Y72uraSe3gsA=;
        b=LWufW7qeqfeHey9Wfmsn2j4fBnXeK0ldVhAVWbTxKZWVd4npK1V4LmO4tTLjlHnoF2
         zf+8iveMml2X+xF4sbIkoBm2No5S4BZOTy+HOQuHKTSRRrVVlYztZF+3MvfQ1zBL41fa
         2eMVYcXsnuqXNM/wJ+D4Fr/I2ZTzh7Ze6VaoiuOvV4tA9bTAscA9yUWNqK6KLFBVcoVQ
         5VHn29AnGNWz2H+NdTug95hGRKopvcOHFhfr1weQcqR9NgIzvrLljD061ioJSnyGUN+D
         vsLfOZGEk3fgHGBUzmAZpIgQPeNbGWILPlwCts5ihWyYKlE6+NTjyY1CuB1AlCRij4Uw
         a2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EcdW/U7hU0q6Sujkw5k1W9H2/xacK57Y72uraSe3gsA=;
        b=UxX2qPG/yqCWwagTx7XM+1Em9fsBSi/pNlVjhYRUuA47qYqJcJp85or+Lr+iwRvTkT
         /xfQRSwuD7WMuAmKCPgD10ZWvqjnRb3l1kgkGPklQT0ztxvial+ZBTe6AnvCaCqu8xp4
         pTaPGvOhmxUNT0D7YDNNHBbt/NN5NIxriFRPWwjLq/ybiyS8/Fwh4BCpedrmFFOp0+re
         W5N+NZPwu0+JWC+MCo5G3pHPxkV4HVkUuvdcpYVky8/Cdy9jvr9i9JjdvTm+eZFejxk4
         KpampYUIxFm6yD3dFvO3/dz9b16aP8L67KlFa4Y+h/5HTXCDtbpaNeudIoFy7O2emnAl
         k5Fw==
X-Gm-Message-State: AGRZ1gJr1R5IXNduvpzMyoii0mKNuc2Au8QsyDDlGtaVgL4mck/4pke5
        m4WFDpqpQiiTT2/qOxb/Bg/cF+w8wBWA5x3fW0A=
X-Google-Smtp-Source: AJdET5caTQyMLddSBMvUlwmnolU/jRdmhToL5DGR6xcGcU90M+BPEUkqOubtaHH+53KKbd2Zt9DlEGt9+OsLaSIt83U=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr2046389qtm.96.1541865948772;
 Sat, 10 Nov 2018 08:05:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Sat, 10 Nov 2018 08:05:48
 -0800 (PST)
In-Reply-To: <3f5ff18e-a264-981d-505f-69636fcf4355@free.fr>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr> <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
 <20181108093617.GB8433@e107155-lin> <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
 <3f5ff18e-a264-981d-505f-69636fcf4355@free.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 10 Nov 2018 17:05:48 +0100
X-Google-Sender-Auth: MaQbR0NO2sY_CUkvjHj27BnBIz0
Message-ID: <CAK8P3a3z_BWHgjvWFBEHLvOdbcGnh6NZ4eT9OtSqLGFHPGbigg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> On 10/11/2018 09:57, Arnd Bergmann wrote:
>
>> On Thu, Nov 8, 2018 at 10:36 AM Sudeep Holla <sudeep.holla@arm.com>
>> wrote:
>>>
>>> On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
>>>> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
>>>> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
>>>>
>>>
>>> Looks good,
>>>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> But I left it intentionally to avoid churn assuming it will go away when
>>> ARM SoC team runs savedefconfig and sync the defconfig.
>>
>> I would never do that,
>
> Isn't that what commit c432c0880596 did? :-p

Olof did that one ;-)

        Arnd
