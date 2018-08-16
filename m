Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E98EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C2C21470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWUGMF5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C2C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeHPWq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:46:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43554 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeHPWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:46:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so5141829wrv.10;
        Thu, 16 Aug 2018 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tS1CpNp5MIbA3Yv1GFrUamzi2RbQ4EpOP3bLdcXcY5k=;
        b=iWUGMF5h5Rwp4KZEUBVI9X3YooQjAmULiW7Bfh5XWfeOakv6WHi8EgOu1pWcF2yM5f
         9iIDCPg0Ud2RQDHipebuoi0qmQeLDnwTg1ane8kHBKNkRJ5i3uJtQ4IFQE4MqEcwLLc7
         0IhpfIkasmsAL9zzpfuxXHhINpQp22VIqrOr0Xv0A94vkAhV5uYEs+DCMWAB2Z7ltd2O
         9ov85ppWDWd1c8XBuQmrDzKSEtWBML3aR8qN/qxlahULqjAuOuq8z7zgY3d55Y9pFKZ4
         GdLOrtuH0jmAA7SCZ9CmJBoxs6Doqb3qh7Q0kSslDvoX4nYijrqOSRspYPqWRQpQVT1C
         1hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tS1CpNp5MIbA3Yv1GFrUamzi2RbQ4EpOP3bLdcXcY5k=;
        b=rcNpOZgFc0RJ5vRxwjEA1TR6ZWy0etmRBkjIrKIGg0vnLvDZwiZkH4yAuzs9Fzlf7x
         iRbuFFchkzxUuzo74nQ9hNOalNBH+BTY5L3fR7ubvKID7KwFGxf8XlFQBLqC8xV7bUbV
         QAq5YPoorFWufnqUOckQTN82Atz20ydmIbxUVFqmOxZTbJhn2JjtV4g2gkbYuQ1X0wc0
         hSlM42obxjoG4srMvjPDRwqtogOpI2Nk9uzz14wAWvpLGWGxhhx9WGfFsAOA4YoTum/j
         C8FkFPMWvxW9eJp+tnXimfsx1iKyHTZJfjZz5SMSBCyilTbqdY/jZCjDhTqLA659dpEC
         BhFA==
X-Gm-Message-State: AOUpUlHfBWYlLY6E73qcNKMHhnMFgvATtSHyXxbWbVyyDkWdfqdFKgSw
        Dk/RkmapEfYGihNRnWeFI8k=
X-Google-Smtp-Source: AA+uWPyCxPtkbTnPmRAyXa7kFJQ2iVZCE0zp/6QVOpxiF/ngxempTMDQQlNKwx7Zb0HAbl5csxlTug==
X-Received: by 2002:a5d:51cf:: with SMTP id n15-v6mr21000189wrv.107.1534448789909;
        Thu, 16 Aug 2018 12:46:29 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g10-v6sm113635wrv.90.2018.08.16.12.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 12:46:28 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:46:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/15] 4.9.121-stable review
Message-ID: <20180816194627.GB22905@flashbox>
References: <20180816171625.340082081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171625.340082081@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:41:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.121 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:11 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.121-rc1.gz
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

As an aside because I feel it needs to be said out loud, I really want
to thank you for all of the work you do coordinating getting all of
these fixes out to us, in addition to the developers for writing them.
I know it's a pretty thankless job, especially when you have people
yelling at you about stuff that "you" broke but it's an invaluable
service and we would be worse off without it.

Thanks!
Nathan
