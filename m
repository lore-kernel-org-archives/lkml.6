Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F55C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C647320672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C647320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeLJTr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:47:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbeLJTr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:47:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0AB630024E6;
        Mon, 10 Dec 2018 19:47:27 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44874608E6;
        Mon, 10 Dec 2018 19:47:27 +0000 (UTC)
Date:   Mon, 10 Dec 2018 17:47:25 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210194725.GM4669@habkost.net>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210184153.GB5482@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Dec 2018 19:47:28 +0000 (UTC)
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

Sorry, I forgot to reply to this part.

See commit 33b5e8c03ae7 for reference.  The differences will be:
* Instead of removing RDTSCP from builtin_x86_defs, you'll be adding it.
* Instead of adding rdtscp=on entries to PC_COMPAT_2_4, you'll
  be adding rdtscp=off entries to PC_COMPAT_3_1.

PC_COMPAT_3_1 is added by the patch that creates the 4.0
machine-types.  You can find it on my machine-next branch at:

  http://github.com/ehabkost/qemu

-- 
Eduardo
