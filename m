Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-93447-1522981052-5-15206396222799367630
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522981051; b=gz0e9I2eQvnuLB2kb8nvtd04XLPVnlDMtuXBXKjJtbuHKk6cvk
    Eap5yqZaTcSuVdqpKedsZf6TiOQkHt2Qvkk5Nb1HnvCgq450ElmeH2NiRYbOa1cB
    JdrRfE+NmmfMwONWGm7hdAGBunntI8mNyvSXpkBsSEj6oOjtn7airTgddyfkX07Q
    jlkcO6YgEswRxUT1KnmgwwORKKsXtEMwbnMgDgsZASZmpTYPNOrzsa/GpEfBF6x4
    j2XP3e4X9M7Bc/jbRX+jqV/JPOc4Ue/Pmfal2E6k5QWwA1PXeuqLzGI3j/HconRE
    ZpSY65oan0x1OBqIjD0IGfKbtGizV2HNrGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522981051; bh=L6OFG
    Qt9SNZbG5EN1zoLajiwDjhpzsBemTBCsnsJ2co=; b=m7kKGVpZlUCJHiwjDUOBb
    1G1aaNgwkf+S3sRD/Lrlpa5W7wrJQOzN6UE18FI+3MyWHBKz+CWasVjpxEk+nMhj
    Fo75y/Y/kOtsonyZZcBKdoBnLF5fC2MqIJprYWd2GZlrbWWC4UvZiXDY6D52VulN
    P5skk6JgTVxEGtOxxV76evuDo1gsPHtDtGnHCG+7oNCsL0Yzh12LTj//X/vyTe5Y
    vWdoUByHBbyWSrOHDHC1E7Ejfs89KKg5Nb1PNrcokmNCe4BfBqDqEk0oz86DLPC2
    t4JK5gyv5PEqH0ezwa8NaGEDwEwN/mfuc/bVzh7mhRB+AOUw0/uKv7Xp8bz87SCg
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGsOvuEPAAQSxrDz0iGWKLC4etCKVRysldoXYhIfO6BCibtYk5/umi+Kciv/kAwpoIet35F+3OhAknv8ztny+iNqJTc/B1WlGqNpTdxBwV4vfJpWaZSl
    g+GmfXckRzZdc8pOJJpH7fSZsm1as3uAvuEHrl1aL9GbN9SZXxj0pdA4GUUxW6OOXiafmPSjrmBgmGM9Gicm+C0flXAETtJ1j8nE1ObDAbo3+E32oW7eVXif
    h+FiguZKc9Y5BteE63wCzQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=LCRuEiK6rFq6UIps5bcA:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 05 Apr 2018 22:17:21 -0400 (EDT)
Message-Id: <20180405.221721.551621428126250766.davem@davemloft.net>
To: haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Subject: Re: [PATCH net-next] hv_netvsc: Add NetVSP v6 into version negotiation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180405184222.3167-1-haiyangz@linuxonhyperv.com>
References: <20180405184222.3167-1-haiyangz@linuxonhyperv.com>
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
Date: Thu,  5 Apr 2018 11:42:22 -0700

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> This patch adds the NetVSP v6 message structures, and includes this
> version into NetVSC/NetVSP version negotiation process.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

The net-next tree is closed, please resubmit this when the net-next
tree reopens.

Thank you.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
