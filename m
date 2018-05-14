Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-436143-1526283190-2-15603820878908446559
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
    1526283189; b=Iq9MMt920+orDejLApod1eyC17FRrXLPBUOrLpJ7r0lm41xMrM
    aqhhtyk4OY6iWoo6Ojz0KcasjPa3UVZU1vKfDrZdv5mzsCC4kfJEu5F3tVPns1Te
    hnRecsC5ue8xOZ4se/IxeQMydNYhpSpVG+FfOoA50qLE40dK1n2p5LvT2p1QJEXn
    cNwQZD+YKzTS8qLSSj2AGYtTe4+3PD1Q4rJXVIBOtEPA1RakQH01aYYKp7hgSf/T
    /7f/6H4WbjY5jguVAVQTyhWpnLyrNVM90YpQ+O8PN1G4oIjk+J6SwWFlC78Eol71
    m2kt1d+cmBPGSd7F1WV1YA3XA547a+NrFJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526283189; bh=6+Ju2wl5Aoug+6+jwA5QoGYXc8dESrPME7YYe7N7JD
    s=; b=BQtUUgvTbbD20zjujW1bQvtoKaXseGPZomOjsarV34sGaXr2VKj4YI6n2Y
    HI4f7GyPS80ZlBIJzgh2JT7af/yb3QtLU0TPKSJ+Uiw/jtLUiieQVJA4wHpxiemr
    gvDltT6IDOBEUWlcPCT4oyh97GvizASXq8XgRx8tSn7P1KCERJDLn0KM8an3mxkN
    hY4G2yaLnK0l8pUKyvGENwTGB3V3vLoZ5aR1lZY0QpKUOgZLzTz3L794HR905dE+
    mqAvJHzpWw/j349NiVeEveMU0G8wHzSiq4OvEecCLDw0BEUHC3SKZfAZDuoo+e8z
    V3RrYcYHD2efzN5nMfFEPQwJKfGg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=SU1r5Nep x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Wf/6wfcS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=SU1r5Nep x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Wf/6wfcS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHhijLZJkfkJey+gXqTV9apdxSi1lBTUhN5m2MEW5gXPxvXleIs0H9BYsDrQmauh9q9XvYN4Tt+grnQHFtU1v03qYecVdPEc+Wlrzi7Y9USyBo1O5ieG
    7xNl70VF09BfpmZRryt7/093Ggd1npBvHV1P5s9cc4kDwzy2KX0T4zUxB8YVu+uuePEDlQfejhXFVM+KhPnn0AaI9id2W0OAQKiWwilHZR68LmQB/FCsIx8m
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=bt8Zh30PAAAA:8
    a=tBb2bbeoAAAA:8 a=uYpR1iKsY2wnXm14TQ0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbeENHcz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:32:55 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44211 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeENHcx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 03:32:53 -0400
X-Google-Smtp-Source: AB8JxZoi34vrpvftBAPcrWwP2MY8tJGVjG9I+QgkR30o68L+3GxrXSr8VwWNt5FqcSkk7pkRi6qK+cHCfrVac52BDvU=
MIME-Version: 1.0
In-Reply-To: <20180514064824.942453369@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org> <20180514064824.942453369@linuxfoundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 09:32:51 +0200
X-Google-Sender-Auth: GBxcgDW6vtyaaYZPCLK0M2P0s9U
Message-ID: <CAMuHMdW8cij2J64pCMeN=THP1h8WqX-eanyHQ70VsYVpERpFjA@mail.gmail.com>
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

On Mon, May 14, 2018 at 8:48 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.16-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Boris Brezillon <boris.brezillon@bootlin.com>
>
> commit 3057fcef385348fe85173f1b0c824d89f1176f72 upstream.
>
> NAND chips require a bit of time to take the NAND operation into
> account and set the BUSY bit in the STATUS reg. Make sure we don't poll
> the STATUS reg too early in nand_soft_waitrdy().
>
> Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  drivers/mtd/nand/nand_base.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -707,12 +707,17 @@ static void nand_wait_status_ready(struc
>   */
>  int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
>  {
> +       const struct nand_sdr_timings *timings;
>         u8 status = 0;
>         int ret;
>
>         if (!chip->exec_op)
>                 return -ENOTSUPP;
>
> +       /* Wait tWB before polling the STATUS reg. */
> +       timings = nand_get_sdr_timings(&chip->data_interface);
> +       ndelay(PSEC_TO_NSEC(timings->tWB_max));
> +
>         ret = nand_status_op(chip, NULL);
>         if (ret)
>                 return ret;
>
>


kbuild test robot via vger.kernel.org
Attachments1:36 PM (19 hours ago)
to Boris, kbuild-all, linux-kernel
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master
head:   ccda3c4b77777f66aeb3c531352bb40d59501c59
commit: 3057fcef385348fe85173f1b0c824d89f1176f72 mtd: rawnand: Make
sure we wait tWB before polling the STATUS reg
date:   3 days ago
config: m68k-allyesconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
-O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3057fcef385348fe85173f1b0c824d89f1176f72
        # save the attached .config to linux build tree
        make.cross ARCH=m68k

All errors (new ones prefixed by >>):

   drivers/mtd/nand/raw/nand_base.o: In function `nand_soft_waitrdy':
>> nand_base.c:(.text+0x1022): undefined reference to `__udivdi3'

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
