Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F383AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1602213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uILvfkYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfBZI5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:57:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39806 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBZI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:57:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so1428379wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OINstVuGmxmCCyv9ZkRDxTef6pKmaOlKxhXRqiUJKvM=;
        b=uILvfkYlX0rn+3Vi/BijgQaGJJOHoc77MWhlJ3pQOKKLffAvSsAjcuSpE6B1FRwbxu
         6gJoNiufDVwBUL9PdCmQwqaWXI9QEf03JVRSYnd3+xXO84W/lVvlyvSVIx3i4xMljFXl
         IXjdoaryMIx6xovwGCY5pA4W+k/NX25Q/nS9DX46H4ub8xIlrnKd45eivO+ssJZpjOsw
         BKFzTA30RaV9hu2GGEBsudBpopG+oVl9ZVgDG29IAzg9xcgIKc/UAHSP+5H+Ro9lfwwD
         RL8VbutIobpM9nnSfdkjn87WHxGP+QUowNO/Zv/4UEccn+jB+5NMSo7cSc4P6eA6Od5Y
         5VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OINstVuGmxmCCyv9ZkRDxTef6pKmaOlKxhXRqiUJKvM=;
        b=FI0e/6+5PR2rpgeVuza30N3suDrUzZ8B4TfgLVJVAsfEQayw2bCQmHrJDRpflBkR5c
         5cHcXlh4IGwxvsAE/wpI5rh5Hx71cI+0hxiGebOsEPetAlLKBXE7C4IUTafyZrjlwjfl
         vTnZeTr2t03r2oG9fDb2XKUPOPilZkQHWYbmrl4TYr/toY7vrqR3laxNg9spB03bRaLV
         BFagiHDU+caq/hDK7Iy2HXryYJxlyWUbkVkODOeYWIDZsUWbFsl8J9V/MQ29l24AYP7Q
         g2sxWPsZTuNIuZ3hKS/CZG5PvimPSoOKK3dZPjqpRFyUj96tFu3jna57JQIAeiwWdMO/
         y9cQ==
X-Gm-Message-State: AHQUAuYMcCpPmJCKWOsVypaLUT53cQQFFNWmimwkCBcvcyQT4ryMAG/j
        G1kKMwlkPfYVKyBTacmVqr7/BA==
X-Google-Smtp-Source: AHgI3IZVjQJU0U7r8j7D5l2mer33euRku0icbrUJbcztEl6adC3/zjch20/TdqH6yTvkZgbh3JLoQg==
X-Received: by 2002:a1c:48f:: with SMTP id 137mr1761364wme.21.1551171452986;
        Tue, 26 Feb 2019 00:57:32 -0800 (PST)
Received: from dell ([2.27.35.194])
        by smtp.gmail.com with ESMTPSA id d206sm18681774wmc.11.2019.02.26.00.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 00:57:32 -0800 (PST)
Date:   Tue, 26 Feb 2019 08:57:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>
Subject: Re: [PATCH v5 0/2] Clean up UFSHC driver
Message-ID: <20190226085730.GK4118@dell>
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
 <60e5da74-da0d-4ba7-6d29-2ca6008b6ceb@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60e5da74-da0d-4ba7-6d29-2ca6008b6ceb@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2019, Marc Gonzalez wrote:

> Martin,
> 
> Could you send this series to -next so that it gets some exposure
> and testing during the 5.1 RC cycle?

Replying for the purpose of providing some gravitas to this set.

These patches are required to support some exciting consumer hardware
which has been recently released [0][1][2][3][4].  If they do not
find their way into Mainline very soon, it would mean that supporting
these devices in the most popular Linux distos will be difficult to
impossible.

Please consider them for the v5.1 merge window which opens in a week.

[0] https://joindiaspora.com/posts/4714199011120137995e0218b7b935a5
[1] https://liliputing.com/2019/02/now-you-can-run-linux-on-some-arm-laptops-designed-for-windows-10-on-arm.html
[2] https://www.phoronix.com/scan.php?page=news_item&px=Linux-On-The-Win-Arm-Laptops
[3] https://fossbytes.com/linux-on-windows-10-arm-laptops-project/
[4] https://www.techrepublic.com/article/open-source-project-aims-to-make-ubuntu-usable-on-arm-powered-windows-laptops/

> On 11/02/2019 14:31, Marc Gonzalez wrote:
> 
> > Casting a wide net to get as many eyeballs on the subject as possible.
> > 
> > I'm splitting this mini series off from the main "UFS on APQ8098/MSM8998"
> > as it's 1) ufs/scsi specific 2) controversial (to my surprise)
> > 
> > Please send all your Reviewed-by: tags if you agree with the patch,
> > and/or voice your concerns ASAP.
> > 
> > This series removes the "disable-VCCQ-power-rail-for-some-Flash-chips" quirk,
> > and cleans up after the dust settles.
> > 
> > Marc Gonzalez (2):
> >   scsi: ufs: Do not disable vccq in UFSHC driver
> >   scsi: ufs: Remove unused device quirks
> > 
> >  drivers/scsi/ufs/ufs.h        |  1 -
> >  drivers/scsi/ufs/ufs_quirks.h | 29 ----------------
> >  drivers/scsi/ufs/ufshcd.c     | 63 +++--------------------------------
> >  3 files changed, 4 insertions(+), 89 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
