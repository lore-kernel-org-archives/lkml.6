Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3082590-1524142844-2-4235035496792997116
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524142843; b=jpL4SYbXI1MUeHLO4RgXXqFSmfiyTGUZEns5xktfVBYxCsHwLs
    j68z84zwmxFaGRESG558lK9pz4rfNV9yqqe+mCzW46pnFZ4Zkc6sgfvWb8QDQm8Y
    O68wZ8PDDOAoufgTE4bk595qhiKtnqCPYBHRRAs6TYeaLNQzLIx9xJIbixgW/X+M
    G9EXBOCkr1e/Rl5lLEoMXgCRA3X8HMAN1+t/2rtCY2ABILYXK9no9zxxloq5OoIk
    QJ7MBMPtagW7wWmKMyMHbB5ioKCQP6ybTRbcWkHmsSnEULOkb7x/abQfy9HHU9ZN
    UBqPonHVBKoMEV5MYIE6JytwSgt2j6abIskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:subject
    :mime-version:content-id:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1524142843; bh=2G72g7mRqASRJQrMaC11hF8a1Cu0syK
    ikqnl4nh8mq8=; b=waQtXRTBSp6mWYCfWlYu8nU6R9RIUBNTL+DLu+sozkrkau9
    3ecwgxlVcvYapibGwuZM3u98hlmuOgl1flh2imypRR099FVWy35dPV+DNL7fDicK
    M2wfXZnB4yzP2h7jJCrUu7D3SL7a7RQnhH/oSGZGLJ/TVNeOSU/7sFtDzhMofyO6
    mSFEzc/53q9CW4hqUETb3m6HhhSAPzYrtgtItn7C+8cWDn7mPOo9dLXaoX1LGpMe
    PSDWrpDhrYXcQv+O+pLtS20WWNAmrIjjgG6mRJeoB1hBB6CLDNA9GJupT2hfDk6z
    WT36TBKo/autQ2uTyi98H7r5mmFaSXBcJHK+12w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwQ8nS86tHxBi4np/NQGk73CHdvINg5gBA7F0/g4u00HwqYlFg4B/ndFkONLD4GAQzCrOquqBC+Wv4PFwMLcmROvxwjmj+IiYJWiXLxV5To7eaNYWn7
    cNEsLfPNS1U5YJ2yWN2hd/X1WIqDDvFXuG/roF5ftVl7/9LRu8oHUqp5XUg/lHuh3AveBb7CNfCHgQY/ANOwBYJWTGrejTFmbmXuMSGkWIxv10ka6rBvcOf3
    AJOUqBW348LV8kypLnwH2Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=KW2fZluiVG7Zq2DVJ20A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180419124140.9309-21-hch@lst.de>
References: <20180419124140.9309-21-hch@lst.de>
 <20180419124140.9309-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 20/39] afs: simplify procfs code
MIME-Version: 1.0
Content-ID: <22410.1524142823.1@warthog.procyon.org.uk>
Date: Thu, 19 Apr 2018 14:00:23 +0100
Message-ID: <22411.1524142823@warthog.procyon.org.uk>
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 jfs-discussion@lists.sourceforge.net, dhowells@redhat.com,
 linux-ide@vger.kernel.org, linux-afs@lists.infradead.org,
 drbd-dev@lists.linbit.com, linux-rtc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, linux-ext4@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, devel@driverdev.osuosl.org,
 Corey Minyard <minyard@acm.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 megaraidlinux.pdl@broadcom.com, Alessandro Zummo <a.zummo@towertech.it>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> wrote:

> Use remove_proc_subtree to remove the whole subtree on cleanup, and
> unwind the registration loop into individual calls.  Switch to use
> proc_create_seq where applicable.

Note that this is likely going to clash with my patch to net-namespace all of
the afs proc files:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-context&id=f60c26c827c073583107ebf19d87bc5c0e71c3d2

If it helps, I should be able to disentangle this from the mount-api changes
since the subsequent patch connects the dots to propagate the network
namespace over automount using the new fs_context to do it.

David
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
