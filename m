Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63DFBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1926A208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldeDNnql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1926A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934396AbeFLRKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:10:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56290 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:10:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so290885wmh.5;
        Tue, 12 Jun 2018 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TmefNusRW/S8xmQc1tMtHCL8cI/Czl2OomSl7Y/MQdg=;
        b=ldeDNnqlY2tSxfgAHKPRtrLlJKwdeQtf5Rh59wNzOcqzFYocXBOwgSp8FE6P4frZHU
         n1qtvcOSEJtblBcqx1O7orfYblbAfc/f71hH2RlgomrWMM/tMF7aXGA8G5FzjN8i1Oe+
         LU/TchsGjJqffVvMmAOiZky6Dy03AqpDBMQERdfL+Zx1iUNXN5asZ/Slhd/9FT4lICCu
         7kzW253OSFyVx5NqaiGMcweGl6UT3Xf0V90y0CCEM+oMmpiqladDyZTf/NEtyPt2CAWF
         oYjSPeS/GBadK8czIXo7uE1EBfLtXdnZcdVdHV1PF7tb8jVPSW2uqNEH/XKsJQlCIZFW
         dz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TmefNusRW/S8xmQc1tMtHCL8cI/Czl2OomSl7Y/MQdg=;
        b=hmX4cDMj3Ksi7IgJl9RsbbLDEm5sXcxP3v3wi5YggcY6JwH4nHcltpca0IdMIRcj3w
         SB+e6iZ4VEKo6UQvteUnlkJVXy/OExp5NFhP8UBDK1Ps3oqfQuHFNEkJynvTJdJKFXgZ
         8TAzeD0M9Cg/xj/vGLQw2AS5PLP0XJY/DLxhilYJFcBiOhCgk/CY2DMSJG3xxhXo/x8V
         z7m/TiPZNBsrrMxeNuj0THwP1JTr29aJGGgVde8g4VOU/7E0WHTf6czDzo+KCbQsHKbZ
         GgcZOgCIgqxEQjrkXJGo8XMKg19o8KZ97YuODe+ejZho4eaKIdz7kcvO2CBsT1BGflro
         2wxw==
X-Gm-Message-State: APt69E05wjkjPXCeL+9h9eD9jWkBro+CBCwPX93QUWmgM5vSLKYx2E15
        Z154f6aCmyW47l4LQPL7Cxs=
X-Google-Smtp-Source: ADUXVKLx3OHnevKeJDT8iRW9Z7CqAGgcpMinvWD7PYnHsi0PuAEuYpGqvqNLXq4seR7GQ9i5gfCoNw==
X-Received: by 2002:a1c:afc3:: with SMTP id y186-v6mr780640wme.87.1528823442814;
        Tue, 12 Jun 2018 10:10:42 -0700 (PDT)
Received: from localhost ([185.236.200.248])
        by smtp.gmail.com with ESMTPSA id g88-v6sm1347470wmc.27.2018.06.12.10.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 10:10:42 -0700 (PDT)
Date:   Tue, 12 Jun 2018 10:10:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/31] 4.9.108-stable review
Message-ID: <20180612171035.GA31286@localhost>
References: <20180612164620.797338191@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:46:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.108 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jun 14 16:46:09 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.108-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed on to my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
