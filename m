Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071218-1526316663-2-954714492997345167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, URIBL_DBL_ABUSE_MALW 2.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526316663; b=AkjG1ZHGlzvnFe3OcXO0UZ4+vbHikjL9C9NhJk530S3pm7+IXv
    vc3NhBi8HSZwijUSgqyMOSfblutRC7lLY5O4qZ56odk8TuBSwlMMsGzZIH/FxIlR
    sbvJnQa7prwkdb40pYlFegnvqY5qF5nlIXa4mV84XO28+f7eY+SRxtHMs/ke4WJ/
    7CRjxUFnkzYbKYPTjH+Yxe9uAbVQZJ47iLNCYrGLZuXpesvNGVU2WlFsG2PcNj28
    WQy+7Pg0JtqWnd0Wn2bL9rE91I9jf2lPjahx/CvJGCcZd0O0egMuUuT8zJ6B52jV
    DCu0MeAaKIMsLfYuzUvstmPMvEEUoQHEu0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526316663; bh=ofFPJsXJ2G1t1VUtxxpjdIc/9xiMjR
    911BSgGv6VX74=; b=R5r9ZBupA7n/KEA+LgSUIlNzI2ycwRu3iW5TZocmu5Rwza
    LfnS8zWEGibExPX3BOTmDtQp8qB25C2gzkS/wu77CecaFllUhPcyCxSxr1aOc8bk
    fpwAU2eUh6BLHegcs6tLsIn4/GsBClgE9ZjHF4YsO/Kjf/0hTnlPsU1cODUAYPiM
    D7kj7Psb691TTzNOP22e1FIoC3qHbMEZamZ6R1s8rP4zYUK89WREIHMqZW/RJE9O
    oyMgAgGBLMODAFkfne7gPz8iVy6xnz5ZmAokkhnYDkETeaK5KVrhqBRp1UNAanV+
    jBMSPIS0d960HdF+cNUHpApBIjBO1HGTHO9p0P1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RA9n1Dm6 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=RA9n1Dm6 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLL1MYGGWONTxQAvtIVkrA3xZ7AtBpsflFdKJJZDUMXVgvZF3b5ANLhq2kZ1sfS/ry3TpjUosUoxM4QNbpXQiiteWptkfP4rtIyvEm9R/krPTTzNxZfT
    TTZkN8vNlMIfHpeXXgkhkNd0vhBbjtF0aB7bWKo1m1KPtStNCUWsfwil9U11tKt7EfZ1m3ootjEBJRZ3EKN/CeW48lJ9ypkVIBcmKLbQbTZ7uw8TD6XjXvx9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=bt8Zh30PAAAA:8
    a=eQMRuHtH9loS4CgqnbMA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbeENQvB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753504AbeENQvA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 12:51:00 -0400
Date: Mon, 14 May 2018 18:50:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4.16 41/72] mtd: rawnand: Make sure we wait tWB before
 polling the STATUS reg
Message-ID: <20180514165041.GA30141@kroah.com>
References: <20180514064823.033169170@linuxfoundation.org>
 <20180514064824.942453369@linuxfoundation.org>
 <CAMuHMdW8cij2J64pCMeN=THP1h8WqX-eanyHQ70VsYVpERpFjA@mail.gmail.com>
 <20180514090422.GA25724@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514090422.GA25724@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:04:22AM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 14, 2018 at 09:32:51AM +0200, Geert Uytterhoeven wrote:
> > On Mon, May 14, 2018 at 8:48 AM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 4.16-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > >
> > > commit 3057fcef385348fe85173f1b0c824d89f1176f72 upstream.
> > >
> > > NAND chips require a bit of time to take the NAND operation into
> > > account and set the BUSY bit in the STATUS reg. Make sure we don't poll
> > > the STATUS reg too early in nand_soft_waitrdy().
> > >
> > > Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > ---
> > >  drivers/mtd/nand/nand_base.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > --- a/drivers/mtd/nand/nand_base.c
> > > +++ b/drivers/mtd/nand/nand_base.c
> > > @@ -707,12 +707,17 @@ static void nand_wait_status_ready(struc
> > >   */
> > >  int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
> > >  {
> > > +       const struct nand_sdr_timings *timings;
> > >         u8 status = 0;
> > >         int ret;
> > >
> > >         if (!chip->exec_op)
> > >                 return -ENOTSUPP;
> > >
> > > +       /* Wait tWB before polling the STATUS reg. */
> > > +       timings = nand_get_sdr_timings(&chip->data_interface);
> > > +       ndelay(PSEC_TO_NSEC(timings->tWB_max));
> > > +
> > >         ret = nand_status_op(chip, NULL);
> > >         if (ret)
> > >                 return ret;
> > >
> > >
> > 
> > 
> > kbuild test robot via vger.kernel.org
> > Attachments1:36 PM (19 hours ago)
> > to Boris, kbuild-all, linux-kernel
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > master
> > head:   ccda3c4b77777f66aeb3c531352bb40d59501c59
> > commit: 3057fcef385348fe85173f1b0c824d89f1176f72 mtd: rawnand: Make
> > sure we wait tWB before polling the STATUS reg
> > date:   3 days ago
> > config: m68k-allyesconfig (attached as .config)
> > compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 3057fcef385348fe85173f1b0c824d89f1176f72
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=m68k
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/mtd/nand/raw/nand_base.o: In function `nand_soft_waitrdy':
> > >> nand_base.c:(.text+0x1022): undefined reference to `__udivdi3'
> 
> Ugh.  Does this also happen in Linus's tree?

Ok, I've now dropped this patch and will queue it up later with the fix
hits Linus's tree as well.

thanks,

greg k-h
