Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863D7FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253F820870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDzpO3LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253F820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeG3O7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:59:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40976 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeG3O7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:59:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so4535227pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TdxROHFGEqVySFphTJtS2UX0gOAApDQcBC8AcSyndP4=;
        b=BDzpO3LH2/M1j/naWG0nkD8T81YiFjCeiAxh58960vmHuHY1hYGBisACf3DQCUlBlh
         Xs8jJ6vDA4ibNyvASP7SRjS8P7dysHkxGNSsSVT7qlRQEfLH+1ThGUmhK7cCYf8hsp1s
         wq4p1XbeSPB+pn2wYXn+S8QbR1S0287Lr3TyuegQmw1LKcjR61m7snNMfWDvYeYjrqgM
         vohfVvUhbw6zeN0Rxx/ndRXi6PrspyxPOjdRBnot5HykhZbEJKW5jUKedZrbGDjJFgUR
         GV25oYsG5mt/jZut5AbTYLtIaZ0MIop3bGHPL5BGYomf+iya7ruzbujmYU5C04tNAzPn
         qFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TdxROHFGEqVySFphTJtS2UX0gOAApDQcBC8AcSyndP4=;
        b=rWM1TgCc9EtDLso1cdYRC7rKKv517VfjtkH+S/Ku5uUxuIzErvWtfDhM7+QGO9QKrb
         VzvlV9MXe5TkDkeFJu7zTNUS18KChl82x2+Va50VIonZCWQj6N45msQ3ZkVJ7m6iENmF
         qt6HJFRwj2xLKXcmaEoSftDqprtonIdUXCYBgYLeQynsLDD+jLPalzg9StWmlVgCkimg
         Y/6wt/5FuFi1VWEeP89LRMeCKoDAvWrjGxGNgJs2JzZl1E1Pfe759aeasAqFnA/V62IQ
         jb1HS795j1KYHOYk5VsT+Stm1dGLRNNy8CqVrLAYBEj4lxpvT8EwzQfE7AeKfapchnUo
         aDEQ==
X-Gm-Message-State: AOUpUlHnB15Id3rYS5zuzCJzPmbmvnUzMUQZguT4uDPIgl+49sFUTel7
        gHMpgU9WZPkdLkiJce3wnCC9DTZ+
X-Google-Smtp-Source: AAOMgpfjj15ItqW77mBxHbe6lZGr+Q6bH9vhBfYcCLDZVF87I16LMp+IwrXHSEMgsJnNL+PDZis3Nw==
X-Received: by 2002:a62:d75b:: with SMTP id v27-v6mr17720767pfl.79.1532957072490;
        Mon, 30 Jul 2018 06:24:32 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v20-v6sm31780329pfk.12.2018.07.30.06.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:24:31 -0700 (PDT)
Date:   Mon, 30 Jul 2018 06:24:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.18-rc7
Message-ID: <20180730132430.GA14710@roeck-us.net>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 03:09:05PM -0700, Linus Torvalds wrote:
> So unless something odd happens, this should be the last rc for 4.18.
> 
> Nothing particularly odd happened this last week - we got the usual
> random set of various minor fixes all over. About two thirds of it is
> drivers - networking, staging and usb stands out, but there's a little
> bit of stuff all over (clk, block, gpu, nvme..).
> 
> Outside of drivers, the bulk is some core networking stuff, with
> random changes elsewhere (minor arch updates, filesystems, core
> kernel, test scripts).
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 183 pass: 183 fail: 0

Fetails are available at http://kerneltests.org/builders/.

Guenter
