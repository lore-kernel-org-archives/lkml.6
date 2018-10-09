Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E3EC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856652089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMOKOIcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856652089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJIIoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:44:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37335 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:44:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so10836046plb.4;
        Mon, 08 Oct 2018 18:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Y3PFzuEe/Qp3LsFSQEE9WQgvGzWssFdxtjqmNhL1dk=;
        b=OMOKOIcW6Yt5gHG3apn1JKQlEmj9s25KyFZT3n8lVNl+Xl8RGth964XYUHvwvW5vSn
         cdNBfUI+EVNNeHFureddnpMpqnnMfn8IFaFVIPcvgkF2UbaWO9UQzydkmPEep7D9Hnq7
         jwVGCmpS7R4Xwzcvk1lMAJ0kiSc+Dd2xP5BqTv9sPYuIv/d8ixreEfKaHBoV0s32aVdL
         bGH3H0gP8r9IPNUXV28lLZBjsmztaRkJwAgJZ4iA7ujlPZV1UC0Y5qOvrultNblzRdk8
         Za99YyLp/ZVHsYCneLxCKmU8SB8i7gG4jCRikZx0YMsDZIDKayMPzfT+UaY2PD+4nvQG
         2OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Y3PFzuEe/Qp3LsFSQEE9WQgvGzWssFdxtjqmNhL1dk=;
        b=SkathzJTjahTsqN65pPjjGjD40ClBZ8xRuRyTXeZuC4pooMhYR6o+snj/LTOr1/lNE
         PhusbPAD5h7Q35JYZskfljz6aA/QixPhdCq8v2HJdUmmXxu2dumgc2EfcvDsGjJe54iO
         BAom0Im6X9UHFm7ET17NRw4g5hjbIyPc1Xt+B4dP4uCziDjALcpFZhY/h885vl99dwdq
         CMDh6OJL/cFfpsM6ybAJPZtgMyLDI9xn0fhEe3VX+cjuss0JSvxFZQQJeWX3l+5DzIMR
         k0H5WHpbwDukZAMPKJrQyZIwtT5vqA86wnm2qVVHpp6CXKgHAPv3Yy14modr7JkyRffW
         Pvkg==
X-Gm-Message-State: ABuFfogjzCoLNhULX+E4jrDAF0qhntEdnxQ9VPTvecnPBwv5brmhCd6N
        Y9/K0G1ohMJbOPjc1EIeuNc=
X-Google-Smtp-Source: ACcGV606U08bD+ReR98rCyR/ChtPYZZ3exuvfyUm4cpCj0Qg7cRL7AUCQykpB7O1My5bNUUw+fmSLQ==
X-Received: by 2002:a17:902:7b84:: with SMTP id w4-v6mr25595586pll.32.1539048611953;
        Mon, 08 Oct 2018 18:30:11 -0700 (PDT)
Received: from localhost ([82.102.30.219])
        by smtp.gmail.com with ESMTPSA id x13-v6sm17569797pgl.87.2018.10.08.18.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 18:30:11 -0700 (PDT)
Date:   Mon, 8 Oct 2018 18:30:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/59] 4.9.132-stable review
Message-ID: <20181009013007.GB26684@localhost>
References: <20181008175546.620836256@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:31:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.132 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Oct 10 17:55:28 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.132-rc1.gz
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
