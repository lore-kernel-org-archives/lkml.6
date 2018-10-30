Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9EEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8D620827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8D620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJ3SP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbeJ3SP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7FE5C049598;
        Tue, 30 Oct 2018 09:23:20 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 824321054FCF;
        Tue, 30 Oct 2018 09:23:17 +0000 (UTC)
Date:   Tue, 30 Oct 2018 17:23:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        lijiang <lijiang@redhat.com>
Cc:     Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181030092314.GC14493@MiWiFi-R3L-srv>
References: <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030091542.GD32102@zn.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 30 Oct 2018 09:23:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris, DaveY and Lianbo,

On 10/30/18 at 10:15am, Borislav Petkov wrote:
> On Tue, Oct 30, 2018 at 01:09:00PM +0800, Dave Young wrote:
> > It is not the content, I think it is a good catch from Boris, it would
> > be good to document the exported things in somewhere eg.
> > Documentation/kdump/vmcoreinfo.txt

For the vmcoreinfo variables document, I personally think it might be
not necessary. The reason is that all the old varialbles are exported
with the name of themselves. We know what they are or what they
represent since they are all kernel symbols or macro. Only this me_mask,
it's a local variable and store the value of sme_me_mask for now, may
store more info later like Petr mentioned, and also will store the memory
encryption information of TME (which is intel's transparent memory encryption).
We can add code comment around to tell these.

Personal opinion.

Thanks
Baoquan
