Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D1DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9D820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YeYmtop7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9D820BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391258AbeGLChw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:37:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40110 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389647AbeGLChw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:37:52 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so16551711iob.7;
        Wed, 11 Jul 2018 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j81LaB8gBjw/veBbHw7PA6iLhIYWfZe0hXexNtVxfjw=;
        b=YeYmtop76kPQFDpRtEZg0bwJUhkDmtrbznIchaUR63BxUreNoKbCo+v5Bo0SlRe8b3
         o+CxZPe0qFGpVIzHRB2ctXRuqeyDziX9kNit9Bd9/ryT5DpdfqVmNuvYOaeq6LFHOVgu
         7qxaFHcnbb32wb/yW2A9OgkSEyv0ZyRNS4gsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j81LaB8gBjw/veBbHw7PA6iLhIYWfZe0hXexNtVxfjw=;
        b=PiDx/VrAmzJnMv69jo7i5BZs8rF2P7u+FdtRpN9ffvhllNnuQmxvhMSHu9JE+SeAM5
         d//LgvbFshERMO9V+HTmbnZ1XIDyB+1vEiQzJx4tzhb6MhpYcyzLzOUbvFzoRcFWu9Vm
         S6yhjrUh+k5mcG2jScYq0cFVTuQKww9aVSDZ+nPTknUOma4CJQnNebCgVm2mc4S22unr
         PJwPPmXmugbPJwGLvCzBEXyMZhUuNXzxi+nGjnj7RrG2LcJPxy29UpJ2apo1quD0A+/A
         4e0tsbjYNAJmC6AZa7DnaqWT71atVFFzjHfdDRI2NU23o0/s0hF5MuSaZf6MlGi2r5Xm
         16TQ==
X-Gm-Message-State: AOUpUlHGFJK/51zUf3Cr2sobN0Hs4ZeCHf7ciAXuKF0ggG/hrQ+IAUG+
        ZFBtpeHRECJu3RPsuN6FrXmqvoaP07X7lN9Knfo=
X-Google-Smtp-Source: AAOMgpcCFBoBrWkE0mzIAm+r4r2EhOd/yM1owjboJW14LfinDPkHwb2m1CqU2TTHqGXokYxJ5EG6b+TITifOtPjX5u4=
X-Received: by 2002:a6b:c64b:: with SMTP id w72-v6mr1071970iof.382.1531362637207;
 Wed, 11 Jul 2018 19:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com> <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz> <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
 <5B46BB46.2080802@intel.com>
In-Reply-To: <5B46BB46.2080802@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jul 2018 19:30:26 -0700
Message-ID: <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To:     wei.w.wang@intel.com
Cc:     Michal Hocko <mhocko@kernel.org>, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 7:17 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
> Would it be better to remove __GFP_THISNODE? We actually want to get all
> the guest free pages (from all the nodes).

Maybe. Or maybe it would be better to have the memory balloon logic be
per-node? Maybe you don't want to remove too much memory from one
node? I think it's one of those "play with it" things.

I don't think that's the big issue, actually. I think the real issue
is how to react quickly and gracefully to "oops, I'm trying to give
memory away, but now the guest wants it back" while you're in the
middle of trying to create that 2TB list of pages.

IOW, I think the real work is in whatever tuning for the righ
tbehavior. But I'm just guessing.

             Linus
