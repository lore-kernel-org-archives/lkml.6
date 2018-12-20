Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A09EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6262E2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbeLTMK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:10:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbeLTMK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:10:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D6B3C7C21;
        Thu, 20 Dec 2018 12:10:26 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D479817D57;
        Thu, 20 Dec 2018 12:10:19 +0000 (UTC)
Date:   Thu, 20 Dec 2018 10:10:18 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH -v2] target-i386: Reenable RDTSCP support on
 Opteron_G[345] CPU models CPU models
Message-ID: <20181220121018.GM19442@habkost.net>
References: <20181210190600.GK4669@habkost.net>
 <20181210194258.GD5482@zn.tnic>
 <20181210200843.GN4669@habkost.net>
 <20181211103839.GC921@redhat.com>
 <20181211115546.GQ4669@habkost.net>
 <e4d9a943-2de2-34a7-3f52-ee3d64ea889a@redhat.com>
 <20181211153017.GN921@redhat.com>
 <20181211161440.GG27375@zn.tnic>
 <20181212195235.GX7141@habkost.net>
 <20181212200803.GG6653@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212200803.GG6653@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 20 Dec 2018 12:10:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 09:08:03PM +0100, Borislav Petkov wrote:
> On Wed, Dec 12, 2018 at 05:52:35PM -0200, Eduardo Habkost wrote:
> > Why did you remove this entry from PC_COMPAT_2_4?
> > 
> > We must keep compatibility with old behavior of Opteron_G2 on
> > pc-2.4, even if the old behavior was incorrect.
> 
> Ok, hunk reverted. v2 below.
> 
> Thx.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> The missing functionality was added ~3 years ago with the Linux commit
> 
>   46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> 
> so reenable RDTSCP support on those CPU models.
> 
> Opteron_G2 - being family 15, model 6, doesn't have RDTSCP support
> (the real hardware doesn't have it. K8 got RDTSCP support with the NPT
> models, i.e., models >= 0x40).
> 
> Document the host's minimum required kernel version, while at it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Queued, thanks.

-- 
Eduardo
