Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5471DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E7920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Um5Yhkff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E7920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeGZIpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:45:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36328 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbeGZIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:45:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so506802lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=90OO8vtHc2IIotEGcSbDjQKm91b2z1TjcTlzuxfCXg4=;
        b=Um5YhkffX9zQpxIjiPZQD39JG/wYlMLL0eWsRvKB5wHEO+b8zqNTRVYiOe4L/D0eQt
         paWSNNLnw4h81P2fap5inurMi0ckfGq6UwrMDjjFJ0WJP5Ru9s18lrRzkJA/7cn5PQc2
         Syx+mt6q1+71WqOWrRQ84JUuTDStDD8yX6iGuONSlwoChIL1C3wPOY7TKWYogfHZ9Z98
         DXyGRCprdVqWb/0fGxv4p240qsUDX4rCIPUjiiePnhzs3DTjXdAqXPMOH+LsHAa5OHnY
         IwMes4D4S1LVtBch8PvuMHReMWXjKne+Q8o4XpXIIfHO8J+zYpmoFax9VtwdpWnwYsKm
         zRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=90OO8vtHc2IIotEGcSbDjQKm91b2z1TjcTlzuxfCXg4=;
        b=WuDGhTJ7UCyJ9vBzKFRoO7CD0K/iwhGV0cLBikC1x5w85Gqd8sVlQ7DXyWoDY/0eFr
         nN1HbS6Aw5H7u/caBh8JvoQ4SJQMQy9Ee/WfzDftLw8mdndrbcgNVXnKe0w1n1LzvMyG
         sJzaOkfBfSa1cmCc9saOlekmyS4fMCr8OazDDatBLG4Sg77rPvwCWQed0JUhk1ibenQL
         x21L1RYcZmb7+TC4HZClvR6aoaaxkO8nIj1HiVyW0+MkbHja5BBYTZJgWuYTiNE8LwYK
         7O14PzrzEmkYMHD3HeNJCzml0dSXDROj0GnoJiJjx45wCb/yX0mNgBWBL9mxepb8dLse
         nLCg==
X-Gm-Message-State: AOUpUlH/SgpdscOdjOfuHR3BSrX9tnnRg4HBS+bWpg2TnvxqULlQSwIK
        Q9f8NXcV/EuGYozRW7h81nRXJg==
X-Google-Smtp-Source: AAOMgpedu5hmfrTQUDxyfIJ7Kb5NroxSEoYJMSlmZR/rJt0HBBkkpyskGkU5wp9Nu9eYvVrsuNH+CQ==
X-Received: by 2002:a19:db44:: with SMTP id s65-v6mr541851lfg.109.1532590220998;
        Thu, 26 Jul 2018 00:30:20 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d14-v6sm100660ljc.56.2018.07.26.00.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:30:19 -0700 (PDT)
Date:   Thu, 26 Jul 2018 00:16:35 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        gregkh@linuxfoundation.org, Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [GIT PULL] updates to soc/fsl drivers for v4.19
Message-ID: <20180726071635.whbiz5onokhvcjb4@localhost>
References: <1532469595-12060-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532469595-12060-1-git-send-email-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 04:59:55PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please merge the following tag to get updates to the soc/fsl drivers:
>   Moves DPAA2 DPIO driver from staging to fsl/soc
>   Adds multiple-pin support to QE gpio driver
> 
> Regards,
> Leo
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-4.19
> 
> for you to fetch changes up to 4625210899095195600062ff8542f37a1c9f5dd4:
> 
>   soc: fsl: cleanup Kconfig menu (2018-07-24 16:19:16 -0500)
> 
> ----------------------------------------------------------------
> Various updates to soc/fsl for 4.19
> 
> Moves DPAA2 DPIO driver from staging to fsl/soc
> Adds multiple-pin support to QE gpio driver
> 
> ----------------------------------------------------------------
> Horia Geantă (1):
>       staging: fsl-dpaa2: eth: move generic FD defines to DPIO
> 
> Joakim Tjernlund (1):
>       soc: fsl: qe: gpio: Add qe_gpio_set_multiple
> 
> Li Yang (1):
>       soc: fsl: cleanup Kconfig menu
> 
> Roy Pledge (3):
>       staging: fsl-mc: Move DPIO from staging to drivers/soc/fsl
>       staging: fsl-mc: Remove remaining files
>       soc: fsl: dpio: Convert DPIO documentation to .rst

Merged, thanks.


-Olof
