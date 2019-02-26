Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28258C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDF6217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="XFaZe+eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfBZPQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:16:45 -0500
Received: from a9-36.smtp-out.amazonses.com ([54.240.9.36]:56308 "EHLO
        a9-36.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbfBZPQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1551194204;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=zk6autZDYWCridaZ1j6pE4L9X3qVCRB7mf1shVksySU=;
        b=XFaZe+eBN7TnCrRANRHetCBj0w20GfUpVaApTi/OaerR928UaWZN3r9O3ctFhYPq
        NV+cNIy/ZieVZEQLCWoBHg6XvuwWSK586i8D/J7UM8R34qAPbH6xsbSg8FfpzwqNL7U
        E1HPo6AoBciq9dlUFK92xUBa8H8E/E9qwTAio4Jo=
Date:   Tue, 26 Feb 2019 15:16:44 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dennis Zhou <dennis@kernel.org>
cc:     Peng Fan <peng.fan@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 1/2] percpu: km: remove SMP check
In-Reply-To: <20190225151330.GA49611@dennisz-mbp.dhcp.thefacebook.com>
Message-ID: <010001692a612815-46229701-ea3f-4a89-8f88-0c74194ba257-000000@email.amazonses.com>
References: <20190224132518.20586-1-peng.fan@nxp.com> <20190225151330.GA49611@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.26-54.240.9.36
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Dennis Zhou wrote:

> > @@ -27,7 +27,7 @@
> >   *   chunk size is not aligned.  percpu-km code will whine about it.
> >   */
> >
> > -#if defined(CONFIG_SMP) && defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> > +#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> >  #error "contiguous percpu allocation is incompatible with paged first chunk"
> >  #endif
> >
> > --
> > 2.16.4
> >
>
> Hi,
>
> I think keeping CONFIG_SMP makes this easier to remember dependencies
> rather than having to dig into the config. So this is a NACK from me.

But it simplifies the code and makes it easier to read.


