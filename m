Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D943C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73A62084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfA2Jpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:45:49 -0500
Received: from ozlabs.org ([203.11.71.1]:55077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2Jps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:45:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43phSn3Rdlz9s9h;
        Tue, 29 Jan 2019 20:45:45 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, acme@kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, dzickus@redhat.com,
        fowles@inreach.com, jmario@redhat.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH] perf mem/c2c: Fix perf_mem_events to support powerpc
In-Reply-To: <f308ef3e-f34b-6000-8826-27bdf8c3704e@linux.ibm.com>
References: <20190114041402.14033-1-ravi.bangoria@linux.ibm.com> <f308ef3e-f34b-6000-8826-27bdf8c3704e@linux.ibm.com>
Date:   Tue, 29 Jan 2019 20:45:44 +1100
Message-ID: <874l9rsson.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:

> On 1/14/19 9:44 AM, Ravi Bangoria wrote:
>> Powerpc hw does not have inbuilt latency filter (--ldlat) for mem-load
>> event and, perf_mem_events by default includes ldlat=30 which is
>> causing failure on powerpc. Refactor code to support perf mem/c2c on
>> powerpc.
>> 
>> This patch depends on kernel side changes done my Madhavan:
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html
>> 
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>
>
> Arnaldo / Michael, Any thoughts?

I haven't merged the kernel patch, I think because Maddy told me not to
because it would break the userspace tooling :)

What is the actual dependency between them? ie. should we merge the
kernel fix first or second or what?

cheers
