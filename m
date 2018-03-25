Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3426895-1522012093-2-8402081578355858965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522012092; b=gRRmtzNeIG2lZDX5eYCrX6AnHLMLtc7ywA9ueL1GJzV2bv5
    76SGL3vw2XiXbNzzdhLa2U6BhS7GEkwks3uS35zrVHvlnLxkPrPZGROo5YZwtjXC
    3RBza1i5o1KXQBs4evC/zfi8DKL9D/+BE7/3peFGk1fmoW9b2JOgJY/y9rKd0PXQ
    Ddw6KJs1pZjHOjathU2aKCYxQptNheouOYYAFz+2gAmFm/DNp8yPnunYhxsgKzAm
    LiQsaCitFOYCl3YHJJNo1OCrFduoign26bYVQiwBtfi/bu52yjHqP38sxDT0RtV3
    dd1wOGrLaj1Wfq0yfvR/KDAjgIVWn+390Bi9fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522012092; bh=k
    10ueaWojS2yO2QJldAV1lilZeMAUT7j0jXvttu0rs0=; b=LKzyCn/HKIEOi2VdY
    UrjmSuKKtJb51OsOfIcly71WIItwKwEL+O6QwU7p571fsrTh4NTa5z5SdeYWR/sJ
    Ter9W8o5K62+xev4bKV8xy0nWGIzfNdPccvTPAVUjmwwqN2iSXLyifC6oVgh9LkX
    VEtFMS/6ZmYk7vDo0IUsd97FkcW8041JcN8+FxkTJWo/uQ13zE5l6KE3QdexpaPX
    uxT3c6+wygDjiH2V+WShcqxO95ehJdtmM+73fD4sIkFZhYMLBl1kszzqDLni5rIw
    95PgpaHSxhuH4u+9iMvDl6yEkraj+n9SaaGz5v6G7zZs3ZG7iYyhPjtsTOdlMfHH
    7JF4A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 25 Mar 2018 17:08:00 -0400 (EDT)
Message-Id: <20180325.170800.800881167512551781.davem@davemloft.net>
To: haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Subject: Re: [PATCH net-next,0/2] hv_netvsc: Fix/improve RX path error handling
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
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
Date: Thu, 22 Mar 2018 12:01:12 -0700

> Fix the status code returned to the host. Also add range
> check for rx packet offset and length.

Series applied, thank you.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
