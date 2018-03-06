Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-875326-1520356122-2-11560785926595559908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520356121; b=q40Iwv9YgQqicPHIDvj8wFxam6XBreDR1AspKqV+fLqALhk
    tOEh5hQhzlY1VgS8L+Vtqb/C/RcLswtOyZRZHyK32ZdSwtCh4F3du51mVGX0vJaY
    IC9/fm1Zaltv1d5+nP1NMsbYCDF8SZZZYwqrso0BVwy5kkqYzRcSd4EsUkbXHCdk
    MVAk3qEHkJCITxN91Z6aMjJjsftVncnVgpKnw+Lcx5kliDCPi9TGjyrLKZ3HzF90
    ZMEe2hdA2qFc82as00Rl+McDBq/h1K+R6n9x/03419t1omrCRgnVua23B4J3R1nr
    ZBaGoRl/OYolZzwDu3jo8YvroRFwy/8zM8DHH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:content-type:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:sender; s=arctest; t=1520356121; bh=/zE4/yAWH
    mQHHlr6lsw2zEqw9I+HtnQ/mHzfa9irMTk=; b=AQq2cVGg4QB5bZESwIBtO7Mic
    V/EK93l/MNPp9M/2+xC7V/3ZtsvShMJrenQkioUAQPVFT1jv2itULQm/JrdyvDwp
    GKxdkuc9D5P6lV3Gul4z1VjnfCJI8YmaIrQ/vwozPJg5cbm/Xd1Ivnu0+20Ahtzn
    3ZBO5cF1iA5/dpU/+Ohvuj4ls7iB7rkg6TK3tEo7n6AWGNROmFGDo7K/5+CSpP8/
    IfFJ2wcMJauCoAa8XVGTujTUOMyW7KMnJAwOv3g/yU8Eb2NoSMsCzKCCiJJ5T/1e
    88BBOqe+Nd6VId68Btp+QMsyeoDUoJGx4I14JyCFgsiKSA3CiiqFlPYpTof6g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,432,1515452400"; d="scan'208";a="316711317"
Date: Tue, 6 Mar 2018 18:08:28 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8192u: Replace printk()
 with appropriate net_*macro_ratelimited()
In-Reply-To: <CA+XqjF8PSF0rP+bOAuUSM8xadHPzDjhZcKE=TauJgUyMdeNgsg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1803061807190.4853@hadrien>
References: <20180305073256.GA4347@seema-Inspiron-15-3567>
 <alpine.DEB.2.20.1803050835230.2306@hadrien>
 <CA+XqjF8PSF0rP+bOAuUSM8xadHPzDjhZcKE=TauJgUyMdeNgsg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-87143636-1520356108=:4853"
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: driverdevel <devel@driverdev.osuosl.org>,
 Greg KH <gregkh@linuxfoundation.org>, outreachy-kernel@googlegroups.com,
 LKML <linux-kernel@vger.kernel.org>, Larry.Finger@lwfinger.net
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-87143636-1520356108=:4853
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Tue, 6 Mar 2018, Arushi Singhal wrote:

