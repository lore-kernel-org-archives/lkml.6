Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38168C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4024218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjHD5/jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfAXTLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:11:31 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37350 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAXTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:11:30 -0500
Received: by mail-yw1-f68.google.com with SMTP id h193so2889607ywc.4;
        Thu, 24 Jan 2019 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/ux42QXwpRUza44sta0d7SF/mVsaFv0K/CkDPesSNE=;
        b=sjHD5/jD9eouUf91CKmtYR2JqVGW6Y5YTXXpD9YEsqqg7wCOwMDhAXzgTYWisiDD3o
         diJVqk6dkU949VplQN/9mjwsbJBoOBViYefjQVFPZJnBarM0LYhBZDuQcLAi65fFCaqS
         m0wTqI0hdOlvwP2K1IOaFmkXq0h8hICeWlVufIZCesV5eeRXtLRPtvshx1/ms4qaBZ1+
         Wxx7tt7HkrqkMCRbCDy6x0QHlyinihAIpZFdWAetDYVTDkY3gXqXjMafkMzqOshSjbIz
         XDqsOZrtwPf0Vwi1mn533o/HA2jhErWmtbrWjn3EYs+MlUNVRrTRC6jDo9JFBzTk9u5K
         Q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/ux42QXwpRUza44sta0d7SF/mVsaFv0K/CkDPesSNE=;
        b=mKkLl51y7iVyp+xTKwZyTkunAH28NlAgcb92YfF/EgViEYednysAt0FS8qbYm4cyPt
         /9PHFL0ZKg7CYwt1GEZje6S9iM1fXMVf9N8eXgM/VA/XPucAE85yFOEeIY7JWaykppFr
         uwxrQA/gUm0/a/SFKTIMPN3/d5sYPJADxWfAyBDKHsC005T3ycwFFxE3/i1AsMJXNwhe
         QbXTDYz68ZeNLGq2y8KQ/Jo9Yeqj1W7hRYooAq2fJ87PjBhJMPfOJpPg6hMwn3MEw90E
         z+IF08dcHqgmd7OuSULRVH25E7BIBjChZlWYbgBTPDm93AJih2zKpiGe//WEihwCOUT5
         6DSw==
X-Gm-Message-State: AJcUukd+3Wvjl9Fkwz2NFltUoFfYZGXPF48TNyM4GeRVIz+x0aqLObHH
        1U9REB8D8EwvjyxS785ysdDi3VNY8j2KvTSpvjU=
X-Google-Smtp-Source: ALg8bN53D2wtFUNnLcXcUWsHoudBl/sspydis5x3f8q3+Yc8OpzBgh2rxSD0SCdNbb7YFGihHT+nrdFo5UY/OdVcgv8=
X-Received: by 2002:a81:e30b:: with SMTP id q11mr7868266ywl.490.1548357089730;
 Thu, 24 Jan 2019 11:11:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+ToGPEQgJ=0eFgbS2C9BexG=Js27vUWikEHqyLE6qs3viE-5g@mail.gmail.com>
 <20190124084245.GK32526@8bytes.org>
In-Reply-To: <20190124084245.GK32526@8bytes.org>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Thu, 24 Jan 2019 17:11:18 -0200
Message-ID: <CA+ToGPGoC720eCxFWva5ZK0buk_GEt7axJxcZ0EKeskxP2W9bw@mail.gmail.com>
Subject: Re: Nested KVM is broken on a AMD Ryzen 5 2400G
To:     Joerg Roedel <joro@8bytes.org>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Thu, Jan 24, 2019 at 6:42 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi Diego,
>
> thanks for the report!

You're welcome, many thanks for your quick reply.

>
> On Thu, Jan 24, 2019 at 01:57:31AM -0200, Diego Viola wrote:
> > [10499.577192] WARNING: CPU: 2 PID: 3487 at arch/x86/kvm/mmu.c:2066
> > nonpaging_update_pte+0x5/0x10 [kvm]
>
> Seems like the nested-paging emulation got broken somewhere in the past.
> Can you try to load the KVM module in the guest with 'npt=0' and see if
> it works then?

I tried this and snapcraft is still timing out on the guest:

diego@diego-Standard-PC-i440FX-PIIX-1996:~/mysnaps/hello$ snapcraft
Launching a VM.
start failed: timed out waiting for instance to respond
Stopping snapcraft-my-snap-name /^C
Aborted!
diego@diego-Standard-PC-i440FX-PIIX-1996:~/mysnaps/hello$

That said, I no longer see the dmesg stack trace on the host. Should I
try a more recent kernel on the guest?

>
> Thanks,
>
>         Joerg

Regards,
Diego
