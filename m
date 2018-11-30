Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83C3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7582146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="SuCLWEMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7582146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeLACPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:15:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44095 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeLACPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:15:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so2928160pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=eRF5DJ8JH5GFhxYJAvcejhjoVk1L84tx1hoxJF6sONM=;
        b=SuCLWEMyxWFQiHTiJhSE7UgWS7Z79Y9mteADQeseUKksHPLCWOIUOgCoGGZjGzrrFG
         amU5MoClpyJ/+um4MMX/zUaMeZ2fameHhHxNv3SdwquCK89KlETawBd5hBzLdP45vd1H
         +1Zxt6UpGNXVdoQ5j1X8n7w3ASlV4Hqgjl1x+in0uFeRt78mf8wT6AUFQAQGX657sNtO
         VFadvUEJpswPZdD1622ZYSzDUtDXTeXbeCSTv7nwvdTOXoDJEMULfMMkd2Q24o2nR7Hd
         kDxbp7CRnTMrKrpYtjSFdtoa6nXh2d3M+WtXnZB3EoG2FQpf/h23zKM88de7+Y22g0p5
         s5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=eRF5DJ8JH5GFhxYJAvcejhjoVk1L84tx1hoxJF6sONM=;
        b=GDEIrpXYTXgfESOHugnyRDiv3wvcjXzq+bg0gbjM4RcvhWQkpHDf8RLGH10CtEuD4C
         mM5QID7VhWkgbpFnqX2FA6lX9tgjjsdFwfZgChb10NOZbISEwMRdYbAvX2lTXcJE9wHt
         rUHpg6UCnrWoHNlQcL+RTQauWvvK9S6BgErd48ywDprk/rWz6goAO5VR9r08CjjhwqrE
         d7iabcdYJnSlKRmqk9qvEKcBCfY6Uc/fo7ef9jG4mFdpe1JTT6EtegPMytsBT/fjbBWI
         Cbfc2KVPFbICmLk+xqEGFxAkSCNQhSn/WxS/aK8pyAlc27r/gmlbMhAXrLfxJgalXZy6
         IgqQ==
X-Gm-Message-State: AA+aEWZXjaoRQSzNmpZgW7+dbRJ0NHsgYHDReKaAd4xTzpeFSMj7ghFs
        TBlg+0qBfH4xfOiUZdbDFDpD3g==
X-Google-Smtp-Source: AFSGD/UBiQEPvVB9xIkJHOwwCnbTfZhJdn284ROi62+MOn6zyAH3/IUuhHMHfqdaosZoQxbIoYpRjA==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr6029068plb.241.1543590324243;
        Fri, 30 Nov 2018 07:05:24 -0800 (PST)
Received: from [10.19.49.101] ([159.65.157.165])
        by smtp.gmail.com with ESMTPSA id h64sm17190991pfj.186.2018.11.30.07.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:05:23 -0800 (PST)
Date:   Fri, 30 Nov 2018 20:36:01 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181130071752.GB1044@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org> <AD3AEAAF-47C7-4EFA-81CC-6E5686143854@prjkt.io> <20181130071752.GB1044@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <3FA7558E-DFC4-48F3-843C-2C0E7591BC23@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 November 2018 12:47:52 PM IST, Greg Kroah-Hartman <gregkh@linuxfounda=
tion=2Eorg> wrote:
>On Fri, Nov 30, 2018 at 03:54:48AM +0530, Harsh Shandilya wrote:
>> On 29 November 2018 7:41:31 PM IST, Greg Kroah-Hartman
><gregkh@linuxfoundation=2Eorg> wrote:
>> >This is the start of the stable review cycle for the 4=2E19=2E6 releas=
e=2E
>> >There are 110 patches in this series, all will be posted as a
>response
>> >to this one=2E  If anyone has any issues with these being applied,
>please
>> >let me know=2E
>> >
>> >Responses should be made by Sat Dec  1 13:58:54 UTC 2018=2E
>> >Anything received after that time might be too late=2E
>> >
>> >The whole patch series can be found in one patch at:
>>
>>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-=
4=2E19=2E6-rc1=2Egz
>> >or in the git tree and branch at:
>>
>>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-r=
c=2Egit
>> >linux-4=2E19=2Ey
>> >and the diffstat can be found below=2E
>> >
>> >thanks,
>> >
>> >greg k-h
>> Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg
>regressions=2E
>
>Thanks for testing these and letting me know=2E
>
>> P=2ES=2E My GCC loving friend Gabe said hi :p
>
>People love gcc?  :)
>
>greg k-h

Everybody's got their thing, I'm not one to judge /shrug=20
--=20
Harsh Shandilya
PRJKT Development LLC
