Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9CEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFD52245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="DZ5mM2jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFD52245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbeKMDF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:05:56 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:36183 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMDF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:05:56 -0500
Received: by mail-io1-f49.google.com with SMTP id m19so1074827ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4vEPWJVZfoDgyB1Z8MZMXCxjG8os+I0SeNm1EVItpcA=;
        b=DZ5mM2jDwSWgEDkjaSnRVZFup7zw7enqYz42GWXc7ThI1GtLzoVNsZp+4CAa+ODXV4
         4GdiKu55qNIWITnBKvV116mwKk+AFC6PML0PFE5HopXNybGIsptnlDEjaFup1x6sl/HR
         TzwlVczOl7F137UAPRJErckzl46Nn66foH3+e5Gw0aVCS2vVe6Q3ty20IpfjtirU+rje
         UBF8tRteB8m93nOYVW2UPk3tgsift0/bygmYr02bHzK0gxHMFNQrahUSXjSDwaG8TgyW
         TRF/3+osgPzWm54uhpCOooTlMcG9SDs5NViCKdEkH6uKFkQVlkQCkCSZatUEgPwyIOw7
         Dxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4vEPWJVZfoDgyB1Z8MZMXCxjG8os+I0SeNm1EVItpcA=;
        b=dz9Zr3vNl9PI9qp3MV8OhY2iZIbYAftijL/jSXpf6c0M1UteeZ1kEmmaw4W2mhMAXC
         4kohRIZSbo2ZPbfw2RId9JVjQpoTXc0u3txar5c6ipKv8hARCi08t5Mj4g0yMUxaJwrX
         lnfip6XX5X7kNtTNJA9yz0LNXs76Vy7wqaXypGCa74xxpDBy9O1cl0MOsJmsysMH3rc6
         itJw9N8cmxyUl7sj1mNigyKzlDuppc/V1I96jW45I5zVT8okt+8hmRPVJ+02fwLvvz/k
         BWpPR8zt+1NWGmRGDHVQdusyQFULvd3vBMZeTt7fJkXxfyNGk7SVTAPNpgjhOzTYDKcs
         V2+g==
X-Gm-Message-State: AGRZ1gJN3fNlLEg0509gMSmOFSBELrIDABnY59heQSMlBsUMmvl/vdGg
        x0J25N5JQmVyiuQ0NJ3xEQt1cA==
X-Google-Smtp-Source: AJdET5eObN7Fbq6VBIJZpziCax1Wm4IlX/N6L2diSYC0h5u7SYk+0uCPVTxBAAe64B83ZHUcbzG48Q==
X-Received: by 2002:a6b:ef02:: with SMTP id k2-v6mr1482460ioh.78.1542042707183;
        Mon, 12 Nov 2018 09:11:47 -0800 (PST)
Received: from cisco ([128.107.241.180])
        by smtp.gmail.com with ESMTPSA id l70-v6sm4693914itb.29.2018.11.12.09.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 09:11:46 -0800 (PST)
Date:   Mon, 12 Nov 2018 10:11:44 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: siginfo pid not populated from ptrace?
Message-ID: <20181112171144.GI3645@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

I've been running some tests on my seccomp series, and in one of the
tests on v4.20-rc2, I noticed,

[ RUN      ] global.syscall_restart
seccomp_bpf.c:2784:global.syscall_restart:Expected getpid() (1492) == info._sifields._kill.si_pid (0)
global.syscall_restart: Test failed at step #22

which seems unrelated to my series (the kernel was stock v4.20 with my
patches on top).

I've been running a lot of tests, and only seen this once, so it seems
like a fairly rare race. I tried to look through the code but didn't
see anything obvious. Thoughts?

Tycho
