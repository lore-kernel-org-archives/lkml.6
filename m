Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFEFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB25220880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="W9JTj8xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB25220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeIZCZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:25:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33471 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:25:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id l19-v6so8518308ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xrd8PBrm0mj1gBSZSmwpuh+XvyIu416DvkmxGLGmjy4=;
        b=W9JTj8xvrtAhCdbNykTnZAlWssutN/MqFXYo5ze+4LYIX3PIB6bWrDFRFlnJHxrG+o
         ux0M2aJmkIYlwdJblD9iUwflyyg3uC+CZfywuTRqS5eoHS6oyFU0DcH+IsrE8TyPcA0x
         SOvDLhrg1CjXlANKC8B3YwmE5fD/35auRSx9hrPMNIWvzg+M13Riz6T44PDsZ2lW1Io8
         N6c19ZTWziSPDVztHl2PSWQV7J2MdMw3uv++4g3wqEJ2Ni6e0+cgqRmuU09lqIQFwELh
         vdxwTjB3foz482BQAhnD+YjU927US5jlQQGkcMJDnVj6R63XjTbeMTfM7UHXl8B33aLP
         RmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrd8PBrm0mj1gBSZSmwpuh+XvyIu416DvkmxGLGmjy4=;
        b=d2OJhbX5O4sslh3onJakQ3d2GV8fE2CWrWGCJVIgj+STSW9v3v2u08rZPH1ewNJ5UC
         1ixnlI1rLp+mAgFPnS9uYU9Y7d5SHEEv//w+j35NT52T+LtxP0d2Li4TiBiZjDEOsrbe
         YjEj5yg8EChFBeN5gK9XktUqypwPJuMfJOb0KXsIR4MebUcUtXd7gLT6TC/RT14dbE6G
         QB1hsANGDiNyEAHoFONW+2Il0AHEmuzuwiq62V7syUcZkIQxSxun+pbFidwX+4ZD515b
         ajGaJm3AKL2SCNLsMytsgZ2sJ58mEM7ZjQlZAzDlrBb0C4lJiRb6Jsu4T4D7MLpE+Dt3
         Zc2w==
X-Gm-Message-State: ABuFfoi/nvsLwHKko9jGrQ/sChCTfYRb/Eq0OnWnROMx0+aFyPRTMOB9
        aHmH4OCEj1aB5mTSqRymGQ6zZw==
X-Google-Smtp-Source: ACcGV63O4H86SHugVzt+c/1t5flrl/CVquzyo32ysuvAYzZ3Iv8NkG30pXLY1Yb6uidS4Uc5v5guoQ==
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr2188138ljd.31.1537906563385;
        Tue, 25 Sep 2018 13:16:03 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 136-v6sm571446ljj.35.2018.09.25.13.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:16:02 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:57 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19
Message-ID: <20180925194757.pp3jiltu36ih2wfo@localhost>
References: <20180924221954.30473-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924221954.30473-1-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 24, 2018 at 05:19:54PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please pull soc/fsl drivers fixes for v4.19.
> 
> Regards,
> Leo
> 
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v4.19
> 
> for you to fetch changes up to 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:
> 
>   soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-17 16:01:46 -0500)
> 
> ----------------------------------------------------------------
> NXP/FSL SoC driver fixes for v4.19
> 
> - Fix crash of qman_portal by deferring its probe if qman is not probed
> - Fix NULL pointer dereference by adding more checks in qman_portal
> - Fix copy/paste bug in ucc_get_tdm_sync_shift()

Good summary, thanks!

However:

> Alexandre Belloni (2):
>       soc: fsl: qbman: qman_portal: defer probing when qman is not available

I think this fix has issues, I replied on the patch. Let me know if you want me
to cherry-pick the other two fixes for now.



-Olof
