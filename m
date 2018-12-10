Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7182082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7182082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLJTGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbeLJTGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:06:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD3B83082E55;
        Mon, 10 Dec 2018 19:06:02 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8E4D5D717;
        Mon, 10 Dec 2018 19:06:01 +0000 (UTC)
Date:   Mon, 10 Dec 2018 17:06:00 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210190600.GK4669@habkost.net>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210184153.GB5482@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 10 Dec 2018 19:06:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:41:53PM +0100, Borislav Petkov wrote:
> On Mon, Dec 10, 2018 at 04:37:30PM -0200, Eduardo Habkost wrote:
> > It isn't as simply as reverting commit 33b5e8c03ae7, but we can
> > surely re-add RDTSCP on pc-*-4.0 and newer.
> 
> Sure. If you could only point me to an example how to add that to
> pc-*-4.0 and newer, I'll gladly cook up a patch and test it.
> 
> > I thought we added documentation mentioning the minimum kernel
> > version required by QEMU, but I can't find it.  In either case,
> > it seems reasonable to require Linux 4.5 or newer on newer
> > machine-types.
> 
> When you say "require" does that mean, one puts it in a text file
> somewhere in the qemu sources or do we enforce it somehow?

I mean documenting it.  We already have code that will print
warnings if a feature isn't available.

See my previous attempt to document the minimum kernel version
at <https://www.mail-archive.com/qemu-devel@nongnu.org/msg486559.html>.

-- 
Eduardo
