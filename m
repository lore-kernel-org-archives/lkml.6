Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3157214-1518622837-2-14834455293112686695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518622836; b=s7o3PH5dAZxWdS2fjSCFW8r9V922aelTVCoi6JBIFrZaVN5
    VHTHW4DGCEkbw8yYPjNeQd37qNTqce3hj5kvihnEZVZTrdXxD44OwxawKWixDRzp
    tMCVHxbFGs0gO7b9Q1/2HB7QEZtzPrvnUZUfn2RaoF9WUb8o1er/j4hYPAuxmx4v
    dhMIjTaHud8n3sIbOxcP5Kn0+5qiF3o36rS3u09ChC0b26XfX5q0+XGpWbuZhNYJ
    8uASgDCNniqqRVEC/H2w5TRDIRrmMlAHKg87M5NgW8en4ocksPmF1yhzPPoKkXQE
    53mqT1M/yEZUs6nU1b/rerDAvGZ5ZibNzASzs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518622836; bh=aQIej1AFLwo2KDbmQJgqwJePX6
    cvAtTWF84YCWOvSwM=; b=EfO6vZkk7GjuJEpKSuV4tELScFN8l9f0OMxzdzNCW7
    t/M3SaWskICLq1nevJvfOUZgE2++aCoBq+JKBJJ7EgsVK3I+5j9hykaym6mbwK9m
    iRdF8DtqxYCzaFy9f+a1nlFvvuveAQfAmOfGgL0Z9qtKR4QWfDDXHXjQrkd0VQse
    zwJyObRDNNaicUlzM+ZgjO/xSLpuQiqwxr7RF4foLlHLAV4FaYUBN0pLjvlsXZhi
    4GLoLNWSQ941cEiJQNt3D3vAj+Mzo9ly/LRuk2mH32sUuevI967JdGwnWduZfamE
    F4FXYSrTv1Tz47v2/EFLlRFxdRRNlb18qnXHWRMfgtcQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031552AbeBNPkf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 10:40:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031511AbeBNPke (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 10:40:34 -0500
Date: Wed, 14 Feb 2018 16:40:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Brown <broonie@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for
 v4.14-stable
Message-ID: <20180214154033.GA2745@kroah.com>
References: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
 <20180214135420.GB24189@kroah.com>
 <CAKv+Gu_uqudgFU1_+cWZtvyQmZMxjCYuUr-2L59yEfoY8EyWQA@mail.gmail.com>
 <CAKv+Gu-D6E02FE+zaqbksM_w-S_y8ueNGc=xPDAieJHjKp1=bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-D6E02FE+zaqbksM_w-S_y8ueNGc=xPDAieJHjKp1=bg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 02:34:01PM +0000, Ard Biesheuvel wrote:
> On 14 February 2018 at 14:24, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 14 February 2018 at 13:54, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> On Mon, Feb 12, 2018 at 11:38:01AM +0000, Ard Biesheuvel wrote:
> >>> Hi Greg,
> >>>
> >>> As mentioned by Will, I have created the v4.14 counterpart of his stable
> >>> backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
> >>> into v4.16-rc1.
> >>>
> >>> Given that this is the v4.15 version backported to v4.14, I have removed any
> >>> mention of 'conflicts' from the commit logs as they are now ambiguous. The
> >>> patches applied surprisingly cleanly, I only needed to drop two patches that
> >>> are already in (the same ones Will mentioned in his PR), and drop another one
> >>> dealing with SPE, support for which did not exist yet in v4.14. I also included
> >>> the patch
> >>>
> >>>   arm64: move TASK_* definitions to <asm/processor.h>
> >>>
> >>> from v4.15 to make Robin's Spectre v1 patches apply more cleanly.
> >>
> >> I've queued these up now, but if you could pull the whole quilt tree and
> >> verify I got things right, that would be great.  There was some
> >> conflicts with a few previous patches I had already queued up that
> >> touched some "Falkor" errata code.
> >>
> >> Specifically 932b50c7c1c65e6f23002e075b97ee083c4a9e71 "arm64: Add
> >> software workaround for Falkor erratum 1041" is the offending patch.  I
> >> think I resolved the merge issues properly, but verifying this would be
> >> wonderful.
> >>
> >
> > No, the build is broken now. I will investigate.
> 
> Your patch 977c3d2cb684e143a18e1564fbf5ecf7576a1c98
> 
> arm64: Move post_ttbr_update_workaround to C code
> 
> removes the pre_disable_mmu_workaround macro from asm/assembler.h but
> it should only remove post_ttbr_update_workaround
> 
> Once I add that back, things seem to build and run as expected.

Can you provide a "fixed" version of just this patch so I know to get it
correct?

thanks,

greg k-h
