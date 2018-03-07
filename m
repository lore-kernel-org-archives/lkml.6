Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2943591-1520419946-2-5811439285197980222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520419945; b=JrNCYKwBXc7FwIXuGSCVrCiQLYYTBif5Dbb3B0jqDniR8ly
    FU4xhONpa3R1l94lKVPcANbkcC6Kj5fB+9DqgVcWIATSE/TET2QVs+px0vK4pLyl
    FDr49MKK5vzGoZhSmXHaPG0vfvSgYpdKsEeFi1aKYKMh0Q2Zmt4fSZ3jPBGuYuCl
    khx25vJn6CH0ULQwrU1ykNz+BqwP2spiyl/o+eBCxH9zEJyJo6wFPbjYw8HANIw0
    Gy7BOl5fRsNJ94ShVVq0iC7yXqj1BaP5k7bzoj+5VDmuOCUWXhWl7axunsvDL3m5
    Lkc4eU6oqYUJCj0xjZYoIhXN/3v24dr04FnMpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520419945; bh=j
    80rKtZQH5OZCnc0FVzz/v67rOxlsAMIrAJDbiEbgkU=; b=ieOkzpALXX2CkSD4X
    tCzu3jmkRlKZR8s5lKg0JZ7evxd3+NuiIO2F89CodEeMnqiQ2S/4dlS3dtWBz07q
    b78zif+4kDTV18/Xoe5qNa8PRcrczPz2KijqaYWUY0/9iMbPLb4UPRvJSYSDq5Tg
    TRX74E/48YcazRZ0XtjcO27OfegfX6Y10b7erpp8ohuzQZdiknuOrawGkwIbI9Aj
    xRvj9rOyZnOWTJ/t8o08okn9F1EXf4cn8LgNuwsxGWzV8jX/wqJooOWtRH1dYBLN
    fFoBjioNGUzrW1uO25TTV2t5YJpkp7HZzGyJq9kHPhjdMSrUBz0VBT9EaEk/r+q2
    K7dYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lip6.fr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lip6.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,435,1515452400"; d="scan'208";a="316830180"
Date: Wed, 7 Mar 2018 11:52:16 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v3] staging: rtl8192u: Replace
 printk() with more standardize output format.
In-Reply-To: <20180307104741.mdy2wa7hplfwxmb3@mwanda>
Message-ID: <alpine.DEB.2.20.1803071151080.3361@hadrien>
References: <20180307103908.GA19612@seema-Inspiron-15-3567>
 <20180307104741.mdy2wa7hplfwxmb3@mwanda>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
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
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wed, 7 Mar 2018, Dan Carpenter wrote:

> On Wed, Mar 07, 2018 at 04:09:09PM +0530, Arushi Singhal wrote:
> > @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
> >  	keyidx = pos[3];
> >  	if (!(keyidx & (1 << 5))) {
> >  		if (net_ratelimit()) {
> > -			printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
> > -				hdr->addr2);
> > +			netdev_dbg(skb->dev, "CCMP: received packet without ExtIV flag from %pM\n",
> > +				   hdr->addr2);
> >  		}
>
> I'm sorry.  I really hate to do this to you...  But the right thing here
> is to use net_dbg_ratelimited() but get rid of the if (net_ratelimit())
> check.  So it looks like this:
>
> 	if (!(keyidx & (1 << 5))) {
> 		net_dbg_ratelimited(skb->dev,
> 				    "CCMP: received packet without ExtIV flag from %pM\n",
> 				    hdr->addr2);
> 	}
>
> Sorry again, when I looked at it before I just replied what my fast
> thinking lizard brain said instead of taking time to look at what I was
> saying.

I don't think that net_dbg_ratelimited wants a skb->dev argument.  The
various definitions in include/linux/net.h just have fmt as the first
argument.

julia

>
>
> regards,
> dan carpenter
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180307104741.mdy2wa7hplfwxmb3%40mwanda.
> For more options, visit https://groups.google.com/d/optout.
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
