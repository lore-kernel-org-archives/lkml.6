Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862ABC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 17:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29795252CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 17:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db6/ZdhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29795252CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeFXRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 13:44:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33030 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeFXRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 13:44:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so10499865wma.0;
        Sun, 24 Jun 2018 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QIRYgFlqYGcBRQbvCIl6/A4br7p53xmp1Oe2lKDIXcg=;
        b=db6/ZdhMPg8SPXmnoI1uL8MF9FU7vaOxowNED/KDX5z6swBgL6HaBKwaXWFZRLI3OE
         Z6cH2kcqB6SH2cppurd7ADjr/fi86uusyRya6ipEg/X+9mjFn1E9QKAGL5hH/0OrBG60
         Bh3NLX9DxUF1fGJCGphQGr2YLX7Kd1Naq9JEt3DfNy0HlF2IgNngnutIDjVX9AyybTdj
         O3cfJ97p2V4KJ70SZ2sXLxXmtfTeRIMTCxz4oIlmNt3p2DoT2RxGLTNBZHE7RTq1pkeV
         kpbTcmhacwf8xI4tshFnH7YWI8XwSm8AyNeqja4NwFl8p6Xf0JdXmOv3yUaHrfDsk0d3
         ZycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QIRYgFlqYGcBRQbvCIl6/A4br7p53xmp1Oe2lKDIXcg=;
        b=nnV2WmbaqH3MRBptaX+JXCye+yAgjLwgMgFPtL0yf6J/yt+pJ0XygO31ptu8SoPCes
         isZ+gRvTMkLbHRmByEp/C0FsccUJMhMdqiSWSTcxOesMoQa5DTKblnhERoNE1fSSoV5o
         gN8+uvBzxFH6xyIGrXPRE3ek3HBP38JoZUTgu/ScWsSF5qD66QABFVM9BJq08zLRIQTX
         13vVWkhHlaD6nkuUDMogDhc9tPD75yM/GpCpqVUXwRMiUaWz1iDU3JKP2iFI9bwNG9S5
         D44Ekwone/349uNcjXyfd+nTQsWoGu5QjuO59xcEdJSbq3Mc5okmyxKRc22DCW31wrbs
         7KXg==
X-Gm-Message-State: APt69E0CkF4HjW6w0fNDxr4w43gFNBc/ulIkvdSxS1+GL5q4MA2P4asy
        d2/9pwzv4V2kKNkXAok4LymJ9Xv2
X-Google-Smtp-Source: AAOMgpcnVBKB5tplEfiWkqeHr7O9J0Ltw/jvdchLiHeJSoSL+uwBZfkGiOX6MqoqXuFfe6n9yId0Lg==
X-Received: by 2002:a1c:2fc5:: with SMTP id v188-v6mr2345926wmv.36.1529862258117;
        Sun, 24 Jun 2018 10:44:18 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f2-v6sm15150612wre.16.2018.06.24.10.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 10:44:17 -0700 (PDT)
Date:   Sun, 24 Jun 2018 10:44:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/39] 4.9.110-stable review
Message-ID: <20180624174419.GA13528@flashbox>
References: <20180624152352.038950449@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 11:23:47PM +0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.110 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Jun 26 15:23:25 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
