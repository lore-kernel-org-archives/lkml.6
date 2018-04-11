Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2548054-1523456773-2-17682987120352668486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523456772; b=RldrCmXHDSwxKX05xAx3tJWXUSbT13+JZKlF2TLtl6wk1agw8g
    wjHecxoIWG8VUq+wtTsdJwp4D3NFm6z3ly2H7hKXWvD1EpWNl+wvSKcCQLh93wR1
    DjaFqBxX7WyGG6h3uRbBCoufe2JhcR7Tg4opYYtU3eo4EklH4mC73/t0svLGO8yZ
    GCx4i9xMK6QtFSZGA7251QEGw4DiJiEsmAHhu5FmaSbyQvh9aWsFGA7ym/wCr0p/
    32hVV4+snCR+ROr6xpgIX6/KRRhpV+59V8/WQMc+SU6RZbJD6ItgPoxDova71zfu
    yxJH7UimsA+TRsqJwgygFDRY0SeIxiurqDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523456772; bh=JI4OB
    R7mw1+LPmhWIhaFhqdEhLJvq6CZs2wmw0fbgaU=; b=b5EeauvlWXt9clQe5yohZ
    thada+/MH2nfFXYalQ2kr7zCvscpYzBFsu/3UrkUCqgLFazWrZpymhgPFMg4lnsK
    oyTdR5vkvOwXWbVQ2zzJ9sczOoBw9V3d8MS3E0Yu9ozkKI6Ih8dmkSbOGVEkykqI
    tGKIbUYEOcKxl7uRjPwoSkgA471+PGK9BwHsVb0hquJl6EHtVO88CCRuazVTfG1V
    Zm91hr1h/4TrvsWm7bCZmbpgadjp77xaFr6/okjmnHttSfT1ZhwOeP8ofHItoUdj
    CEknzw7/AKfV1bbUN/QdAlW+Ed86e9nR2HO5jIVx0kbB+WTkAeaG+IZmpDI3oiL9
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGz+kJ0+Krbqp5Fnym3QBNLANLh+Cl8Q6iGYy/xsxZZMR4Yv9iSTSufN2UrITfO8pYloON3tR5n535NhEB0Gjnu8GFed+X9fIwc/xv1AAvL/9air1Jdl
    P8a3zZOqcZhbzb3NRMZwRN7+JnS2DJsSmcx/S8Lv7tEgwn5z+u8g7yHa/4beOR7A4znPNwHqFAjeJtaVbOFu3J14/MdEPLedVaNzrVwo42xyw5Eumo0PfKmd
    7nDiXOBo6nL2c+XFnxrIeA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=cM7wT0cbYTk5s7OTonwA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 11 Apr 2018 10:26:03 -0400 (EDT)
Message-Id: <20180411.102603.1023000970717039691.davem@davemloft.net>
To: baijiaju1990@gmail.com
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
From: David Miller <davem@davemloft.net>
In-Reply-To: <865ad04e-ccbc-6144-c6ea-fc39790f861f@gmail.com>
References: <ecf21a6e-0e99-55dc-54be-3bd633bedbc5@gmail.com>
 <20180411081724.GA4155@kroah.com>
 <865ad04e-ccbc-6144-c6ea-fc39790f861f@gmail.com>
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
Cc: devel@driverdev.osuosl.org, samuel@sortiz.org, gregkh@linuxfoundation.org,
 johan@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 arvind.yadav.cs@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 11 Apr 2018 16:20:22 +0800

> Okay, I now know why many of my patches were not replied.

Many of your patches are not responded to because you handle patch
feedback poorly sometimes.

Also, all of your networking submissions have been dropped because
the net-next tree is closed.

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
