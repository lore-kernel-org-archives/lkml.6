Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2709797-1526392480-2-1465589413272390588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526392479; b=UDuO5UElj/wcXOuPxit9c44ElgrIf6Z5s53OduJ0IVV2yoF/ux
    uXFYM93sp+33vkzqAJdeLKX7Ph/hlkuEN3tfrhEqtn0vLqksRn3TruaEgVd/7Jks
    A3XNIzQKY2gSIdpbbWQrArb2b3OrZo6/YhgQxSxqJ9K0bu0pGGYvWL/UQnoYI+A2
    3EnhlzLK2y5vNgez/JknM5SMN/mrzxU9gCzOaS3NHmeCEBEj2Q7NMb2AVg705Yfd
    xcXqkCPuPW0GgZMAFk/MTf2cCFPx98wIPBPEuDLm2Bb6D3f3svyJlSUhewD1eB2P
    75GGH5yhglN9ANQfUIG8nfj4n4O8DRXLVteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526392479; bh=VYZpN
    DpNixn1d0wmK2Z99Pj122bxRUq2nxkx7aiN1AM=; b=dVIAlJfGRcURe1sWf7mOW
    PUPf14UVZHanKb1jffnRjvtdBxVd5AJpPtkOHInm8LvBBsQ5GDluAmoyJwRmh4qC
    IfmQ/qBrVixtWZaR3CwpT1g6bYaXMOhiI0lN+BvEYKoszRIHNwN7KCYRgp6K5xR4
    lI+WvIn7q3/C9XwnN0FUViCb8iEW9lvzSl4JzZnjVgpD7JFcasl6i1xphuLHzeMm
    cVdGSH6G9iBemG1cBdgOZt7KAInr4dP0pyVcxa6km+dK45eNdbP/FuFZ4tYkJy0M
    1t6AaDSXRFWMi//21Evww+EOWAUkG8YCWDLbakY6iPn8aKltRHt/OqBmgLBMYhE0
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfILAMAH5wbzHVO2Djfd+BnvLSSkfBgUJkJXmn0HLfXBA/oo3DAs/lty8Y7nrw9WdYCxrYvnhnCtPtNcdf0FF1deChvJiCty4T+qY+pb3r3PSh9lQ4xAA
    M9QlUz7zp1sXn2QNw6z4wLhqAjWcLUmiL/cIGL7CJBD+fuh9Zc9GpDVLm2zrvjM5bxyO2Mf+tPqESLVvISYz73UZHkeoLBJq+2LsB7+VXdLIBvyXHJmMjOlB
    bSQA2BPVuJDBw57/l8bQDA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=iIULUyXJ87q8ZBMsflQA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 15:58:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 06/40] proc: introduce proc_create_single{,_data}
Message-ID: <20180515135849.GB31296@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-7-hch@lst.de>
 <alpine.LNX.2.21.1804261118050.8@nippy.intranet>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1804261118050.8@nippy.intranet>
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
 linux-afs@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
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

On Thu, Apr 26, 2018 at 11:45:50AM +1000, Finn Thain wrote:
> >  
> > -/*
> > - * /proc/nubus stuff
> > - */
> > -
> 
> I don't think that the introduction of proc_create_single{,_data} alters 
> the value of that comment. That comment and similar comments in the same 
> file do have a purpose, which is to keep separate the /proc/nubus 
> implementation is kept separate from the /proc/bus/nubus/devices 
> implementation and so on.

Added back.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
