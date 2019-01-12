Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3950C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25C220835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="wjk0rSnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfALO4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 09:56:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37846 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfALO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 09:56:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so8118043plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=V5E5HVvqK+1CLVRgcy4qbmvaCq3pUkU4xC3iEr63Di4=;
        b=wjk0rSncmJX3ss0hZ8/FECYtZvZrPye/UMwb41cKAJxeq9yk4DX3M9Dhfr3WUPHdrz
         W+RXo5DQumnzk3cSPksO/EP2di1F1RM7CClpffKeNtuOaGOfj4vphVm61dVu4zHc4JpP
         JTXNzvEwrXd/sVnKFBbbDckIkF6UugPmPBQLaxmVqSRhunOzOEIzsAg9C87BqpHwyrHh
         gztiLexK0FuUR/tf5iSOohhnEwLPb6mQWgT+3q8O10flsAGQ9Hl4Dm9kaT+TJGvbqF1Z
         8/xI0YS18HfnJPpNYq85XCb623nVDCmk+2R/jqx9F/AC9I0toeA1XPxay81VoHe3OiPo
         TUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=V5E5HVvqK+1CLVRgcy4qbmvaCq3pUkU4xC3iEr63Di4=;
        b=CERb4lWddmsLKH+j15hkzs8/s+JkEo4L8U8QPo4E4F7iVj5bYnxIqPF9h5lAGTTVPR
         oBzkORGWWhzxjkGfWOFR70/MIFON+T8e6MRv59ndKcU2vaVlfybaFvyf3uvCcNDZJ7Gy
         uB5LZ/wa2OpQeNmT7jNfO1ZzggIGIROuGDTM7w8GhpswVlCILdLx240Uy92oI4OSmcrE
         q0mmpN8rdiJDUp8bfEdScjuX9zECEIkj+t28cyeeCfHNYeu5N7Zk57XxWhdvGefyRhXI
         7tiHMuOe/k+hCAu3JUy5pzb7CxZ0cAgsPAfcwHdHFbBf2o4pQH7WFGZMGoAh+QQAJd/f
         LvaA==
X-Gm-Message-State: AJcUukcqyT8nZkL5fEioUae43f1zGtheENDSi4Adniwdoih6cg6w3DX0
        U4+xlxXqRwBG4C50xG350LqbvA==
X-Google-Smtp-Source: ALg8bN7EMgVWOTvjpJ05n3tpaKWWW0VTKG5TpUKZhIyRakUQ+HpOFPkWuih6Ha1GYbiJ8VX9l11gzA==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11mr19017125pls.259.1547305010840;
        Sat, 12 Jan 2019 06:56:50 -0800 (PST)
Received: from [192.168.0.101] ([103.57.87.77])
        by smtp.gmail.com with ESMTPSA id 84sm292523563pfa.115.2019.01.12.06.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 06:56:50 -0800 (PST)
Date:   Sat, 12 Jan 2019 20:28:13 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/47] 3.18.132-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <E1A9F213-D665-49E2-ADDF-3AC9600E2E44@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 January 2019 7:37:45 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundati=
on=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E132 release=
=2E
>There are 47 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Jan 13 13:09:31 UTC 2019=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E132-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the OnePlus 3, no userspace regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
