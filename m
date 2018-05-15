Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2709797-1526392755-2-7777684437130802672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526392754; b=mB9dfaXuI/xawAJD30mLNngtpmRpmcCE1VoGINYEPOoIPINpqO
    aPARpV6AYT++hObB0AhCu8MKS6DSUhw8NCkeV3A4T0gdQdXR5JZogCOFj2yjwnMD
    kUQhmsGTzpCB1V7VTC/z1zMxDmrwRvV28kbQCIIDzFuuaupl0xSlzfa5JrHulGbu
    HCpr9q1kJ++sX7IcP7B5AqoetIhcd7znG6x5S8seE10422SY2h3ZTlj6zZ8+/K0x
    zX17WcU/a0AQRw05Zj8dLcDGA0g5o/zDbTvAYdlGXEyAKFr9kb8QkI+GMjJJ18cU
    UOxRjX85uL7kNss/zuX+o2oDIVcuzY6uAz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526392754; bh=a5pgV
    iWEoWQz+BVeJ0YBgXLApqpEg1X1Boda38uI/6Q=; b=OIgfsG1hQ4RRjWCkXYcQe
    phzH7Fy8djxlf2ehyhKnVK0AXGK2Knsl09ThX2ETdh3VK7JALLPxiGRTaHCfpC7x
    +k7DB+3rq2Rfm7jxlAtL/DHMlp25rIcIUTNyedbNgBhe3AcjMOD9EjY41ZN6RN5s
    OGyMiZl442kq7mIXoV+vo6+URxQAAMrxmK4FQcMZT16cK6CAGwSHslIMoS7mkkYE
    TTm9DZyDn2OrHVnc4fTeJnjQuRHDcNZPyXoJlKmI4tXjEothmF4/dHpsTZmFCHXR
    6pltZvJN3jcdfany5yCE28jlm2IEDJNQuzNemNeC0SL0rNrPzg+/qWrlfb+x/P+G
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLzVX5sfEDv/pcG4EgW+aVb2+yirZ7HWU4iCdCe1pMgBs0Q/B3BCw+rqX0SFy0pRdNx11zwruP6cqY9pZ5ypFyk+VMYBKsCvRJ+BfYqLGrR6MOFxMQjQ
    LsQbURmmjPIAKQvpzf3csGnYWk+q27iTfdfbdDWHToP+9oEm7x/VvP1fRX5YkuK+5eXYXocBnTW2+oYxkAnynWqbV2rjjyAx2hA8rEEFmLSxl7fI4JSVj4wC
    8DzYN/DRRCUggvKlZG360A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=QiEDfoRPBmZhUppsx_QA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 16:03:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: simplify procfs code for seq_file instances V2
Message-ID: <20180515140326.GC31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de> <20180506171948.GA769@avx2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180506171948.GA769@avx2>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 08:19:49PM +0300, Alexey Dobriyan wrote:
> On Wed, Apr 25, 2018 at 05:47:47PM +0200, Christoph Hellwig wrote:
> > Changes since V1:
> >  - open code proc_create_data to avoid setting not fully initialized
> >    entries live
> >  - use unsigned int for state_size
> 
> Need this to maintain sizeof(struct proc_dir_entry):

I'll fold your changes into the relevant patches.

> Otherwise ACK fs/proc/ part.

I'll take this as a formal ACK-ed by for all patches touching
procfs.  If I was wrong please scream.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
