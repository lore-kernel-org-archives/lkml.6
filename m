Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A17C4314A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E224686
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5E224686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966966AbeF1PEg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:04:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964934AbeF1PEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 246744075741;
        Thu, 28 Jun 2018 15:04:34 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 634881116712;
        Thu, 28 Jun 2018 15:04:32 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Radim Krcmar <rkrcmar@redhat.com>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] KVM: x86: hyperv: implement PV IPI send hypercalls
References: <20180622145616.5851-1-vkuznets@redhat.com>
        <20180622145616.5851-4-vkuznets@redhat.com>
        <20180622191333.GC2377@flask>
        <CANRm+Cyj_Bw1nx=K9KDv7MDDdB--DxNAyRwFwCff_twXk1tPPg@mail.gmail.com>
Date:   Thu, 28 Jun 2018 17:04:31 +0200
In-Reply-To: <CANRm+Cyj_Bw1nx=K9KDv7MDDdB--DxNAyRwFwCff_twXk1tPPg@mail.gmail.com>
        (Wanpeng Li's message of "Thu, 28 Jun 2018 22:05:13 +0800")
Message-ID: <87vaa3dkao.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 15:04:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 15:04:34 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> Hi Paolo and Radim,
>
> I have already completed the patches for linux guest/kvm/qemu w/ vCPUs
> <= 64, however, extra complication as the ex in hyperv should be
> introduced for vCPUs > 64, so do you think vCPU <=64 is enough for
> linux guest or should me introduce two hypercall as what hyperv does
> w/ ex logic?
>

Neither Paolo nor Radim but as we already have
#define KVM_MAX_VCPUS 288
on at least x86, supporting <= 64 vCPUs seems to be too limiting for any
new functionality.

-- 
  Vitaly
