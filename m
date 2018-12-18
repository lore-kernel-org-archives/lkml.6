Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3CFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9A12184D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q4CbiSFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLRL24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:28:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbeLRL24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:28:56 -0500
Received: from zn.tnic (p200300EC2BD17800D087FC134B548C22.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:7800:d087:fc13:4b54:8c22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAFEC1EC0AB0;
        Tue, 18 Dec 2018 12:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545132535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YtRTAYWZiJ3KcZXxRVriXMVSGOBAPjJKvowi2PhuK7E=;
        b=Q4CbiSFwQvcRGxhSPqBanMpd5zlO47CtFBLiIwB/7ubL58gBFLwotZ3kO5LLUYu4F1nU+q
        4hbxs2tow8yjfPLHN+avPjCCpokE3V2Qq7diI4RT1wAJ6MTVtGMHQLOFyzuJ0hVO8Ns8ls
        /HJvNuWMoA37kdic2RmH9LiYSkDEZhU=
Date:   Tue, 18 Dec 2018 12:28:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org, bhe@redhat.com,
        msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 1/5] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181218112848.GC7485@zn.tnic>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com>
 <20181217172510.GA90818@gmail.com>
 <20181218012704.GB31775@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218012704.GB31775@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:27:04AM +0800, Chao Fan wrote:
> The basic conflict is the kernel avoiding KASLR-randomizing into
> hot-removable memory areas.

And this should be in a prominent place in your commit message to give
an idea *why* you're doing this in the first place.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
