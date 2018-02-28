Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937802-1519847177-2-14432597400748640492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519847177; b=VdR8we7zsQAJgn0tvF83ga/kQmSYBOGfTwFdhDb12g6mALK
    QcEAE24rexUnXTCnNCEB+l3FV1NWvFWnXHyjNGzSAzjRtOLQHYYajV9bvuYmFvg+
    MT1+ws3fIsaw8+/BaN3EE1O25MEMbo5/8JqKk9mRIzrHNCW9FvVVf/9to4t1BjOj
    qiFnqBHrwdLNYcBi+9nS7+igQ396bALfm/+GVp625ItdUaGzhxPOzN2gQ0EQS7ML
    U8R2YNnq3XDvgLu9ZSN8CV0VU4JKFdSbTMlGPjGHYBv1XUKD3Wu1vjtbd8BZyYCz
    +a3E4mw8imy52yr2HRvFtuNXaltP4I612VuDUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :reply-to:references:mime-version:content-type:in-reply-to
    :sender:list-id; s=arctest; t=1519847177; bh=q9YtUqwPSUpyMxNdWJO
    swabHKnD176spKrLbk4HVy+A=; b=WdToIKZGib07o9a5qstjmTISr7LgIwoi3lx
    DyBHjyOtSXwwzq+Xoi5rjEGVlOJdXzIwaY+8WkGaQTQEvorBut5HiqhlsF+sMAEO
    jJwvn7BXObztZ1jlUApbmfSEu8OPxSM9VtVSKzP7d/kom8nIIjqcnOsRQy9MwBke
    dlxseeuFIo7P0pQYvD9n+4qVF6gEqD5oIAxwEzB7fhBeii6GvSVajghy0Y4i2qzl
    tQijzJ1EjH1uzF5oFwEHllqeG0uzr4diI8yXF3/ZuS+Xcz4E3u/gBMLrhakbCsy5
    n3z6pK2qhU8TEEfBrNXAnNHwBKzYbeGATEBcn0b/tPoUegXKxSg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934063AbeB1TqC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 14:46:02 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:27143 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933879AbeB1TqC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 14:46:02 -0500
Date: Wed, 28 Feb 2018 12:45:58 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Ingo Molnar <mingo@kernel.org>, marcus.folkesson@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] watchdog/hpwdt: Remove legacy NMI sourcing.
Message-ID: <20180228194558.GB28906@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
 <20180226032227.14615-3-jerry.hoemann@hpe.com>
 <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
 <03b13d44-9ce3-ead8-020d-4b1b8114079d@roeck-us.net>
 <20180227010250.GC8244@anatevka.americas.hpqcorp.net>
 <8766f2ee-428a-d72f-b0c3-e5fe68fd0a33@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8766f2ee-428a-d72f-b0c3-e5fe68fd0a33@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 05:29:55PM -0800, Guenter Roeck wrote:
> On 02/26/2018 05:02 PM, Jerry Hoemann wrote:
> > On Mon, Feb 26, 2018 at 06:32:30AM -0800, Guenter Roeck wrote:
> > > On 02/26/2018 06:11 AM, Arnd Bergmann wrote:
> > > > On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> > > > > Gen8 and prior Proliant systems supported the "CRU" interface
> > > > > to firmware.  This interfaces allows linux to "call back" into firmware
> > > > > to source the cause of an NMI.  This feature isn't fully utilized
> > > > > as the actual source of the NMI isn't printed, the driver only
> > > > > indicates that the source couldn't be determined when the call
> > > > > fails.
> > > > > 
> > > > > With the advent of Gen9, iCRU replaces the CRU. The call back
> > > > > feature is no longer available in firmware.  To be compatible and
> > > > > not attempt to call back into firmware on system not supporting CRU,
> > > > > the SMBIOS table is consulted to determine if it is safe to
> > > > > make the call back or not.
> > > > > 
> > > > > This results in about half of the driver code being devoted
> > > > > to either making CRU calls or determing if it is safe to make
> > > > > CRU calls.  As noted, the driver isn't really using the results of
> > > > > the CRU calls.
> > > > > 
> > > > > Furthermore, as a consequence of the Spectre security issue, the
> > > > > BIOS/EFI calls are being wrapped into Spectre-disabling section.
> > > > > Removing the call back in hpwdt_pretimeout assists in this effort.
> > > > > 
> > > > > As the CRU sourcing of the NMI isn't required for handling the
> > > > > NMI and there are security concerns with making the call back, remove
> > > > > the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
> > > > > the system had the CRU interface.
> > > > > 
> > > > > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > > > 
> > > > This avoids a warning in mainline kernels, so that's great:
> > > > 
> > > > drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
> > > > found in RETPOLINE build
> > > > 
> > > > I wonder what we do about stable kernels. Are both this patch and the patch
> > > > that added the objtool warning message candidates for backports to
> > > > stable kernels?
> > > > 
> > > 
> > > Makes sense to me, but it is really a bit more than a bug fix, so I'll
> > > leave it up to Jerry/HPE to make the call in respect to hpwdt.
> > > 
> > 
> > Generally speaking, HPE customers who run linux do so through a distro
> > vendor and pick up patches from them.  But I'm sure there are some
> > customers who do things differently.
> > 
> > The distro vendor's have their own repos and we'll work with them
> > to back port patches to their code base.  So, I typically don't do a lot
> > of kernel.org stable branch work.
> > 
> > Looks like objtool has been enhanced to find Spectre vulnerable code.
> > Are the other kernel patches related to Spectre being back ported
> > to stable release lines?  If yes, it probably make sense to do
> > the hpwdt change as well.
> > 
> 
> Spectre has been backported to v4.4 and later. I don't know about earlier kernels.
> 
> > Is just the patch removing the firmware call back wanted/needed? Or the
> > whole driver rewrite?  (The older baseline don't have all the watchdog
> > features that the patch set uses.)
> > 
> 
> We would only want to backport this patch. The rest is really out of scope.
> 
> > Which stable baseline(s) would need to be patched?  Priority?
> > 
> > Who does it?  (i.e. do you want me to submit patches to the stable baseline?)
> > 
> We would tag the patch for stable (and submit it into v4.16-rc). Greg would
> take care of the rest unless there are conflicts, in which case we get a note
> telling us that a backport is needed.
> 

Guenter,

Are you waiting for anything more from me on this patch, or are we
good for now until the back ports to v.15 etc.,?

Thanks

Jerry

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
