Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1EAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056AA2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVdju/DM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056AA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeKQMGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:06:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37873 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:06:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so5523422plr.4;
        Fri, 16 Nov 2018 17:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/QuOQ2ktNOuGzkGZkvCU1LqpXgue9a/ZPpeQbHXPrTY=;
        b=LVdju/DMOr3j/fj/sZAxVzGxizXGSbo2I0nEIlJsCJ3/MSnt9k070VmkZjbxu85MYn
         /c2uMZYzTDlmsaq8p1Xz9G8KxcDOkikCt5ZlTQEpg1Ujpce5Vo9YKKhLmrg/5+vwFAee
         z+eKzQdxDQTmo7et1Qu+1/VVKcUHM5WBUFWdNd7dpMP7Kdj8KFWvSWmr3VpuffaPHKsk
         r+wgSTW9qFVnm2WVBTOaeLeNaOyyBWdwjx5G05nZhuLg4Vd4cra8x3WsrGCNaf8r7q+Y
         ZHNFdC4Am/SnX6IM5S4vLBEZd3hmOJvzBV2k9wcRmRivBhxWb0V7eOF8rCYLg4aebAzm
         mq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/QuOQ2ktNOuGzkGZkvCU1LqpXgue9a/ZPpeQbHXPrTY=;
        b=c4LKByEtLNFbxHXWuuYYoc7nXJsfKsXZ4fTMrLShfIPpocb/f6bw6jMIFdinS3K7eG
         RuFjAAfxt1Wak21KPl6rJx8XPXKKIMhrlWehwW8E17HYnyct7RdwtqPTJMP9pmbQLr/s
         12zGupC0a1mDCzQz3l/KmakpjOSH126efTQUwMFAx0m9Rx8llMxq7+9PvMhcFQazBzeh
         eBTZKPFfh0hnuVbkhlsYG4nS7Em2VaXfFYv+Ewjg/FedIdITfYcZ3TJTqPMph7XVdvVk
         oqPgfYay2oRQEZgx9dfjfRyVPeDIRbR10bCIT4MaCLzFosVlDEy3k62FCAcTp2s7ItjS
         fdwA==
X-Gm-Message-State: AGRZ1gJ4mRn+h6SjrmaytE/Mu894a8FbvDJKZZhk0GtNU0b2chjqwbLW
        LEhw0YDBddq8YarbufB8cGQ=
X-Google-Smtp-Source: AJdET5cIrMOuu8yvzMN4h4eTB7MVeFZKd4kOrxAk+7KiIGe1qFvpl/VAj56dbkCmtiv2itKh1h0lqQ==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr12951540ply.261.1542419524609;
        Fri, 16 Nov 2018 17:52:04 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:3220])
        by smtp.gmail.com with ESMTPSA id p188sm8987705pfg.65.2018.11.16.17.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 17:52:03 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:52:02 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Remove unused variable in nsim_bpf
Message-ID: <20181117015201.r6t62y25a2c22why@ast-mbp.dhcp.thefacebook.com>
References: <20181112221042.11160-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112221042.11160-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:10:42PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/net/netdevsim/bpf.c:557:30: error: unused variable 'state'
> [-Werror,-Wunused-variable]
>         struct nsim_bpf_bound_prog *state;
>                                     ^
> 1 error generated.
> 
> The declaration should have been removed in commit b07ade27e933 ("bpf:
> pass translate() as a callback and remove its ndo_bpf subcommand").
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, Thanks

