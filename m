Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-79580-1518401194-2-8639005178099918039
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518401194; b=RB2HgHvJsxgO8RkC7oIGwBNYxPnb+efYWOKYQb8vauqowno
    LF+GiGRCo5jpJlfGgDjaBqAob8Yzzn5jegxSZlH8bxQFr0H+biznBuI7PmDDG7KG
    k4HEHVL9YSOlchZhI8jSmpVMPFgD2kA21l4cAHIG+feArxkPyzXCJPBFV4mIApSG
    nH//VQgBiZY8AYCtLhMxpPON00MeTtfUJlQWKg6NcpwBsccI053VZal828HY9T9l
    mc7As3VaXjQXrA0ZtjxJ1R7lPf9Ik7l1WVNTj0NOzm9sPkCqa/TQFASEP9nl1Dhv
    ynguf6v8pGjlUwFKl8HHQa03aWzfjAKUexdtw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518401194; bh=P
    d930T1C8RGo5nCHy+kOZg7OhLxDpZ2Sk7KPrn6/S5o=; b=nSbueSJ54+Onc/593
    u5IZ0j6PlWfXBHmSrk09WFNQuqz6EhI6c2T/hWqlE1/DhQFpHmorc/JgAGht7rON
    gX56aYsKdPdrBdUUgkjN/qnbfm3jnkN6e3IbtcJEUMBSLDM/3SjWzaKS0FJX+I1/
    VO4s8ql347h6DLkAQ84KSGQIrRfKjofoYgq34VwrrAj5947NZD55y+LICQzqb2Yh
    3UBpAfT661xUStCnsWZOqKfwBDU9mVigKADJYcgC/7l4scaE6WTzDibPeHWb45E5
    FH/BwgV3PNegXZWSWCql1EKZXt6DfYrdSlceXRZ2+s+Lh1syHku32UOu1IP63CfP
    +BDQw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=drVJhOLO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=drVJhOLO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....9 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Mon, 12 Feb 2018 02:06:07 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] staging: lustre: update the TODO list
In-Reply-To: <1518390961.4139.1.camel@perches.com>
Message-ID: <alpine.LFD.2.21.1802120158500.3291@casper.infradead.org>
References: <1518390008-17876-1-git-send-email-jsimmons@infradead.org>
 <1518390961.4139.1.camel@perches.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180212_020608_291526_B58C3E32 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Sun, 2018-02-11 at 18:00 -0500, James Simmons wrote:
> > As more people become involved with the progression of the lustre
> > client it needs to more clear what needs to be done to leave
> > staging. Update the TODO list with the various bugs and changes
> > to accomplish this. Some are simple bugs and others are far more
> > complex task that will change many lines of code. Some even cover
> > updating the user land utilities to meet the kernel requirements.
> > Several bugs have already been addressed and just need to be
> > pushed to the staging tree.
> 
> Nice list.

Thanks. Its nice to have a direction :-)

> Are or should those entries that have been addressed
> also in this new list?

Do you mean by those entries what originally was in the
TODO list or what has been fixed over the last 2 years?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
