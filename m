Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1381604-1525094377-2-17874110808169239146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
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
    1525094377; b=DiZ0209BBszrY8W+hhNVhDH9J5M/0h2piS3hzi9/VC/WvS1QKk
    yejdMEdZ8tVHUO/cDbrKfEDGI8zfMUXM3bB+7/Y5A+G9pWdUt82t4V8WR5g2IArY
    7G3UB3dJ0OnR3bWwlnrcLk7VG1m7STI1uBtmjvX8lksS5UBFVO7KEpuRqj1jtr+L
    sNOw/MtkoW2jNhPoFRWMLHfExCG5VPZsedPqSXPpdm5+K7cO7fUFFSHo0SuvmZ4z
    fzNYBxajvDaraD/TGyxadmaewWjWjXnz6yT9ADY/rRwnHN7WdqwXeA46y+cMmBJH
    dnrhbK4veMJotM2BCXadj2RRwa7W9xsWBIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:subject
    :mime-version:content-id:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1525094377; bh=NzotM/mVCeKHHmehLvhkcKGbRMxX4N7
    QoSe+yAiezOw=; b=J62ok5eULztygKKchbvGuFmW2hUpwaYI6xBiYVEtsxOc83c
    HEIoG6YQuhbbXyrTQsqEJYmECXbJl1BWLnMAaduHS1HK+yAT+YQQ2wjDq60HfgWu
    Kd2v0In+TRE+38dGguRnM7zRrVS4f9zrJ4kB+jJpiRr2Etf1zJIxMw7dmxYDZogR
    hwCpv1Lj0x3Kqtux0S+gD5NUw8IzdDwrqcZBR4ICKNmT8pGUmbnJOYK/lm11zpmQ
    dYQWcFs/Zw8LrGMkfNuZ2ffo3heLK72bIZWJkZ6WR0anQdWUvXNnqGCmfIHB/ymL
    iDVTCPMWq4Ebb91KooNYKzXX6V/lON+eQyxJYQQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP/jIf5AkucTcN3eM4uOKrCYB41QYuINmS73EkjNGytR17fgBFeKfu/LXMwLjcDX4Mjz+htsSbJYRdv9OQ2Tp7OiJ1f8IBWIMypGfRQQ6z54OsmC3dUH
    xty0TBIGWZgvbKaEoOtDc4SmiT6JUI6QF1Ljuj6OHik4PD9joPi925A37Le8Ffk8kSpA3CNmwjoLNP15e040eyYsijqxn6w/K4UxgRWEe1Pd4zvhWVqiOi2d
    eTgkyEg1YGYf4KLcLMm84A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=AV-5NBc5AReA9oLAFvsA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180425154827.32251-5-hch@lst.de>
References: <20180425154827.32251-5-hch@lst.de>
 <20180425154827.32251-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/40] proc: introduce proc_create_seq{,_data}
MIME-Version: 1.0
Content-ID: <26539.1525094365.1@warthog.procyon.org.uk>
Date: Mon, 30 Apr 2018 14:19:25 +0100
Message-ID: <26540.1525094365@warthog.procyon.org.uk>
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
 megaraidlinux.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, dhowells@redhat.com,
 linux-ide@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> wrote:

> +
> +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> +		void *data)
> +{
> ...
> +EXPORT_SYMBOL(proc_create_seq_data);

Please add documentation comments to exported functions when you add them.

David
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
