Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC203C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2442152E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgcHQcoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2442152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeHZL4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 07:56:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35838 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeHZL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 07:56:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so10847480wre.2;
        Sun, 26 Aug 2018 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vLaWJHX2Px7n7CkUs/CNALrxQPiVxXWZPcTsp9uQZjs=;
        b=bgcHQcoLDaRvv7G4Cqo9tboRPIth815X9cOfaNOoMDYB7nj/eEkchyxB7S7k61clQM
         Rmm38+7MvBT55+IVTNzh5Db8nX04dUyJKuGdT7Tnc6GRcflt1xpaWR1IR/gK2Wix2Rnr
         /yz6x0YGGjkKZmGqbMZFnF0ZsKae6DIS9dJEWVhG37GvKI94oK/G+IA6veIS6YWOfY+A
         08CXxzUQPFGut3snZaI3wx9UDAE2bGrj0UOlopRqRNfKbdAJWAgciSljMRe601dNELQC
         tlJ/aj+6c7twCPyuR7kqGvNfTtWeOSozBp97nfTjS1ry2elfEq8eNF6tkN3HEaHGXXxa
         MkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vLaWJHX2Px7n7CkUs/CNALrxQPiVxXWZPcTsp9uQZjs=;
        b=qCdJ1QX7ObC5wTsOCO23qAQFmWbZ0ucZDr1V1U/xGR+yLoobTsdTHLd8bTZ/UigWIj
         /YdNhddbvO3ol90HbOCijur9wqsM7ueEKsb/Jyb3d17mL5oX6FJ9RVKGWS4Y31eI/tLa
         TKk1MPAWiFD0Scn17O6Twpj7aMJVcEeFhn7zPMDKBDbB+/m0/TCTOyQYPRuAvG1v/8vo
         9BM4bQs2qTCVqjEE6sUGK8cGiNpYG4MlZbOCcLBIMNRnuKH62k7sXu3aZ3LE7X5I9hS9
         Xkyj4LMCcV8SJVAOcev+2cUHm1H3YeeYGUxar7H3OoCSXIzHQzSBOfQ1X2j9BpbUJjS3
         w9Rw==
X-Gm-Message-State: APzg51B0PRFuhp1cjtaUmGbiUqXH9iqazvdMGZm6NCR3rO4flNmHiLCG
        VAWP/a+63BNy7fUsEkITz3M=
X-Google-Smtp-Source: ANB0Vdb1XUbkBGaq/etHbTemiI1I77dfyyWaEXM46Q7xryT1XIVuGArUqhVuRGhDGljZrvcdLJPqZg==
X-Received: by 2002:adf:a602:: with SMTP id k2-v6mr5107877wrc.181.1535271289066;
        Sun, 26 Aug 2018 01:14:49 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x15-v6sm5995636wrt.53.2018.08.26.01.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 01:14:48 -0700 (PDT)
Date:   Sun, 26 Aug 2018 01:14:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/56] 3.18.120-stable review
Message-ID: <20180826081446.GA18410@flashbox>
References: <20180826064232.320669119@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 08:44:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.120 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Aug 28 06:42:19 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
