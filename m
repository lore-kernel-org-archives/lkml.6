Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB52C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6582075A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+shVbuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfBSGFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:05:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53155 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSGFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:05:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so1250641wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 22:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AlXQMPf5dGIVKoffuvDXzs0jRehP4FtGw5K79z3NUFw=;
        b=k+shVbuyKWPt4f1ubogn5pMBlqZfz05F/3ymGovDlDJ5Uk/XF/mzVZvxqPavNozK23
         S86Fr6d0OMWTgDEWXz6lr3/lb6t5VmGxiRysPA1bkSh1YfSlFurHrqW6BZiAGPAWdocv
         muytKG5jGnHY8hac/qJyL511TeDbAtGtpnvGLMeUAx1NJfiWmjHEt6bgSi3UrvIGLqOt
         fII67mt+cd5+r28cHyZrCiXjqQ45ujNKUS5Uas2//kFOWvCQKieprnOrfbDrdrqnReHY
         h4131eAJ0yLHZ4RvWEMFwscAwp1O4SbF1Z4CoP5fWAj4dRIzeUkxnkxiBiWWmnGWhBKF
         skmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AlXQMPf5dGIVKoffuvDXzs0jRehP4FtGw5K79z3NUFw=;
        b=nADFxjoW0ol+zbyZsa0cK0m938M2sp5au9pQ7k1IFKhKl0pPWHgCX83gZI1ALu0TmN
         HZWzlULOgYPxZQlBFrH1qP1xsDdHHLYL9mr9zx+l/u3IHjpkbFdn/JTYfO+NxTQuVOvS
         d+mb3n7FAthKhrMD1ah8d2ZX2PFsnnlEw39L8iP2MGXaUiLpq44iC5XdLiInR99z9DEQ
         ibdb1BmCKakMidvgFdZ0awoVtErTSJNuneIAZ6yiE1pwrplYF9DM+0tkqpM50ZOxp9ZR
         kvvknaB+SHvo04z3oIK+dvV+H4AwHYXNacu47682IimLBW7wlN4MqgRmOLF6ksLVDnAk
         sX5Q==
X-Gm-Message-State: AHQUAuazKicBWOXoBVnyNvM3VmtYL6AFgXkyc+1136fId7PD8OE8fWLx
        Q6/AZGz4hKTl13YmkdmMKg==
X-Google-Smtp-Source: AHgI3Iab7rtejVxu8XOKvOZcB8IAoKWthjazxDD6VBPUUleu8EwN4PjoKczKB2FZAEz9nJzgMHVSVw==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr1569134wmc.92.1550556334947;
        Mon, 18 Feb 2019 22:05:34 -0800 (PST)
Received: from avx2 ([46.53.241.2])
        by smtp.gmail.com with ESMTPSA id r6sm3784587wrx.48.2019.02.18.22.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:05:33 -0800 (PST)
Date:   Tue, 19 Feb 2019 09:05:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190219060531.GA3263@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/kheaders.txz

This is gross.

> The feature is also buildable as a module just in case the user desires
> it not being part of the kernel image. This makes it possible to load
> and unload the headers on demand. A tracing program, or a kernel module
> builder can load the module, do its operations, and then unload the
> module to save kernel memory.

Please explain how keeping headers on the filesystem is not OK due
to "licensing and other issues" but keeping a module on the filesystem
is OK.

> > I can route it via bpf-next tree if there are no objections.

Please don't.

IKHD_ST IKHD_ED are bogus artifacts as others mentioned.
proc_create(S_IFREG) is redundant.
seq_file.h is not needed as is THIS_MODULE.
I'd say such data should live in their own section for easy extraction
with "objdump -j", something /proc/config.gz never did.
