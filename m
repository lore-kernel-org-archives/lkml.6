Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB59CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8CA206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8CA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJBVHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:07:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60211 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:07:48 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7LaC-0005fO-Ni; Tue, 02 Oct 2018 16:23:28 +0200
Date:   Tue, 2 Oct 2018 16:23:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mike Travis <mike.travis@hpe.com>
cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi@sgi.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [PATCH 1/2] x86/platform/uv: Add is_early_uv_system check
In-Reply-To: <b63d338b-c93f-cd05-2d99-59d66662d390@hpe.com>
Message-ID: <alpine.DEB.2.21.1810021622550.12704@nanos.tec.linutronix.de>
References: <20181002012204.297193336@stormcage.americas.sgi.com> <20181002012204.453928259@stormcage.americas.sgi.com> <alpine.DEB.2.21.1810020818530.32062@nanos.tec.linutronix.de> <b63d338b-c93f-cd05-2d99-59d66662d390@hpe.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Mike Travis wrote:
> On 10/1/2018 11:20 PM, Thomas Gleixner wrote:
> > On Mon, 1 Oct 2018, Mike Travis wrote:
> > 
> > > Introduce is_early_uv_system() which uses efi.uv_systab to decide early
> > > in the boot process whether we're on a UV system.
> > > 
> > > This is needed to skip other early setup/init code that might break UV
> > > platform if done too early such as before necessary ACPI tables parsing
> > > takes place.
> > > 
> > > Signed-off-by: Mike Travis <mike.travis@hpe.com>
> > > Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> > 
> > This SOB chain is wrong. I don't see how Hedi is involved in this. If this
> > wants to express that the patch was developed together please see
> > Documentation for the Co-developed-by tag.
> 
> Hedi suggested a "Suggested-by:" tag, would that suffice?

Sure, instead of the SOB. 

Thanks,

	tglx
