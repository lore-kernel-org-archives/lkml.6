Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B103C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397AB208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbGB/BIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397AB208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbeHAR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:26:06 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38626 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389725AbeHAR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:26:06 -0400
Received: by mail-ua0-f195.google.com with SMTP id o11-v6so12977410uak.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wv1TVAQuOucsDCeMy/N+Sw4PV9a4wS/ncz4Czq6Z2a4=;
        b=GbGB/BIStKPJHcsBHFbinqCRI6zquCCbRVk+XQbtrJaV8xouhmMFAnYcnm9Wxt0YC8
         rfupQlrLYvwmzQ0j5BAfh+k8X9vCd7G2C2hIxxEQEFBLy+fP8S7AJCNiPMdRQnc73KRG
         Xjqk8w06TyqIo0Z7l3wTJOFDo2WUUJrDQ0YgJOzMsE+P6kdnPfK+jv9BqlDDOFgsEG7D
         xac+MiJ6mQQtPhZw2gt0bBjsW9SGacATSxxhu46sZxlTiqW6GwcsMWrCmzJxejia/5Fq
         1+HUD+y1jjFzIxKhdo8AzfWgR0fw7a5XMYr87uWg7/BO+iJZvv6m5dRbD8DW0XmK4wVg
         8KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wv1TVAQuOucsDCeMy/N+Sw4PV9a4wS/ncz4Czq6Z2a4=;
        b=IW+7VGSJHnAq78FY2Wf3nM1OFMLoPlIQM8JjWOr3qc3787DAE6/9nKqRt57uQ5/zMY
         k4VUuHSmDqDTEEqNkXcEiz4cMQBbYTlQLSKIAR/UlJcf9GPVL/wlWr1Nwv7Ibgq7QcCv
         qFy9VgyiArbkdjsJe6enEQWh3EzYSMe79FupKhBnfnUVGk1fKzv0IFR1RL5mESk77QKv
         pzj8ippZJiMmZCF5f9x4NsXg+sUMcVhAEPnKLRU6DMXaxRcpZEynmLix1mDYcJOwmvom
         EXkPziTi8MnlOMbMEJ8VgEf10EIJWA/CXV3SfeMzPRn/EUzePrR+kB/gSnT8kuZllyBi
         XnXA==
X-Gm-Message-State: AOUpUlEcTmevQsz/a72JM4Gcx1FIY7ZZcNQMQ5ZEdiOI/zVwpsGV5Flq
        pBFM1xwbKWGPUFGYF3eMZo3pPVQ0MnaHC0DGhRQ=
X-Google-Smtp-Source: AAOMgpdRygPHUzVAO+0vdeRVAqnXHZ7QoC8xAp4tYv84u0WSe0V/yX5chrLoTCqLV3JpyxgwNH0NgQtIrfHsFYysOa0=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr18496290ual.141.1533137988110;
 Wed, 01 Aug 2018 08:39:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:39:47 -0700 (PDT)
In-Reply-To: <CAO2xqGHSyGLheUAg3-qQ2J2nWVgf2+sVZ5GaFukEHA0fDpZ98w@mail.gmail.com>
References: <CAO2xqGHSyGLheUAg3-qQ2J2nWVgf2+sVZ5GaFukEHA0fDpZ98w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 18:39:47 +0300
Message-ID: <CAHp75Ved1swf3MYg2cVb+jjUoD_p6TvqD9qE-eWSucrrnzT56g@mail.gmail.com>
Subject: Re: kernel hang
To:     Ram Gupta <ram.gupta5@gmail.com>
Cc:     linux mailing-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 3:31 PM, Ram Gupta <ram.gupta5@gmail.com> wrote:
> I compiled  standard 3.10 kernel  on Centos 7.2. Once I boot with the
> compiled kernel it hangs with the message "early console in setup code
> Probing EDD (edd=off to disable)... ok". I need to make custom kernel but
> this kernel is standard without any code changes. This is on x86_64 bit
> processor. Has anyone come across this issue? What am I doing wrong?

You need to send this to appropriate ML.

Here we are almost at v4.18 which is 5+ years newer.

> Any suggestion is deeply appreciated.

-- 
With Best Regards,
Andy Shevchenko
