Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 684FFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4042086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYBjejyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4042086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeFLSRc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:17:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46951 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeFLSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:17:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so12517592pff.13;
        Tue, 12 Jun 2018 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQqlJuiwOeUlB38wU9Cc2b0I2zNJh7afSi42+RAOwcI=;
        b=tYBjejyK8FisVggZ/LS923ocGldLT4KbkDcA0xHdZ8sggTKGA+VGmEbu75ENiNvpA/
         BXy5ljDa8kJ4dRkjczhAAp7wXcWX7C9JY372yL9mnSiGctN1Gfas9PDnqxzZ5RL0R5n2
         d45kzoJ4QBUHTEiQOmZOShPjEwf+WzbYw5wnqV/lWt9iRjlRb3QWhgdFhSZff98cqIQF
         WI+gHUxd7jPo4bb9yePlupNKnhfKiVhjrUpWBOZSlOfMX/YGdE4GKGdWWtI440Qe5381
         9DD9DCbchnAvQ8KfnE6EKyxA4fRY1Uow0YoqrWs8NB6Xvil7I1ssPuJ/cbh8txtr4v46
         wRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQqlJuiwOeUlB38wU9Cc2b0I2zNJh7afSi42+RAOwcI=;
        b=QwXr0t224UEE8knWd5bUEjQ85Z9nn424Z+te8nzQ88IOIQCTAu2TwKUOoIR+JZgi5h
         Lh/aZ17llZuy+LgHTK1GzT1IZUiE/zkWYGYa9XQaYxJhN01yp1Mz35YcqGrCcNq+kb/m
         PVqaBWiTML3ZKUJo5TjoSwuel8FJ/seUuYroYeEGQ/AIMhSmvpvV5EWKtustFmumR2uP
         7r423ZPFx3vLfxspRb21I+R1KgpuT6J8BhPDfrEp+zoBPMtWlLQu+d65Hce/zjvWl0bs
         WuhtiAuY/bx2W5y1bVzcShRSK+Xn2Bmoa+DhyVdAjWDW3m9VirVqqPQ3HOq6LE5cM/Xy
         iPqg==
X-Gm-Message-State: APt69E2pMZK0YBKZ5BydlMyXfAz2ksbx7A6YRI8YbPrzeT4pcQx8X6o5
        KKfKvCY2hWfTFJsErTPsN9F9tqx0mKI=
X-Google-Smtp-Source: ADUXVKIkiESmFw085qGznxwaKytguzXUTnWV06x3zn3xa0HCXnimzYJvQ8pEuEO+h+jU/5XRJKK6Gg==
X-Received: by 2002:a62:9385:: with SMTP id r5-v6mr1512715pfk.59.1528827449310;
        Tue, 12 Jun 2018 11:17:29 -0700 (PDT)
Received: from localhost ([185.236.200.248])
        by smtp.gmail.com with ESMTPSA id u13-v6sm837288pfh.147.2018.06.12.11.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 11:17:28 -0700 (PDT)
Date:   Tue, 12 Jun 2018 11:17:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
Message-ID: <20180612181725.GA2621@localhost>
References: <20180612164816.587001852@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:51:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.137 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun 14 16:48:07 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.137-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed on my Pixel 2 XL and
OnePlus 5.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
