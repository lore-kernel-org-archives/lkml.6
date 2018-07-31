Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF6FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C91208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPccWRkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C91208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbeGaCLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:11:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37227 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732039AbeGaCLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:11:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so24729811oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 17:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q6qAHMtM8Zt3F4yjM8/8LanF+pgDj/Qzv1IxjBBudXA=;
        b=MPccWRkTWhanoMMspra11+O1jCYtYNVgkk2zCbyZ7c6BEroE+A0zYKXOKEmxPcuVxg
         s5v6a0NWO0v6Ttr/wq+aVEwLBR84PJ9na0hXZk71SGZc+2/dnrrQJTXnOKHkTDrzaPz3
         VK0b59DEbLAJI7rDy2zc801kOfLPfm9G7cRT1z5xDz2egDPjQMpjGsNlsEw6JzJwHoHe
         8Y29j5duHkozDLgqtnfrcX8bu5NFeBo0Y+l1b+kOfpjLqfxuXyrQarGtX8YczfZ3xKOn
         LMmlnZhXng3QpusuBCfZey9VGunG6M8/ybBjIx/0MhQh/Gl0ter6s+cGe05j2Sam2Ger
         Ii1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q6qAHMtM8Zt3F4yjM8/8LanF+pgDj/Qzv1IxjBBudXA=;
        b=nxBepB3iAjN5pKhJhQPOruxWk/h5W1j0Nnjme3OnJNrDKvE9fFRMiU8GLGOeyVIjgH
         joWSC6yqGdcdsZuL2FahtNef6VR0E1eAFSBvac9/U1snpWyQ+ZS+X9D/wuPoXruA3oU5
         T0xMrXW/2IRgLv4xdzepOY4509ZswNs3dBAfVjq52KYUpT3nmBnWgaPOLx2cehVDIxY6
         5C9yVzoglSGqyFVZtRii+V8uw/4U7nf0RJyT/lpVe4WqzC1bX6Uf4OoMo0TpEGhi1Z2U
         HBo2Bw9LnqguXFCshYuFrzCgHKyQ45cH09Hz860BlzCxItxBB0OEOtd5X2TGKqd22I0r
         x21g==
X-Gm-Message-State: AOUpUlFgeH3biVTgUDyHKDVlgv69+vQgrLkNgL1mHJQdhbh4u/qurQHK
        YMtvvq9rcHETdBaPIWLtb5TOxJkL5XwkbnfUrlEjvA==
X-Google-Smtp-Source: AAOMgpePRAHLOsKA22I93VJMZgdFBCbzYnMNlUkQSlLBNuvEi08ptZLYAPqqfjjlwCe+crjaLN1NAuUkcoHnLXRc52E=
X-Received: by 2002:aca:acc8:: with SMTP id v191-v6mr18527397oie.354.1532997220586;
 Mon, 30 Jul 2018 17:33:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1147:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 17:33:39
 -0700 (PDT)
In-Reply-To: <20180730172641.7d516231@cakuba.netronome.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com> <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
 <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com> <20180730172641.7d516231@cakuba.netronome.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 30 Jul 2018 17:33:39 -0700
Message-ID: <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2) command
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 5:26 PM, Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Mon, 30 Jul 2018 03:25:43 -0700, Daniel Colascione wrote:
> > On Mon, Jul 30, 2018 at 3:04 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> > > Hmm, I don't think such UAPI as above is future-proof. In case we would want
> > > a similar mechanism in future for other maps, we would need a whole new bpf
> > > command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
> > > the underlying map may not even be a map-to-map. Additionally, we don't have
> > > any map object at hand in the above, so we couldn't make any finer grained
> > > decisions either. Something like below would be more suitable and leaves room
> > > for extending this further in future.
> >
> > YAGNI.  Your proposed mechanism doesn't add anything under the current
> > implementation.
>
> FWIW in case of HW offload targeting a particular map may allow users
> to avoid a potentially slow sync with all the devices on the system.


Sure. But such a thing doesn't exist right now (right?), and we can
add that more-efficient-in-that-one-case BPF interface when it lands.
I'd rather keep things simple for now.
