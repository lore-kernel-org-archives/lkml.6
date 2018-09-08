Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABEBC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E532086C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="x5GjGe7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E532086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeIHKH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 06:07:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41677 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeIHKH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 06:07:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so7948762pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 22:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:disposition-notification-to:return-receipt-to:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=wI6Q16khXeVUO4k+zPVVpYgTsOg91H82PpCe3hYvOwc=;
        b=x5GjGe7SKIoRU/PK9iUKexdTZLFTDc7NBcdSlHLHQF2f58N7vA2X9vryxtgCdNR1MY
         sa2rtwwIMfqr7BuTwTEP0l4GPR0HVB9lBnX2xB1KznTnzFkbMPXjxXgilGyTefb+TZe8
         /T6c2fn9k9i4bQd+jxfw07HjaRMauDyj3W5NhXu/Q74kJYzKRF/P9lVKK0EAot5kE0xW
         Jmi4r4nzcqExR+/wuveJ9Jp6DDuOt/AXLbL7bUk/Xo3kD0QfoRpf9r7LAmmEGHIn5SVs
         hw1bD5lF+xdSVfDwSL56FkFuID54AByNGHf8gW+mzfyMEBMb0MTma8ahaOzvBhQTKPxP
         QEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:disposition-notification-to
         :return-receipt-to:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=wI6Q16khXeVUO4k+zPVVpYgTsOg91H82PpCe3hYvOwc=;
        b=uCdp1/sf2Z6ICkOvcbt2/oVEP9y/zGOmq7RQAzz+nvOhMDqyDO/jUwkV8jaIkDO+FA
         qWW4Rp5QUrhwEE0hAnP7yIdZBvLzhLaUbdE6eO3tuqleTLZAXUZBN6z+0KZ2ekDXik35
         irqtQvObUpz5hMYEVVuC3eiTnh0MB6MEJEWH/eG2C8CJ5l6tvbN+HRUN+8OGTNkaU5Vb
         TOkaHgBdwYb4RiOceUV5rsP6cdUFF8OY4ipDRtdwv6fI9SbZWWwN7Had5xVV48XGVZUi
         SioJhCnCSALR3aT09tiiMPmoqEBTwlbvwg5ljAlc8ajhBHkr60FMCaPn1VmXutLQNg68
         q5hA==
X-Gm-Message-State: APzg51CbDtCWEvGZYylr+XzaLzxYAOW8POPgDP8K6yvZ2vvpkvJGTcro
        nwYOZKziJ+pNKknJW3wxvkjdoHDBNq9f/Q==
X-Google-Smtp-Source: ANB0VdbLLTdNHln4lNOOaQ4Ut0kFo0bfLOoUNKSVNN2ojclqipvcjd0JiVSOIVd2LmEbVzaMxTH+gg==
X-Received: by 2002:a62:205d:: with SMTP id g90-v6mr12338499pfg.253.1536384209409;
        Fri, 07 Sep 2018 22:23:29 -0700 (PDT)
Received: from ?IPv6:2402:3a80:9d3:81d9:e0fe:c0b9:5c08:e60d? ([2402:3a80:9d3:81d9:e0fe:c0b9:5c08:e60d])
        by smtp.gmail.com with ESMTPSA id b18-v6sm11032103pgk.15.2018.09.07.22.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 22:23:28 -0700 (PDT)
Date:   Sat, 08 Sep 2018 10:53:22 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/29] 3.18.122-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh 'Shandilya <harsh@prjkt.io>
Message-ID: <5188E506-7DCF-46B1-BE91-086EB2356D69@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 September 2018 2:40:21 AM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E122 release=
=2E
>There are 29 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Sep  9 21:08:52 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E122-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Cleanly merges and builds with Werror in my oneplus3 tree=2E No immediate =
regressions noticed=2E Thanks for the update=2E
--
Harsh Shandilya, PRJKT Development LLC
