Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1763119-1524100876-2-1924849068743107046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524100875; b=AWhWwQGErNbCfXOVPfsU63YvF1Xl73Ht37x89A5GifmutSwLCQ
    sWeQhUhBsyIrLeuoAYlCoaSIwzMbcG3kCeA1PwkbUFAdsedZmETxrdYqWq6a36OV
    ujH+VXmPt0BshxJGiXGQpx6Th3NP/cQhM0+kmH0mm2JfwHTRk5uhlxoL2VbNCyEw
    Sn2KIBNY77kPRC5Zdcbrs5+iMLmSpu8uiMncsdcK6ANzuoThhVkm6sh8M5/Yb34P
    A+fanCEoFvAFF8GsMzVyBn3R7JSzWgGHQ52jtQNvKBHYDSu7LEa7SGwJruMpl94o
    9Ltw8f4Ahkf78h65WfqycmNPwcC7sMY4xfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524100875; bh=f0eB6
    cKxDhx1CHzuIHUB9nUwvd2eo5kfCWgTIEOrevk=; b=grDyiVaJMzaBWgwBzOSBk
    qFWR7f4BvXXxuTLwmi4JlaB3ZVGDSxotWFNG2TmH2jl9XCXtjNoMyBKaUar+Tu51
    tky58R7xVSulbqmP8p3raLWH4az4xvaXUACSF+rpFLI1f4Li25X2Wv2oPQ9nHuwp
    vM2kr0ZqjGGLhEq0kZT4ITrPCrJ2J0njs54+M0mK7BKQ9bRQ5S4Lgvp9hieN1vnS
    JPHRUhn+zGxCtJ34BqIY+/BAJCpDNtC5wpZTPVvtFgy548QGl6ovwCzxkzi5YhZp
    4QsxNkxq1YcQ8d+484I/XfJ9dKuKf6+P7ltJf8Y9VT94cGB79aB6C+d1pr5TTAnt
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGtI++60hI4/UmG1mrN6OTQNae9/iNHeAaInhabbkMl2aYu3Amjunzkn2kFZwuKzFIaeDA2A30v5GE+8Qw+g9mon3dw43VQnVSoXEUIDpvx+OlqRDXbd
    bRN8Cs5r617OnzaVM/wqbnRkkbwmYj28mj++UIrjZZjy/N40qgxPvxs6yWJ43kgcTIsDP6tEGdXShIDL7tKKK/tzmhYhO9kaOTazBineh5r6QPLUd7YEmNFr
    nTMrzv02PWrH/gBUX1ll+Q==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=jzkuFgeyWvmhbfbB2qQA:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 18 Apr 2018 21:21:05 -0400 (EDT)
Message-Id: <20180418.212105.742287236334361940.davem@davemloft.net>
To: haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Subject: Re: [PATCH net-next] hv_netvsc: Add NetVSP v6 and v6.1 into
 version negotiation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180417223147.23218-1-haiyangz@linuxonhyperv.com>
References: <20180417223147.23218-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
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
Cc: olaf@aepfle.de, sthemmin@microsoft.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Tue, 17 Apr 2018 15:31:47 -0700

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> This patch adds the NetVSP v6 and 6.1 message structures, and includes
> these versions into NetVSC/NetVSP version negotiation process.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied to net-next, thank you.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
