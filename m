Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D74C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCA521019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fu5HTO7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfAVRdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:33:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33003 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfAVRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:33:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so24439039otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lcn7tuaNZ7GwD7JACdY8Nxk+FBJvKzf+TQggo1/zanU=;
        b=Fu5HTO7Uw/lZDFb15QpkaKn5jbTd6vhevqc0RyCCarYoTYrB0ytPrRZs3VkmhvWe0d
         yiX6A2WwsE5zG1GFLcRToVQJmalSi/js4qyr6ZlF6sRn2Kf+Wk5KTigENG2ut+SnrbXh
         9Sprv1dNFP2vJY9ffY8mjMeIUdTqZx7SyGc3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lcn7tuaNZ7GwD7JACdY8Nxk+FBJvKzf+TQggo1/zanU=;
        b=W0HC2gMm8y4tdhRXd3WdYCB+thqaS4B5cY5DNUYHeMywaky+KM7f67Xlrb5o1e2/TV
         axgJ38OH92GCg3i2CEVC/hi34k7l6UjgBRhKcuCm3h6+JA2qDl3siwbD6YmZMU8LpUW8
         biRfvVwtcchTw69wC9Ria0D+I24uj8O3sD3r4aJoE8ctVewrT4xIHduo/amSQx7K8zf8
         MwJoiIcNWbydHhT4nDJ0NTHY1DFh5Do8gMFLBh+SCoPjMWl5hBJkJ2lwzyZSCgXCTKAE
         a+tupn3hPFJcTXa1FdpBD2U9y4nPy4prwKBUGQAqvLxX9WDMhKGm2qiLGIRS8Irm+vmk
         wPUA==
X-Gm-Message-State: AJcUukfFV0Y3ynaEczpz260tLnDqepDAFYzyGBCmm6L78DcvbSI1cpP1
        jgvGq72nJFooXhRiZnAI0LK7Pe6MoI3K3N8whHzV+A==
X-Google-Smtp-Source: ALg8bN4sV9J0f9UnfNvBLkpfaFGH0bFMwAAl2RHKDmYcYRQAR+zJIexb/0hDctyjdceQT9CkOyvaIjmJpEQrrkfMnjU=
X-Received: by 2002:a9d:1d65:: with SMTP id m92mr13205202otm.65.1548178413939;
 Tue, 22 Jan 2019 09:33:33 -0800 (PST)
MIME-Version: 1.0
References: <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com> <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com> <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com>
 <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
 <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com> <alpine.DEB.2.10.1901161450470.10666@lmark-linux.qualcomm.com>
 <3bf4bfce-aee6-9c52-c2f7-783dc63bfc3a@ti.com> <alpine.DEB.2.10.1901171704270.12287@lmark-linux.qualcomm.com>
 <b8b16d71-e09b-6bf9-259e-79c1de7fd15b@ti.com> <20190121112235.g36qqptpv6wjuj7w@DESKTOP-E1NTVVP.localdomain>
 <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
In-Reply-To: <b89df12e-00bc-5484-6458-f7c85a362b42@ti.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 22 Jan 2019 23:03:22 +0530
Message-ID: <CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on map/unmap
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Sincere apologies for chiming in a bit late here, but was off due to
some health issues.

Also, adding Daniel Vetter to the mix, since he has been one of the
core guys who shaped up dma-buf as it is today.

On Tue, 22 Jan 2019 at 02:51, Andrew F. Davis <afd@ti.com> wrote:
&gt;
&gt; On 1/21/19 5:22 AM, Brian Starkey wrote:
&gt; &gt; Hi,
&gt; &gt;
&gt; &gt; Sorry for being a bit sporadic on this. I was out travelling last=
 week
