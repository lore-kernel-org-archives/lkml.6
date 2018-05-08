Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525779720-2-8490153460344454544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525779720; b=Nc9cjlL6/n9lsMkK7E9QiWOcTEPnzFw+tbj4TcieIL0noVy7Am
    PRRVGDRM3ylx7kAJeV4rLNYU1oJAJK6lDZotOD/i1zc9aBn2ANYfQmglnXkL8B/t
    yYf1atZ1L82YMSRGFbljy+vbsoIh3rEbjoS5Wvn9TIaL/h49n4tc76bagQwrGDRW
    4OCxoFhXRI/j7r3IFGxTw9lO3ruNOlttDlYh3b3QviWexMgxvNm9rq5xaK97nXo+
    otHfQXTExK63Z6zVaqNA/xctVQt1UuOnnm5nNio3mu4q7dr30mAhdVA24S7GxnA7
    P0vmrgx0oYj8gOlIShqAhIUY8FbeNgBe6dVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525779720; bh=WAufZ
    Ka2hWkrtDjJsmwwNQR/zqWmXMKFbui2zO6ehco=; b=E8XaNzAmoprT81ZKGIWOV
    Q1Ul38BOgivY8axPANh02wrQF+N00sc6Ye8K+gHhKVnjya/lo5eWDio0ttCAk0ig
    lEtcTp+A7+9YwOTLlasq6q9hXK/YAOGJi+FDm5i9Rq+EED5NvsHT9vdV1EijLPPw
    5ZcNQnTgHrGpw4kdD27lxGljKmQVtmZV8/OX8tMxBqpucrf4uOlYY0TEiZ3yEPU2
    wau/ANANiovXcZq+hyyaSkPyCooTxuFCElmgCLpVV8gr0f5fgi0b5hRHzQnR4WQ4
    KhT8UhcK6YK03RGa0iRNgmKmy+R6ATYli8YCnJhlZT+LQ/+ee9ET7cbm0vSc8A1w
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=hbPQXEel x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=sSP77FXp;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=hbPQXEel x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=sSP77FXp;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH2uZuxcWPfRgsZp2UmrZCbwsBLrV9wVLfeNx3XzFiEvSTy0AlfFz3pZoLWQ+YzImbfGN5HMvOoOZ+WDPaMfcbvc+2FdfNSyy4d/BK04EEO5irIQG4ne
    Kp4WtvOOAiH8gRtxYFKG4RR9uUZOaKNjUJqede6P2dgKceLOzwqkfI+HPAcYacqVIaCGaNoaMOwakWTnlLmOjl2lpzSOHNtJY6kmCg/LjE6T3Ud/Be6dsSWg
    AQEmfbIlscNzBKB78XXmgQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=D19gQVrFAAAA:8 a=DDOyTI_5AAAA:8 a=fqkPvO5EGXc3R085H7cA:9
    a=MW_vLVPs1UV3ad9M:21 a=mn9TP23jW5Bd7Hxm:21 a=CjuIK1q_8ugA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoEtvt2jEDgFOc+rOwRjdnVX23o0Mmfv74QREhk/hjSKFLI7ppJ8iXH3IvD3s06xbJCYoBekw==
Date: Tue, 8 May 2018 04:42:05 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] staging: ks7010: Move from bool to int in structs
Message-ID: <20180508114205.GA27629@flashbox>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-7-natechancellor@gmail.com>
 <20180508113431.GA12019@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180508113431.GA12019@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 01:34:31PM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 06, 2018 at 03:03:04PM -0700, Nathan Chancellor wrote:
> > Fixes checkpatch.pl warnings.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/ks7010/ks_hostif.c   | 4 ++--
> >  drivers/staging/ks7010/ks_wlan.h     | 4 ++--
> >  drivers/staging/ks7010/ks_wlan_net.c | 8 ++++----
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> > index 628171091786..43090922daff 100644
> > --- a/drivers/staging/ks7010/ks_hostif.c
> > +++ b/drivers/staging/ks7010/ks_hostif.c
> > @@ -475,7 +475,7 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
> >  	case DOT11_MAC_ADDRESS:
> >  		hostif_sme_enqueue(priv, SME_GET_MAC_ADDRESS);
> >  		ether_addr_copy(priv->eth_addr, priv->rxp);
> > -		priv->mac_address_valid = true;
> > +		priv->mac_address_valid = 1;
> 
> Wait, why?  This should be bool, not an int.  Why would checkpatch say
> this is incorrect?
> 
> confused,
> 
> greg k-h

CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
#417: FILE: drivers/staging/ks7010/ks_wlan.h:417:
+       bool is_device_open;

Introduced by commit a4c4c0492dad ("checkpatch: add a --strict test for
structs with bool member definitions"). If this is wrong, please feel
free to ignore it!

Thanks,
Nathan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
