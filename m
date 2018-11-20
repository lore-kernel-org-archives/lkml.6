Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8AEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154E206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8154E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbeKTOeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 09:34:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbeKTOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 09:34:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66D8A3082141;
        Tue, 20 Nov 2018 04:07:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BAFE5D75E;
        Tue, 20 Nov 2018 04:07:22 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, akpm@linux-foundation.org, dyoung@redhat.com,
        bhe@redhat.com
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
 <20181118115251.GB19380@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <e7237f99-67cf-f3b5-e078-81208d68baf2@redhat.com>
Date:   Tue, 20 Nov 2018 12:07:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181118115251.GB19380@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 20 Nov 2018 04:07:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月18日 19:52, Borislav Petkov 写道:
> On Fri, Nov 16, 2018 at 11:25:55AM +0800, lijiang wrote:
>> For the pci mmconfig issue, it should be good enough that the e820 reserved region
>> [mem 0x0000000078000000-0x000000008fffffff] is only passed to the second kernel, but
>> the pci mmconfig region is not the same in another machine.
> 
> Yes. And now the question is, *which* reserved regions need to be mapped
> for the second kernel to function properly? How do we figure that out?
> 
>> A simple case, hotplug a pci network card and use the ssh/nfs to dump the vmcore.
>> If the pci mmconfig region is not reserved in kdump kernel, the pci hotplug device
>> could not be recognized. So the pci network card won't work.
> 
> Yes that's a good example; put *that* example in your commit message.
> 
>> Here, there is an example about SME kdump. Maybe it can help to better understand.
> 
> You keep pasting that and I've read it already. And you keep repeating
> that the reserved regions need to be mapped in the second kernel and I'm
> asking, how do we determine *which* regions should we pass to the second
> kernel?
> 
> If we should pass *all* reserved regions, why?
> 
> IOW, I'm looking for the *why* first.
> 
> Thx.
> 

I guess you have gotten the answer what you want from Dave's reply.

Thank you, Boris. Also thanks for Dave's explanation in detail.

Regards,
Lianbo
