Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AD020872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS/LmHfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AD020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeFTMDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:03:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33604 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFTMDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:03:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so4594197lfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HqoOgMEoaRmi7o6NkRMOkcwpdLU9/KbXEQGATRMyi3g=;
        b=DS/LmHfMzW+8Q4ZAqJGGnOidOAaqYatG+KxR/ytnzDnzPgT1IkgnEHh+b/Kb6fYMTW
         uuB1H9troCmbkFaUxmWCv6FMjz74MsYtZ0Mm7wMljY9jdpY+v5mYW/RTtpoWp+fdesXF
         DzZTvC20WKOF2ExCPqj5wV12ZWxXvfbmjs8fKXAiRUjoKg8ZLw17dV84AeCHlC8Rueuu
         60X1Q1cvzVaU5M7W6xxCPPVE28s+XWE71IH8R/2EVrI2EbKTEqSh0O8mhVwc0annzxfl
         aKYwwE1wyIuzaM6PpiHfLfqo74TbDfBrTRKmeGR2Hqb/VpWpDgr5nnU9226GVEp3RTqd
         iFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HqoOgMEoaRmi7o6NkRMOkcwpdLU9/KbXEQGATRMyi3g=;
        b=TrwNU0tOvoMHtqZYzWvQdTT8BdoySJQPfEY8WWnDoGxiW7mvLeDmW7jDya5BBJKVAR
         RodmSDBI584ak/4Dd8qcfCNCPURAWzneDTWXsK7Z9dVEqEmbZpv8uKn65qQtJaETJH+A
         fKIIq8ZhHlSX8WAkupCyHNPwU4yx3oSeWmK5TW0qRSs+9TDGLzQYrykKwv4c7fkOvPIw
         ABVs+u8FA/i4NDxmKm3SgfCiAFKSNWiNPWZbKnPBsV7Z01WCGgPdFUUZCnvA2o6hsWgo
         fepHmypyRjgxTfqQJfZx/JU2aUNo2MneVCwv039d+XSXHaDvvtQKkz3hHCXFlDvurBGT
         6z4A==
X-Gm-Message-State: APt69E2lk3vUMu2U6G07U7E1WxYVR7M7fCvU3rYYpuFFtISQaOKSah05
        +V/cDYUazQFCbyMav78GuE23cWMp5Zw6hD7rkL8=
X-Google-Smtp-Source: ADUXVKL+HCZZIEjZ9eJCJop/ocg44SMrtNnHYeWYSHK33+ZTGtcDzmUR77m1gUjzI6z3eQDNGCeG7QcVTNN609cq588=
X-Received: by 2002:a2e:99c7:: with SMTP id l7-v6mr6736785ljj.148.1529496220693;
 Wed, 20 Jun 2018 05:03:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 05:03:40
 -0700 (PDT)
In-Reply-To: <5489.1529492311@warthog.procyon.org.uk>
References: <20180620083339.766780-1-arnd@arndb.de> <5489.1529492311@warthog.procyon.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 14:03:40 +0200
X-Google-Sender-Auth: rLQVxi7wXj0iYH0zZs3IjJSVuQ0
Message-ID: <CAK8P3a06uP18jei=b3Hwdoe21f3gM6K5j2129Ra5CdVx5aKh6g@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: avoid deprecated get_seconds()
To:     David Howells <dhowells@redhat.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        linux-cachefs@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:58 PM, David Howells <dhowells@redhat.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> -     sprintf(nbuffer, "%08x%08x",
>> -             (uint32_t) get_seconds(),
>> +     sprintf(nbuffer, "%08llx%08x",
>> +             (uint64_t) ktime_get_real_seconds(),
>
> It's not necessary to expand the 'time' field of the name.  It's not
> interpreted by userspace, it's just there to prevent collisions when moving
> directories about.  If your cache goes weird in the future because there was a
> collision with an object that was moved to the graveyard 68 years ago and not
> cleaned up, then that's probably a bug in cachefilesd.
>
> But I've no objection to using ktime_get_real_seconds() and truncating the
> value.

Ok, fair enough. I was mainly worried about what might happen when the
file names stop being strictly sorted in numerical order by their creation
time. If that is not a problem, I'll send the simpler patch to use
lower_32_bits(ktime_get_real_seconds()) for clarity.

       Arnd
