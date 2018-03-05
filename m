Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2569030-1520283813-2-10642687814801059790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520283812; b=WccvgNoVBB+AtKGy/cc0ZspWmFSQS9AVvp7D4XH6wzBe7fj
    bABBZEsfoz6MZW/qgsRwCwSn6ru2SuHHKeViBG6c+VVFSQ8vuCXJT2dHX6D7Fr/z
    S6/hgemg2WpwJwh2WHYD+mz1p2AkV1CbCCGtdIlkzWunu12I/Yh2196192wIUsuo
    kyWwhbOUniSbBeU4WQigeXWbIMs9VsnhLxOcXepqSaFeX3zv0hew7Y2RFuZM0zO+
    2rvr6+MS6Xke0UC2ZotxgdP406DqiUSNWPzgpTJ5yoJ8YJgjrWpvkKc3+ABc05Kd
    3nsejaVd+WSofVyfkZgzbkJzKvDAgY9L8rCrrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:content-type:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:sender; s=arctest; t=1520283812; bh=V/T6hcrUy
    qkfscCv1tvLQMg59S3GxJS65hntCLsgSUs=; b=CZXy7vEUhhR/tJX7bEV7JVKkW
    JHKDnWcZ41bgibgfgqFq+QqhuzVqhzu48Iqd0wfg56IYVHYrXH8ElvXtPwWX1GXg
    lFNFjCR0gx4xoMU1i32YG0U19TaFDzXJAOftitv2Dp4AZduiiFj/nC00q6/yABME
    VxJhwfbDnKEwK/s/hceHJjjTAAfz4JR/1PJeC0pelL+nIpw0rgVS5P+wjixRcnMD
    mO65zAXNRz0BM0Z2gazWN6YhMF1eXg5q/jBlYsDsEYuDMKR6DQhSOYqC0rxVFLtc
    schaZJzdPWPdM8/a1/MCF2guiiD8biK1oatbbKJvOvtccDKFf5SFqpGU2aT1Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,428,1515452400"; d="scan'208";a="316528854"
Date: Mon, 5 Mar 2018 22:03:20 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: irda: Replace printk()
 with appropriate net_*macro_ratelimited()
In-Reply-To: <CA+XqjF9tBqpgp7ymQOAWeJHm1hPd6w01u3ZVS8ozq4JuoBNSEg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1803052203001.2763@hadrien>
References: <20180304223205.GA31416@seema-Inspiron-15-3567>
 <20180305100345.v6ajs7vdgzmwu5x4@mwanda>
 <CA+XqjF9tBqpgp7ymQOAWeJHm1hPd6w01u3ZVS8ozq4JuoBNSEg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1001131651-1520283801=:2763"
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
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, outreachy-kernel@googlegroups.com
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--8323329-1001131651-1520283801=:2763
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 5 Mar 2018, Arushi Singhal wrote:

>
>
> On Mon, Mar 5, 2018 at 3:33 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>       On Mon, Mar 05, 2018 at 04:02:06AM +0530, Arushi Singhal wrote:
>       > Replace printk having a log level with the appropriate
>       > net_*macro_ratelimited.
>       > It's better to use actual device name as a prefix in error messages.
>       > Indentation is also changed, to fix the  checkpatch issue if line is not
>       > exceding 80 characters.
>       >
>       > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
>       > ---
>       >  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22 +++++++++++-----------
>       >  1 file changed, 11 insertions(+), 11 deletions(-)
>       >
>       > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>       > index e6648f7..200fe5f 100644
>       > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>       > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
>       > @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
>       >
>       >       priv->tfm = (void *)crypto_alloc_cipher("aes", 0, CRYPTO_ALG_ASYNC);
>       >       if (IS_ERR(priv->tfm)) {
>       > -             printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
>       > +             net_dbg_ratelimited("ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
>
>
>       This should probably just be deleted.
>
> Hello Dan
> Why we should make this change?
> According to me it's use here to print debug message.
> Wanted to know more about your thought on this.
>
>       >               priv->tfm = NULL;
>       >               goto fail;
>       >       }
>       > @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>       >       keyidx = pos[3];
>       >       if (!(keyidx & (1 << 5))) {
>       >               if (net_ratelimit()) {
>       > -                     printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
>       > -                             hdr->addr2);
>       > +                     net_dbg_ratelimited("CCMP: received packet without ExtIV flag from %pM\n",
>       > +                                         hdr->addr2);
>       >               }
>
>       The "if (net_ratelimit()) " already means the message is ratelimited so
>       it's net_dbg() ok?  I think so, but I've never looked at this before.
>
>  
> net_dbg() is an implicit declaration of a function. So we can't do this change.

Perhaps you can add the header file that declares net_dbg.

julia
--8323329-1001131651-1520283801=:2763
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--8323329-1001131651-1520283801=:2763--
