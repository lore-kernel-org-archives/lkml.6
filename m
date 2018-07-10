Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D75D20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4/D1UiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D75D20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbeGJTJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:09:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54795 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbeGJTJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:09:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so107100wmf.4;
        Tue, 10 Jul 2018 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=51g7B3mXVFxmkaq9s+AiB239EVyrcc3EgnYF49D8onE=;
        b=Q4/D1UiY2IHhJwk+07qkCYBh8bd3nQSvnVF8PNQ61h2gQGjAFzfK5p1cDk9LO9GwAS
         JiA1A5NDdjFOBMimM4pNMGRAncQnMpzEgTnwV6ZxgfX6Xgo4Xf+6dQgE4iT7QbBvBxMg
         BkGQ/kvSW5NwkbSBK6fbomOucIZd39qdIBinLapaW6bTOrWw4BNsdojh0Sfdu7szaY/t
         evW4bMD2gFEko21XC8I9XMEOAwxvy90cyAoLIcNpbLNxWraqgqiRBBKcSwd62QbWmG8A
         Ofx5bWkmxLNPF1UEktG5gtkPu+CA3WgcYiPgzYNDEIfj2AH4AhBz+GHF0RiBrvAeD3D6
         XZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=51g7B3mXVFxmkaq9s+AiB239EVyrcc3EgnYF49D8onE=;
        b=Tn/eahxe1t+1wMSea5hE8UAxFwJihmlGgaSL98/T3mAoeJ9iWRK6AlyTi+HVMeBlyB
         yTgGn1MLGOD5OcBtKBdYB6+oikv2N+7xAaNwU+Vy3EUcI/6YjjlYVc3jGYwGtqAZsIpO
         aPg2N9GJILWmWCn7cni1tcbERisCIDaUU+cppTrlEkDIFC+SH7vc0mDWzp+BtKxnxGrr
         6VvMZH6Ypq+nTd+oZt9c4Ce1Hf3VgP6WUb9Q5JOWak6Qkd1fdVUBGZ4yxqQ+llcEK2yN
         7TyOYFrfgrFXtQdErsPCsPRMuE2yugU75mqCgN+jkqx9rUYm7MDMnj0X0DCHymIZPbI1
         nkrA==
X-Gm-Message-State: APt69E2ZC/IqXmp0RPNO/0LMTFwI977ecu6Qthv9c7ZbtsU1O0m6MxUo
        LjQIwEPeGd4GXCdlsUOKhMBGnr+h
X-Google-Smtp-Source: AAOMgpc/ny0upREICGILyr8zc6rlntrA6FbefhtwiU3HCPh9x8UEQ7ZNB1H1WsvasEcJy40XFlLWSg==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr15517601wmb.14.1531249745933;
        Tue, 10 Jul 2018 12:09:05 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b33-v6sm19008900wrg.45.2018.07.10.12.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 12:09:05 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:09:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/23] 3.18.115-stable review
Message-ID: <20180710190903.GA7871@flashbox>
References: <20180710182308.877332304@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:24:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.115 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:22:59 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed on my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
