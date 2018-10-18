Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C9AECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BD7204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJRIkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:40:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46999 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:40:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id o21so28078605otb.13;
        Wed, 17 Oct 2018 17:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YPSWkYi4Yn6BF9jSje7icF8G7gqvw0roJ+UMVgRDUJk=;
        b=tk7l5Q4J6VNTQgGNXBYH10jVyi419lTndCIHOztL30fue/UWZA98DuL1Hw67eXCsCF
         yKSyPmgCb0veHjL6+EZMjkpwf234ZbFxUtobOfD/sQNHVfJ1uYt2MpQd4VwD+uTHd/fo
         2ZdhjP7iwzmf1jZb1gzDlZWNbj454yEe1VeLXa/YNtTJTenmZH280GP6PXuvpIRbfXFX
         dkpltoTq/4bWzpFBPtfbygZHFKJze17G52r9Zw2RA7LQfrfbV6WETIXXFhrB/5IgNBL6
         CrV8T88WqCVmBKUASV4aUDKIMdnLcpjg9RsyEKW/SD3V6eHVxyGLixbLyNIiO+kDnc7P
         KXdQ==
X-Gm-Message-State: ABuFfojubhS7b1u/g+e6caSXejHpPF5LXfCgisKIFxQpBDzPfhoZXnK+
        VUrjXeH0A4ZEVW/ZZTgCUg==
X-Google-Smtp-Source: ACcGV60yumRSSuP2yOxNr7JHDNy/jcP9Kr++JcU/+LR6qPhZ5OM/KwbLO1or4sAkw2k3vWKVSn7IPg==
X-Received: by 2002:a9d:4c0b:: with SMTP id l11mr17570057otf.355.1539823335632;
        Wed, 17 Oct 2018 17:42:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l10sm5893764otc.64.2018.10.17.17.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 17:42:15 -0700 (PDT)
Date:   Wed, 17 Oct 2018 19:42:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Can Guo <cang@codeaurora.org>, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, sayalil@codeaurora.org,
        asutoshd@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, liwei <liwei213@huawei.com>,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
Message-ID: <20181018004214.GA5937@bogus>
References: <20181012213926.253765-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012213926.253765-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 14:39:26 -0700, Douglas Anderson wrote:
> If you look at the bindings for the UFS Host Controller it says:
> 
> - compatible: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
>               also list one or more of the following:
>                  "qcom,msm8994-ufshc"
>                  "qcom,msm8996-ufshc"
>                  "qcom,ufshc"
> 
> My reading of that is that it's fine to just have either of these:
> 1. "qcom,msm8996-ufshc", "jedec,ufs-2.0"
> 2. "qcom,ufshc", "jedec,ufs-2.0"
> 
> As far as I can tell neither of the above is actually a good idea.
> 
> For #1 it turns out that the driver currently only keys off the
> compatible string "qcom,ufshc" so it won't actually probe.
> 
> For #2 the driver won't probe but it's not a good idea to keep the SoC
> name out of the compatible string.
> 
> Let's update the compatible string to make it really explicit.  We'll
> include a nod to the existing driver and the old binding and say that
> we should always include the "qcom,ufshc" string in addition to the
> SoC compatible string.
> 
> While we're at it we'll also include another example SoC known to have
> UFS: sdm845.
> 
> Fixes: 47555a5c8a11 ("scsi: ufs: make the UFS variant a platform device")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt       | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
