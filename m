Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2118878-1524390137-2-1398141660554478845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524390137; b=SloFkeW0+eKpHJO3R7pQO99caZY5FlRDHriHs01bDpF9ducacS
    QnzMKgpO+FOqgNImZV//aiKljAcwqmUAJmSwpJTFAlBzq1b7OWRO2LL4nIcW8SG7
    3XLSJqCC5O+nS/PY82s/8LkTjJausGVGFF/PZktG2HnHrbq4b43J+LbIMNy+sxvc
    3dGTpdB06MfDUqEKOsIbOehbUU1nnHmF0gbUwukt+cxqVjsnfy0x4m+5WLu3xJBd
    9AXN5VNaNmR+Z1/qvuZaa8SAXtEXIX6Nlti3hGbXKIGeA+KyRH8BF5E3+7o/u+Nv
    U3MacNl6P9Gy5uBrzlqU8JpI/f+GZUaenOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524390137; bh=nicPl
    tiSznGKDd7FbiXuchnpM2GizdQg8hXIvpeVRqQ=; b=taJp4Wd6dgM2dh6AKeSX2
    YsyLXoeFn5KvgQI6BuLXhF3cxcRi2w1v5WZ1j4ly1hktU2f0moMx4Pnc41Yeo4OK
    bzaZG5aU7pNVpUp6x5p9dBdrZzeFtjrVdHlFKzqQtVY6ETPSmYxdUsDYyDu6e2ew
    bVooE2t+3gdHciot/lE+p4J3IAxem8wjlZUdgZTJ36dwwQKq7uQUuFUVRsomn9D0
    ZhIDaCeheepLW7fape1gxu14MnpEFOXvzBo1PnZylLHfpiSUKeFZ4KIEpivWk4I5
    ybZT3wP9mnO7ejr1UNg3UkTIXHND3hpbQJ5liHFqu3s9JsnhOxiHP0WsBRJyv3zc
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FH0V8LJj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=awpbnvx5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FH0V8LJj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=awpbnvx5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE+IOpLavx4v9qrvoBUPwK3EeZx2W8Ewf5Zm24kuTqsN/Z2118D6booQ4j+6gu1Z1Q5yOFjAXxvBZegVpMjB1ihcB2jFINWrYFcxhWyxraip0+Yc0Lvb
    A/E3LuquYFDK+zy1qcvyjwt1KOSZyXOnukpBZ6t/qF6/8XyxxwKypYi9bimyhWvIGj1QIKBqDRI3V/LJU6BeT6ipGCLSVFrEV3Z3wFbzMJAlgIoBvr71/wA6
    0T0AN+isZIoNYkWilkN/Ag==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8
    a=KW2fZluiVG7Zq2DVJ20A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49hBpthUKrZl+dwPGA/ikgVwmqTMcXYvKVnTpZgiyOW0BcwE0YhrNODnZsNpjMPeFL2bLk5FguyQfW1C/3qSzw=
MIME-Version: 1.0
In-Reply-To: <20180419124140.9309-16-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-16-hch@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 22 Apr 2018 11:42:08 +0200
X-Google-Sender-Auth: iB3F2RIKSJPLc15NKjNPaZ6zhIw
Message-ID: <CAJZ5v0gRw8P8KL12QKMuSjyePxWn71LB+s8ephF2a4-Ns234NQ@mail.gmail.com>
Subject: Re: [PATCH 15/39] acpi/battery: simplify procfs code
To: Christoph Hellwig <hch@lst.de>
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, megaraidlinux.pdl@broadcom.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 2:41 PM, Christoph Hellwig <hch@lst.de> wrote:
> Use remove_proc_subtree to remove the whole subtree on cleanup, and
> unwind the registration loop into individual calls.  Switch to use
> proc_create_seq where applicable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It is OK AFAICS.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
