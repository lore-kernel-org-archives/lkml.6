Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-290911-1526477327-5-14828932466629654683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='uk', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526477327; b=A0NpI9UnuzNhH1C8djB+FGe85wFBn47M9UAdRKLAblDSrnlNei
    37uMx4a5bpSNiG2WlNK3VJGxL1zisGgyyRzTyXWeGVm2Yx4B4K6e9/Eb/8TU9D8u
    IdDY1/xz7yh56offwhQ/D6YWp9Isf3uk8E75lskWRp0eXN6NHEYzTD3gEahO19R9
    KhfPF3HvBTmlEg3eRw9zvKXcIgmusxhhWDQBTgunMNWkQlUt0nXZ3Q5980jVdU6F
    XwJc1wjHSnFRCc0blzOn7LO6LsNJvSuD95HzrUeb9lM8Az47U/a14sTbIBNyEm3R
    WnuudWo95BuKhPJ8JuVUiiv1gA9/MrPgzLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526477327; bh=HHn3+
    3jD+/G3ijmdtDxI+o+l9YlmTJlF0HIDroaoHxo=; b=CvthLXbCcf4osTSTq6jzt
    JPO92+vJUlyCYOQ86Ve2twK2mPPDP1OmWB3t2Jev8Fm92+4FLEhu/MMSLrkCc19F
    kISKQH74Bw1P/TgwneXzXyC1lHNa1IYcxY9sJc360SjAnFaacLlUu+ewsSleo7BQ
    Q3qFes0WQaZoK10kpYSCxoCCPv2hOB8/ix0O/0YCtbgaJoXo7kM7M7XH09BHuZDR
    XZf0ThrhSCn4LLgNXQNndPq3lXAo+Y7KWldHtX1BByD9EHPoO+gK8xbD99HZXwtH
    HOEy+Ibg11rqkOIntuPqy6j5s9d0l5yhzoRjEHfJbh3fTc9ztybA8Wo4gXdNhmH5
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=zeniv.linux.org.uk
    header.mx.error=NOERROR header.result=warn
    header_org.domain=linux.org.uk header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=zeniv.linux.org.uk
      header.mx.error=NOERROR header.result=warn
      header_org.domain=linux.org.uk header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMWPs8ozw78rrskU+KxoKQFb8VA30FixKIY6ovzThKOxM8m9eJnyqPnGZj5KLss/HYA6mp1mmRkDdB/edJV3mvBFunJtvnns6amFcdLHcESzwI1reD5Z
    en1YG7/hA9rMLmciX8QwXNej2j3V/4CkniWFjy9/qRFOJ58BSrm4l2/VyLq9bABcKw9KLq/O08ycymScSiP5aB2ETLuu4DHYu6WNnyhOq5RcZkRSBODhvuxs
    xp5QAiiZQmhAbXO1nfVz1w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=Hw3jIB1s1ZXg7VT1QH0A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 16 May 2018 14:28:01 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: simplify procfs code for seq_file instances V3
Message-ID: <20180516132801.GO30522@ZenIV.linux.org.uk>
References: <20180516094346.20506-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
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
 netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, megaraidlinux.pdl@broadcom.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 11:43:04AM +0200, Christoph Hellwig wrote:
> We currently have hundreds of proc files that implement plain, read-only
> seq_file based interfaces.  This series consolidates them using new
> procfs helpers that take the seq_operations or simple show callback
> directly.
> 
> A git tree is available at:
> 
>     git://git.infradead.org/users/hch/misc.git proc_create.3

Pulled, but the last bit is a bleeding atrocity in need of followup
cleanup.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
