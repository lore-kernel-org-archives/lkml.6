Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52979C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2131F218E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lst5ZHnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfADPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:53:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34099 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfADPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:53:50 -0500
Received: by mail-io1-f65.google.com with SMTP id b16so10198019ior.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhy0S1xhZAFzPdreTA2b8exx8aKVzEPCuknbxeSg8eY=;
        b=lst5ZHnMa1+zLcZGgSlbYqG5UbbHjq6Iv2kEhjqSn5wpSC4yVnXM5whJt4SHaDrghl
         rjhNRVEqcHBFZtLEASVF3kA9TyRiWkwEsTn70M9bb5f0Y0Us1Z4WRVi3FxVLnd/PuREu
         6J0DHuDjuE+OGsB0li2gyO7PtS56ipXy11/oRBvlMQ/kL1qU1rUv/wEyH3OwCFYTD1cY
         SqTQ76i8N0i4fZeS4IrowukrQtCdg6bTyDv8xF6naspkxTsOrWN2qhzjZ/g+J8h/htYO
         yyddntBIzhpjeFhAaKbqEc1jX4tlQfSGt8P5hihXVHoRjKSRwMi8CZ/NcJOofsY0DaLR
         1UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhy0S1xhZAFzPdreTA2b8exx8aKVzEPCuknbxeSg8eY=;
        b=DzY7KbQ6X0LFUjCbt0qGk4/BaSR5GLr2w691oVNlgshm4mGlTotHejKFuKogHG+7TI
         RQrSsYrLWGQ/0U8eT0DZyH/yK7bVbP8vuyG8D9duZeEs98bjT2AzftcKC+xoFNV/Fprr
         bCZMjEW2vaCJnnQ5AMhPrLA8QuKlCF0qgzMfYFq0TGi4DMmTrn006KxzbNs6CCNLvZf1
         lyCXISQl+6hcpuZ7+KcgXSWCujdCxBkijOfVDvhsBYr7dD9MqArEBRmZ7O0al71Od+5k
         xztgQoBsQW+oR11dKnkLyUPiRY5MPXhsK15M9GHokiCEjrvROfZ8j2Gm0UiL+f2Ywz0f
         eYLQ==
X-Gm-Message-State: AJcUukdggRIcP8CXIzZyGyDoZyodysJBRc/3l4XHFWnSm1L3qMMGqFd3
        rrqS9BkcV67egMweFmzVmB7V1jyVvyEmERYDx2J5rA==
X-Google-Smtp-Source: ALg8bN7BrShxnFXyxjOneq+dS1P9T2pu/3okZFQH8h4evc6TONVFroxnRc3eXO8VQsHU3zecW9HJwc5MbeLl0SWlYxo=
X-Received: by 2002:a5d:81c3:: with SMTP id t3mr18378555iol.93.1546617227812;
 Fri, 04 Jan 2019 07:53:47 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-5-git-send-email-wei.w.wang@intel.com> <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com>
 <5C2DB81F.3000906@intel.com> <CALMp9eR0rkF-DuOWyB16q5r8y9DrefsMd1h4GfDkA8nmpWjMEg@mail.gmail.com>
 <5C2F30CD.6010108@intel.com>
In-Reply-To: <5C2F30CD.6010108@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 4 Jan 2019 07:53:36 -0800
Message-ID: <CALMp9eQOLpQwcjDV0ddi=xrK_ZCZj4g-tpx1-PCOS1Nn7Nx3jA@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 2:03 AM Wei Wang <wei.w.wang@intel.com> wrote:
>
> On 01/03/2019 11:34 PM, Jim Mattson wrote:
> > Fast forward to, say, 2021. You're decommissioning all Broadwell
> > servers in your data center. You have to migrate the running VMs off
> > of those Broadwell systems onto newer hardware. But, with the current
> > implementation, the migration cannot happen. So, what do you do? I
> > suppose you just never enable the feature in the first place. Right?
>
> I'm not sure if that's the way people would do with their data centers.
> What would be the point of decommissioning all the BDW machines when
> there are important BDW VMs running?

TCO increases as hardware ages, while the TCO for each successive
generation of hardware tends to be lower than its predecessor. Thus,
the point of decommissioning all BDW hosts that are beyond their
useful service life is to save money. Our assumption for Google Cloud
is that we will always be able to emulate older Intel processors on
newer Intel processors, so the running BDW VMs should not be affected
by the decommissioning of BDW hardware. Obviously, that means that we
won't offer features that don't have a forward migration story, such
as this one.

Yes, someday Intel will drop support for some feature that we
currently offer (like MPX, perhaps), and that will cause us some
grief.
