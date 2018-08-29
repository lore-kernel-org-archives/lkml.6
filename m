Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7367CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0020647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="dKPibXp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF0020647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeH3BUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:20:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43706 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeH3BUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:20:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so2865630pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hvoRhU+Xie14lLYlUOhHMZUhbjCC2zc5xXra9GCVlak=;
        b=dKPibXp85SkXYThsJOo60e5/+rve+9q3uqGdYyGsh7BoAkr7/4L2WkQAEqYQ/kptgg
         fu/9Yc6yPzuQpzqRnQ6FFgTJn2ENBuzRNIANaSVsDsNasnJS+nqp7DBZ/IrL+tJnvAuN
         M+LjlQXUArziSPbW5yJrrWlM9SXVUcAtBCg1xUEbNN7J3QJmdFgaNrhudCuVA/fR8Gc6
         S3ulfl2c9x6H9e3rxX8U9H9KZd1/Hs68NV3uXv5KHMzgJVmY0jSY5JU/tl/TatO+c3Lb
         Rnamfp6KrJBFPJ5rdAoWoiKD1HI+zZJX/TU6Bk3bJ/usEyNCmRwV89FQ9Q4mOC+UUZ/V
         fTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hvoRhU+Xie14lLYlUOhHMZUhbjCC2zc5xXra9GCVlak=;
        b=hMM/H6Q7Tev577RSrBMT6qq5jBPzl2aaV1QCZz/yE0pqXeN9kWCw8ZiYlnD8H8G8N1
         8jZ6JapRYXYKTd1vDJvL5wX/lkz97YSxb9O4nsBfY8CFbSWp7g2HTe4/iTUetv28V9cr
         DrDzTQA81Snz9/Aud2oTlhyUG6t0ORj3s7G49s7CaaHvzPEEzDQ/bED08qjYoK1RISUw
         OPYugw26F0hevt6gPQGumgbDKO+hN+XmpelWx7AmFHs2fgMs+Z9J93o7Ou5W5nfZIDhM
         CEoaniLNeAmjRbovRyRri1kqNwIVEzVbexcSxe1/USCxD0XjOnvGcT5J1p4+Yx6CEVwG
         4McQ==
X-Gm-Message-State: APzg51B7+wK7Lu6SMdXCcHf81TBxSjP370KJEp+L1U4e3dh0FhJGSNC3
        RQIXdw3h+3piVW7QNtth0sGpXQ==
X-Google-Smtp-Source: ANB0VdbtY5gt8w2O0ghUBY+Iiby5Q1h0Kqd2umHk0vk9z92gQ6WzDc3b74vIxFpb/IEXpeMnk0/Qfw==
X-Received: by 2002:a63:144b:: with SMTP id 11-v6mr6886400pgu.219.1535577690450;
        Wed, 29 Aug 2018 14:21:30 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.191])
        by smtp.gmail.com with ESMTPSA id 143-v6sm7020647pfy.156.2018.08.29.14.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 14:21:29 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:21:27 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 1/5] seccomp: add a return code to trap to userspace
Message-ID: <20180829212127.GA15213@cisco.cisco.com>
References: <20180828143603.8127-1-tycho@tycho.ws>
 <20180828143603.8127-2-tycho@tycho.ws>
 <20180829185917.zj3gqyn6qf62sx66@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829185917.zj3gqyn6qf62sx66@mailbox.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:59:18PM +0200, Christian Brauner wrote:
> On Tue, Aug 28, 2018 at 08:35:59AM -0600, Tycho Andersen wrote:
> > +Users can ``read()`` or ``poll()`` on a seccomp notification fd to receive a
> 
> You have changed this from read() to ioctl(), right?

Derp, yes. I'll re-write this bit. Thanks for the others, I'll fix
them too. It's not bike shedding if it's incorrect :)

Thanks,

Tycho
