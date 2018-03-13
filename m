Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520954785-2-5497989211905867310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954785; b=w3zTR4UDORzKfSyL0hjL2BHgDuT2/+rjH29HcNxgbVMrjoG
    FE0GY72XRa9sdFaB/Kl7Wr2c34R22DqCtRWE6wYLB9MjrS1U4C23OuFoKzc5oFWz
    QoN5Mqk7+FL6PvYj20ZV1vEwrH2579ndFkKZYSmHd3OkfZOAupHmtmHDbmv2a3NT
    I+LN+hq2tnssxeeC7EuP+KGY6VbKos3fagR95hREA7ka3g4/rmRjBPrUF1Qu28qF
    qX87uvAM60ZyDAsOm8YjweIGT3epuTRtAoLDAFihkzvLC6Bj+Vi0zPV8inat+q5j
    aIpDNmVxv3gPUcYkxzWJHluD6QpS+m9889jq1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520954785; bh=0
    yhV5RTXNOAq9JVPJ0Hrf6GxqvRxXNl61Xc9TJ8cxOc=; b=TUe0diFwKBtJJkW2w
    y/ZdR4wYcrSrFGt0iFe+gQYDyIidQ6G94cRHCFCgKgSKoi329P+vUB9EqE6k/y2i
    AtoNQI0vpiNma22s0v2wYUmmgY5yIZ06uT9gbpmjeIRuk4FmzYsA0cvOXOGU3Zd4
    Sg7fu1WWL1bB5z9UuRhtSHQ5jcqJKLSzHSUvKA0+3nlmW+7i1vcjQ8+SuPewUGLA
    OJfoLfsHWo9G7rDbuYOMV1gIfthNnK/C7YUXQEpNfG+aHqhW7d/bRFuJKW2Sh3NC
    Ko9nKtuiHTU92PT5jTAszNprzYlkyLiN6C/OMbNX3his5haVYnrK3bgyxqfVAd5I
    fb45Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=M2TU4Bra x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=M2TU4Bra x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 13 Mar 2018 16:26:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Message-ID: <20180313152614.GC17895@lunn.ch>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
 <20180313135156.3322-3-razvan.stefanescu@nxp.com>
 <20180313142251.GB3814@lunn.ch>
 <AM3PR04MB07438DD330E88830AD714339E6D20@AM3PR04MB0743.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM3PR04MB07438DD330E88830AD714339E6D20@AM3PR04MB0743.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Alexandru Marginean <alexandru.marginean@nxp.com>,
 Alexander Graf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Hello Andrew,
> 
> The current driver implementation uses only a single FDB for the switch,
> so  it is not possible configure multiple flooding domains to accommodate
> ports partitioning.

Ah, O.K. Rather than break somebodies network by wrongly flooding, it
would be better to return -EOPNOTSUPP when the requirement for the
second FDB is met. The offload to hardware will then not happen, and
the software bridge will do all the work.

    Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
