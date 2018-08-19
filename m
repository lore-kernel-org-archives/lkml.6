Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5771C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F05820C0B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hECm9+Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F05820C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeHTCfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 22:35:21 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:43045 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeHTCfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 22:35:20 -0400
Received: by mail-io0-f180.google.com with SMTP id y10-v6so11132071ioa.10;
        Sun, 19 Aug 2018 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxGDBZz9uh6S0ltpXSXfLLtJT5VszhyAgT6mD5Jqvo0=;
        b=hECm9+WmKnIABrZw7INVv9GFibBhCEH0Do/hh9W1Yxr4qdSsekXovOgnv21nKPdUNg
         2dbE/0p3RWGiIOm+ehK7XkjkOvE3m5mgk6Ly/qyfhi8wE4dAB2aa+afMEZNTN8bUiswG
         KuydDNSytEr6HzeImZL76SgoKd5KuFKvoTVVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxGDBZz9uh6S0ltpXSXfLLtJT5VszhyAgT6mD5Jqvo0=;
        b=mof6ddrGqATLpHpA8tX4/CUbd27bs23R4JQXbFfEZPtpjsJHgLAQTJxwDCSNlfukeo
         /OhaLhGVjLVqks/DL7t7jNSMUX/427o70msM9vWKZ/zCYsLoJL/QN7O4hR6hgonzBjkh
         H9gUjCx2c7m6LB8iqXwIBKDgYUEVB8tbgEppX/yDlirg1QSxhgz2q/ZfhqKCNaTuv/TO
         86cYXWuuUbbUHWgXHzEH0IvJQKUF3DSA4ruABexxqC9bA7Y+Zr4Y6qQ1WI04Aj5EnEwj
         xa2b7PeHPsoK5/myaeekDRs2YrlyT16LVYhq1mECVECrsDX3MUF6DkWzM+VEPaQUdlwN
         Mzuw==
X-Gm-Message-State: AOUpUlEpIWmH1hoiM9P50B362gA4O29pbTaFzoxf9i/I607BjbjCVYmK
        kIjVe+gj4TD7CaI9Soukj15sglIfxl7JYc9W1D2vMg==
X-Google-Smtp-Source: AA+uWPw9O909jbKQGq4tIsS2BlEshilJmDbor1csrACU6eqv8O9DM4SGagOct1IzrUcSj4XVKn4sjseNPGLFsZFXAAo=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr24515531ioh.203.1534720928458;
 Sun, 19 Aug 2018 16:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180820081323.23a47af3@canb.auug.org.au>
In-Reply-To: <20180820081323.23a47af3@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Aug 2018 16:21:57 -0700
Message-ID: <CA+55aFw4WcLcFJkoWoE2v--J3s2Hk8JBU92=Zh351FH7xY8zpw@mail.gmail.com>
Subject: Re: linux-next: build warnings from Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 3:13 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next build (powerpc ppc64_defconfig) produced these
> warnings:
>
> fs/cifs/cifssmb.c:605:3: warning: 'strncpy' writing 16 bytes into a region of size 1 overflows the destination [-Wstringop-overflow=]
>    strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
>
> Presumably caused by my update to gcc 8.2.0.

Yeah. There are some patches to mark some arrays as non-strings to get
rid of these, but we'll see. Maybe we'll just disable the new gcc
warning if it causes more pain than it is worth.

                  Linus
