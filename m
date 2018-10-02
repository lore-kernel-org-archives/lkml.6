Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C6C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FE1206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct5i1gEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FE1206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeJCCEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:04:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43143 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeJCCEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:04:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so3474317wrt.10;
        Tue, 02 Oct 2018 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AVtUFwTAcoKpexa5P9jL4ArwO9HhrsTrF5AUEekmhrw=;
        b=ct5i1gEfXCWPutvf+tRqsuqhZN15ryzw1WJNFJIHDzECTuvx2bWZG6hvz/0ZBEKtof
         BIZOF+mWSB0NqAk/oLx3XSm8bRtBs6pKp2Uc1+Wf2OTi2EPQMyTyVqJqwLe6BDkF6cYX
         0LR7S8cUSObhGNvGOCJ3tkVN/iq+ORbFe10qrkd1I55LrcP2cpHsKvPWnIn9wZpnLx67
         sb347ajoR0Q4q3sgB2vS/QWpCFE77hjgaeK/XV3hxjYUxPcpAvv2cwAHHumj5fea0cDi
         mbYjLCK6sQ9+mpULI55RTTS3qWaTWStOuKib9mcKJT9QxSsdWeofjlqDG8WB5XQBjAxH
         I9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVtUFwTAcoKpexa5P9jL4ArwO9HhrsTrF5AUEekmhrw=;
        b=DaMW5yI1mEBDnSqhbEd8hL9bFLpTWIlFaGJ7GocE+J3WKbPKegBYBqUIzbvzb4fimj
         SdLdfdGtlThvnsriWFbPDqhRDpoehpmIzsJFWLrhZdjvS/QnI9wdyKy0fhjFyidzBYNb
         ZyU6xzjKNgRTz2opnlqasBzmAU33gkZbGlzuFN0qCS9cH1r69lgOG9kRkSKAKSWWQ92t
         reH3GUU1GD61JJQ3R5QYeEMkxeLnpMXbHnqphWsm5Ta8ymRe0ovr0furqA78SDMQZJu8
         WhXvVyui7X5tdcgQvUUpGCm9/BngIB0eU3WrT1lEXk6poaEZsfi7tMkL5HgWqePBCl7y
         DOzA==
X-Gm-Message-State: ABuFfoh86kt/8wPT3kqSXyuDslpHdQQnzNW0oUNaWxPM9Dpkw5RyDQ2D
        WS0n3WpgCZIlybuHpDuti24=
X-Google-Smtp-Source: ACcGV629xWUmvTF4CHRhCj9UeNDDj2DIIKmqfRd8w4jo7QRQKcBlfmrkhKVQI56I63QRuucOQKbiaw==
X-Received: by 2002:a5d:694c:: with SMTP id r12-v6mr11112529wrw.170.1538507983079;
        Tue, 02 Oct 2018 12:19:43 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b5-v6sm17815457wrr.94.2018.10.02.12.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 12:19:42 -0700 (PDT)
Date:   Tue, 2 Oct 2018 12:19:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/137] 4.14.74-stable review
Message-ID: <20181002191940.GB4996@flashbox>
References: <20181002132458.446916963@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:23:21AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.74 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:18 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.74-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
