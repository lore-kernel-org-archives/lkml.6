Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519562-1526290326-2-5474064295066405865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, URIBL_DBL_ABUSE_MALW 2.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526290326; b=ju9EEtGFDu68f4iz1CnU0VmzJwzy939eQx5SEkXNQ4pP3PTNg2
    DmZMqBagzLZInZ5MIwQG3DENdfSukZkDNeyzyEVUL4g7YL/f5X2OonlzWD2P4Ewx
    7V39EWLMtvpb/hNSX3ekW7fNZcGOa/Ty19fO/Wz9iVnH/iwVkQZnvpWqspDIODei
    2BU0oOc6u1+bnnxAccEczK44jX9nBHRS9qdFPvM33SUef+rDaQnZ+lr44hyck4Qw
    e2hgj9m1zd+jueJ7z+XFGDFqeF9Qq/CVrx0g72rU9uIWSCzRgNapRmCcDXABAPB6
    FGjayJu6PhPomcS5W7WYIrEza3sdvrF5n/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526290326; bh=7XI91TTjBTIaj3vJfMFLMSr47M6duq6RbbiLb3gMdl
    Y=; b=hjO/QSzddNP2GiuCpZfreMuHZ7Vyp5RTTu3w/PTo0p3ep7rHt0wh9SMucU
    qykgu08nIVZGs4TA1g8cnKlGdogGQiy+L/Pdn3A/1YBAoe/2FFIyki9eLoY19OR+
    ee3NnrA3wpb0bJMxzq2eBR8ZKz7cI+f+GE+YyXj+Ch9ViDitGziwVZVBomKLc5zL
    uvECUNHcNAkDRjWLZzLBiYnguOQelUsRRB4iRxVvZ+IYA9BxWN++koewnaWgAjoM
    4borxu0qQrN4ryI1e0dKGFXxjq5aYOgwOr/gMnXZcwHGpzf6cf4X3Ecf78gLgaXo
    TjspvPR71MA5Zcq1tNAndF6DWc2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=TQ8wVr2Z x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=q22iQeHb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=TQ8wVr2Z x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=q22iQeHb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIkMK5R57nGIYLPMDOYE2GwYdyJNchhS2NyKW0eJCcTt0j3YOEmAfDQlPsM820Lq3My5K4XYuA9i+Kmd2oNfk7TrF84mcb4TtoK1tCjX44UhGRzwDrl7
    k4CZvD79a51KEbVB6Vrmj/9MBepomW4DrqiXCn5cpeUYxEj4idrw1A9O4uJ0Nh+Qh6qNkYvecLv7FVm/a6J/m2kyQSGFBnAT30D3U3E/5mkpNApXSc0Q13IA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=bt8Zh30PAAAA:8
    a=tBb2bbeoAAAA:8 a=sRgJkP9H25OLt4jbNMgA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeENJcD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 05:32:03 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39507 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeENJcC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 05:32:02 -0400
X-Google-Smtp-Source: AB8JxZoRhb0tR65OETohJg+qMfmpztTcx75XoisPsTOtqBdgZQxH38wqH7LGotPaiguwcozKiOOVQMZ4hZplZ5msNeY=
MIME-Version: 1.0
In-Reply-To: <20180514090422.GA25724@kroah.com>
References: <20180514064823.033169170@linuxfoundation.org> <20180514064824.942453369@linuxfoundation.org>
 <CAMuHMdW8cij2J64pCMeN=THP1h8WqX-eanyHQ70VsYVpERpFjA@mail.gmail.com> <20180514090422.GA25724@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 11:32:00 +0200
X-Google-Sender-Auth: 8Y-mVDyqQgKwsPvg_lew3xZnuqg
Message-ID: <CAMuHMdVfFD0zZk+Vpx-SXHQBjfQTMjnLP98-7xNH0GPcmfVwXw@mail.gmail.com>
Subject: Re: [PATCH 4.16 41/72] mtd: rawnand: Make sure we wait tWB before
 polling the STATUS reg
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Mon, May 14, 2018 at 11:04 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, May 14, 2018 at 09:32:51AM +0200, Geert Uytterhoeven wrote:
>> On Mon, May 14, 2018 at 8:48 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > 4.16-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Boris Brezillon <boris.brezillon@bootlin.com>
>> >
>> > commit 3057fcef385348fe85173f1b0c824d89f1176f72 upstream.
>> >
>> > NAND chips require a bit of time to take the NAND operation into
>> > account and set the BUSY bit in the STATUS reg. Make sure we don't poll
>> > the STATUS reg too early in nand_soft_waitrdy().
>> >
>> > Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
>> > Cc: <stable@vger.kernel.org>
>> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > ---
>> >  drivers/mtd/nand/nand_base.c |    5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > --- a/drivers/mtd/nand/nand_base.c
>> > +++ b/drivers/mtd/nand/nand_base.c
>> > @@ -707,12 +707,17 @@ static void nand_wait_status_ready(struc
>> >   */
>> >  int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
>> >  {
>> > +       const struct nand_sdr_timings *timings;
>> >         u8 status = 0;
>> >         int ret;
>> >
>> >         if (!chip->exec_op)
>> >                 return -ENOTSUPP;
>> >
>> > +       /* Wait tWB before polling the STATUS reg. */
>> > +       timings = nand_get_sdr_timings(&chip->data_interface);
>> > +       ndelay(PSEC_TO_NSEC(timings->tWB_max));
>> > +
>> >         ret = nand_status_op(chip, NULL);
>> >         if (ret)
>> >                 return ret;
>> >
>> >
>>
>>
>> kbuild test robot via vger.kernel.org
>> Attachments1:36 PM (19 hours ago)
>> to Boris, kbuild-all, linux-kernel
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> master
>> head:   ccda3c4b77777f66aeb3c531352bb40d59501c59
>> commit: 3057fcef385348fe85173f1b0c824d89f1176f72 mtd: rawnand: Make
>> sure we wait tWB before polling the STATUS reg
>> date:   3 days ago
>> config: m68k-allyesconfig (attached as .config)
>> compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 3057fcef385348fe85173f1b0c824d89f1176f72
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=m68k
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/mtd/nand/raw/nand_base.o: In function `nand_soft_waitrdy':
>> >> nand_base.c:(.text+0x1022): undefined reference to `__udivdi3'
>
> Ugh.  Does this also happen in Linus's tree?

Unfortunately yes, this is torvalds/linux.git, cfr. "tree" above.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
