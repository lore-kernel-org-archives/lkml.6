Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85768C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBC4208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rdZtxOIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBC4208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeGHQNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:13:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44922 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeGHQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:13:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so11731126ljq.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nlZ3TuvcCX0EAJjPU4G0widkLJfj7wMVUQp5kXuu6Z8=;
        b=rdZtxOIjotVjoWojrZcKUjSprM7tfKwUvCGrIjd2okzfIukmJMc3FswtCYXK1eowhd
         5YtZPQg8dvnQNv9e5g7Ewnhc5kXhj4c4Hh40dFvBwtMNwLaCp9QWMRgUitcA4TPLMGID
         TtIydqsvSK/9zC4e6Cn8Jg04otPINxLcYK2B2lONMCXxMjmQezaNakdmsqpP5V1m8cdZ
         uGkHeActK/gA25Z7PblBYs4UWyi3Wbh/psc7s9ra/rrJMnPo6pjcskwtvlUKz43QB1j6
         Dr15HPGjRNRz3Xtud9ZZSa33Vl6xoMn5X6PXtBNgsHWaSFr3NX456YPaKDcWZFKQ0n4Q
         BuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nlZ3TuvcCX0EAJjPU4G0widkLJfj7wMVUQp5kXuu6Z8=;
        b=ZNNA8tFQeWtCjMy+RLxw23CFkV9Mj9DVcoFkY4Dp+P+Fzb6DFpZT9/1MkXY52Mx+BY
         f3MyfCfYQN+rl6xEdrQBYOatq/B5jWhPpdfNWsAN7XHg+/7q0ZcR+4VPjGt66DFviOT1
         qV8+wSWBipGURCuAT6cOE8kBcAVrLASnqQ0VIh1lmSdTle8yJ4J12Olf/hKb0cWOQewd
         cJxPpgZC2Vz9v8MvicEa+uWBmjLonqQ28LvP0HREftToS3rzXLLK/IexDALBYrb5aSC+
         9a5N0YT9kqvCbQBaVcFlN6EJU78c1HqTsgG/O0s/FDXIOMp3uJCnpNS27iSyQLAD6/RV
         zI0w==
X-Gm-Message-State: APt69E0IHtHQhnGf7L7wkTAebsStimcfoQINAleiaZYjVtzNr5cYmlxG
        5AP1jVTCGl41j37hAQ4FKrb7f5Xe
X-Google-Smtp-Source: AAOMgpfywO77Olo1/NIIM/76ILF1G4kbhuly7KAc+tpQUOts6DGVMrNHU6CzTmjWzJSsJByPl3/iEw==
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr10380546ljf.136.1531066419579;
        Sun, 08 Jul 2018 09:13:39 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id n3-v6sm1079203lji.96.2018.07.08.09.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 09:13:38 -0700 (PDT)
Date:   Sun, 8 Jul 2018 09:12:32 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/3] ARM: Keystone config update for v4.19
Message-ID: <20180708161232.23erjlj4fqqc2ici@localhost>
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
 <1530912342-4641-2-git-send-email-santosh.shilimkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530912342-4641-2-git-send-email-santosh.shilimkar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:25:41PM -0700, Santosh Shilimkar wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.19
> 
> for you to fetch changes up to 60e9343b355118e903a155135f0511918d69e3ac:
> 
>   ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP (2018-06-29 15:57:53 -0700)
> 
> ----------------------------------------------------------------
> ARM: Keystone config updates for 4.19
> 
>  - Enable MMC support
>  - Enable Micrel and DP83867 phys
> 
> ----------------------------------------------------------------
> Kishon Vijay Abraham I (1):
>       ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP
> 
> Murali Karicheri (1):
>       ARM: keystone: k2g: enable micrel and dp83867 phys

Merged, but if you look at the git log --oneline of arch/arm/configs you'll see
that we try to use "ARM: keystone_defconfig: <...>" as the prefix style.


-Olof
