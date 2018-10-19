Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C05C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AD22064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDtxCBqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AD22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeJSJp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:45:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33906 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:45:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so35264683wrt.1;
        Thu, 18 Oct 2018 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M0BTN6/FH/fB/1qj/HH+3V/ToN4S9C9Oh5I2MhvN9oA=;
        b=CDtxCBqeYRwmw9YnGZeZ03euinP2lAD01NEum9Muej93KE7iD/HaZZfccoBkXSB2rp
         ZSjHz5mS+fUzcRnoe+3+KaS1sjd/4DBO2eJY+opCnHg++0pYp5IGOWm504vGVHvDol/U
         4IKFpm0btLdQNjFIREB/lNg5qdzNZ0nXl2XvyJ2UctyVvg7QrYTvanxSySRHuNQh2ado
         ahMMHYwyUpbPLYp8qjgDM8lbQhvyWMFOZqXxOuFukZ5zY5ZrIWGysHmvrKVeDAsFUtdi
         dfA4rdA5Ja2nyomZHKJyxMiJn8UAhvkJykFeZueY19tI1ipwEtVTo2Aesl8I5FTk2ioV
         jQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0BTN6/FH/fB/1qj/HH+3V/ToN4S9C9Oh5I2MhvN9oA=;
        b=lPx/dNLmuv0F6drXynbbav5DwdhUNP8R5EfJmO1ZHtb7Y2xh1+mdb3B7iDpkQx+tpe
         IgeB40+bTDAfKdF0K5wmQ6UJrQD9DSHsgwVjcxpuXzESIBJi46Oz4vGgx5+0aDkyPSSf
         QKR8dV/dYl5H1Y8ZDnOoUAofEd83diM996SLMotstIKTjQobAmxvouHr70fBWNSOIiX5
         4GUTlFynz+hDL7tH54DBOzC79bckbqrm4cELyar9ep/lrCgpUotvS508hoPkMGl/A3SU
         pqXxkidWuwqUOpRWRRQmfu0LFFUMB3cZKhqGq8Ld5t1xeu+cvjgJTq+AJTj1qEepfrxp
         E4oQ==
X-Gm-Message-State: ABuFfoiVrIQ5PX+6H1AZK3Oa9t9VkcAB0b6N4Jzqz4XNjuy6lNiwIP3q
        Mr2afFB20AFv0m+VJhorsdw=
X-Google-Smtp-Source: ACcGV61YPKM+31SS0ti2ZmFNCMs3PJ1ruQF7eER2ZhNV/q1we3T3nE4FFbe9eCQjpVHpqY4FlBWj1g==
X-Received: by 2002:a5d:4409:: with SMTP id z9-v6mr29331174wrq.227.1539913295353;
        Thu, 18 Oct 2018 18:41:35 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h18-v6sm14596325wrb.82.2018.10.18.18.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:41:34 -0700 (PDT)
Date:   Thu, 18 Oct 2018 18:41:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/41] 4.14.78-stable review
Message-ID: <20181019014132.GC19093@flashbox>
References: <20181018175416.718399607@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:54:15PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.78 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:53:55 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.78-rc1.gz
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
