Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF88C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109F521841
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbeLQKay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:30:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbeLQKax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 837162814D;
        Mon, 17 Dec 2018 10:30:53 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 520C86012E;
        Mon, 17 Dec 2018 10:30:51 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 0/7] x86/kvm/hyper-v: Implement KVM_GET_SUPPORTED_HV_CPUID
In-Reply-To: <7a318d1c-7601-fc67-8924-971f9deb8824@redhat.com>
References: <20181210172159.410-1-vkuznets@redhat.com> <7a318d1c-7601-fc67-8924-971f9deb8824@redhat.com>
Date:   Mon, 17 Dec 2018 11:30:49 +0100
Message-ID: <87woo830o6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 17 Dec 2018 10:30:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

>
> Queued, thanks.  I moved this above the direct EOI series so that
> KVM_CAP_HYPERV_STIMER_DIRECT need not exist at any point of the history.
>

Thanks! Just to make sure (and to conclude our discussion with Roman):
with your Qemu maintainer hat on, do you agree with the design decision
that KVM_GET_SUPPORTED_HV_CPUID's output value changes when
KVM_CAP_HYPERV_ENLIGHTENED_VMCS gets enabled? This differs from
KVM_GET_SUPPORTED_CPUID (where we always list all feature bits even if
they require explicit enablement)?

-- 
Vitaly
