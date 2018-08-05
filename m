Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC81AC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621B42186F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621B42186F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeHEShE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 14:37:04 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45841 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeHEShE (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Sun, 5 Aug 2018 14:37:04 -0400
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Sun, 05 Aug 2018 18:31:46 +0200
Date:   Mon, 6 Aug 2018 00:31:39 +0800
From:   joeyli <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6][RFC] Add EFI secure key to key retention service
Message-ID: <20180805163139.GB27062@linux-l9pv.suse>
References: <20180805032119.20485-1-jlee@suse.com>
 <CAKv+Gu81vEGNggcWv1NyPJsMeK0HRi_DanH2+Z_4metoNG=txA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu81vEGNggcWv1NyPJsMeK0HRi_DanH2+Z_4metoNG=txA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 09:25:56AM +0200, Ard Biesheuvel wrote:
> Hello Chun,yi,
> 
> On 5 August 2018 at 05:21, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > When secure boot is enabled, only signed EFI binary can access
> > EFI boot service variable before ExitBootService. Which means that
> > the EFI boot service variable is secure.
> >
> 
> No it, isn't, and this is a very dangerous assumption to make.
> 
> 'Secure' means different things to different people. 'Secure boot' is
> a misnomer, since it is too vague: it should be called 'authenticated
> boot', and the catch is that authentication using public-key crypto
> does not involve secrets at all. The UEFI variable store was not
> designed with confidentiality in mind, and assuming [given the
> reputation of EFI on the implementation side] that you can use it to
> keep secrets is rather unwise imho.
>

I agreed with you. Especially I can't refute the part of EFI
implementation, manufacturers can not be fully trusted. 

I am thinking a case... Some machines provide setup mode. If user
earses all manufacturer's reloaded keys and only enrolls their own
key. Which means that user fully controls the authentication
environment. Then the EFI boot service varible can be trusted by
the user. But this case is too strict for normal user.

Thanks for your review and comments. I will think more about your
suggestions.

Joey Lee  
