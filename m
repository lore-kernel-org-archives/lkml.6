Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC40E2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC40E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLGQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:48:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeLGQsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:48:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF71430DDBD1;
        Fri,  7 Dec 2018 16:48:43 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 699EF7D962;
        Fri,  7 Dec 2018 16:48:39 +0000 (UTC)
Date:   Fri, 7 Dec 2018 14:48:37 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] kvm: x86: Report STIBP on GET_SUPPORTED_CPUID
Message-ID: <20181207164837.GE7395@habkost.net>
References: <20181205191956.31480-1-ehabkost@redhat.com>
 <20181205220206.GA16013@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205220206.GA16013@char.us.oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 07 Dec 2018 16:48:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:02:06PM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Dec 05, 2018 at 05:19:56PM -0200, Eduardo Habkost wrote:
> > Months ago, we have added code to allow direct access to MSR_IA32_SPEC_CTRL
> > to the guest, which makes STIBP available to guests.  This was implemented
> > by commits d28b387fb74d ("KVM/VMX: Allow direct access to
> > MSR_IA32_SPEC_CTRL") and b2ac58f90540 ("KVM/SVM: Allow direct access to
> > MSR_IA32_SPEC_CTRL").
> > 
> > However, we never updated GET_SUPPORTED_CPUID to let userspace know that
> > STIBP can be enabled in CPUID.  Fix that by updating
> 
> Ooops!
> > kvm_cpuid_8000_0008_ebx_x86_features and kvm_cpuid_7_0_edx_x86_features.
> 
> Shouldn't there also be a patch in QEMU to use it? (aka, +stibp).

I will submit the QEMU patch soon.

A patch exists on some downstream QEMU distributions, already,
but it was never merged upstream because GET_SUPPORTED_CPUID
never supported STIBP in the upstream kernel.  (And because in
the end it was not used for mitigating Spectre)

> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thanks!

-- 
Eduardo
