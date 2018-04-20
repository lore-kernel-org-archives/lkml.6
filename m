Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-990390-1524209011-2-1466488522216607126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524209011; b=n6gw3wxsEXfaInrvZrz1vQ6zQzjQG8jaXn2iW94ZcIkTi53Z3V
    5J9mTCy+KOqMxEt+E9oH6tuMfwwVlaxr7BUO5jTXEMAhl4pW2PkAo5jegccdkyke
    yNRwxbIpeYUIZbiuRPm2+ExWrmOqIAHZrJszNampBcGZ53YmHHOxoTrbBBxp5PQ1
    rNmOHMZAG7+ndq4lflr2c9Fxi48wne2rfkkPqTt5VAG90PQYr9E2pgHIcCxbNrLR
    ZS8epENWIzlfSuuxEtgRppsDC0/icmE3zcFTtOeJvcDFjgLN8ThXu/qaHS67tQFk
    DY+/mzPXWlNdUBaME8YDJkunamGJAvh63JQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524209011; bh=XqqcL
    sDJkWEsSIaTXkPxceaw9pzJAWU7PTnrMBibmkw=; b=ME07WmxrKaGV2gG3vvrdI
    sNpGZZCQK/NYO1Dk4jbPpWNBhqFYarWXL1XDKW0OSYUBnix9QszO3YCzwPyTLZEY
    Vd0lb/y09m/60GLfhqR/7fsFGl08Zl1kcxinpw3neKuTMHawH0ooowb2WxTEsnPf
    pdrNZb2rxUVT5Ee5bjJREfwm49mj+sZUQVBGCYDjTYM9XkMX6S9LRRGhA9G+VnEU
    4QR8zOToqOXL1F1dpkP01FAO6+qJ3v6DI4QOcXBvNfCYJtG1QU+7jmd6WrBzfe0S
    VyJwntuTj/hTsfLh/NGeIXBYjOS0B2AhojPXcPwuUW0LGyML9neR1dNh9c1+zgHX
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dmpdcixO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eTTPOt4a;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dmpdcixO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eTTPOt4a;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP2o57FEcGI6dpOjU4AYVcbJ6c/fENrxEBzPNs6hgNp5MqQo5ZcKji/UqzhKocFUs717q4UMSxpPlIhyxOE5mt6sFBCq55wSP3UxyC+f+of3p/7igO2F
    mBmEJyOXz2Pa6Ogb8wSUg/xB6n6mnMw0msXotf66eDmSmTy8fzkU7YyNxJfgj+RK7wpRsJCKeFTIqlGgoMCxVIfDWHZD/q377wKqi2nNkGysnfpDGD9VGZUW
    XNF/Ob0l+c7lrlCBZS219A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LDBv8-xUAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=bWRg1Lgjned46bBKuhAA:9 a=CjuIK1q_8ugA:10
    a=DZeXCJrVpAJBw65Qk4Ds:22 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqD8Sg3E8aYJHr415kJw/kxA+f3ncAXbZUvxeeBiUGBAXPsCECI5KZssju74uICzXmLGCXWjQ==
Date: Fri, 20 Apr 2018 09:23:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 47/61] staging: greybus: simplify getting .drvdata
Message-ID: <20180420072318.GM9198@localhost>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-48-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-48-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 linux-renesas-soc@vger.kernel.org, greybus-dev@lists.linaro.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 04:06:17PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Johan Hovold <johan@kernel.org>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
