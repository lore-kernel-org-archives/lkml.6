Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90550C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4692920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="KM0XO0YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4692920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbeGXQwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:52:34 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39167 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbeGXQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:52:33 -0400
Received: by mail-yw0-f195.google.com with SMTP id r184-v6so1694181ywg.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GlOJewZS6VzUerVl4qqVPRWRfs3a2C2CoN6dKebhrVU=;
        b=KM0XO0YT9gH+vAeouG7XUB7bL8ZbeZMc/Pet94srGhtazhq1eAOK3Lhg+qgN0EXQBv
         Y5Jrw0RcEJMboekmAZJNJzBLPL0sAwqne5UKO/F8Smdd/Ewf7pyE9wd+E43NvOCpcHyJ
         9dp9beN3M+ATuUF0mQykHkmhxaRvG2vMuxsIlpMLC2whC/Bs9H9jRIQ77676zElB7NSH
         TB74l0MNa50NAsM2NaI+D+pDTGIlWIB/PBxjiU2XaSuE1Op1qomrdDT6OJQtkYGUWIGl
         yD+MDxPc5KwNBo734Tqi/PsrwoCpMShGX/q9SCQ4hKD7DdIDCdEoeS8MTp8HKYgfhhXp
         2IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GlOJewZS6VzUerVl4qqVPRWRfs3a2C2CoN6dKebhrVU=;
        b=dDHpPxMR2XygJQ2hR3b7+4/ZQsA2d9y2subykemi+g8TUG9uwdgkqosk/lCGpd6tnB
         56RsEnl51YYnFdu54dOymoyaLw1sgoxYZv7OTnKxQqzpnkiCD39oJF0Q7UKgQh9590kk
         5LW81/AKcHfT3vVddcoQBoZgz1TMIP6qM9JHpfzDG1ZisNwNnedEIU7bsoeVygFrHKnA
         J7OrSK92qStBxsjIKFdjeb0hPytISVKBQ1khiVJBPofEkDDVMVkVDd4BkiUiMXU2LDQX
         jgxdXBz3Y9Hjx999sZ60VPjXMn+cmP/VFlfHIJMiJ0KWqR6M3jm906jH9VkJeMvnVZSG
         HkZQ==
X-Gm-Message-State: AOUpUlEJz+XM+KRptx1zG/R519UumQj9bhNh+4qynU0mzI47zDr9ivY0
        6+rK1XfAu4RD6gNKIrDgtgTWWg==
X-Google-Smtp-Source: AAOMgpfpGVYgBfmieyyYWP1Wyt4ggcvkwWf/wXyRZhj3dsp5s/0l2ZNOUOWkzRSmo/Yld5g6mfHHVw==
X-Received: by 2002:a0d:c3c5:: with SMTP id f188-v6mr9082157ywd.328.1532447129138;
        Tue, 24 Jul 2018 08:45:29 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id 63-v6sm6760411ywd.8.2018.07.24.08.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 08:45:28 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:45:27 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxge: Remove unnecessary include of <linux/pci_hotplug.h>
Message-ID: <20180724154526.GB5871@kudzu.us>
References: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153237958637.172194.6734539971240967379.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 03:59:46PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The vxge driver doesn't need anything provided by pci_hotplug.h, so remove
> the unnecessary include of it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Not sure you need my ack for something so trivial, but here it is
Acked-by: Jon Mason <jdmason@kudzu.us>

> ---
>  drivers/net/ethernet/neterion/vxge/vxge-config.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
> index 358ed6118881..a2c0a93ca8b6 100644
> --- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
> +++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
> @@ -14,7 +14,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/etherdevice.h>
>  #include <linux/pci.h>
> -#include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  
>  #include "vxge-traffic.h"
> 