>
>
> On Mon, Mar 5, 2018 at 1:07 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>       On Mon, 5 Mar 2018, Arushi Singhal wrote:
>
>       > Replace printk having a log level with the appropriate
>       > net_*macro_ratelimited.
>       > It's better to use actual device name as a prefix in error
>       messages.
>
>       I asked several questions about the above two lines, which as
>       far as I can
>       see haven't been answered. Please excuse me if I missed the
>       answers, but I
>       would still like to know what they are.
>
>
> Hi Julia
> Sorry, I missed your above two question on my last patch and only saw the
> suggestions :(.
>
> -Why did I choose this function?
>
> Here we are using printk() which is the raw way to print something and it is
> always preferred to use dev_*macro() and netdev_*macro() because of the
> benefits they provide like dynamic debugging interface.
>
> And as we are using network subsystem so, netdev_*macro() or
> net_*ratelimited() can be used to standardized the output within the network
> subsystem.
>
>  
>
>       Namely, why did you choose to change to rate limited output, and
>       what does
>       the "device name as a prefix" comment mean?
>
>  
> Yes your point is correct, as before function used is printk(), so changing
> it to ratelimit is not a good idea. So here I should have preferred changing
> it to netdev_*macro().
>
> As every kernel subsystem has its own printk format like net_* for network s
> ubsystem. And it is preferred to use them to standardize the format of the o
> utput within the subsystem.

Sure, but I don't think the ratelimited function does that.  At least, it
doesn't seem to take any arguments that will help it with that.

julia

> Best
> Arushi
>
>       julia
>
>       > Indentation is also changed, to fix the  checkpatch issue if
>       line is not
>       > exceding 80 characters.
>       >
>       > Signed-off-by: Arushi Singhal
>       <arushisinghal19971997@gmail.com>
>       > ---
>       > changes in v2
>       > *change the subject line, in v1 driver name was wrong.
>       >
>       >  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22
>       +++++++++++-----------
>       >  1 file changed, 11 insertions(+), 11 deletions(-)
>       >
>       > diff --git
>       a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>       b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>       > index e6648f7..200fe5f 100644
>       > ---
>       a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>       > +++
>       b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>       > @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int
>       key_idx)
>       >
>       >       priv->tfm = (void *)crypto_alloc_cipher("aes", 0,
>       CRYPTO_ALG_ASYNC);
>       >       if (IS_ERR(priv->tfm)) {
>       > -             printk(KERN_DEBUG "ieee80211_crypt_ccmp: could
>       not allocate crypto API aes\n");
>       > +             net_dbg_ratelimited("ieee80211_crypt_ccmp: could
>       not allocate crypto API aes\n");
>       >               priv->tfm = NULL;
>       >               goto fail;
>       >       }
>       > @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct
>       sk_buff *skb, int hdr_len, void *priv)
>       >       keyidx = pos[3];
>       >       if (!(keyidx & (1 << 5))) {
>       >               if (net_ratelimit()) {
>       > -                     printk(KERN_DEBUG "CCMP: received packet
>       without ExtIV flag from %pM\n",
>       > -                             hdr->addr2);
>       > +                     net_dbg_ratelimited("CCMP: received
>       packet without ExtIV flag from %pM\n",
>       > +                                         hdr->addr2);
>       >               }
>       >               key->dot11RSNAStatsCCMPFormatErrors++;
>       >               return -2;
>       >       }
>       >       keyidx >>= 6;
>       >       if (key->key_idx != keyidx) {
>       > -             printk(KERN_DEBUG "CCMP: RX tkey->key_idx=%d
>       frame keyidx=%d priv=%p\n",
>       > -                     key->key_idx, keyidx, priv);
>       > +             net_dbg_ratelimited("CCMP: RX tkey->key_idx=%d
>       frame keyidx=%d priv=%p\n",
>       > +                                 key->key_idx, keyidx, priv);
>       >               return -6;
>       >       }
>       >       if (!key->key_set) {
>       >               if (net_ratelimit()) {
>       > -                     printk(KERN_DEBUG "CCMP: received packet
>       from %pM with keyid=%d that does not have a configured key\n",
>       > -                             hdr->addr2, keyidx);
>       > +                     net_dbg_ratelimited("CCMP: received
>       packet from %pM with keyid=%d that does not have a configured
>       key\n",
>       > +                                         hdr->addr2, keyidx);
>       >               }
>       >               return -3;
>       >       }
>       > @@ -306,8 +306,8 @@ static int ieee80211_ccmp_decrypt(struct
>       sk_buff *skb, int hdr_len, void *priv)
>       >
>       >       if (memcmp(pn, key->rx_pn, CCMP_PN_LEN) <= 0) {
>       >               if (net_ratelimit()) {
>       > -                     printk(KERN_DEBUG "CCMP: replay
>       detected: STA=%pM previous PN %pm received PN %pm\n",
>       > -                            hdr->addr2, key->rx_pn, pn);
>       > +                     net_dbg_ratelimited("CCMP: replay
>       detected: STA=%pM previous PN %pm received PN %pm\n",
>       > +                                         hdr->addr2,
>       key->rx_pn, pn);
>       >               }
>       >               key->dot11RSNAStatsCCMPReplays++;
>       >               return -4;
>       > @@ -341,8 +341,8 @@ static int ieee80211_ccmp_decrypt(struct
>       sk_buff *skb, int hdr_len, void *priv)
>       >
>       >               if (memcmp(mic, a, CCMP_MIC_LEN) != 0) {
>       >                       if (net_ratelimit()) {
>       > -                             printk(KERN_DEBUG "CCMP: decrypt
>       failed: STA=%pM\n",
>       > -                                     hdr->addr2);
>       > +                             net_dbg_ratelimited("CCMP:
>       decrypt failed: STA=%pM\n",
>       > +                                                 hdr->addr2);
>       >                       }
>       >                       key->dot11RSNAStatsCCMPDecryptErrors++;
>       >                       return -5;
>       > --
>       > 2.7.4
>       >
> > --
> > You received this message because you are subscribed to the Google
> Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it,
> send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to
> outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visithttps://groups.google.com/d/msgid/outreachy-kernel/20180305073256.GA4347%40
> seema-Inspiron-15-3567.
> > For more options, visit https://groups.google.com/d/optout.
> >
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visithttps://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF8PSF0rP%2BbOAuU
> SM8xadHPzDjhZcKE%3DTauJgUyMdeNgsg%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
>
--8323329-87143636-1520356108=:4853
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--8323329-87143636-1520356108=:4853--
