Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2573826-1521587987-2-11670381907562465391
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521587987; b=o3biT7fshnd+iQ/y5fmwA5UtInbJPdCT75oJS/wPKF+hNYj
    kjC4v8qXTgN12r0gd1qf/LX33PhUH5oLgsBWCoeL8l+Vhp4RaSZ0+CaolzZvCONS
    jm9If61FxoJLP75M3hOeCRhD1otvArt7dnOHNyvfz5+5WvSNDcTXbiThGF1EZB3t
    kDpI5NvfJqZpSkY8Oyi1T0WLxCJsf2jBPRY9Q1qhAe2qD2RXD3Yvv9f3JlLSScWe
    NttJwShDhoiV/HRZVlNLBMY8pSRjx/dqZtVckmzeZFYN0KO945GD2IeXjJwtgRxa
    NzUiZDkjpuT8PTaAaI6jy0lH/hcM4ytSUpej+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521587987; bh=+iP2dJ96bXUqR/FqR1vGHIppLqAp/Pq9pguNKpllwpM=; b=A
    7bVkgJKvYUl7nb/HIDws1BBikvBPrtOxMfo2jwRLqdK/2lhQw/wPnIv8JeTZ7MMk
    p7mB92+7gYZTQDrtA8Vz7sTw4R/4zej249dEcGSfjjlBk9ELxZSEK/aDBpt0GM9u
    AsyAlH7BLO7dDM/jE0zsR+n+v8KEWvmeVp2Dc+0YIMfIGr3mU9gU5G3U9t7mS0xM
    InySPmHHb3cXbPGw9aP8NhaG/9j15kwhjFR7Fm44o4yELSlHRSycFQgsVXE2euPp
    kmeamlFNnIxcOT33kKSaPiuFjHhE3LE+QgBuKH6k8lJcB+khyvb5W8zter7PACzN
    vrKgecf7WP9lN473b1jWA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeCTXTo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 19:19:44 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46915 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCTXTo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 19:19:44 -0400
Message-ID: <1521587979.23626.117.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 29/63] watchdog: hpwdt: fix unused variable warning
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Date: Tue, 20 Mar 2018 23:19:39 +0000
In-Reply-To: <20180318101416.GD13276@kroah.com>
References: <20180316152259.964532775@linuxfoundation.org>
         <20180316152303.262268098@linuxfoundation.org>
         <20180316225537.GA5989@anatevka.americas.hpqcorp.net>
         <20180318101416.GD13276@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-03-18 at 11:14 +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 16, 2018 at 04:55:37PM -0600, Jerry Hoemann wrote:
> > 
> > Greg,
> > 
> > Sorry, if I'm missing something, but I see 3 patches for
> > hpwdt queued up for 4.4:
> > 
> > 	queue-4.4/watchdog-hpwdt-fix-unused-variable-warning.patch
> > 	queue-4.4/watchdog-hpwdt-smbios-check.patch
> > 	queue-4.4/watchdog-hpwdt-check-source-of-nmi.patch
> > 
> > 
> > Shouldn't there also be a 4.4 patch for
> > 
> > 	commit 2b3d89b402b085b08498e896c65267a145bed486
> > 	watchdog: hpwdt: Remove legacy NMI sourcing.
> > 
> > As there was for 4.15, 4.14, and 4.9?
> 
> It does not apply to the 4.4.y kernel branch.  If you feel it should be
> there, please provide a working backport.
> 
> > commit 2b3d89b40 is the Spectre related patch.
> 
> If you look closely, not many Spectre-related patches are merged into
> 4.4.y as no one has taken the time to do the backporting.  I thought
> someone was working on this, but odds are they just moved to 4.9.y or
> 4.14.y as everyone really should if they care about these issues with
> their platforms.
> 
> So if you care about Spectre, I strongly recommend using 4.14.y or
> newer.

I think you have most of the Spectre stuff aside from microcode
supported fixes.  These are still missing on the 4.4 branch though:

8fa80c503b48 nospec: Move array_index_nospec() parameter checking into separate macro
1d91c1d2c80c nospec: Kill array_index_nospec_mask_check()

I think there may also be some extra uaccess functions that didn't get
the nospec treatment.

I'll probably look into backporting the microcode stuff to the older
branches (4.4, then 3.16 and 3.2) at some point.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
