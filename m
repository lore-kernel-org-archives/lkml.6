Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF45F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXeHdrvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF45F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeINUHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:07:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39091 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:07:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so4429490pff.6;
        Fri, 14 Sep 2018 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M0O2jkd0sAesQdO5tAbwEX8lQhimT2mBpbkEapL4LCo=;
        b=AXeHdrvYfaP1vo4mU/HCdFJZ8hU/36+0Vr3XwlvjGl3+q5dwjoJ2ocvyVm/Qt2+ltp
         MbEvH0Hgwgj0sERr6oR/kGX5cCDLO6pvkiMtG4Ss4rW6YCXVkixXMpGm1Lp5kDBk8KQD
         XeN8nNtFNApLyxz1aWvhdxpn+FApSOGk+vuaOtyUIYOBFn8hmG30885X5+BBBozVFUPo
         EZBenm3Lqn5Sr2/hTvXZYZ9GrILGTboGvk5SIrT2KZ8Of9SL36tXmouKbj4UM52nL5Gy
         X4QCdqlmzoMNQPENvdUHe3WyPr1iSJWzeCQZNz/8+rUiTJFJstyU0uZAWhSZx4yNXNme
         4WwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0O2jkd0sAesQdO5tAbwEX8lQhimT2mBpbkEapL4LCo=;
        b=afrPtx4iqr68X856bSpXYPBmmcT0xJ5LpqqrXhIcYhayVXSpdb+I3ip63vdA72B21i
         L0fMi3784tKwGDWiSyfpgIAt2RS2/18MNHQumOmCanHF+VsAa50vvaB8kynY3qukn04c
         JAQEUZ2gjE9+zPFsfe/zE3Zh8Y6M4n8BlPhiyvIaABCr/DuqHiTS3RD/OXAjDpi3/fNS
         0QqGcDlexFlweh9Q78bHix7NEy6bGGZhUnyg4jALv5EsfOkvZTTJ0yWKenW8VpBqlfF6
         xPTgrnKOLirhoFbqJsdDLe5lejxgld5HQ0Vv+WeLAtPltKMmEgfGRiwqfRd2iWBETxPI
         IFrA==
X-Gm-Message-State: APzg51AyG6iohUTA7bBiTZkvqqvz0+6MJHPDygm34s6vYv4z0dknGdiM
        n6xWnhrqRsb3Oz4qXkHlS/0=
X-Google-Smtp-Source: ANB0Vdbhpb7msJuq1h5lX+FBOW3f7xsIbKLqiecjTEabUc7Gx/b4KKNNWRVRf85J+mROM/frbTVnLg==
X-Received: by 2002:a63:9c19:: with SMTP id f25-v6mr12435633pge.447.1536936772368;
        Fri, 14 Sep 2018 07:52:52 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a192-v6sm15390850pfa.124.2018.09.14.07.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:52:51 -0700 (PDT)
Date:   Fri, 14 Sep 2018 07:52:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/60] 4.4.156-stable review
Message-ID: <20180914145250.GA19599@roeck-us.net>
References: <20180913131745.261413581@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:30:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.156 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:29 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 285 pass: 285 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
