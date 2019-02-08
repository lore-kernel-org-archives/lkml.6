Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4981C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEC82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg4DIuBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfBHQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:24:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40657 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHQY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:24:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so3247635edr.7;
        Fri, 08 Feb 2019 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+S/WQRslqGz8AnBF5fM0s3zNPO3/hGxx3P8rsm3nJ4=;
        b=Yg4DIuBVzrFLJhYr5vSLqyVODpl/Ema5Y28Z1IODXuviBcilEMYsyVVJvDydAdgZLk
         Ae2D0aHagOJW/79T6eUaSw4mtyT6FcpIOGRQZg3erKyzlvNDitccliiHZtaWoupFLJTt
         ji0sRb68Qi26gtCRwhEZTd39LhN4DjvJTspmnirCdTxlVTSuzBG00+mu96AsfJTeJUf5
         TEfmlqDWMZhZLY6XIX+X6PPLhk0fbeblYzD0gqMx7eFycbWW+ua3/WNOL/3YXlfJQTO5
         esFBUuwW3bVGLWpkMI8y8jo+ia6pii5YNrumdq6C4N6Ui8UT9ERfD0A1GXPXISP6+DCd
         XgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+S/WQRslqGz8AnBF5fM0s3zNPO3/hGxx3P8rsm3nJ4=;
        b=Xze6PcdfwF2muBu0xynovjwrNgUfbPSG2hIjQM9txt7nujuPRQkMIwk+yE/pQreI1g
         eoi3c/tutspGqKVCGM9RKD19XUQV1HHdw9DOe+ABpoo5McqvtppGufWAwOv6Gckzc1Fv
         b5k9DDbTCpgiFD8wk6zR7ahT4YiWOUzl9mu/ZV7IQ1tC7roHZlL2dxnWK5gByx6bqkJ+
         EKmimN7Q+e04kKc39EZjjwgwcpsiMSiyLem8uRDMMKS87RtZCdFuPgX2ctkAKwBDTVbV
         SL/9Z4gCNw/zuAdrRPNONYPa94FzR05L9NtiQFzHJP6JnAL8J/grVLFNRWRhfWjKOk1Y
         pszg==
X-Gm-Message-State: AHQUAuaqoTxJp0VWcHh02g+WJWzZ4pJYXObCuSa8Dov5lBo4L/G1tHMQ
        hf9oHgnBSZb1lXC9Sbiq2p8=
X-Google-Smtp-Source: AHgI3Iak83tTlQDEJ9T4y+JwIseM1N++0eNQiTY6lPnledIZKxTiI6RcbW9a2EO2vxkkbXUjniIgTQ==
X-Received: by 2002:a50:8f86:: with SMTP id y6mr17943368edy.131.1549643067294;
        Fri, 08 Feb 2019 08:24:27 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s17sm561547ejr.17.2019.02.08.08.24.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 08:24:26 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:24:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
Message-ID: <20190208162424.GA636@archlinux-ryzen>
References: <CA+icZUUs-OYuSs184jC+RivsyLmB5sLZdkfxckSTYrq2ibJS=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUs-OYuSs184jC+RivsyLmB5sLZdkfxckSTYrq2ibJS=w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 03:21:15PM +0100, Sedat Dilek wrote:
> Hi Nick,
> 
> why don't you simply check for CONFIG_LD_IS_LLD existing (when [1] applied)?
> 

Hi Sedat,

This section runs before Kconfig so we can't rely on the symbols it
generates. See commit 995167420797 ("kbuild: remove cc-name variable")
for Masahiro's explanation.

> If you want a specific version of ld.lld (you mentioned kernel module
> linking failure was fixed recently) why not transfer this into a
> scripts/lld-version.sh file?
> 

We'll probably need that eventually but given that lld isn't ready for
widespread use, I don't think it's necessary.

> Greetings,
> - Sedat -
> 
> [1] https://lore.kernel.org/patchwork/patch/1039719/ ("[1/4]
> init/Kconfig: add config support for detecting linker")

Nathan
