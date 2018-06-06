Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C5ED60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeFFSfU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:35:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:53253 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752780AbeFFSfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:35:18 -0400
Date: Wed, 6 Jun 2018 20:35:15 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nbroeking@me.com, bjorn.andersson@linaro.org,
        Torsten Duwe <duwe@suse.de>, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] efi/firmware/platform-x86: Add EFI embedded fw
 support
Message-ID: <20180606183515.GG4511@wotan.suse.de>
References: <20180601125330.25054-1-hdegoede@redhat.com>
 <20180605204623.GB4511@wotan.suse.de>
 <350930d6-5a0f-11e1-1b04-e5c11961931b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <350930d6-5a0f-11e1-1b04-e5c11961931b@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 08:17:26PM +0200, Hans de Goede wrote:
> But yes this means that these probably won't go in for another
> cycle or 2, that is fine.
> 
> > > -Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
> > > -Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
> > >   to check if this is allowed before looking at EFI embedded fw
> > 
> > There's a discussion over having security_kernel_read_file(NULL,
> > READING_WHATEVER) become another LSM hook. So your series would conflict with
> > that at the moment.
> > 
> > So yet another piece of code which this series depends on.
> 
> Ah well, I'm in no big hurry to get this merged. OTOH if this is
> ready and that discussion is not yet finished it might be better
> to merge this as is and then have the security_kernel_read_file / LSM
> hook series fix this up as necessary when it is merged.

True, there is also value in getting this series reviewed so that all
that is needed is to consider merging it, so if you address the new
call as I requested in a next series I'll review the series then.

  Luis
