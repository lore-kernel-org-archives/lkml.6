Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D51C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DB1208B1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="I0ESZNNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DB1208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934374AbeGCRvx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:51:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36039 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933569AbeGCRvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:51:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id n24-v6so2303812lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1LbWqS8wY9Ifa8ngXJRg/KG8uqIEK9Iye4KZzq3suA=;
        b=I0ESZNNHBnkkub6OaRukXUXM/vFV8CRKEOQr4nORmmlFI0DXIJqvvLikVVgPMbK0ok
         1aAlu79S0ts8Hq26N0dACALn8MsauQB+zAQ/x6RzSmegE0XtKhmGni8T9afNw1TIgnEc
         n2/KVgt34jQYSqRIf8ipM7xaz2Gcu4mEg9Vo9RcdTQz2DHsJyuexB4FonuQJQcsGHAQ2
         l9QMRSNy2+5tkUodzKNiKM48mciQcnKXdFTqi/UDpOPev/srbnooZeLchC1fyevntezD
         0M2F6ux3a8TMPmle2t1XyntYbjkEWk3Svq+giBppcxIitc+lpyCX/x5lZDYIkYKkDNKd
         wcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1LbWqS8wY9Ifa8ngXJRg/KG8uqIEK9Iye4KZzq3suA=;
        b=LP3TW0955DDmMUaP9Jz07RvZD8Zjma+1y6t4VKYgjJltduVUyPZyg5n/j0ifAHOUCU
         UCvyEb2vYPy1F+rzQpb7PPJW1/hZ/BX37kjwa+B5JRsYG7LBvzmnRMXs5RFd0G8Zbst+
         apnZAzXlrwQygqUO0LgmPOTO+wXcCF0tY1eO/z2tzKyhUJJ/aq8Ke+1VPhZ2rLN2hDz9
         5zEU+a8RNEV0lpbeWtl2q0cHFOTXtyK8NphWsSJGjh/UtbN/h7jHUA6yOsVht/QMMoU0
         2LXjaw6n9LsuFuepKv4DLUAJVNC/DCzzA3aAcZeQuRMkm5SArmUa9usXQNjT1oZX6pJZ
         0TgQ==
X-Gm-Message-State: APt69E3rL729IDrtS540DEUAbTa2AC/l8EFdnuCnyw7HDMt4gEHlxMSm
        YJebttvg0yq5GnQrZ2M/PZpYug==
X-Google-Smtp-Source: AAOMgpcL2V6KQJVblgNyGYGlhYgOYBqgNKe8zsaRIlhlqnKKWJmZZT5HZ0TUHNG7WwVpDMY6KaX5ug==
X-Received: by 2002:a19:73c9:: with SMTP id h70-v6mr14247310lfk.61.1530640310223;
        Tue, 03 Jul 2018 10:51:50 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y21-v6sm258431ljc.67.2018.07.03.10.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 10:51:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:51:36 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] ARM: disable KCOV for trusted foundations code
Message-ID: <20180703175136.vfx2nap7dsv5zen5@localhost>
References: <20180529103636.1535457-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529103636.1535457-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:36:26PM +0200, Arnd Bergmann wrote:
> The ARM trusted foundations code is currently broken in linux-next
> when CONFIG_KCOV_INSTRUMENT_ALL is set:
> 
> /tmp/ccHdQsCI.s: Assembler messages:
> /tmp/ccHdQsCI.s:37: Error: .err encountered
> /tmp/ccHdQsCI.s:38: Error: .err encountered
> /tmp/ccHdQsCI.s:39: Error: .err encountered
> scripts/Makefile.build:311: recipe for target 'arch/arm/firmware/trusted_foundations.o' failed
> 
> I could not find a function attribute that lets me disable
> -fsanitize-coverage=trace-pc for just one function, so this
> turns it off for the entire file instead.
> 
> Fixes: mmotm ("arm: port KCOV to arm")
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to arm-soc fixes branch for v4.18.


-Olof
