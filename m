Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-766342-1520608616-5-9733694791469387391
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520608616; b=vTlMXTH4MIYuT3h1kNenx3SarqlyZOjzx9ssZiEZ8pnE2Ax
    e6QholTnlZT+wiNmC+8Pu0AGeG+Ufh344q2zRpEYp3mCNX65Ar4Vq5UGYPTKbnuL
    FHuPTgPGWDCIJgHxMNwi1Aysu7GCDYv9tFi6H9njyaPQMB1RkHwA7HpmIKDJGSFC
    QzoMhnd48GZNStQ0gPVceEtYz0EkJJJZZhk/VH9xHGuxKSjtoS0Tie6OEv1L3y6B
    N82NDsrrPU661iTefgldx6qFcZesnnirUsMKP2rLNtv+pYbi4+YqAfl7GlHLALUh
    POwLZR5fODT9gDd/Ur35hdYsWKI4fque2dnrIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520608616; bh=0
    VP80Hhfn6YEU6Tn8EioSQgw0aldDk81AcCs2SS7pkw=; b=eeG3Bqsh6ULlMaGdl
    Nvq2DTrncTlrHnem4CoPwH23TJlA7iG7xDyGs0IDiTdCV/THq9Eu/1iUg00xmhew
    y4HMfFZzadlg8ZpZk+y6GuqOQZZsRMup3mFept9JbVGXgIcS7lXntGSbeA80VVvQ
    XpA0lAfRsGRvdM+y+Zud6BZFmxu1XpYQxiDjdPpfpalAjw3vPUxOUdu9iBbdUUdA
    HfJBSQY1q4o7cdAHy7uTn5QzQe7+k7WRCc6pvryK5bTauNpft5CC0eOA7GN49uyh
    rdCjcuUDmLFuDofbwG5F/kvBRq520FCU09da7teSw3Aynn8ymbuBh3sTYVNgfwer
    cylNA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 09 Mar 2018 10:16:44 -0500 (EST)
Message-Id: <20180309.101644.154265435513307278.davem@davemloft.net>
To: mgamal@redhat.com
Subject: Re: [PATCH net-next] hv_netvsc: Correct filter setting for
 multicast/broadcast
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520594542-24257-1-git-send-email-mgamal@redhat.com>
References: <1520594542-24257-1-git-send-email-mgamal@redhat.com>
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
Cc: otubo@redhat.com, sthemmin@microsoft.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Gamal <mgamal@redhat.com>
Date: Fri,  9 Mar 2018 12:22:22 +0100

> Commit 009f766 intended to filter multicast/broadcast, however
> it did cause DHCP timeouts. A closer look showed that the filters
> were not set properly causing this issue.
> 
> Fixes: 009f766 ("hv_netvsc: filter multicast/broadcast")
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

This is fixed already in the net tree.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
