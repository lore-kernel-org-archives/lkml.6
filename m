Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE237C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8956208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ruHBQpdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8956208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeGHQNt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:13:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40676 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeGHQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:13:43 -0400
Received: by mail-lf0-f65.google.com with SMTP id y200-v6so13331849lfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LvHIoxprSF3Jhci0unyqXSqbBqdI0fJxMmz6VH7tI5Q=;
        b=ruHBQpdvAMQDOcV+IxPon4C0IZfNA7Rr3hKzqR0Oc0VA6b6WPawWM/1Wb+36UZo6X8
         oVFG8horTquRxFvdbUcWzjmb51zSVWhMuZ7uFVLvwNBBJmyyEfGG/gkvR3H73Kp5WrbT
         r8P/iyqX8SMwWAR3HBfvqa7KefCCCXPliObeP30hqvuEe+h0PUxa0BS4+ajpXdLUHmrh
         0wJZbdPZyQT/gszt40U+HZ7bZ3OdgVYV4h95ZY6TdgIdE6cwx/RkV6T4s7B0zF6ORFXs
         G2/pLVm8iRQuxzBKLMkl5drlEGTJLCoN2gsZ0++Hdi2xbPglslgV05KLB95Wtx6Q4Sfb
         UQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LvHIoxprSF3Jhci0unyqXSqbBqdI0fJxMmz6VH7tI5Q=;
        b=umcdGmNIhwUgvi2hJP1l6kOESoBO432Te+unGwKACU5DUaj11ZrB/Yrw9gE3A9e2q0
         wUio/BHKGXtRoD144IaI/nPOuzouZdBQQg1yHm3wk11VY5QCEzLSWg6l2tq6rOGsUCZI
         CKrfJzZvlmAQwUXhKDSUqxNdNkFyZAMBgUKQ11dm6mvuenJxIfUrshgADuuUdOL3NyDa
         851A0E0OayaLHEE3xiKpNTJhuZNpcRzZIXMxOLarUvpkvsxWE+oNga4yxfsJ8ABwrYAN
         HZ7me5gvmzidVg4G/wn/Gm8s0bVfOQCktTtGT+1xoKNZf8cSqicGN57rI2H/296Rlg9x
         VeRA==
X-Gm-Message-State: APt69E3+cIF7dqOeqh+8ZCIJgfyB5CdwEtfNIY012LpY9c28Xjq09uz7
        On8ZA2x3zT74SG9vbgcUqOqzyA==
X-Google-Smtp-Source: AAOMgpfDZKZHL2TVXplJngtF61eYoVfh/trzEGpoKxul86tTsaA/fega3ovoAZNr8iHZbuYud8jxtQ==
X-Received: by 2002:a19:2194:: with SMTP id h142-v6mr11887638lfh.75.1531066422406;
        Sun, 08 Jul 2018 09:13:42 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id l3-v6sm2001870lfi.36.2018.07.08.09.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 09:13:41 -0700 (PDT)
Date:   Sun, 8 Jul 2018 09:13:21 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/3] SOC: Driver updates for v4.19
Message-ID: <20180708161321.xqrxliflp7rl7kkx@localhost>
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
 <1530912342-4641-3-git-send-email-santosh.shilimkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530912342-4641-3-git-send-email-santosh.shilimkar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:25:42PM -0700, Santosh Shilimkar wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.19
> 
> for you to fetch changes up to 990c10091db318c7eb7e8935c86b6f7c01585015:
> 
>   soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused (2018-07-06 09:47:51 -0700)
> 
> ----------------------------------------------------------------
> Keystone SOC driver update for 4.19
> 
>  -  Add suspend/resume functionality to TI EMIF SRAM driver
>  -  Add wakeup M3 RTC self refresh support
>  -  Fix for the PM runtime ifdefs

Merged, thanks.


-Olof
