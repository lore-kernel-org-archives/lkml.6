Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49459C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047A421722
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YruzIQwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047A421722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeHUKlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:41:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35134 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:41:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id g1-v6so14954523wru.2;
        Tue, 21 Aug 2018 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uTqZh4EmUFtLjBa7E8iGzAgSWAQ+DU62c4TwIpV79o8=;
        b=YruzIQwFbASMAnCw5mWYrgLCqCIHvb2YW5TNCZ5TOnsBrAZjK6VEzRw5pHMU8u8HwX
         hzo0HKusEOkv7neAbFbzLv8sU95pcbbmIBq3P1lvvLen3uFBd0/fOV2VSSL8xdGJJ9PR
         S5oEsf/JvGWILU0TjcOHXZSZLxrZpEXdt5K5Nf/rPhQd2/2KbZ3+Zc3auscxNFxsYwgu
         Y6nWB8JNSCwOQwHA2Cex/BQN8GPF1dVnQxcJH/aGaGP3sMq2LP8Kvht6fzfBFUZ1+KEM
         GOEBL1hagNWCp6re2iK83GnA/ITjFf8S0G/lTAsZNVPFkLKKxFXbaD+bqQBYsVV0WPRU
         2yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uTqZh4EmUFtLjBa7E8iGzAgSWAQ+DU62c4TwIpV79o8=;
        b=N+6RZs6lPlDW9STRUa0IHrYw0VFeGfBxfyAciLsrRwRJMR8UI5gqGHfVOyBk107t/y
         LtB3jSa40ingxPGPlVQqeIwFvTtGc3MV0U44TU1sw19XssV811+RyA0A+pBRy2bCbx58
         XTqo3O22OO12poirr0ngqc9fCwPEbOw9HA4czoWp5+Q2Q67RkhD5xnGXVp1hPGbVxG+c
         cJuXzyJ9gFwKyK6WK21OMG1nMSj5H88dPCYijT+IXkux97YyIejOWeN5mahcUR6KOPwK
         KV+AjGDupYO6b4MoVNSC9KjSKTDocKHyuS98D8eLrQg6MHFExNdkvNOEpKQ26pxeXPNj
         D48w==
X-Gm-Message-State: AOUpUlGMcyP3v71gDifFoSJvfF9AElO3F/QcvQlyoUMt4eGq/uSa9TYH
        EWobuR6TmHbsTGXnKE6U9Q4=
X-Google-Smtp-Source: AA+uWPwI+qqmOlTXxfuqM/MFKu5ZjFeUy+7P6BcMfQdREWp6souuOhvwh1veo+OW9DoNT29COe+KGg==
X-Received: by 2002:adf:d08c:: with SMTP id y12-v6mr31601934wrh.152.1534836120855;
        Tue, 21 Aug 2018 00:22:00 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j3-v6sm9877631wrt.70.2018.08.21.00.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 00:21:59 -0700 (PDT)
Date:   Tue, 21 Aug 2018 00:21:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/25] 4.9.123-stable review
Message-ID: <20180821072158.GA27793@flashbox>
References: <20180821055124.909865464@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821055124.909865464@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:21:14AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.123 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 23 05:51:15 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.123-rc1.gz
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
