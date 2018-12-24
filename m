Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8FAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5678D2176F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OQkt4utx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbeLXLs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:48:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40890 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLXLs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:48:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so11582042wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 03:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7gir0ddrSr/xERbPKX/yuRsDRKsdHI2Lx7hGfrWzEZE=;
        b=OQkt4utx9EEMUw3h1sMv47HLcPhjRkDJms2MFPK/STRHkcrj7EwDPBjxBK+GL6O2Dg
         iaRbAAiFZnBjOwT3fZbUtrC2Qe3vg+pJMN8ijKqkynt1692FIm1wsVkvxEGYFuRYQOeY
         SjywQDgGJG9zCkWFlTzMHsxNS1kbShk1hwv9EbeVUlZlcu7vvkhXa6Bm56YqmG72rVx9
         N1N5YQJxNR+/rUVKdI7/kP+pnhgHWgUC2KwNcRe1n+A3katScFDRgYX+ppo8jn7WUtuP
         4w1RWwn1D33kTkjt/L+TIXBpWmOEId4m2QVB+NNRP5QUrhCKr7+1uPI/FlK9RTC1aiKx
         T4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7gir0ddrSr/xERbPKX/yuRsDRKsdHI2Lx7hGfrWzEZE=;
        b=DTI7FDS+pbPWkuvNlQRZDAH7sQQe71dz5v8oMLEA5qTEhgMCNGE9zHujKejQm2KISV
         RW2ZoUaxfHU4YkZ9iz7MGc9oz5O6hAusu0ZZsH26lzgKWz1/cslhF7vOVq1w4eGV/PyE
         MK3LrWiU07nSj4BfkdpP+crcUCF6f3wZjzbfHrvwh/lrJmRyeNIfAo5OMhoduk7td0B9
         YXVeASpyhLCTVfqzB6SPVftOaetVdZjKuiGvJ2MSvQD3ZPIL0/Ch4gbgtPn/NnyVdIr9
         KHn0rbBPD8cyc8pDNqLLejIFVFompwuTaKwt/VKtRXiEQ3dW31ezid1pN/zojkvk2aMn
         cBmg==
X-Gm-Message-State: AJcUukfNkduixmmgrmY+AdIRhbN1HT3YbIXt+QdU7M1LXV3amQOCwlt2
        8icZt5/ifR6X2miiHvv6HiBL9OZnAvqPQw==
X-Google-Smtp-Source: ALg8bN4FmfiQgui/RTv8fK8odIALzwnN1xomJ266QUlBLejbmZVGCtebskM3MO8wyvTxhSbBZDT42g==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr11443783wmh.119.1545652107316;
        Mon, 24 Dec 2018 03:48:27 -0800 (PST)
Received: from brauner.io (p5B2A6FBE.dip0.t-ipconnect.de. [91.42.111.190])
        by smtp.gmail.com with ESMTPSA id 1sm17432228wmx.48.2018.12.24.03.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 03:48:26 -0800 (PST)
Date:   Mon, 24 Dec 2018 12:48:24 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        joel@joelfernandes.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v1 1/2] binderfs: implement "max" mount option
Message-ID: <20181224114822.quwdpa74gvhu6ybn@brauner.io>
References: <20181223143550.10672-1-christian@brauner.io>
 <20181224110935.cop4v5kfcdkemtwo@brauner.io>
 <20181224114559.GA4124@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181224114559.GA4124@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 12:45:59PM +0100, Greg KH wrote:
> On Mon, Dec 24, 2018 at 12:09:37PM +0100, Christian Brauner wrote:
> > On Sun, Dec 23, 2018 at 03:35:49PM +0100, Christian Brauner wrote:
> > > Since binderfs can be mounted by userns root in non-initial user namespaces
> > > some precautions are in order. First, a way to set a maximum on the number
> > > of binder devices that can be allocated per binderfs instance and second, a
> > > way to reserve a reasonable chunk of binderfs devices for the initial ipc
> > > namespace.
> > > A first approach as seen in [1] used sysctls similiar to devpts but was
> > > shown to be flawed (cf. [2] and [3]) since some aspects were unneeded. This
> > > is an alternative approach which avoids sysctls completely and instead
> > > switches to a single mount option.
> > > 
> > > Starting with this commit binderfs instances can be mounted with a limit on
> > > the number of binder devices that can be allocated. The max=<count> mount
> > > option serves as a per-instance limit. If max=<count> is set then only
> > > <count> number of binder devices can be allocated in this binderfs
> > > instance.
> > > 
> > > This allows to safely bind-mount binderfs instances into unprivileged user
> > > namespaces since userns root in a non-initial user namespace cannot change
> > > the mount option as long as it does not own the mount namespace the
> > > binderfs mount was created in and hence cannot drain the host of minor
> > > device numbers
> > > 
> > > [1]: https://lore.kernel.org/lkml/20181221133909.18794-1-christian@brauner.io/
> > > [2]; https://lore.kernel.org/lkml/20181221163316.GA8517@kroah.com/
> > > [3]: https://lore.kernel.org/lkml/CAHRSSEx+gDVW4fKKK8oZNAir9G5icJLyodO8hykv3O0O1jt2FQ@mail.gmail.com/
> > > [4]: https://lore.kernel.org/lkml/20181221192044.5yvfnuri7gdop4rs@brauner.io/
> > > 
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Right, I forgot to ask. Do we still have time to land this alongside the
> > other patches in 4.21? :)
> 
> It's too late for 4.21-rc1, but let's see what happens after that :)

Sweet! Much appreciated. :)

Christian
