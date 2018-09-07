Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8382C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906C120869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO3JCZHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906C120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeIGTSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:18:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38192 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeIGTSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:18:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so27634833oix.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C14Jv6OqEu91YYl9D0II/PlmJJ5pjs0XzVdp7LD1wLU=;
        b=FO3JCZHgN1Cz1xGmCG8/8a1tvDEkP+kk93Z9RODPw3QiKTeFDscaF01CZGS7fE8VRp
         cVSKrRRJBNzp4xzbJYKSbHm7xu3EM0DGNprJ+Eq0No8O6I2mciaID6NR0RLLbeTJ2mrx
         haMVGH+8ADK86PNNrVi9R6cYd9RXinRB6NSLZ8dWdjosNRx5iLfMwh97MwV2uwCZ1yfv
         SGcs/v7+34M8/9T4uLawJURMYBU4TBnXZC15kAhIPJPbuQFx+Ct8Odeiinphs7eE6rOs
         HCYAyo2OFC5ank50TTHuflu+lWSltUVQ4f+5AKh77SddVIS0+BmExkJ6QkcZlzlvwoCU
         K5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C14Jv6OqEu91YYl9D0II/PlmJJ5pjs0XzVdp7LD1wLU=;
        b=mAl7H08gTw+ksumfS58/SgfaCl+YVkcQXuWtqau6QA//KILf2KwQTK/FN6Bklw29lD
         +4yxH8l/ScwRXsTFOiD+DKawnnAXkEpMFg8y06iro7kTFUekgM8SlIzvWd1yETjP6QsG
         +NzcEK4/sWbRMP0bP6ruadcUT+TFxz1nMybjCSxnQBKR0SUpccRzkrzEzQjReuT4iNwk
         mG8QGl1pdYX3gTIcZZLoxCJqFnQKQBRbYpa2GFFupqr+61ONNLRGlrL9imSpJONQwTAc
         iw3iDA+CcrfV2LbQ81ohvQkgGs3O3KBlKHDRJhSvB4+DRRqNMIKCo9pYlInAQDhTqSvQ
         TzVw==
X-Gm-Message-State: APzg51Cd2/nIHhj8RZQJIcXX41L0SOcB35WPL9DN4nnBoSmqzuqXkfhu
        3ZpcFnJdJThFkbWLbHKeG1mcneKv9DGx9UMaX1RTd0uTu3E=
X-Google-Smtp-Source: ANB0VdZz4rP6WsdNGZAbIixicE9WbnPczVa/y/Nzzwm0xg6Jv37n/6AilnnN3GrqrEDza2NnxK77EK7/31EHE4kXlo0=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr7556195oig.159.1536331041375;
 Fri, 07 Sep 2018 07:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com> <1536233456-12173-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1536233456-12173-8-git-send-email-wei.w.wang@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 7 Sep 2018 16:36:54 +0200
Message-ID: <CAG48ez1MX18nNgq1mih4dBmX5C_-0ZoCAayzhuzyaDvxYmJrdw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
To:     wei.w.wang@intel.com
Cc:     kernel list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 4:28 PM Wei Wang <wei.w.wang@intel.com> wrote:
> This patch adds support to KVM to save/restore the lbr stack on vCPU
> context switching.
>
> When the guest sets the ACTIVE bit of MSR_KVM_PV_LBR_CTRL, a perf event
> is created on the host for the related vCPU. This perf event ensures the
> LBR stack to be saved/restored when the vCPU thread is scheduled out/in.
> The perf event is removed and freed when the guest clears the ACTIVE
> bit.
[...]
> +void guest_lbr_event_release(struct kvm_pmu *pmu)
> +{
> +       struct perf_event *event = pmu->guest_lbr_event;
> +
> +       if (unlikely(!pmu->guest_lbr_event)) {
> +               pr_err("%s: guest_lbr_event already freed\n", __func__);
> +               return;
> +       }
> +
> +       if (event) {
> +               event->pmu->stop(event, PERF_EF_UPDATE);
> +               perf_event_release_kernel(event);
> +       }
> +       pmu->guest_lbr_event = NULL;
> +}

Is there some guarantee that this method will be called when the vCPU
is torn down on guest exit?
