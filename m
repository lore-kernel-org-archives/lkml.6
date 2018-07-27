Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0ABC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B59208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k80v/u4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B59208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbeG0Nni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:43:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42178 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbeG0Nnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:43:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so4858142wrs.9;
        Fri, 27 Jul 2018 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AqcwTsf/Xrue0zUUnyDv6PgW/E/AZ6YDfNgUh4Z7Y+4=;
        b=k80v/u4/jYmBIxlongFA20cR9mmR9EJr3qC0Lb7X+SRpPzqAalbaFwJhoJG+3nzgQV
         SM6EhUowK2LcPqndazDLrFSlb/yJIHt86BbJ0WUiKWXoYRkGcQ8N9xyGFnjiI4EkzPvl
         G9DnGgDMVllffWUC/pCL1/SqapVgg4LHocIoYSFHIgdPFajR+gTqcc0OH5HHZQPO0M5N
         tdd+LLXTcj/FhdqrVs4dhdk1jT0NZmB1ThMqoFsYZf618nHtBJxqqA69uwceCdCECQJX
         2siMwtsdrXsqs5e1WFt7FMMo9jVf2ZmAt8ks3qXERdHsR9u9mf3svMX9xCrd7mmmYcGr
         U6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqcwTsf/Xrue0zUUnyDv6PgW/E/AZ6YDfNgUh4Z7Y+4=;
        b=a0uQ721BHOMBwhVo7eXWKxDwX2+h0xiENAJ09Uu1sYVBbOJNspVotCCVHeB5jnjCHw
         LmsNqG9NwjT/rqdqpQvBEOLfUmSrNKJEITKJ3W4DNNazEiSRzjhrPaHDPH/8PhZ8selO
         oS/wGDDbOvwOcpFsqId6VqN+PfjtcWPVSlid1+8cEY5/Dy3fm6o9+FsNf4Gzw31CdI4e
         vziBpWlJuz7M47OVfsU7cZpWybRaPZDdnDqDnSFqo86XbBml2ICDIt20XGy5D0+wPj7u
         EkmAT/kEVgDS/6/VSSq1sSlmCe5AVkmDxbAlp96fBNWa7W2nB/ugdjY/Z457GMqKx4Ax
         A4SA==
X-Gm-Message-State: AOUpUlG/BlqtjpJg+u82jFXHNMiXxRM2WfBRSxPRUGL/vNfSrROps9sT
        hA+Q/J6om7ljPPH76N4R9jo=
X-Google-Smtp-Source: AAOMgpcaaMkC2jNshpHrTM2X7yUy1fTmI2T6InGMlqVMln7COcc3gWu4+tFVHwBmVUpdOe04S2cHHw==
X-Received: by 2002:adf:b112:: with SMTP id l18-v6mr4857220wra.101.1532694115530;
        Fri, 27 Jul 2018 05:21:55 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l19-v6sm3788361wmc.3.2018.07.27.05.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 05:21:54 -0700 (PDT)
Date:   Fri, 27 Jul 2018 05:21:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/33] 4.9.116-stable review
Message-ID: <20180727122153.GB2437@flashbox>
References: <20180727100827.665729981@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:08:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.116 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 10:08:17 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.116-rc1.gz
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
