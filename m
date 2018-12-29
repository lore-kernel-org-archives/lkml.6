Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560B6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257B621905
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="Vf+exGbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeL2JA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:00:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33433 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbeL2JA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:00:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so11414545pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=0JSyTfgb3EDI95T69y6JNR7c0ouDuc9AI5k1zET+mG4=;
        b=Vf+exGbrYjlL8yOlezWoqzeGE7jjTZ4KCDyjtM/+ovofb2CzeC0t24HGlEiCTPee2z
         VxGNSdqo0EvBcbr1xpxQLY4xZShH6A9yhDzJoViShfldVqlHiNc5udrvwtFyf+0wdPHU
         R52EvL2L7R7DJcBy3wQ5CgKQo+wCh1UAeE5P8HtS6LiFiee0wqwEY7AMq1Ra8qztxl0z
         3gAPoZv2SwmbnMDdfeq6bm5X+51/nvy1ZOcg8HDbSOxxSpfXbnfZUTGJKLPwPklhWHjw
         audxgVt+FKZaL7Wf5c4L2xkRS+NtegGZRJkvuLZdCqn8FBogczBfIMN12VLUamwh+dva
         MdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=0JSyTfgb3EDI95T69y6JNR7c0ouDuc9AI5k1zET+mG4=;
        b=uGqgVnGQz0UmqWH1Ue5Ynk90kQd8MHoj9aCTmwLHDfiyTmmAinxuwBQSIa2q/rEr6s
         +ICIO6hnbjrMrMPgtpDakbnA60m2c4UdehQ5WT7uIq5u7gNCdbEN1/53pyYozVnWD2eJ
         tFa9JeJ303sFjhaSLnQvV6rUtKHdKM9zeGNoc9m9ubH1Tm1Hrmh4N1x7RJWLws4Jc7Ay
         CQ0EF1bE1PuFGrE8Wo6llJHJ9EqOnHOnfXy/8YAvB7Fli0K1HsqGPFx4wy/PdxBTnQru
         jJMTLfUO6odMAL2HfNSuwhzFZpo6D8miC09bUaQnuq39kFf668j0KyUS1XVDHwhHrBt1
         oVKQ==
X-Gm-Message-State: AJcUukc+Ez7+6WOP8IQ+DH4srwKyrh7Z92oeIqBQCEIBa3jp2aFnYKMK
        A3P7Af4p7A7hdyvOpnwi4mTuEA==
X-Google-Smtp-Source: ALg8bN6WrqmEyWeaDitqey6SvRWktTxrZ0m2Z1DmzajgEyOdfR5+xWK6scAV2Np7KwQGqunmCte6Yw==
X-Received: by 2002:a63:2141:: with SMTP id s1mr1017790pgm.148.1546074027290;
        Sat, 29 Dec 2018 01:00:27 -0800 (PST)
Received: from [192.168.0.104] ([160.202.37.176])
        by smtp.gmail.com with ESMTPSA id h69sm51254315pge.4.2018.12.29.01.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 01:00:26 -0800 (PST)
Date:   Sat, 29 Dec 2018 14:31:33 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 00/46] 4.19.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <F0DFEDEA-22A9-4767-AA10-3FFE2506CC79@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 December 2018 5:21:54 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E13 release=
=2E
>There are 46 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Dec 30 11:30:49 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E13-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E19=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