&gt; &gt; with little time for email.
&gt; &gt;
&gt; &gt; On Fri, Jan 18, 2019 at 11:16:31AM -0600, Andrew F. Davis wrote:
&gt; &gt;&gt; On 1/17/19 7:11 PM, Liam Mark wrote:
&gt; &gt;&gt;&gt; On Thu, 17 Jan 2019, Andrew F. Davis wrote:
&gt; &gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt; On 1/16/19 4:54 PM, Liam Mark wrote:
&gt; &gt;&gt;&gt;&gt;&gt; On Wed, 16 Jan 2019, Andrew F. Davis wrote:
&gt; &gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt; On 1/16/19 9:19 AM, Brian Starkey wrote:
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi :-)
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Jan 15, 2019 at 12:40:16PM
-0600, Andrew F. Davis wrote:
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 1/15/19 12:38 PM, Andrew F.
Davis wrote:
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 1/15/19 11:45 AM, Liam Mark wr=
ote:
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, 15 Jan 2019,
Andrew F. Davis wrote:
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 1/14/19 11:13 AM,
Liam Mark wrote:
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Fri, 11 Jan
2019, Andrew F. Davis wrote:
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Buffers may
not be mapped from the CPU so skip cache maintenance here.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Accesses
from the CPU to a cached heap should be bracketed with
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
{begin,end}_cpu_access calls so maintenance should not be needed
anyway.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
Signed-off-by: Andrew F. Davis <afd@ti.com>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
drivers/staging/android/ion/ion.c | 7 ++++---
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;  1 file
changed, 4 insertions(+), 3 deletions(-)
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git
a/drivers/staging/android/ion/ion.c
b/drivers/staging/android/ion/ion.c
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; index
14e48f6eb734..09cb5a8e2b09 100644
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---
a/drivers/staging/android/ion/ion.c
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++
b/drivers/staging/android/ion/ion.c
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -261,8
+261,8 @@ static struct sg_table *ion_map_dma_buf(struct
dma_buf_attachment *attachment,
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;   table =3D a-&gt=
;table;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; - if
(!dma_map_sg(attachment-&gt;dev, table-&gt;sgl, table-&gt;nents,
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -
     direction))
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; + if
(!dma_map_sg_attrs(attachment-&gt;dev, table-&gt;sgl, table-&gt;nents,
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +
           direction, DMA_ATTR_SKIP_CPU_SYNC))
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Unfortunately I
don't think you can do this for a couple reasons.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; You can't rely
on {begin,end}_cpu_access calls to do cache maintenance.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; If the calls to
{begin,end}_cpu_access were made before the call to
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; dma_buf_attach
then there won't have been a device attached so the calls
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; to
{begin,end}_cpu_access won't have done any cache maintenance.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; That should be okay
though, if you have no attachments (or all
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; attachments are
IO-coherent) then there is no need for cache
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; maintenance. Unless
you mean a sequence where a non-io-coherent device
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is attached later
after data has already been written. Does that
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; sequence need supporting?
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Yes, but also I think
there are cases where CPU access can happen before
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; in Android, but I will
focus on later for now.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DMA-BUF doesn't have
to allocate the backing
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; memory until
map_dma_buf() time, and that should only happen after all
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the devices have
attached so it can know where to put the buffer. So we
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; shouldn't expect any
CPU access to buffers before all the devices are
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; attached and mapped, righ=
t?
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Here is an example where
CPU access can happen later in Android.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Camera device records
video -&gt; software post processing -&gt; video device
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (who does compression of
raw data) and writes to a file
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In this example assume
the buffer is cached and the devices are not
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; IO-coherent (quite common).
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is the start of the
problem, having cached mappings of memory that
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; is also being accessed
non-coherently is going to cause issues one way
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; or another. On top of the
speculative cache fills that have to be
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; constantly fought back
against with CMOs like below; some coherent
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; interconnects behave badly
when you mix coherent and non-coherent access
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (snoop filters get messed up).
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The solution is to either
always have the addresses marked non-coherent
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (like device memory, no-map
carveouts), or if you really want to use
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; regular system memory
allocated at runtime, then all cached mappings of
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; it need to be dropped, even
the kernel logical address (area as painful
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; as that would be).
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Ouch :-( I wasn't aware about these
potential interconnect issues. How
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; "real" is that? It seems that we
aren't really hitting that today on
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; real devices.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sadly there is at least one real device
like this now (TI AM654). We
&gt; &gt;&gt;&gt;&gt;&gt;&gt; spent some time working with the ARM
interconnect spec designers to see
&gt; &gt;&gt;&gt;&gt;&gt;&gt; if this was allowed behavior, final
conclusion was mixing coherent and
&gt; &gt;&gt;&gt;&gt;&gt;&gt; non-coherent accesses is never a good
idea.. So we have been working to
&gt; &gt;&gt;&gt;&gt;&gt;&gt; try to minimize any cases of mixed
attributes [0], if a region is
&gt; &gt;&gt;&gt;&gt;&gt;&gt; coherent then everyone in the system
needs to treat it as such and
&gt; &gt;&gt;&gt;&gt;&gt;&gt; vice-versa, even clever CMO that work on
other systems wont save you
&gt; &gt;&gt;&gt;&gt;&gt;&gt; here. :(
&gt; &gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt; [0]
https://github.com/ARM-software/arm-trusted-firmware/pull/1553
&gt; &gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;
&gt; &gt; "Never a good idea" - but I think it should still be well defined=
 by
&gt; &gt; the ARMv8 ARM (Section B2.8). Does this apply to your system?
&gt; &gt;
&gt; &gt; "If the mismatched attributes for a memory location all assign th=
e
&gt; &gt; same shareability attribute to a Location that has a cacheable
&gt; &gt; attribute, any loss of uniprocessor semantics, ordering, or coher=
ency
&gt; &gt; within a shareability domain can be avoided by use of software ca=
che
&gt; &gt; management"
&gt; &gt;
&gt; &gt; https://developer.arm.com/docs/ddi0487/latest/arm-architecture-re=
ference-manual-armv8-for-armv8-a-architecture-profile
&gt; &gt;
&gt; &gt; If the cache is invalidated when switching between access types,
&gt; &gt; shouldn't the snoop filters get un-messed-up?
&gt; &gt;
&gt;
&gt; The details of the issue are this, our coherent interconnect (MSMC) ha=
s
&gt; a snoop filter (for those following along at home it's a list of which
&gt; cache lines are currently inside each connected master so snoop reques=
ts
&gt; can be filtered for masters that wont care). When a "NoSnoop"(non-cach=
ed
&gt; or non-shareable) transaction is received for a location from any mast=
er
&gt; it assumes that location cannot be in the cache of *any* master (as th=
e
&gt; correct cache-line state transition a given core will take for that li=
ne
&gt; is not defined by ARM spec), so it drops all records of that line. The
&gt; only way to recover from this is for every master to invalidate the li=
ne
&gt; and pick it back up again so the snoop filer can re-learn who really h=
as
&gt; it again. Invalidate on one core also doesn't propagate to the differe=
nt
&gt; cores as those are requests are also blocked by the now confused snoop
&gt; filter, so each and every core must manually do it..
&gt;
&gt; It behaves much more like later in ARMv8 ARM (Section B2.8):
&gt;
&gt; "If the mismatched attributes for a Location mean that multiple
&gt; cacheable accesses to the Location might be made with different
&gt; shareability attributes, then uniprocessor semantics, ordering, and
&gt; coherency are guaranteed only if:
&gt; =E2=80=A2 Each PE that accesses the Location with a cacheable attribut=
e performs
&gt; a clean and invalidate of the Location before and after accessing that
&gt; Location.
&gt; =E2=80=A2 A DMB barrier with scope that covers the full shareability o=
f the
&gt; accesses is placed between any accesses to the same memory Location th=
at
&gt; use different attributes."
&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ION buffer is allocated.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; //Camera device records video
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; dma_buf_attach
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; dma_map_attachment
(buffer needs to be cleaned)
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Why does the buffer need to
be cleaned here? I just got through reading
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the thread linked by Laura
in the other reply. I do like +Brian's
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Actually +Brian this time :)
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; suggestion of tracking if
the buffer has had CPU access since the last
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; time and only flushing the
cache if it has. As unmapped heaps never get
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; CPU mapped this would never
be the case for unmapped heaps, it solves my
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; problem.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [camera device writes to buff=
er]
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; dma_buf_unmap_attachment
(buffer needs to be invalidated)
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; It doesn't know there will
be any further CPU access, it could get freed
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; after this for all we know,
the invalidate can be saved until the CPU
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; requests access again.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; We don't have any API to allow the
invalidate to happen on CPU access
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; if all devices already detached. We
need a struct device pointer to
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; give to the DMA API, otherwise on
arm64 there'll be no invalidate.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; I had a chat with a few people
internally after the previous
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; discussion with Liam. One suggestion
was to use
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; DMA_ATTR_SKIP_CPU_SYNC in
unmap_dma_buf, but only if there's at least
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; one other device attached
(guarantees that we can do an invalidate in
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; the future if begin_cpu_access is
called). If the last device
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; detaches, do a sync then.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Conversely, in map_dma_buf, we would
track if there was any CPU access
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; and use/skip the sync appropriately.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Now that I think this all through I
agree this patch is probably wrong.
&gt; &gt;&gt;&gt;&gt;&gt;&gt; The real fix needs to be better handling
in the dma_map_sg() to deal
&gt; &gt;&gt;&gt;&gt;&gt;&gt; with the case of the memory not being
mapped (what I'm dealing with for
&gt; &gt;&gt;&gt;&gt;&gt;&gt; unmapped heaps), and for cases when the
memory in question is not cached
&gt; &gt;&gt;&gt;&gt;&gt;&gt; (Liam's issue I think). For both these
cases the dma_map_sg() does the
&gt; &gt;&gt;&gt;&gt;&gt;&gt; wrong thing.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; I did start poking the code to check
out how that would look, but then
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Christmas happened and I'm still
catching back up.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; dma_buf_detach  (device
cannot stay attached because it is being sent down
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the pipeline and Camera
doesn't know the end of the use case)
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This seems like a broken
use-case, I understand the desire to keep
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; everything as modular as
possible and separate the steps, but at this
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; point no one owns this
buffers backing memory, not the CPU or any
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; device. I would go as far as
to say DMA-BUF should be free now to
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; de-allocate the backing
storage if it wants, that way it could get ready
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; for the next attachment,
which may change the required backing memory
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; completely.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; All devices should attach
before the first mapping, and only let go
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; after the task is complete,
otherwise this buffers data needs copied off
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; to a different location or
the CPU needs to take ownership in-between.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Yeah.. that's certainly the theory.
Are there any DMA-BUF
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; implementations which actually do
that? I hear it quoted a lot,
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; because that's what the docs say -
but if the reality doesn't match
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; it, maybe we should change the docs.
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt;
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Do you mean on the userspace side? I'm
not sure, seems like Android
&gt; &gt;&gt;&gt;&gt;&gt;&gt; might be doing this wrong from what I
can gather. From kernel side if
&gt; &gt;&gt;&gt;&gt;&gt;&gt; you mean the "de-allocate the backing
storage", we will have some cases
&gt; &gt;&gt;&gt;&gt;&gt;&gt; like this soon, so I want to make sure
userspace is not abusing DMA-BUF
&gt; &gt;&gt;&gt;&gt;&gt;&gt; in ways not specified in the
documentation. Changing the docs to force
&gt; &gt;&gt;&gt;&gt;&gt;&gt; the backing memory to always be
allocated breaks the central goal in
&gt; &gt;&gt;&gt;&gt;&gt;&gt; having attach/map in DMA-BUF separate.
&gt; &gt;
&gt; &gt; Actually I meant in the kernel, in exporters. I haven't seen anyo=
ne
&gt; &gt; using the API as it was intended (defer allocation until first ma=
p,
&gt; &gt; migrate between different attachments, etc.). Mostly, backing sto=
rage
&gt; &gt; seems to get allocated at the point of export, and device mapping=
s are
&gt; &gt; often held persistently (e.g. the DRM prime code maps the buffer =
at
&gt; &gt; import time, and keeps it mapped: drm_gem_prime_import_dev).
&gt; &gt;
&gt;

So I suppose some clarification on the 'intended use' part of dma-buf
about deferred allocation is due, so here it is: (Daniel, please feel
free to chime in with your opinion here)

 - dma-buf was of course designed as a framework to help intelligent
exporters to defer allocation until first map, and be able to migrate
backing storage if required etc. At the same time, it is not a
_requirement_ from any exporter, so exporters so far have just used it
as a convenient mechanism for zero-copy.
- ION is one of the few dma-buf exporters in kernel, which satisfies a
certain set of expectations from its users.

&gt; I haven't either, which is a shame as it allows for some really useful
&gt; management strategies for shared memory resources. I'm working on one
&gt; such case right now, maybe I'll get to be the first to upstream one :)
&gt;
That will be a really good thing! Though perhaps we ought to think if
for what you're trying to do, is ION the right place, or should you
have a device-specific exporter, available to users via dma-buf apis?

&gt; &gt; I wasn't aware that CPU access before first device access was
&gt; &gt; considered an abuse of the API - it seems like a valid thing to w=
ant
&gt; &gt; to do.
&gt; &gt;
&gt;
&gt; That's just it, I don't know if it is an abuse of API, I'm trying to g=
et
&gt; some clarity on that. If we do want to allow early CPU access then tha=
t
&gt; seems to be in contrast to the idea of deferred allocation until first
&gt; device map, what is supposed to backing the buffer if no devices have
&gt; attached or mapped yet? Just some system memory followed by migration =
on
&gt; the first attach to the proper backing? Seems too time wasteful to be
&gt; have a valid use.
&gt;
&gt; Maybe it should be up to the exporter if early CPU access is allowed?
&gt;
&gt; I'm hoping someone with authority over the DMA-BUF framework can clari=
fy
&gt; original intentions here.

I don't think dma-buf as a framework stops early CPU access, and the
exporter can definitely decide on that by implementing
begin_cpu_access / end_cpu_access operations to not allow early CPU
access, if it so desires.

</afd@ti.com></afd@ti.com>

>
> >>>>>>
> >>>>>>>>>> //buffer is send down the pipeline
> >>>>>>>>>>
> >>>>>>>>>> // Usersapce software post processing occurs
> >>>>>>>>>> mmap buffer
> >>>>>>>>>
> >>>>>>>>> Perhaps the invalidate should happen here in mmap.
> >>>>>>>>>
> >>>>>>>>>> DMA_BUF_IOCTL_SYNC IOCT with flags DMA_BUF_SYNC_START // No CM=
O since no
> >>>>>>>>>> devices attached to buffer
> >>>>>>>>>
> >>>>>>>>> And that should be okay, mmap does the sync, and if no devices =
are
> >>>>>>>>> attached nothing could have changed the underlying memory in th=
e
> >>>>>>>>> mean-time, DMA_BUF_SYNC_START can safely be a no-op as they are=
.
> >>>>>>>
> >>>>>>> Yeah, that's true - so long as you did an invalidate in unmap_dma=
_buf.
> >>>>>>> Liam was saying that it's too painful for them to do that every t=
ime a
> >>>>>>> device unmaps - when in many cases (device->device, no CPU) it's =
not
> >>>>>>> needed.
> >>>>>>
> >>>>>> Invalidates are painless, at least compared to a real cache flush,=
 just
> >>>>>> set the invalid bit vs actually writing out lines. I thought the i=
ssue
> >>>>>> was on the map side.
> >>>>>>
> >>>>>
> >>>>> Invalidates aren't painless for us because we have a coherent syste=
m cache
> >>>>> so clean lines get written out.
> >>>>
> >>>> That seems very broken, why would clean lines ever need to be writte=
n
> >>>> out, that defeats the whole point of having the invalidate separate =
from
> >>>> clean. How do you deal with stale cache lines? I guess in your case =
this
> >>>> is what forces you to have to use uncached memory for DMA-able memor=
y.
> >>>>
> >>>
> >>> My understanding is that our ARM invalidate is a clean + invalidate, =
I had
> >>> concerns about the clean lines being written to the the system cache =
as
> >>> part of the 'clean', but the following 'invalidate' would take care o=
f
> >>> actually invalidating the lines (so nothign broken).
> >>> But i am probably wrong on this and it is probably smart enough not t=
o the
> >>> writing of the clean lines.
> >>>
> >>
> >> You are correct that for a lot of ARM cores "invalidate" is always a
> >> "clean + invalidate". At first I thought this was kinda silly as there
> >> is now no way to mark a dirty line invalid without it getting written
> >> out first, but if you think about it any dirty cache-line can be writt=
en
> >> out (cleaned) at anytime anyway, so this doesn't actually change syste=
m
> >> behavior. You should just not write to memory (make the line dirty)
> >> anything you don't want eventually written out.
> >>
> >> Point two, it's not just smart enough to not write-out clean lines, it
> >> is guaranteed not to write them out by the spec. Otherwise since
> >> cache-lines can be randomly filled if those same clean lines got writt=
en
> >> out on invalidate operations there would be no way to maintain coheren=
cy
> >> and things would be written over top each other all over the place.
> >>
> >>> But regardless, targets supporting a coherent system cache is a legit=
amate
> >>> configuration and an invalidate on this configuration does have to go=
 to
> >>> the bus to invalidate the system cache (which isn't free) so I dont' =
think
> >>> you can make the assumption that invalidates are cheap so that it is =
okay
> >>> to do them (even if they are not needed) on every dma unmap.
> >>>
> >>
> >> Very true, CMOs need to be broadcast to other coherent masters on a
> >> coherent interconnect (and the interconnect itself if it has a cache a=
s
> >> well (L3)), so not 100% free, but almost, just the infinitesimal cost =
of
> >> the cache tag check in hardware. If there are no non-coherent devices
> >> attached then the CMOs are no-ops, if there are then the data needs to
> >> be written out either way, doing it every access like is done with
> >> uncached memory (- any write combining) will blow away any saving made
> >> from the one less CMO. Either way you lose with uncached mappings of
> >> memory. If I'm wrong I would love to know.
> >>
> >
> > From what I understand, the current DMA APIs are not equipped to
> > handle having coherent and non-coherent devices attached at the same
> > time. The buffer is either in "CPU land" or "Device land", there's no
> > smaller granule of "Coherent Device land" or "Non-Coherent Device
> > land".
> >
> > I think if there's devices which are making coherent accesses, and
> > devices which are making non-coherent accesses, then we can't support
> > them being attached at the same time without some enhancements to the
> > APIs.
> >
>
> I think you are right, we only handle sync to/from the CPU out to
> "Device land". To sync from device to device I'm not sure there is
> anything right now, they all have to be able to talk to each other
> without any maintenance from the host CPU.
>
> This will probably lead to some interesting cases like in OpenVX where a
> key selling point is keeping the host out of the loop and let the remote
> devices do all the sharing between themselves.
>
> >>>>> And these invalidates can occur on fairly large buffers.
> >>>>>
> >>>>> That is why we haven't went with using cached ION memory and "track=
ing CPU
> >>>>> access" because it only solves half the problem, ie there isn't a w=
ay to
> >>>>> safely skip the invalidate (because we can't read the future).
> >>>>> Our solution was to go with uncached ION memory (when possible), bu=
t as
> >>>>> you can see in other discussions upstream support for uncached memo=
ry has
> >>>>> its own issues.
> >>>>>
> >
> > @Liam, in your problematic use-cases, are both devices detached when
> > the buffer moves between them?
> >
> >  1) dev 1 map, access, unmap
> >  2) dev 1 detach
> >  3) (maybe) CPU access
> >  4) dev 2 attach
> >  5) dev 2 map, access
> >
> > I still think a pretty pragmatic solution is to use
> > DMA_ATTR_SKIP_CPU_SYNC until the last device detaches. That won't work
> > if your access sequence looks like above...
> >
> > ...however, if your sequence looks like above, then you probably need
> > to keep at least one of the devices attached anyway. Otherwise, per
> > the API, the buffer could get migrated after 2)/before 5). That will
> > surely hurt a lot more than an invalidate.
> >
> >>>>
> >>>> Sounds like you need to fix upstream support then, finding a way to =
drop
> >>>> all cacheable mappings of memory you want to make uncached mappings =
for
> >>>> seems to be the only solution.
> >>>>
> >>>
> >>> I think we can probably agree that there woudln't be a good way to re=
move
> >>> cached mappings without causing an unacceptable performance degradati=
on
> >>> since it would fragment all the nice 1GB kernel mappings we have.
> >>>
> >>> So I am trying to find an alternative solution.
> >>>
> >>
> >> I'm not sure there is a better solution. How hard is this solution to
> >> implement anyway? The kernel already has to make gaps and cut up that
> >> nice 1GB mapping when you make a reserved memory space in the lowmem
> >> area, so all the logic is probably already implemented. Just need to
> >> allow it to be hooked into from Ion when doing doing the uncached mapp=
ings.
> >>
> >
> > I haven't looked recently, but I'm not sure the early memblock code
> > can be reused as-is at runtime. I seem to remember it makes a bunch of
> > assumptions about the fact that it's running "early".
> >
> > If CPU uncached mappings of normal system memory is really the way
> > forward, I could envisage a heap which maintains a pool of chunks of
> > memory which it removed from the kernel mapping. The pool could grow
> > (remove more pages from the kernel mapping)/shrink (add them back to
> > the kernel mapping) as needed.
> >
> > John Reitan implemented a compound-page heap, which used compaction to
> > get a pool of 2MB contiguous pages. Something like that would at least
> > prevent needing full 4kB granularity when removing things from the
> > kernel mapping.
> >
> > Even better, could it somehow be restricted to a region which is
> > already fragmented? (e.g. the one which was used for the default CMA
> > heap)
> >
> > Thanks,
> > -Brian
> >
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>>> [CPU reads/writes to the buffer]
> >>>>>>>>>> DMA_BUF_IOCTL_SYNC IOCTL with flags DMA_BUF_SYNC_END // No CMO=
 since no
