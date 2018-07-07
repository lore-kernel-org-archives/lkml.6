Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9031C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6141522ACA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aRquQHQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6141522ACA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeGGCbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:31:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43289 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753816AbeGGCbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:31:43 -0400
Received: by mail-io0-f193.google.com with SMTP id i23-v6so12447674iog.10;
        Fri, 06 Jul 2018 19:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C458p9DEfwjINN6z5R85tZTbw6X+0aDpcWZ898AIJMk=;
        b=aRquQHQT9dFdxIobcf1GAu16/w/PGlcnouiWbJfk7X+eL/6RmFYMORSZ+oFTorhY+Q
         iVNfZNbL8+pFPKJi6Bpr+jZbhsDaLNeCHAMBdkraVw43Jy+1ZKmrWwDAVO60tnN4JUaB
         qmXS9xFiA1qgMrF0PUNcKYiPg8GgFtH49SZtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C458p9DEfwjINN6z5R85tZTbw6X+0aDpcWZ898AIJMk=;
        b=rpuLYnXh4In16nArybb0cqaOx47Bg4NkD117V4Spppg1ApjFKiJlfjtLf2RDSdpi1H
         /tIjhCttQzv/507BcNI2cmFeakKf3IjCSfVAW71Fqms7d9iZTAh4ruCOZjvzgX9KgIK8
         z6wf1s3vbCfwXmGuE5qmkWdEKL9/5+o5ZJ57ZkRz3S0hMEQTPCizep1YSbDeOxbodDLh
         +Io0eZ92CVZtBrv2iHWyXQfuqv0TX2VLFMPVVSIkAfKQHfVm1ha5Lck53NVRVbI/B9xj
         2y2eTEqRrmiRMBxxL1HqErJ93pVFGM8lJ9DFa0ygko7XdYKiAYKVpKKyS4uHsU6kclVc
         o1Lw==
X-Gm-Message-State: AOUpUlGUW9SH5HcwtUG8YlgtJ0Hgb1DzghQTX1jdVaZK6CTQ3M4JIXWg
        fQsv3NIBV+AtqmPQKaFl6a0C0tNeme4yRPlPJG8WND/P
X-Google-Smtp-Source: AAOMgpeNtbE6qpakwZp/J3fVgB1hT/iHYNi4rn5v5DQTu2kkEjNt0/l9WCJwV5ogf7VnvfXngwxx8pT7xBcvU/mXTXQ=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr10940562ion.259.1530930702631;
 Fri, 06 Jul 2018 19:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
In-Reply-To: <1530913134.3135.2.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jul 2018 19:31:31 -0700
Message-ID: <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 2:38 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This is two minor bug fixes (aacraid, target) and a fix for a potential
> exploit in the way sg handles teardown.

Gahh. Is this where the IB people got their insane model from, using
read/write as ioclt replacements?

We have that ib_safe_file_access() hack for IB for this exact reason.

Who actually does direct read/write to /dev/sg? Could we perhaps just
add a config option to disable it entirely? If you want to send a SCSI
command, why don't you just use SG_IO? That's the only thing that
actually works on most devices (ie anything that isn't /dev/sg, and
nobody sane uses /dev/sg any more).

              Linus
