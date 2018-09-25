Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EF02086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ao/T7HLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EF02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeIZCZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:25:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35205 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:25:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id j25-v6so2994261ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDfam4ctWiO1F/1r/kkQNQQTL79dXU33pgSEcsRXm6M=;
        b=ao/T7HLD4NfLGn/Uxn+TLCR2auazMywNhpT0vws7BEzxAbbC0MX1A6RorEsKepX2LI
         OcZ3HjAXoHl6V3NbMUA62DW/FvXpB35Oqi7yr018b5+NmxiLy5yAWlAap6K2IYhrJtyR
         96atcWMjCpCfQVKaMdzrwKRWLR6RJRTluhXojoyah3hjZOhH8hItjME4zIIEaMDeYzzm
         45XxhIwjK1m6PKG/7Frog/lHBF/rYRv2Dg42Ha85WIGwjjK447WHaCET39qa0hvEw9rA
         yogzv9VDxp5WGezKo/Gjsriu8YJKpWZZGFan7ef440IO9XRrParKP9Ub5q9EAVqF4Okl
         fojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDfam4ctWiO1F/1r/kkQNQQTL79dXU33pgSEcsRXm6M=;
        b=GfgnFv9UhkvdTOFKQAg7r4V2nd6ftN22aYB7pI47EJIpzdWKxc5I4urAGMCxcQX2uc
         vYT8oaNgxdJh6vlNUGTSHj89mRC85H4/p0bSw/9wsesE1SJg5u5k/NjCZOOIgZ7eoduR
         O1Jbwr10kbTiH45uRTB5f9bEu+3eD+EPIHtlo7vVDeEpqfzklrEfjA2+vrjFKC3rAmmG
         5rIgcFpz1tzExMCD31VqMpzPl5crofjtLOTsG5Y868/ylv7jNuXlEebFQE3CEDsshf6b
         lT4cBPh8E2N4lXCRGc8rN0xYn0XMIpIR/t2RwJ2rZ98vcTBu3OTaBB6cUiMFnURFdYLe
         QrEg==
X-Gm-Message-State: ABuFfoh9j/Y/IOEHY9azK56jHreEQpPDsqap3ToH0Ui2mH0rpe9G+nT2
        tafffkxCS0upRxC7FXOCva1jyw==
X-Google-Smtp-Source: ACcGV63uAisbASXEnpJU3CPjWQlbFXbBXZmp0WwCuG0H8CZ+yDvln8slN+9rZ6LD7opa0+P76481yw==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr2016896ljk.42.1537906566317;
        Tue, 25 Sep 2018 13:16:06 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id s76-v6sm185779lje.94.2018.09.25.13.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:16:04 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:49:24 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [GIT PULL] updates for soc/fsl drivers for v4.20
Message-ID: <20180925194924.upvoooum2lynsg5a@localhost>
References: <20180924222017.30522-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924222017.30522-1-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 05:20:17PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please pull soc/fsl drivers updates for v4.20.
> 
> Regards,
> Leo
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-next-v4.20
> 
> for you to fetch changes up to afa86d264a7ce62ba214bc7c6012e2129141421e:
> 
>   soc: fsl: dpio: remove redundant pointer 'priv' (2018-08-30 12:19:02 -0500)
> 
> ----------------------------------------------------------------
> NXP/FSL SoC driver updates for v4.20
> 
> - Use of_get_child_by_name helper for QE driver
> - Remove redundant pointer 'priv' for dpio driver

Good summary, thanks! Merged into next/drivers.


-Olof
