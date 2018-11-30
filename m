Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E7B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT5RmY0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E7B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeLAKpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:45:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45491 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:45:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so6138504edb.12;
        Fri, 30 Nov 2018 15:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRQQqjwzZGR6mtX+Vtx/c1svOrNUmlfPUpeX9+9RBbc=;
        b=IT5RmY0ssKdNcOS9g7QX9G+8OMWU/nKYjhD/bRvphzACrQkuOW5fAOY2xZKNdoRaA/
         rk0gR9a4uiIlNdST3L0Wn89+TW8yIe2Q6bDiinjlbar0DdPglXuncba+gTGukA8skypn
         GeQI8zZCsdYfXHtLnxAWA3hfNBJ4jmy+pm1b2cqL/jr2TSlx1rknCcFIB5vy33sqQRAD
         87hkVuW7PXc/k3KaRVghuuhv3plqCP1FlkYOWv60p0F30XXEdOG9MCKZUHA2NFPE4d3D
         b3SyFUQvRf11cDd/j/ciG6k8x0lgd6T/iw7P/dORQ0wBGURsPMMllZNW2A6dZ5sSiaut
         AzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRQQqjwzZGR6mtX+Vtx/c1svOrNUmlfPUpeX9+9RBbc=;
        b=oO1kzJ+BzrevAu7K6LNeYCyctAMRA7vHn/T+8v8sdO6VnDlZRMcvnMxmfY3Wxjm1qF
         NCg9BaH4c5bWBZavetBKhqfqRJVNF6ycsZwFDBLK4O3OUOQbsmW060JBCYUdXPi7qnkC
         vUaVGLcoQrtGqGNofM6TdhXm6lQQzaD8X+Tfa2MRb2roQGk36qITXSg5O9CszeirKWX6
         eBgR362Giqupb77qAHqv55+RXxOJEBCzdBDDoSetJJuyZBskEVlvWxrjwtiJqLpC1hRV
         yON7ooSoU6ywntS89FgwzkL4VJ6AwpjNSm+i7nb5J0yjZw4sHLAm8gYX+WXb800wj7dK
         sQxg==
X-Gm-Message-State: AA+aEWbQ7LCfeMXZm6KACk1yJR048IWUFp/BsLEdwGEv+StzGe1kkJFJ
        oHfQm5/ko0aiRPLzgcqaTNWYdLCG8u/0MqA1tAI=
X-Google-Smtp-Source: AFSGD/V7zedB+Gj7jkugGHFb2ur850hbGFmVi0WxyvAcMK9SiEksoJSS/NdkA+cKPs+0vfflfMd1nER7S8v+8mTUL4Q=
X-Received: by 2002:a17:906:2313:: with SMTP id l19-v6mr5817919eja.204.1543620873166;
 Fri, 30 Nov 2018 15:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-3-deepa.kernel@gmail.com> <CAF=yD-KfxXK=Ta=+a8UYMcmUYzN=UokotfzSno2-xi=JeS6=0g@mail.gmail.com>
 <CABeXuvr7M4z6-7qsnBZqnXQEcGxfgVddGmsoV=iLwA-n=S5VkQ@mail.gmail.com>
In-Reply-To: <CABeXuvr7M4z6-7qsnBZqnXQEcGxfgVddGmsoV=iLwA-n=S5VkQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 30 Nov 2018 18:33:57 -0500
Message-ID: <CAF=yD-+DNdGpitd9TABeHjnBFRPcrN4E-AcQNmGMD-Lt9th7mw@mail.gmail.com>
Subject: Re: [PATCH 2/8] sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Helge Deller <deller@gmx.de>,
        David Howells <dhowells@redhat.com>, jejb@parisc-linux.org,
        ralf@linux-mips.org, rth@twiddle.net,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:38 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 7:59 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING options, the
> > > way they are currently defined, are not y2038 safe.
> > > Subsequent patches in the series add new y2038 safe versions
> > > of these options which provide 64 bit timestamps on all
> > > architectures uniformly.
> > > Hence, rename existing options with OLD tag suffixes.
> >
> > Why do the existing interfaces have to be renamed when new interfaces are added?
>
> Existing options need to be renamed because of the macro below:
>
> #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? \
>             SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
>
> SO_TIMESTAMP is now dependent on size of time_t because of the libc flag.

Yes, I understand the mechanism based on libc's definition of time_t
after Arnd's explanation. Please do capture that in the commit
message, for possible future readers who stumble upon the code with
git blame.
