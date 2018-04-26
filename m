Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1709749-1524709997-2-12875199643536574912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524709997; b=qGLQZB7aXQg+fbQES29aSC0lRC74rJ2eJdcSuAIEnuXO7QUTzC
    pMM6tkH0b7or8z8AMomF5I5l9PhPQkamVaLe7VSExCW9nBwUyECa0wNU6iNmf38/
    RLzJWTHSPOqQJQQaHgT4hcFr1ARscQZ2Egyz4gu3g7EqulXpC/+5uMX1XKq520zO
    XpuyUww8JqRsRBZA/RWiv/I8Xg4IES4PWhvSc/3xlbxIQO058nkByMhNlj8eXHnK
    YbOK2ULbz9IxicKMGIhT7wEJNwq/STJDWdEbwmGKUisizPcRPNux5xNGYLa82v9K
    a/41hAMoMPtC3JvCu1T+SjAmON8fMcri8esA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524709997; bh=YCxZ6
    rMciAGlisouuWF/Krb7BSdilDtOd7ajyGG04ic=; b=e+0ye2iCkjuJFZNe4De86
    mkRD+6gQxJKUaVMPKGRba+P7YM3/9Gf5wPdrGPCVJzG98rZ6ZcRqoRjNUgEXxw1H
    hBAFUh8nLiOIhfN7cqvEdqPaf7CieHULSHpOgq07sl2E/mmqgwOhT4t5WGyrmnnv
    rhUtNp92//LqFEnCKcW1/lMzM50wrTp4nSEH8r1X5JRD5EGcRbtsEe1kxPSol34h
    IJzSm9V/2ZpNJA3HcUXukFCR2/CPdj9w39vIKzPJqp9F4jeOj5qEz0cPdEWVzIZJ
    EDQmZxLhi3tYqkAy2nEsZ3vjwiYuf2akDbnCFoabGK3kjtrC8rx+PKjGP66mGgBU
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=omu0EBZE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yb50cwil;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=omu0EBZE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yb50cwil;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM9aDne6upbG0Gyi1cQv4XyNsTW3AoReoTzkTz0CPLfGReEjNuNBGwULQSe4i7BT4lTxKf6f1CEvt01C5bSIQPgH30PTRarb9i3a79E7V8Iqy6CCi54Z
    E8pmRxsJy9GSmLXfvZrmvBKzxU2yKfv3Eb/IwhCbK8RHb8ox0AkMHwqqGO9lxWfYM2NH/+5RCbNnRHNBAEIfcIZTpu4i3UbPgtr7qib1nWMDJskPmAABUouA
    5NkNZRKyRDCxLjcPw+5e6g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=cwpi3mySyuoA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=nPJxnXOjp8d1i2QADWcA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/mf0nCDLDOhZkQ3i0wotJA/Fpq1ptUoWLjorU/L9Wij+242W0BeKRwC62+jjk1XgFxZ51tQA==
Date: Wed, 25 Apr 2018 19:33:08 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH] staging: fsl-dpaa2/eth: Add support for hardware
 timestamping
Message-ID: <20180426023308.aezdge7xlbqoe5at@localhost>
References: <20180425091749.46841-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180425091749.46841-1-yangbo.lu@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 05:17:49PM +0800, Yangbo Lu wrote:

> +/* PTP nominal frequency 1GHz */
> +#define DPAA2_PTP_NOMINAL_FREQ_PERIOD_NS 1

Nit: Frequency is the inverse of the period.  It can be one or the
other, not both.

Why not call it simply DPAA2_PTP_CLK_PERIOD_NS?

You haven't implemented the ethtool_get_ts_info() method, but you need
to do so.  Show us how the user can related these MAC time stamps to
the PHC device in your other patch series.

Thanks,
Richard
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
