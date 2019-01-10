Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDBCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490082173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkhg5iOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfAJIhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:37:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAJIhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:37:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so4976529pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 00:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fzJWWhVhoQ53zvh9P9pc3UFm4hIku4H1tEhsKDoVCAM=;
        b=Vkhg5iOcNaoLDfnEdTDGsDcg3xX8ZNV0xbeizayZ+hKjQ7SI87p1ylIOB9Wt+FSynK
         GntqVziQOvupttR7fsMESEThG+JWNx9oKI8nsevBkh+2QgdL+PXzhAs+OpqOr9lAuyYd
         ll2cjzEelNSWFKe6nZ9w3F9K2j5nPSMBPtH6zUkC6cd2XiuusfqBHmCQQQKEtNPmFUEE
         dZZMiMR7gZp49v40Zj26BFF80faWIcat7lmIL0G61OEK/s1QS4UzL2M6xeskGPOw1La0
         7isCX2K1nQKDRkQ0Ou5dqPmhNhEmqMaFWL3KV0SP7RLjCxf6Y8cZJtT2Uy+e4fhRtZGw
         ogMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fzJWWhVhoQ53zvh9P9pc3UFm4hIku4H1tEhsKDoVCAM=;
        b=WC00qLAdlnt5xBo82AWOzoZS9yGuXpuweGE/D0WiMJ4MoyaO0VZO22IF6zE0wIkeIN
         ZBdDeluz9M13abIeTErFS2jDVqHOYDyRN2u5RYwLi8KMWQCfMfXwXLUp6u5v86dFU1n6
         jaeiJcVJQODvJVIK+//r9HqcT2whwSr3Me6oAW1RDxvXECCy1Ok322zZvF51MlGSyma3
         gj4DchT4wUug7WcEQ5bc+rWnLDwU3k4Cl8fKj68kiAxEHf9Wpw3d7aallmf2ZewB1ak3
         aNftNO/POftgverQpAnMBf6B8sqMn4TQI16fsxP9bBSAHQF3WeenOH8OP1NUEWEy8Hhg
         kkdg==
X-Gm-Message-State: AJcUukfsjEa+fQ4amGFQ7MBobmsfsGUjlBniByeycBIyU6/v3UJmgyEU
        OmaYLnosUGool7cUh9EY24Unwyn5
X-Google-Smtp-Source: ALg8bN5aQdHGtnmy45jJFRiZjCMjuptAvFiZssGoHWMDkg1s4jxdj20SbnRYsZizg+5nuoMvZgUyNA==
X-Received: by 2002:a62:5301:: with SMTP id h1mr9261121pfb.17.1547109422124;
        Thu, 10 Jan 2019 00:37:02 -0800 (PST)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id 196sm293228929pfc.77.2019.01.10.00.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 00:37:01 -0800 (PST)
Date:   Thu, 10 Jan 2019 00:36:59 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kernel: release ptraced tasks before zap_pid_ns_processes
Message-ID: <20190110083658.GA11083@gmail.com>
References: <20190102205939.26231-1-avagin@gmail.com>
 <20190108165043.GA10240@redhat.com>
 <20190108203612.GA19454@gmail.com>
 <20190109170829.GA15302@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190109170829.GA15302@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:08:30PM +0100, Oleg Nesterov wrote:
> On 01/08, Andrei Vagin wrote:
> >
> > No, you don't. The patch looks really nice. Thanks!
> >
> > BTW: We probably need to add the "Fixes:" tag, but I am not sure to which
> > commit, it looks like the issue is here for years.
> 
> I hate you ;)

I know :)

> Ok, OK, this was broken by me in 7c8bd2322c7fd973d089b27de55e29c92c667a06
> "exit: ptrace: shift "reap dead" code from exit_ptrace() to forget_original_parent()"
> 
> > Acked-by: Andrei Vagin <avagin@gmail.com>
> 
> Thanks, but if you agree with this patch may I ask you to send v2?
> 
> You found the real problem, my version is only slightly better than yours,
> I don't want to steal the "From" tag. Feel free to add mine signed-of-by.

Thanks Oleg! I will send a second version of this patch.

> 
> Oleg.
> 
