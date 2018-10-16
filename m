Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2AAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19B02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19B02089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJPVuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:50:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJPVuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:50:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0059B308624F;
        Tue, 16 Oct 2018 13:59:40 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39C2B62489;
        Tue, 16 Oct 2018 13:59:37 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] x86/kvm/nVMX: allow bare VMXON state migration
In-Reply-To: <8d6b85c4-16c6-cbde-22ec-ee61df0c49fd@redhat.com>
References: <20180913170522.24876-1-vkuznets@redhat.com> <20180913170522.24876-10-vkuznets@redhat.com> <8d6b85c4-16c6-cbde-22ec-ee61df0c49fd@redhat.com>
Date:   Tue, 16 Oct 2018 15:59:35 +0200
Message-ID: <87zhvernzs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Oct 2018 13:59:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/09/2018 19:05, Vitaly Kuznetsov wrote:
>> It is perfectly valid for a guest to do VMXON and not do VMPTRLD. This
>> state needs to be preserved on migration.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Please cover this in state-test.c too.
>

Sure, this is kind of tested in the newly introduced evmcs_test but
makes perfect sense to do this in state_test too.

The series also got rotten and requires a rebase, will do that.

Thanks,

-- 
Vitaly
