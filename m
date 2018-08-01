Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1882BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B9E208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B9E208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbeHARUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:20:05 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:58190 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389455AbeHARUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:20:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 42CC887CE;
        Wed,  1 Aug 2018 15:33:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: arm92_5b3ce4c43a755
X-Filterd-Recvd-Size: 2093
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Aug 2018 15:33:46 +0000 (UTC)
Message-ID: <d21f238a0aaa9f5f8323c1e3087612ebf12a86bd.camel@perches.com>
Subject: Re: [PATCH 1/4] genirq: Provide basic NMI management for interrupt
 lines
From:   Joe Perches <joe@perches.com>
To:     Julien Thierry <julien.thierry@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, marc.zyngier@arm.com, mingo@kernel.org
Date:   Wed, 01 Aug 2018 08:33:45 -0700
In-Reply-To: <df8f9f98-a1d3-e871-eec8-d805ff7cf5b7@arm.com>
References: <1532430427-57151-1-git-send-email-julien.thierry@arm.com>
         <1532430427-57151-2-git-send-email-julien.thierry@arm.com>
         <20180801030723.GA31383@voyager>
         <df8f9f98-a1d3-e871-eec8-d805ff7cf5b7@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 16:09 +0100, Julien Thierry wrote:
> On 01/08/18 04:07, Ricardo Neri wrote:
> > On Tue, Jul 24, 2018 at 12:07:04PM +0100, Julien Thierry wrote:
> > > +	    || WARN_ON(irq_settings_is_per_cpu_devid(desc))
> > > +	    || !irq_supports_nmi(desc))
> > 
> > Shouldn't the logical operators in a multi-line statement go at the end of
> > the line?
> 
> I couldn't find anything about this in the kernel coding style and 
> checkpatch didn't complain.

coding-style is a set of suggestions not dicta.

Many of the tests in checkpatch are not written out in
coding-style.

checkpatch does emit a message when used with --strict here:

The checkpatch test is:

# check for && or || at the start of a line
		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
			CHK("LOGICAL_CONTINUATIONS",
			    "Logical continuations should be on the previous line\n" . $hereprev);
		}

This message is not always emitted because code outside of
net, drivers/net, and drivers/staging does not use --strict
by default.

