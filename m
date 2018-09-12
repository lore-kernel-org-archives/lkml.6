Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E9C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11BE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kk3qdLxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11BE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeILHeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:34:44 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:37454 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:34:44 -0400
Received: by mail-io0-f182.google.com with SMTP id v14-v6so300973iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 19:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOT3sjc5QKAVzoG/nlki/j97CMfopzOjkWj4vmbY2ag=;
        b=Kk3qdLxsviBkmSqeA6x1//rdDVrQmQE/rf5zhWVj8sIJ1tPTaVEzDCoFsMbXmbpfen
         8LSpdMdy575dMZKr+3Mtx0iDZEPLDnLWlvILi8gVUS91KK75JngOcgah3cX9LJ4Oe4Gs
         zSw5Aew0s0Zi5F0nOrGMiLuK7FMik+UKuNNKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOT3sjc5QKAVzoG/nlki/j97CMfopzOjkWj4vmbY2ag=;
        b=uIL/op2Cd3KyrUfjYMlXR4x7eWNNmXE8kYm9MX+ud9o7lG4RcmmHaynv7M4cTjwOGk
         NY9kc/+ftZbg0o3fqiueyXo9b41ySel6jjLzWVePVYKIWHuiMzXDAVsnN09/5QCdFt9e
         lsMGVZxP8/igd3Vg28R2rB6Dq887+60Cnmrx07WcPb5GntTjqJ/Z6rySIDnEIRVsqDqd
         a/sL9HK+QNuLtz/Vioi/pfKni5jlVKENKN77l0ATI2p4UCwQLC343JDBAWKx9walRKza
         KJwcMB7tWrxABH2gz27fFj3Kg4QY9uoZ2GHV5YCYEkZlqSkgKLrSTeLSXh5DNyTuv1O3
         w78g==
X-Gm-Message-State: APzg51Ba/MeyzjRFudTGGHwMtBlu/BnKZ29NuQjRhUPPDtv/yYgrOGmL
        Zf1ojSx12XWwWOQEem3+jB2X8T/fScdPLRSuMyf2bg==
X-Google-Smtp-Source: ANB0VdbbanFErVCL3nhcJvyy6w97OOnMigL4g3YIDdge3yJvU7IvfyfgyfJUeR39umLouJq1KTs0pAYtfF4MiIVFcow=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr24937184iop.238.1536719552574;
 Tue, 11 Sep 2018 19:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180910235550.GN19965@ZenIV.linux.org.uk>
In-Reply-To: <20180910235550.GN19965@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Sep 2018 16:32:21 -1000
Message-ID: <CA+55aFzfcxNNyGRyvOhqe8+tWB6mkRYQxbSYGVpd8x4jhgcsbQ@mail.gmail.com>
Subject: Re: [WTF?] extremely old dead code
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 1:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Hadn't that sucker been dead code since 0.98.2?  What am I missing here?
> Note that this thing had quite a few functionality changes over those
> years; had they even been tested?

Looks about right to me. The only point that actually acts on FIONBIO
is the fs/ioctl.c code.

Impressively, the dead tty code looks perfectly correct to me too,
despite not  ever being triggered.

              Linus
