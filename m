Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3FEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2BA2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2BA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeHBTRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2997 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbeHBTRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:17:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89A763082133;
        Thu,  2 Aug 2018 17:25:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E1F1600C0;
        Thu,  2 Aug 2018 17:25:03 +0000 (UTC)
Received: from zmail18.collab.prod.int.phx2.redhat.com (zmail18.collab.prod.int.phx2.redhat.com [10.5.83.21])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 449BC4BB78;
        Thu,  2 Aug 2018 17:25:03 +0000 (UTC)
Date:   Thu, 2 Aug 2018 13:25:01 -0400 (EDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Message-ID: <1139128422.9369612.1533230701907.JavaMail.zimbra@redhat.com>
In-Reply-To: <428fb407-4082-abef-b643-7b92cdd6b14c@redhat.com>
References: <20180725163057.13948-1-vkuznets@redhat.com> <4c221ed3-5de8-b9cf-663b-d31ce0834c12@redhat.com> <871sbgaonv.fsf@vitty.brq.redhat.com> <428fb407-4082-abef-b643-7b92cdd6b14c@redhat.com>
Subject: Re: [PATCH v3 0/6] KVM: nVMX: Enlightened VMCS for Hyper-V on KVM
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.12.235.128, 10.4.196.4, 10.5.101.130, 10.4.195.11]
Thread-Topic: nVMX: Enlightened VMCS for Hyper-V on KVM
Thread-Index: aKlygpHufkdRoih176SgV+WAA47ptQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 02 Aug 2018 17:25:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just make clean and it will work. Will debug it.

Paolo

----- Paolo Bonzini <pbonzini@redhat.com> ha scritto:
> On 02/08/2018 15:22, Vitaly Kuznetsov wrote:
> >> Looks good, but we have to do something about live migration.
> > Sure,
> > 
> > I don't actually see any fundumental problems when eVMCS is in use,
> > however, I'd like to enable migration when we know that it works so I
> > was going to wait for your nested virtualization state migration series
> > to land and gain Qemu support before starting to experiment. "One bite
> > at a time".
> > 
> 
> Don't worry about QEMU - working with tools/testing/selftests/kvm/ is
> much simpler (as long as a similar test exists to what you're doing).
> 
> Paolo

