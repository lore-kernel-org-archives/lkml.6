Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C39FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9C221726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfAVIwh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:52:37 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:50436 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfAVIwh (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:9:1>);
        Tue, 22 Jan 2019 03:52:37 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Tue, 22 Jan 2019 01:52:36 -0700
Message-Id: <5C46D9D00200007800210007@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Tue, 22 Jan 2019 01:52:32 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, <linux-mm@kvack.org>,
        <tglx@linutronix.de>, "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH 2/2] x86/xen: dont add memory above max
 allowed allocation
References: <20190122080628.7238-1-jgross@suse.com>
 <20190122080628.7238-3-jgross@suse.com>
In-Reply-To: <20190122080628.7238-3-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 22.01.19 at 09:06, <jgross@suse.com> wrote:
> Don't allow memory to be added above the allowed maximum allocation
> limit set by Xen.

This reads as if the hypervisor was imposing a limit here, but looking at
xen_get_max_pages(), xen_foreach_remap_area(), and
xen_count_remap_pages() I take it that it's a restriction enforced by
the Xen subsystem in Linux. Furthermore from the cover letter I imply
that the observed issue was on a Dom0, yet xen_get_max_pages()'s
use of XENMEM_maximum_reservation wouldn't impose any limit there
at all (without use of the hypervisor option "dom0_mem=max:..."),
would it?

Jan


