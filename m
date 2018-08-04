Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C619C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544A2217D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2MxhbQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544A2217D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeHDL3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:29:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45446 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeHDL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:29:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id f12-v6so7575536wrv.12;
        Sat, 04 Aug 2018 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fBSAKK7Yif8naa+XFOhqWlJda9sQTn+GrYmJkcUUzkc=;
        b=J2MxhbQRwxH6eJFTsSk8ncZD6av6Lk6liyJRQZ92wcXw5oLuj7lVeKKxEN1/Bnr+hP
         kcqWiL9gNdoqyW1oYzoTaIyCDOYfBGUF+utguO+x5SWM5TXuFeMU+X/A5H0+g9+yPBoH
         iQd206ToKpfLRAZ2unvbMtsE3nNsjkevP47smU/VxyRc45iLiQChynZqwTz+9+2q7YdH
         Lx/r+k+xFfCdrP+404N2E288kkwvsXCumzJP6g1JtQVc/scMUKpzlsMjEBVuF/r7oY4g
         BXQS9D03O20rdAewmE1JUPLOpR8iHXJlaXRfF4odGdBQTSXAa5VLi51A1++6xsfZHelr
         xJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBSAKK7Yif8naa+XFOhqWlJda9sQTn+GrYmJkcUUzkc=;
        b=cvaWc9sTDiivATFe5I82eEkg8iyoQqjbW1FHAsWPX6O2pO7yAzkEgNp6QjLyt+0c1o
         9dFpm3Tz0JEwO0HkqBTfZE9P5UOQG/3xvblKmQcNQRUb0/8q44M1c4xvbIDdWRIUJEWl
         iAtsTsByiJe5XyH4mnRCNQCATFc4Mn4/eoScrVJFcruHzHvmZVn4KW/1gHFiANtIoAvz
         iGFnmNXZ7QQAPlfDjcX7L6oRlPfvjohs4nYGcSgGTTxhR3hyEXteb5JhBm0IihJiz5YV
         gYSE3qPgh8yaiKyspSuVbjjyihh9GFYV/nC1nncv0P2ITE0IcGBVW3NHBqH7huC1REag
         dWaQ==
X-Gm-Message-State: AOUpUlFzrrzziAaUdg51WoAKchY/uXpealRiIsGNdXieQRSPM5PcHM0u
        tJNY3xaCXtaB1ofSVF9r7FJSpa36j/mOLA==
X-Google-Smtp-Source: AAOMgpf7Gr6PPTEVqCUaJglM3DUGnbjOoPBtkaV3qrNvPe5Rz1H66G8NA275zlePBhVTsPuU3gc1vA==
X-Received: by 2002:adf:9e84:: with SMTP id a4-v6mr4598162wrf.70.1533374965332;
        Sat, 04 Aug 2018 02:29:25 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g125-v6sm1375017wmf.16.2018.08.04.02.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 02:29:24 -0700 (PDT)
Date:   Sat, 4 Aug 2018 02:29:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/124] 4.4.146-stable review
Message-ID: <20180804092922.GA27721@flashbox>
References: <20180804082702.434482435@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 10:59:49AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.146 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.146-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No issues noticed in dmesg or general usage.

Thanks!
Nathan
