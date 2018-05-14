Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610692-1526295290-2-9441148453244492212
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
    1526295289; b=lYwZ/BCjNO1NwNtCoG81qTg8mVrjVoizPs9xTBpgUw7M04bais
    AQdBV6ORuVZIZmrnJwVmn6cgbPmXhofroFCh10H30LIYtsB+oczHc8JSdm0RUMSg
    q2WHYuSdc650SeSxxS2TuDX9xG3p+bhVD8QBHTC7IijSJznGY7pLGb0IIXb8ZsU4
    j6jpsmEzSeCFgbDyp7Q2I9ASxk0/gOa2ON7FNsynoSVZcjeMVaMVqtKL1QHun6Bp
    UgVxnWSbbetMdgzeg8JTc15ibQeaV09Oqow+hhgceYE8ewE6eBbm9jJxVyA5S2yf
    uAbVh5EmwFjQItpvixP2p2YCs3mJbyCIi4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526295289; bh=NYltwA2Fga96QltIoZj/gHLU5R6iz873BsGwySMGb+
    s=; b=AZ+qYdhAu9xIlIp/749yHX7kVzoZAlBLJay66dCMTTSqDi+6wMQDFuoGS4
    mW7EMwecVYc5drRl0nyVMBnzBSZO05Lsm6RtzNfPEniQv8TkewYPlZrNIF5YWShv
    uQ2h8eRHCA9SaaqbEyt3LrofVVqjQYtT/Diz4MfuBoKi56JfwuTqaPvMySiGZoch
    W0zeYceRMoU62zMWdzXT8UHISrPgDPL1ee2YDVvn2c4NWaMyIuk0VN5zqOGUoHrq
    RuevU/1WvBCN/3/eF+t0IwTXn1cFtipFwvWH98tPN6s400vvwUYUq7G2xe/izRAl
    hPWcFJmKFimWHdSLCXzbje1NmdUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GKkI7Jcn x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ndfTuAxP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GKkI7Jcn x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ndfTuAxP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNXpsgA2hjPqMTIPGpj/i5HV6fk4JIaBcNEw6zLCZ5vy4lJUPqH71vGVMqGuOyyZyHA16at4JFee2hqRTt+VU9T8GXpwMB9+NaRNb+p8/b1IbwVdRQpJ
    gzdAxcUjDIDccylk5Iq90WqFjmdHXPm4RxoI/j7UpOA3U5eW5LRuAul7ypVtMFKvLAS7YFDP2SaDgRdyypJNknGZLjy65npGx2HU9/86POc/zatIOPapLxYn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=bt8Zh30PAAAA:8
    a=tBb2bbeoAAAA:8 a=6FR7CgYFdLcJftj5HjsA:9 a=QEXdDO2ut3YA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeENKys (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:54:48 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46907 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeENKyr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 06:54:47 -0400
X-Google-Smtp-Source: AB8JxZoN8H6X9Jqx3nN7q9HXpoC5BLPfic3bbmuhbjX9XUH1nlwhjt+N0/WnQ1JdlIhCNFGjKtjyc7yR4KJ6TjgtRdg=
MIME-Version: 1.0
In-Reply-To: <20180514110936.0497e59e@bbrezillon>
References: <20180514064823.033169170@linuxfoundation.org> <20180514064824.942453369@linuxfoundation.org>
 <CAMuHMdW8cij2J64pCMeN=THP1h8WqX-eanyHQ70VsYVpERpFjA@mail.gmail.com>
 <20180514090422.GA25724@kroah.com> <20180514110936.0497e59e@bbrezillon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 12:54:45 +0200
X-Google-Sender-Auth: JzNBv6sV2UGXphPrWXgmc-HYVA4
Message-ID: <CAMuHMdWMe-UGJqAO0y9ndLq0pYiUteTUpWMi=BWAYweAFgy1iQ@mail.gmail.com>
Subject: Re: [PATCH 4.16 41/72] mtd: rawnand: Make sure we wait tWB before
 polling the STATUS reg
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:09 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon, 14 May 2018 11:04:22 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
>> On Mon, May 14, 2018 at 09:32:51AM +0200, Geert Uytterhoeven wrote:
>> > On Mon, May 14, 2018 at 8:48 AM, Greg Kroah-Hartman
>> > <gregkh@linuxfoundation.org> wrote:
>> > > 4.16-stable review patch.  If anyone has any objections, please let me know.
>> > >
>> > > ------------------
>> > >
>> > > From: Boris Brezillon <boris.brezillon@bootlin.com>
>> > >
>> > > commit 3057fcef385348fe85173f1b0c824d89f1176f72 upstream.
>> > >
>> > > NAND chips require a bit of time to take the NAND operation into
>> > > account and set the BUSY bit in the STATUS reg. Make sure we don't poll
>> > > the STATUS reg too early in nand_soft_waitrdy().
>> > >
>> > > Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
>> > > Cc: <stable@vger.kernel.org>
>> > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> > > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > >
>> > > ---
>> > >  drivers/mtd/nand/nand_base.c |    5 +++++
>> > >  1 file changed, 5 insertions(+)
>> > >
>> > > --- a/drivers/mtd/nand/nand_base.c
>> > > +++ b/drivers/mtd/nand/nand_base.c
>> > > @@ -707,12 +707,17 @@ static void nand_wait_status_ready(struc
>> > >   */
>> > >  int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
>> > >  {
>> > > +       const struct nand_sdr_timings *timings;
>> > >         u8 status = 0;
>> > >         int ret;
>> > >
>> > >         if (!chip->exec_op)
>> > >                 return -ENOTSUPP;
>> > >
>> > > +       /* Wait tWB before polling the STATUS reg. */
>> > > +       timings = nand_get_sdr_timings(&chip->data_interface);
>> > > +       ndelay(PSEC_TO_NSEC(timings->tWB_max));
>> > > +
>> > >         ret = nand_status_op(chip, NULL);
>> > >         if (ret)
>> > >                 return ret;
>> > >
>> > >
>> >
>> >
>> > kbuild test robot via vger.kernel.org
>> > Attachments1:36 PM (19 hours ago)
>> > to Boris, kbuild-all, linux-kernel
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> > master
>> > head:   ccda3c4b77777f66aeb3c531352bb40d59501c59
>> > commit: 3057fcef385348fe85173f1b0c824d89f1176f72 mtd: rawnand: Make
>> > sure we wait tWB before polling the STATUS reg
>> > date:   3 days ago
>> > config: m68k-allyesconfig (attached as .config)
>> > compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> > reproduce:
>> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> > -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         git checkout 3057fcef385348fe85173f1b0c824d89f1176f72
>> >         # save the attached .config to linux build tree
>> >         make.cross ARCH=m68k
>> >
>> > All errors (new ones prefixed by >>):
>> >
>> >    drivers/mtd/nand/raw/nand_base.o: In function `nand_soft_waitrdy':
>> > >> nand_base.c:(.text+0x1022): undefined reference to `__udivdi3'
>>
>> Ugh.  Does this also happen in Linus's tree?
>
> Yes it does, unfortunately :-/. I posted a fix here [1].
>
> [1]https://patchwork.kernel.org/patch/10396217/

And a fix for the root cause:
https://patchwork.kernel.org/patch/10397919/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
