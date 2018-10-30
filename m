Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE1DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD920823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AD920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeJ3OBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:01:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeJ3OBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4317F308FB90;
        Tue, 30 Oct 2018 05:09:08 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B94560BE1;
        Tue, 30 Oct 2018 05:09:04 +0000 (UTC)
Date:   Tue, 30 Oct 2018 13:09:00 +0800
From:   Dave Young <dyoung@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
References: <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 30 Oct 2018 05:09:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 at 12:46pm, lijiang wrote:
> 在 2018年10月29日 21:49, Borislav Petkov 写道:
> > On Mon, Oct 29, 2018 at 09:41:26PM +0800, lijiang wrote:
> >>>         VMCOREINFO_NUMBER(phys_base);
> >>>         VMCOREINFO_SYMBOL(init_top_pgt);
> >>>         vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >>>                         pgtable_l5_enabled());
> >>>
> >>> +       VMCOREINFO_NUMBER(sme_mask);
> > 
> > What I'm still missing from the whole fun is where are we documenting
> > the contents of that vmcoreinfo thing?
> > 
> 
> I'm not sure whether the following document is what you need.
> Documentation/ABI/testing/sysfs-kernel-vmcoreinfo

It is not the content, I think it is a good catch from Boris, it would
be good to document the exported things in somewhere eg.
Documentation/kdump/vmcoreinfo.txt

> 
> Thanks.
> Lianbo
> > If not, we need it documented.
> > 

Thanks
Dave
