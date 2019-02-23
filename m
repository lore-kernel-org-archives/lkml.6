Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53E6206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHfr10sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfBWJTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:19:33 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43067 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBWJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:19:32 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so4177325uaa.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 01:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mMkEwXPKdNVPBWA2qzkLRwDPRiyKUX6poVWNjc8JK0=;
        b=RHfr10sjJXyTPFx9JCHpu7Tsq4j2vANKHRBxayIDYDjooym9ZRtm1jGice9eaIxYf4
         80MCe9VtmceLIHznvTI8vPTdfFu+q44ixcEWrtiO6mXwgP2OZYvaE25jWw4XfawSix7g
         d193dS1pmOBbMCL/+RRgypNicX0Zpz12dnJQSYHHbD4Z2L69iaCfpQHwUz850w7cFoM6
         VWgFieS05InTf9ykaqJ1otYuxKPMDyY+vyMZk2x89wRu4HtkMBioclHWtxFW4wSGcFEj
         w8lx/logWaw89tA6W1xmeBEMGhEHAywKDfFPnQM7a2SPq7pmW8nyvVYC9AeEPTw+yvSJ
         zBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mMkEwXPKdNVPBWA2qzkLRwDPRiyKUX6poVWNjc8JK0=;
        b=rq5KIo8XhtdOYRX/KiTl+cGxovX8GMHIr5MEg/wwoz6S1cjKKZEwxmZxq4KrGXFNM8
         wXq9KuHk7elghWXGNHjdHlhRsNldSwTBCcYWU/LVQTZi854rnpdunZT0YtIrxYLc19zm
         uVW+gteV2UQcQPNi0ozvhe5IdXnWGwEp5UVPYKIpuJCqywxQxXIuIqaZza08vkMugQ3N
         NTwkUD3tcI4WVHnCZPhlZxGFt8wn6uqHZFn4daw7VO5FfnDe5BpMByIBmZsmO/NVQQjE
         GVAsvl3mlIiHq2z/uHkb6LUilZ39ia6QeztXo7X+lIqtzEZuLQuD8ykwTEnrVXXsVuCv
         qe3Q==
X-Gm-Message-State: AHQUAuYhRvL5FxXE6aAoSf3t93x/spc9mXJKSv88/k8767/O5l6bOcQw
        AMMMkYwb37w1vUoI2+lRStwN9MO/VXA+1t8h6rw=
X-Google-Smtp-Source: AHgI3IaZQBJfjuoW9eHAu3rdT6XOF365q4hOF7WY+5ZyJYqeY6sJdjyOM+F9reQ2LI8CBZCZkjPWsiZLJRQ9T4LdZiU=
X-Received: by 2002:a67:741:: with SMTP id 62mr4209576vsh.228.1550913571882;
 Sat, 23 Feb 2019 01:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20190222192959.241499-1-oded.gabbay@gmail.com>
 <20190222192959.241499-2-oded.gabbay@gmail.com> <20190223091659.GA25029@kroah.com>
In-Reply-To: <20190223091659.GA25029@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 23 Feb 2019 11:19:07 +0200
Message-ID: <CAFCwf13nv5Q6dy=dH=GtoMYNyZHMCnQ=C68kLhkcJ8P0LaSdqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: driver's Kconfig must select DMA_SHARED_BUFFER
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 22, 2019 at 09:29:59PM +0200, Oded Gabbay wrote:
> > The driver uses the DMA_BUF module which is built only if
> > DMA_SHARED_BUFFER is selected. DMA_SHARED_BUFFER doesn't have any
> > dependencies so it is ok to select it (as done by many other components).
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
>
> kbuild reported this, right?  You should always add that type of credit
> to the patch.  I'll go add it by hand this time...
>
> thanks,
>
> greg k-h

Ah, I didn't know that, sorry. It wasn't enforced in drm :(
I'll follow your example for future patches.
Thanks,
Oded
