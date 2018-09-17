Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0BEECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42CC2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJvgR5RL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42CC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeIRF2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:28:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44012 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeIRF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:28:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so77722wre.10;
        Mon, 17 Sep 2018 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQ/qxaahr/BZzKvik1MlqT1L14UShorYR0wk3yDprxg=;
        b=pJvgR5RLBF1Agax6YUpx54XQ5SH6T5YYWOVhjrm6imYX38TP407u6b5pj+40dfl3dH
         5nPTE3WY/rPrrYj1To0D0eQ4jBJR33f9YEpfOYow43ctb6YR/cVXfPnXeFSw4iGW8mKk
         yz8UYlihmSGO80Ocdouw9jGO0cp5Juq+mb6Z1YttSyEJUSY5LRqAScQ7MmqFauXuizfc
         tH+BW20OabplzC+G09TPTtFouD0IufUOqwfmwK+JT+OBB79nNvXmNnpXUdX+aL5L7DhR
         7N3cHfKENE1v7nrDUN0E43cJc9I0AyLrvQe9sdmkQbXWTRt0nq3d91xjY4Jn3gUhLaPd
         9wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQ/qxaahr/BZzKvik1MlqT1L14UShorYR0wk3yDprxg=;
        b=a4hW9DzEBG/Kpkuophok5rGgypb8S0MfcpPKwmqJJez5l63uqGyyOneYlKFFqiz6hK
         dwbz1h+xPTDo6tDq9wGI2UA/+5crlrRln7GTl5uSzDKaaRK8Me1Y1Ucpnc4Lq/S+CSyh
         Vcq9lCB7xm6RAcXVe6s5cNjTM/407I+h8bKBam4N13WrEnn1uUSCuXlzizC6qW+M9lPk
         ImiAX62jLJkJmFhhjwO3fCcdhfmBr0XZB5sRFSW7m7fBwjoV4n8f6gjNpZFXi0rAENQp
         qiFviZ9DX1FMZu1EebULll4rBu5dYW8VRIsrIAhWaGVHafgBeMjgXNiMtI7wLo23jMMC
         mscQ==
X-Gm-Message-State: APzg51ATwEuEuZr+xUCXyjbEAWOpikfecxQDcI+tAmB1KEwE3hkAKPJq
        +QqnvyxP+pIbTwEKzer/5Js=
X-Google-Smtp-Source: ANB0VdZarBZ3n/iUCMgfaiNMoi9ssPfIjUHCV68n7ga+XENSuR4WluWR+9hTJIML7dukPk4SN7FBnQ==
X-Received: by 2002:adf:f045:: with SMTP id t5-v6mr21758986wro.92.1537228732694;
        Mon, 17 Sep 2018 16:58:52 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm35994107wrc.21.2018.09.17.16.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:58:51 -0700 (PDT)
Date:   Mon, 17 Sep 2018 16:58:50 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/56] 4.4.157-stable review
Message-ID: <20180917235850.GA5879@flashbox>
References: <20180917213827.913122591@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:41:33AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.157 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 19 21:38:11 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