> >>>>>>>>>> devices attached to buffer
> >>>>>>>>>> munmap buffer
> >>>>>>>>>>
> >>>>>>>>>> //buffer is send down the pipeline
> >>>>>>>>>> // Buffer is send to video device (who does compression of raw=
 data) and
> >>>>>>>>>> writes to a file
> >>>>>>>>>> dma_buf_attach
> >>>>>>>>>> dma_map_attachment (buffer needs to be cleaned)
> >>>>>>>>>> [video device writes to buffer]
> >>>>>>>>>> dma_buf_unmap_attachment
> >>>>>>>>>> dma_buf_detach  (device cannot stay attached because it is bei=
ng sent down
> >>>>>>>>>> the pipeline and Video doesn't know the end of the use case)
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>> Also ION no longer provides DMA ready memory, so if you are =
not doing CPU
> >>>>>>>>>>>> access then there is no requirement (that I am aware of) for=
 you to call
> >>>>>>>>>>>> {begin,end}_cpu_access before passing the buffer to the devi=
ce and if this
> >>>>>>>>>>>> buffer is cached and your device is not IO-coherent then the=
 cache maintenance
> >>>>>>>>>>>> in ion_map_dma_buf and ion_unmap_dma_buf is required.
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> If I am not doing any CPU access then why do I need CPU cache
> >>>>>>>>>>> maintenance on the buffer?
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Because ION no longer provides DMA ready memory.
> >>>>>>>>>> Take the above example.
> >>>>>>>>>>
> >>>>>>>>>> ION allocates memory from buddy allocator and requests zeroing=
.
> >>>>>>>>>> Zeros are written to the cache.
> >>>>>>>>>>
> >>>>>>>>>> You pass the buffer to the camera device which is not IO-coher=
ent.
> >>>>>>>>>> The camera devices writes directly to the buffer in DDR.
> >>>>>>>>>> Since you didn't clean the buffer a dirty cache line (one of t=
he zeros) is
> >>>>>>>>>> evicted from the cache, this zero overwrites data the camera d=
evice has
> >>>>>>>>>> written which corrupts your data.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> The zeroing *is* a CPU access, therefor it should handle the ne=
eded CMO
> >>>>>>>>> for CPU access at the time of zeroing.
> >>>>>>>>>
> >>>>>>>
> >>>>>>> Actually that should be at the point of the first non-coherent de=
vice
> >>>>>>> mapping the buffer right? No point in doing CMO if the future acc=
esses
> >>>>>>> are coherent.
> >>>>>>
> >>>>>> I see your point, as long as the zeroing is guaranteed to be the f=
irst
> >>>>>> access to this buffer then it should be safe.
> >>>>>>
> >>>>>> Andrew
> >>>>>>
> >>>>>>>
> >>>>>>> Cheers,
> >>>>>>> -Brian
> >>>>>>>
> >>>>>>>>> Andrew
> >>>>>>>>>
> >>>>>>>>>> Liam
> >>>>>>>>>>
> >>>>>>>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Fo=
rum,
> >>>>>>>>>> a Linux Foundation Collaborative Project
> >>>>>>>>>>
> >>>>>>
> >>>>>
> >>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >>>>> a Linux Foundation Collaborative Project
> >>>>>
> >>>>
> >>>
> >>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >>> a Linux Foundation Collaborative Project
> >>>

Best,
Sumit.
