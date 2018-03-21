Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4050712-1521637576-2-13835699697946835366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521637575; b=gN0BkBUgWKH9TRxZdOKiuc++pYqqp7egW37ceu3rCtpCRmH
    rqEyE4Fdbghy5+DFg6ZV+QM6ZMri3UIekaVEOaH4Tm/KrKv7jqYPrUhOFCDSzHF2
    WuakhzbhXHNwj3xjxhE3VpBA0bSWk09MmcoFar1rvw2JRelReVFFTL2dKl4/nvEG
    iBnWUYDBjD8SKpfBk66ODq6nAUIS9e8gfaRQDQskA7kWvs7d2OKWOZAtwbyBmx6j
    9ztYsOQRRFxdOQlYvrCqUZfmKBdzkMFZXMibsNU3V4lXWgRlFs9J+2GJY3ybR/zB
    Sgl1Ut15PKMsCaSmDkkl7riNtqJFkYAeMYXyPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521637575; bh=O
    9DlR0erK3Dz+9qoO0zb8P6M8Z2V/fLSqBV2cu8xBEU=; b=hcaGIlkHlVfGWG2/I
    BRkpjrq9F1g6pl25EZY/+7v84g5jyuiKxrC4g8uQWqfp/QLTWJvnGSeAvQGpL9Ib
    cAgQzwQi5laUe/MGrF1q+GtjCaWKL1W23VKbjQX6IfJg+/wMbrtL/muXB7m+qXyD
    bQVsIL0p7IUlZTm7Vl0ddOW8rrEYKEUNio4asEbrRPoJcxX0JQ9+v3Zqz2vDYCc3
    M0EXJO23W+hkkfMT3/jpbzzTpqxqy2GvOfNyVqBWD6WbnH5Go4T5XcTIgT0Kt6JG
    PHbDECnIpPBGtKxAJBvSNeb8R6fKPyM1rKguTNj0A8fcEvmNbntP0y2es1JIAyeY
    S0XEg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IMkEF/g0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iATInzvc;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IMkEF/g0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iATInzvc;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsW67mzFqbwAGqVejgItk1/1GYPdbjeMC0n4kwem4own3eHFdSTbdqv6oSV5yZ45WSAK3ZghQ==
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
X-Google-Original-From: "<Hariprasath Elango>" <hariprasath.elango>
Date: Wed, 21 Mar 2018 18:35:57 +0530
To: Denis Kirjanov <kirjanov@gmail.com>
Subject: Re: [PATCH] staging: fsl-dpaa2: replace simple switch case by if
 statement
Message-ID: <20180321130411.GA11639@hariprasath>
References: <20180321111604.9902-1-hariprasath.elango@gmail.com>
 <faa92f0e20fc44019ee0b64b04413d69@AcuMS.aculab.com>
 <CAHj3AVkQMn26EGtYzu3R2TgDMAaijXoJXnAV3f94eUui6kWtJA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHj3AVkQMn26EGtYzu3R2TgDMAaijXoJXnAV3f94eUui6kWtJA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hariprasath.elango@gmail.com" <hariprasath.elango@gmail.com>,
 David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 03:17:51PM +0300, Denis Kirjanov wrote:
> On 3/21/18, David Laight <David.Laight@aculab.com> wrote:
> > From: > hariprasath.elango@gmail.com
> >> Sent: 21 March 2018 11:16
> >> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> >>
> >> Replace a couple of simple switch cases by if condition
> >
> > Why?
> > In principle extra 'case' might be needed in the future.
> =

> I had the same question when saw it.
> It's better to keep things as is.
> >
> > ...

 Hi, since the switch statement had only one case,I thought of doing
 this. If there are plans to add more cases, we can leave it like
 that.

 thanks,
 hari

> >> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> >> b/drivers/staging/fsl-
> >> dpaa2/ethernet/dpaa2-ethtool.c
> >> index 070a3f2..fb517cb 100644
> >> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> >> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> >> @@ -171,8 +171,7 @@ static void dpaa2_eth_get_strings(struct net_device
> >> *netdev, u32 stringset,
> >>  	u8 *p =3D data;
> >>  	int i;
> >>
> >> -	switch (stringset) {
> >> -	case ETH_SS_STATS:
> >> +	if (stringset =3D=3D ETH_SS_STATS) {
> >>  		for (i =3D 0; i < DPAA2_ETH_NUM_STATS; i++) {
> >>  			strlcpy(p, dpaa2_ethtool_stats[i], ETH_GSTRING_LEN);
> >>  			p +=3D ETH_GSTRING_LEN;
> >> @@ -181,18 +180,16 @@ static void dpaa2_eth_get_strings(struct net_dev=
ice
> >> *netdev, u32 stringset,
> >>  			strlcpy(p, dpaa2_ethtool_extras[i], ETH_GSTRING_LEN);
> >>  			p +=3D ETH_GSTRING_LEN;
> >>  		}
> >> -		break;
> >>  	}
> >>  }
> > ...
> >
> > 	David
> >
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> >
> =

> =

> -- =

> Regards / Mit besten Gr=FC=DFen,
> Denis
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
