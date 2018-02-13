Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-381307-1518537777-2-10092418942157006574
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518537776; b=cA4fLmzEc3ziJn3zlh0MHCJbfOQqwSj6CcX6Y9ds/OV/qu0
    BADZBUov8rXYy0aj0Ow4SPcvBLogQKuo/lOy2EJpD6Ffv2lVXnMDJTdU4zEYrpw6
    JYDuPRIvdaNZufFTThFaIp92v/DyGY4AoK1YmvOj+rOD9U2z0lqfY39g5YXTU8lZ
    sYspcBj02WNfgig0Z1vkSImEmfmRt4iqW4ZXWUCDXSDGZgqSTncjkketG2D/hJOG
    iF2TIOTpswCdyhTGme0qnvbKdHAhVUegR9zkYxW9MO2fgTX6kNxYZK8DS8skEGGi
    14G4G+WPeXkS0/5Sggdj5/uxyMMCosYZX3T+hTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1518537776; bh=rYhJzo8S238S7gekwyfmHKqlqVBgnC1atyC
    z/zYzc24=; b=Br3suwrDrf2h4ZApZWu7qVFUJcqcBAGsDdJgDAMKQRCBmz/VYoW
    r1dkPA+VTAGQoR9DBWviNZndN0CWfL5q08uHIdt0p0AMBGWJtIxKDlBb1ndkwM0H
    AwpHwbQBU30HbPx3tO/sdqYSyCHUY8f6STn4g3P+PCHfrwJ1nlw+eyVXI5I7W4po
    fqrT0p50TFgvSlrgiYxhtGcp4pQyW0ZgdEJZH8lcr5jrJX9xdm1xK5zmj9LWsGs4
    DAD59wtMlz3lU/q9lpKIx5bPfbZpqtIjzCT7CMxhrVo3PdQrpdEiZu/ppfpqvS0G
    2D6itesDvyGA2beN0wUBCVhZknCg2vMrtTw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933698AbeBMQCz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 11:02:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeBMQCy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 11:02:54 -0500
Date: Tue, 13 Feb 2018 17:02:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <ak@linux.intel.com>
cc: Arjan van de Ven <arjan@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Lowe <nick.lowe@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        gnomes@lxorguk.ukuu.org.uk, ashok.raj@intel.com,
        karahmed@amazon.de, torvalds@linux-foundation.org,
        peterz@infradead.org, Borislav Petkov <bp@alien8.de>,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
In-Reply-To: <20180213155603.GK10945@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1802131659520.1130@nanos.tec.linutronix.de>
References: <20180209133931.211869118@linuxfoundation.org> <20180209133934.259299920@linuxfoundation.org> <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com> <20180213150007.GJ26982@kroah.com> <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
 <20180213155603.GK10945@tassilo.jf.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018, Andi Kleen wrote:
> On Tue, Feb 13, 2018 at 07:09:44AM -0800, Arjan van de Ven wrote:
> > > 
> > > So, any hints on what you think should be the correct fix here?
> > 
> > the patch sure looks correct to me, it now has a nice table for CPU IDs
> > including all of AMD (and soon hopefully the existing Intel ones that are not exposed to meltdown)
> 
> I don't think the table is nice, it's a white list that would need
> to be maintained forever.

No. The table is basically excluding families <=5 and a few individual
ones. Anything newer than that should tell via ARCH_CAP_RDCL_NO and not
need any entry.

Thanks,

	tglx
