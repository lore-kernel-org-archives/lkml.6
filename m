Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D50BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F8820892
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZKfNSro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F8820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbeKGF5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:57:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43939 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeKGF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:57:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so6304015pgv.10;
        Tue, 06 Nov 2018 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9bcQTHatR0h3xte3IHN9/6sqFGmlf4lbOsLLbTfBMh8=;
        b=LZKfNSroBBnQNJ56gwz8XVBqnaKzgyT2lbw0TdHr5MDcnvDAUegX9ePXIgOeyqYomn
         zQI3ZqqUMrK1WajehCnlM1HbM2wpSvFWDmttaCKbEfK/XyzUra7s7TwwqEtB1cG8YWmR
         V9a7lumeAKegK5iElNn5N8u/QYPGpTMDMXRKSmUGM38PmMePy1HDR64g/Pt5XtucmRWA
         UOfdxpbAhuZpDXeHCGEEkoeJC3Q0CpDQB0NNOzJYs4tLBEjs2AevebVavS8QfsFFAB5t
         Sa+zrOiSXQ0aq56dahv0rsKRhlFMl/BCbD3RgI+YtB0BY09C8VyT6n2/gXmw6ALB/qUP
         xwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9bcQTHatR0h3xte3IHN9/6sqFGmlf4lbOsLLbTfBMh8=;
        b=L/tgRfhELvjTRAsQq9bg+XDry8fp4C79gAwnRM35rK7SpuZr0NM5Tk8R3OL+xcvrJM
         CimG0xNe4RAxydlYS8foFCTHyw/3+hEzTy23fQmXW1wdm6+fgX1zZg6W0v4NI2JyYSgA
         UT+xMe7QEmP+idjeVvWye7J3WS4e/LnrlvMPaRez/ZqODD+YYiuuewc7muI6713KqslE
         EQRsblTeaWzgUxe3HanUPfWarBB7Ub3cD5dHl9Ph9NxEiee/dC5330mA7FgyAqWljQvP
         tG+ODOyj5WDlZK0YjDazyq6hBu8ju+LloCMhfyJkPRaMIaYPtm0RUrcugk0H/t/MLir/
         IjyQ==
X-Gm-Message-State: AGRZ1gJvPDQ4s7/wyc6cgoGwY/I0FodbaZkXRPoiEPFEtu6EHK0uUUfI
        NNsmfYF0QaTKOySwEJZ2ddk=
X-Google-Smtp-Source: AJdET5c1LU81thE3DnZ4/98Z0xO9yiibic+Z7iQpJPnKN0MigBzClLu529MJ+y45Zu+TFVQHk3QX+A==
X-Received: by 2002:a62:6d83:: with SMTP id i125-v6mr7506232pfc.184.1541536210480;
        Tue, 06 Nov 2018 12:30:10 -0800 (PST)
Received: from octofox.metropolis (corp.Cadence.COM. [158.140.1.28])
        by smtp.gmail.com with ESMTPSA id g123-v6sm91396760pfc.67.2018.11.06.12.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 12:30:09 -0800 (PST)
Date:   Tue, 6 Nov 2018 12:30:03 -0800
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v1 0/4] xtensa: system call table generation support
Message-ID: <20181106203003.q7kqlwm5hcnxmu6t@octofox.metropolis>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 07:26:17PM +0530, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 
 
Do I understand it right that you're also planning to unify scripts
and makefile snippets used to generate headers, as they're not
architecture-specific?

> Firoz Khan (4):
>   xtensa: move SYS_XTENSA_* macros to non uapi header
>   xtensa: add __NR_syscalls along with __NR_syscall_count
>   xtensa: add system call table generation support
>   xtensa: generate uapi header and syscall table header files

Other than the two notes that I've posted to the individual patches
this series looks good to me.

-- 
Thanks.
-- Max
