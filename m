Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955CF20847
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955CF20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHXKXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:23:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726455AbeHXKXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:23:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB3DF26A81;
        Fri, 24 Aug 2018 06:49:47 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-135.pek2.redhat.com [10.72.12.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D427C621AA;
        Fri, 24 Aug 2018 06:49:43 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:49:38 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180824064938.GA5316@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
 <1533800010.5087.71.camel@gmx.de>
 <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
 <20180822102310.GA19827@dhcp-128-65.nay.redhat.com>
 <20180823035705.GA5743@dhcp-128-65.nay.redhat.com>
 <1535086138.4661.9.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535086138.4661.9.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 24 Aug 2018 06:49:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 24 Aug 2018 06:49:48 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/18 at 06:48am, Mike Galbraith wrote:
> On Thu, 2018-08-23 at 11:57 +0800, Dave Young wrote:
> > 
> > Mike, since we are going this way, I'm working on a kexec code cleanup,
> > but it needs careful testing so still need some time.
> > 
> > Can you help test below efi fix and provide you tested-by if it works?
> 
> While it averts the efi=noruntime oops on kdump kernel load, the kernel
> does not boot when kdump is triggered.  Bailing in setup_efi_state() in
> addition restores functionality.

Yes, that is expected.  Kexec code need fix and cleanup in other
patches.

Thanks
Dave
