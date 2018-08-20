Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A7DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AD621534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AD621534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeHTLxS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:53:18 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:34834 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeHTLxS (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Mon, 20 Aug 2018 07:53:18 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 20 Aug 2018 02:38:34 -0600
Message-Id: <5B7A7E0402000078001DFD01@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Mon, 20 Aug 2018 02:38:28 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH 1/2] x86/xen: don't write ptes directly
 in 32-bit PV guests
References: <20180820051456.20779-1-jgross@suse.com>
 <20180820051456.20779-2-jgross@suse.com>
In-Reply-To: <20180820051456.20779-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 20.08.18 at 07:14, <jgross@suse.com> wrote:
> In some cases 32-bit PAE PV guests still write PTEs directly instead of
> using hypercalls. This is especially bad when clearing a PTE as this is
> done via 32-bit writes which will produce intermediate L1TF attackable
> PTEs.
> 
> Change the code to use hypercalls instead.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>


