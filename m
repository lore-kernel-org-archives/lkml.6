Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED138C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96C20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF96C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeIHAEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:04:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36919 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:04:39 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyMKd-00009a-2P; Fri, 07 Sep 2018 21:22:15 +0200
Date:   Fri, 7 Sep 2018 21:22:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F485BA620@ORSMSX114.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1809072116530.1402@nanos.tec.linutronix.de>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com> <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com> <20180907112207.GS24106@hirez.programming.kicks-ass.net> <FFF73D592F13FD46B8700F0A279B802F485BA5C1@ORSMSX114.amr.corp.intel.com>
 <e10acaa8-f5d8-85f3-219c-86fafd793a87@redhat.com> <FFF73D592F13FD46B8700F0A279B802F485BA620@ORSMSX114.amr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018, Prakhya, Sai Praneeth wrote:
> > > So, if Thomas, Ingo, Andy, Ard and Boris are ok.. I will make it as
> > > default (i.e. without config).

Yes, that's the right thing to do.

> > Also, some distributions already have specific ways to handle buggy
> > firmwares which can be at times dependent on the underlying hardware
> > and the firmware versions.

If the distro patched their kernel to deal with buggy firmware, then:

 1) why did they not upstream it ?

 2) why should we worry about that ?

> > I would suggest that we enable this under a CONFIG for the first round
> > and once it is tested with wider variety of x86 machines which have
> > buggy or orphaned firmware and linux (and reboot) works fine with them,
> > we can drop the CONFIG option in future and enable this by default.

Sure and then nobody enables it and the affected machines still crash or
hang on reboot. The whole thing is simple enough now to make it
unconditional.

> Sounds fair to me, but, I would like to wait for someone experienced to
> make the final call.

Please get rid of that config knob. Buggy firmware exists and we better
deal with it by default.

Thanks,

	tglx

