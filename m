Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C18C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2A20864
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC2A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeGLRIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:08:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbeGLRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:08:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2114F40073B7;
        Thu, 12 Jul 2018 16:57:48 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B29E51C676;
        Thu, 12 Jul 2018 16:57:46 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/kvm/nVMX: set exit_qualification correctly when nested_vmx_load_msr() fails
References: <20180712113505.23354-1-vkuznets@redhat.com>
        <CALMp9eRabYJ0Q==pok9R0eDUXtdPa2iv83GWPcM-xw3ZFGq4Ww@mail.gmail.com>
Date:   Thu, 12 Jul 2018 18:57:44 +0200
In-Reply-To: <CALMp9eRabYJ0Q==pok9R0eDUXtdPa2iv83GWPcM-xw3ZFGq4Ww@mail.gmail.com>
        (Jim Mattson's message of "Thu, 12 Jul 2018 09:25:46 -0700")
Message-ID: <87zhywwfw7.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 16:57:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 16:57:48 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> This looks similar to my "[PATCH] kvm: nVMX: Restore exit qual for
> VM-entry failure due to MSR loading"
>

... which is still not in kvm/queue. Missed that, sorry! Let this one just
be a gentle ping then :-)

-- 
  Vitaly
