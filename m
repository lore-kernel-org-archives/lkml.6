Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF082C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC352243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="h0g/saL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC352243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbeKMIJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:09:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42515 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:09:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id m5so16191693qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=LDfgfP9Q8uMgf1da3eypEdujEmso5JVMI4gfPBHSe5M=;
        b=h0g/saL3EdbQX40dLYMJwQndT5XiScXk4zl4S95kuhBSCFGpr1gyOk3/hO4UNban43
         WrR7LieE7KYXkzeT/eee4GO69Pv7r/OFj5eMi+q4lXm6ovMlD1bun41olGwH67xrVy9N
         YmEUluD+H8TngEifAmDIDebyupCfBVtI6CQVKHugoxjuUR6viAPPCOrSNKTbdEMwvfD7
         gvz8GnvIJfSmqbU8VIKbhBoey/3My9hHJVDakKGfMoDZ1FMpIgtvBoALySKG+Fh4XQZ5
         e8zIGMjQkJ4KMHxItxl+uVUQrHmdY0wOYmGi6yx+u45KONHEOPXaedRCUdiMHb+Ffn5R
         Qwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=LDfgfP9Q8uMgf1da3eypEdujEmso5JVMI4gfPBHSe5M=;
        b=ZHw6jnwy50fwk1AG2QZMdRGWcAaEgkGBQPsYg2dTVyBkWrwzH5WFfgvyM8PR03Ox+J
         wm3FgGca3NduZx1+aPbb/6+8gVBMniB+z6s+1ravT9JbEJyD6zLLMNhNvM815qjM5Nuo
         zEKsBgPjqHp8ZYGWngnf9HH2xho23KZyIe6mDMkZw8acV8+w6bZI2sl2AdwuHe0xjvld
         FcTASzHjdYJjTcni9c8stZcX4tQufV9uhAoRXHGT2zpXYuvPLDtiBnQmjLQG08klJw4D
         KAshsOCCeGNoA8Ir86d2sgp3d6b/gwEXpVRznV8F5NEhZ4/aI4AUSKU6pHACu8HrBAxc
         d4fw==
X-Gm-Message-State: AGRZ1gL5IBZQpCsLfrhTNqYvV5TrSI4ss+YWQBotykDG8V6RS0uTzuqG
        K5l38lFWWpJ44peWcp5y9DXa+g==
X-Google-Smtp-Source: AJdET5fuFmKKWoEJyQzY2pwR+FtCgeX5ygFRB8QubHtRYG1usn9qlnK/Z1TDWjrp29iLecaAGqsBxw==
X-Received: by 2002:ac8:5314:: with SMTP id t20mr2606646qtn.328.1542060858747;
        Mon, 12 Nov 2018 14:14:18 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k38sm10592278qkh.72.2018.11.12.14.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 14:14:18 -0800 (PST)
Date:   Mon, 12 Nov 2018 14:14:14 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Remove unused variable in nsim_bpf
Message-ID: <20181112141414.4dacb194@cakuba.netronome.com>
In-Reply-To: <20181112221042.11160-1-natechancellor@gmail.com>
References: <20181112221042.11160-1-natechancellor@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 15:10:42 -0700, Nathan Chancellor wrote:
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

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
