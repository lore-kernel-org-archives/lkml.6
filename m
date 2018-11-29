Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB400C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5E82145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="x/MtRJce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5E82145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeK3JbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:31:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35611 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeK3JbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:31:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so1575103pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=p+RkRfjIxg0bYgJRItiD+iuRMOGwmvzUG/PZ3z98Vq0=;
        b=x/MtRJcel0Vu6GXKy6VA9sOWIA/MJGUe5m/mnpUl+osq2nG0p/7y+8TbAz6r7x4yXy
         Mr8jhIfH8m9NVV/RMI6XH1IlGn5voPv/Sr8RGUbrGrhnICEN27WHqi/QUw381MmYvnbr
         9DA8kiHQWDmvlHfK8nw6J97zg1wiqUMb7I99aZ+5kW+o5OGNOQeMHeJzVGTecKGE7xcZ
         C3C5t9skmVkEyunSD68sFyMJfC3YzOyn4Tet5YPlO7xKyYVqGYJIwPtJOdHGQgqn2aP1
         yQ1QdYgSnQh+ytJ9XsbpBHvHxGDovp0mwfkZUQvXJdKpByRIqsMV2q5nIL+wmWdpAfVR
         iNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=p+RkRfjIxg0bYgJRItiD+iuRMOGwmvzUG/PZ3z98Vq0=;
        b=o5+NvX1tbGEuo2tuvL10CQ6xpAtXIOizCQJla+oIIHkf7DBF5/X256U6xMbV5sjDAA
         BbVnqtph+Y3Szm4eYhYtNJjBQxl6XFlsPJBY4jvxmeh9jrVjnvH0kKGPJS9cQUFUOwQT
         f5ZRVsHAF68Ggzai0VTeCXfih9VBtPIcfyzPE3GabN01coILUJwQcFVoiCQSS45vVNUs
         W1aVMVkYuOOSws1n56NsUjvSp4+DP/iQAUKhayhN/gJ+lk70rt2xRsPnhNTxugsULitz
         zetV+SmjyhsOpeq1n8h9/r3MIatMGCTAHp58EeMl/IlVMbYoR1u3WnHPSWox9CcI9xRo
         UaUg==
X-Gm-Message-State: AA+aEWbN58LjMPwovLn3Z81CDxAT+JGzzFzzHHtwpAar7wnh26Snv+TL
        rq8PyqTtC5MKPo5wH5TfHmE8sQ==
X-Google-Smtp-Source: AFSGD/WxW7vxu0uIZIpsTC+GNKYvtIzh5c9hBxnqvypsiEZXEBJxXWNLxLNVYsAvxTDB8OFqbARDww==
X-Received: by 2002:a62:c21c:: with SMTP id l28mr3154524pfg.74.1543530247005;
        Thu, 29 Nov 2018 14:24:07 -0800 (PST)
Received: from [192.168.0.100] ([160.202.36.44])
        by smtp.gmail.com with ESMTPSA id 202sm5754374pfy.87.2018.11.29.14.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:24:06 -0800 (PST)
Date:   Fri, 30 Nov 2018 03:54:48 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <AD3AEAAF-47C7-4EFA-81CC-6E5686143854@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 November 2018 7:41:31 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E6 release=
=2E
>There are 110 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sat Dec  1 13:58:54 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E6-rc1=2Egz
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

P=2ES=2E My GCC loving friend Gabe said hi :p
--=20
Harsh Shandilya
PRJKT Development LLC
