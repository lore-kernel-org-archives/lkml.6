Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB5FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA152084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbCYeX5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA152084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeKZLSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:18:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41589 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZLSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:18:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id z28so14349601edi.8;
        Sun, 25 Nov 2018 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6tYA31JK+VM9ItGjZeRv2g4pGpea7PdrNsKNs2c6As=;
        b=CbCYeX5d0y2vjOBmuvm3nVLqiKuij2la85estmi4hP+I8O+VZMSul9RRZGgCryEZgo
         uoQEg4+T1JpJf69EPX3F6M1GpsQTj9mlDYAqq7PktwHm/Y2ib7Ch8nRNxDwLpYgoDa9v
         l/qWAbcneweHvEGGWSSeY2tON+vwZwqgDW0S+dDFbazEOh1LK52d1IDdpycdA7/TWzcu
         n7OuDlvgFRFmrNwbMSU3Ker7I25VgdkZVWe7kOXL8jCshxEz5WwROZilrj+sT9ryON9Q
         x4cA6XSRyHw+QskSOuIy6uA5OwRjV7uSTD83klQNGdmtqAPRqJRAMuNicqgCQlpSBB6q
         c1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6tYA31JK+VM9ItGjZeRv2g4pGpea7PdrNsKNs2c6As=;
        b=TASCdrz5E37CE3zCDPU1l1Yr4uT8/Se/8l7BLKouj6DyG96qmDZOhJrAYpeXblUn4u
         94kfpSMioAXzWwvbyajQTz3Q8yBIDfr0fa61FUYtJZxUs6/21G8zpQaTBBysZmuH40B9
         6Gia/NeoRocstsK1u3d4GfV/hCUubCGWUaYBbur/EwlEAFPG4I6UaXXr5myse7uiKCBN
         28y5Uyrwkghbv4gPnYj40ItlvpA+b6edZ8UhcnquIGYNnyyeOm1jSotRVAS7F1nXxVMf
         62UUxzAbnvNjogju6PfBqTmDgShCBNOmjIKShPpH+BeAzOwZih2cUPaGpbrp61vnak6i
         XPuA==
X-Gm-Message-State: AA+aEWY9l4avnSe8ck4y8n7Gu2Ic+6VNfx0J7lHoOooe331vfQLA9+4O
        rHcnBABGsEGHDohwx4TVzlDuh3J5eTjc3YQMgN0=
X-Google-Smtp-Source: AFSGD/VM0MpBKduDauIHFOnt4QLYVz8xfoL6eDgxnTGxazH85CpI9i3HT25aNtfvRTThE5etaY/lTMIdyMRTIDgBG1o=
X-Received: by 2002:a50:b31c:: with SMTP id q28mr20881377edd.241.1543191981630;
 Sun, 25 Nov 2018 16:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
 <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
 <CAF=yD-LngkYq23Q2TCJv_0PRiAryznYRWRbqYFaQkNO=U0w9gQ@mail.gmail.com> <CAK8P3a2_i=RwcyjeDTn9HrzvPN7FYEYdFuyo3RXSVS_N4sbYeg@mail.gmail.com>
In-Reply-To: <CAK8P3a2_i=RwcyjeDTn9HrzvPN7FYEYdFuyo3RXSVS_N4sbYeg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 25 Nov 2018 19:25:45 -0500
Message-ID: <CAF=yD-+m=mn9UyB39u_kuRVSsqWFg8ZBW812p_c=h9h=9_6XLA@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The existing timestamp options: SO_TIMESTAMP* fail to provide proper
> > > timestamps beyond year 2038 on 32 bit ABIs.
> > > But, these work fine on 64 bit native ABIs.
> > > So now we need a way of updating these timestamps so that we do not
> > > break existing userspace: 64 bit ABIs should not have to change
> > > userspace, 32 bit ABIs should work as is until 2038 after which they
> > > have bad timestamps.
> > > So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
> > > assume that 32 bit applications will switch to new ABIs at some point,
> > > but leave the older timestamps as is.
> > > I can update the commit text as per above.
> >
> > So on 32-bit platforms SO_TIMESTAMP_NEW introduces a new struct
> > sock_timeval with both 64-bit fields.
> >
> > Does this not break existing applications that compile against SO_TIMESTAMP
> > and expect struct timeval? For one example, the selftests under tools/testing.
> >
> > The kernel will now convert SO_TIMESTAMP (previously constant 29) to
> > different SO_TIMESTAMP_NEW (62) and returns a different struct. Perhaps
> > with a library like libc in the middle this can be fixed up
> > transparently, but for
> > applications that don't have a more recent libc or use a library at
> > all, it breaks
> > the ABI.
> >
> > I suspect that these finer ABI points may have been discussed outside the
> > narrow confines of socket timestamping. But on its own, this does worry me.
>
> The entire purpose of the complexities in the patch set is to not break
> the user space ABI after an application gets recompiled with a 64-bit
> time_t defined by a new libc version:
>
> #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? \
>             SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
>
> This delays the evaluation of SO_TIMESTAMP to the point where
> it is first used, the assumption being that at this point we have included
> the libc header file that defines both 'time_t' and 'struct timeval'.
> [If we have not included that header, we get a compile-time error,
> which is also necessary because the compiler has no way of deciding
> whether to use SO_TIMESTAMP_OLD or SO_TIMESTAMP_NEW
> in that case].
>
> If the application is built with a 32-bit time_t, or with on a 64-bit
> architecture (all of which have 64-bit time_t and __kernel_long_t),
> or on x32 (which also has 64-bit time_t and __kernel_long_t),
> the result is SO_TIMESTAMP_OLD, so we tell the kernel
> to send back a timestamp in the old format, and everything works
> as it did before.
>
> The only thing that changes is 32-bit user space (other than x32) with
> a 64-bit time_t. In this case, the application expects a structure
> that corresponds to the new sock_timeval (which is compatible
> with the user space timeval based on 64-bit time_t), so we must
> use the new constant in order to tell the kernel which one we want.

Thanks. That was exactly the context that I was missing. I hadn't
figured out that the test was based on a libc definition. This all
makes perfect sense.
