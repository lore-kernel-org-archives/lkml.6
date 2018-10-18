Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43951C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52992145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mJBpMJPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52992145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJRQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:41:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37611 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeJRQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:41:14 -0400
Received: by mail-io1-f65.google.com with SMTP id m16-v6so20500747ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FNvJBbSmqK56TmUnXFhfz6AtQJ1sV1Tr9rhAggP80ok=;
        b=mJBpMJPVbrS8PzM3ROdJ3NuNfzewFw1HjBx+ovEiN5QFO0eooCVdbZOhffmjJH9N0m
         rfXoS4pCB9S3AgdyHX+yQAdjIJSUlelnMdua/n29E9xA/dO0tf3Kfi2Z/h48WGCfbCbD
         PoXuWCACWkxNOHNpaT8LFXOTqZ8xab9EjUfuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FNvJBbSmqK56TmUnXFhfz6AtQJ1sV1Tr9rhAggP80ok=;
        b=gHgfh1n725V5I4ktoja6FdhD2geXDpLlKwr/lN6oKxU3ybTRo6geGWey6X2ZE+f9q8
         z93M970zRB5ruEPs18Cpf8ukfD68E2mMZYSOQpBQVUntIRpIQ6c9I5yBQVaqFu6502Jm
         iwcz5btZhFlaiBPE27e5REDs+Ex9wVEhTTjL7zMtXL76KiMeryLdlvx5T3CAKJ16bEbp
         gDck5uCxdUhqaPQ1E0SbXxNk+do3ZljR3lOoSfFV6tmpKw04O4eUcWRwPWhHASQc6QEv
         DG/YQyYuHyUfHbSrq/lxPvDpr23OlDrRgeIsFREuGSjMV5fBqg8ddWv4HWFdzOaPY414
         wdCw==
X-Gm-Message-State: ABuFfoga9Umt1Q8BNlwWsSjy8Ir4RYQi1oI5PUn3fLgjZ8pMkNAKRQkr
        uKa1LGmoONduucVBHS74rfPfnkxkRXtshx2uZJCB5A==
X-Google-Smtp-Source: ACcGV61v7He3Y+aoPMHsxdlQoVn6/2p6hhIiGLspbmRtLS9rPl/n8ktAmxkciSK53R5iDnImF0/3R8jaD5R6sDguFjI=
X-Received: by 2002:a5e:8b06:: with SMTP id g6-v6mr15996127iok.144.1539852078693;
 Thu, 18 Oct 2018 01:41:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 01:41:17
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CAOQ4uxjY1LpVKv1id6W-1nHaKC=RbG8HUkTvgGTdGo8MKwzSTw@mail.gmail.com>
References: <00000000000058404b0578797a9d@google.com> <CAOQ4uxjY1LpVKv1id6W-1nHaKC=RbG8HUkTvgGTdGo8MKwzSTw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Oct 2018 10:41:17 +0200
Message-ID: <CAJfpegsDfJMsT8OJVYuUFpNz94ex0fm5Z-e2Gp=cUgXsb_L-Jg@mail.gmail.com>
Subject: Re: possible deadlock in ovl_copy_up_start
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     syzbot+3ef5c0d1a5cb0b21e6be@syzkaller.appspotmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 8:26 AM, Amir Goldstein <amir73il@gmail.com> wrote:

> Can someone tell me what the expected behavior of a nested
> mutex_lock_interruptible(&lock); ?
>
> Why does the reproducer only warn and not really deadlock.
> It is because that is considered the lesser evil?
> and obviously, then inner unlock releases the outer lock?

No, it's not the same lock, just the same lock class (first one is
OVL_I(d_inode(old))->lock, the other is
OVL_I(d_inode(new->d_parent)))->lock).

So we could possibly get away with annotating with
mutex_lock_nested().  Is this the only place that ovl_i_lock is
nested?

Thanks,
Miklos
