Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673742086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673742086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbeIUH4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:56:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeIUH4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:56:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80D59308625E;
        Fri, 21 Sep 2018 02:10:20 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E7237B03E;
        Fri, 21 Sep 2018 02:10:19 +0000 (UTC)
Date:   Fri, 21 Sep 2018 10:10:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180921021017.GO2555@MiWiFi-R3L-srv>
References: <20180909124946.17988-1-bhe@redhat.com>
 <20180909124946.17988-2-bhe@redhat.com>
 <20180910061151.GA85199@gmail.com>
 <20180911073057.GW1740@192.168.1.3>
 <20180911075946.GA97454@gmail.com>
 <20180911081811.GY1740@192.168.1.3>
 <20180911092829.GA9079@gmail.com>
 <20180911120803.GZ1740@192.168.1.3>
 <20180912031808.GC1740@192.168.1.3>
 <20180912063152.GA33500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912063152.GA33500@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 21 Sep 2018 02:10:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/18 at 08:31am, Ingo Molnar wrote:
> Would you like to work on this? These would be really nice additions, once the code is cleaned 
> up to be maintainable and the pending bug fixes you have are merged.
> 
> In terms of patch logistics I'd suggest this ordering:
> 
>  - documentation fixes
>  - simple cleanups
>  - fixes
>  - enhancements

Sorry, there were some RHEL kernel issues last week, so started this
since yesterday. I have sent out documentation fixes as you suggested in
the first patch series. Next is simple cleanup.

> 
> With no more than ~5 patches sent in a series. Feel free to integrate all pending 
> boot-memory-map fixes and features as well, we'll figure out the right way to do them as they 
> happen - but let's start with the simple stuff first, ok?
> 
