Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-368919-1525248009-2-9822206300938774207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525248008; b=NvmeccLsBMX0SPbktW/xDTtbctzt3Niouxn02vZJpjECCzI3xX
    vGUFr5FmSihqzg75dhy0XhrlAKh17PiRo6m94SRhXM5X00137EO+8UufdRa8ttMu
    NN9MQSmTInUX/zUqnZ+31lYFVhvJaTW3252M9Nb5XAjEp4raIRBVn7Qrv8qSKSuA
    9Oq5zQn8otvFbzmZFYYHVz7fIykxs5yL9MlXW3XmbfSGPQpcT5lluOI5Sj1QjrCo
    G4zdezDjB9LD5HI6ZGdKKfkF/x7/pboEktpFcryzvv5XYDyjtw1ldBjYxbGG/RCM
    HERVUlBlDdFxaUG26ztcovTPQaNfeadqecKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525248008;
    bh=6SLDyWoiSbiQ0rVzrToA9C65ISpldPJ3ugkgU6vr724=; b=MVt76V9C2X/s
    JSABycydbiIDWfApRVj0vek4wnsDY/1keSHOJuxYAy+5Zh7NzPLu1reY94eWwyuO
    a7avAsiZo9Oy1vGUM6uij6dJk/PXsxKPWYhwswZSHgbjsM4gzSO+8uHDaf8kMMzS
    1I0hnB/xW7g1AFI53TsdU/AqJZfxoPYaadLfzVPQeAq7AJrhzzDyPtCDzJXhmKFa
    ZhXGRR6x1mYR1n3gqrRV6BJhe4FTvqtg6gFPl9jxM6ahU/m2NoNDmw36fcXmym5q
    SXm/XoL8f13DM+iyNOSFKCYHZLBP1fxLtR9iyCJ3s4wjYYpZC0sQT7AoqVDdyRoy
    gXVR10CGOg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLy+y6IA8OgO5mdKqiS6tWg8VQw3hqYBBZlGzd+MU7F9Bj9DPB9QW1dQt9IzlG9farvmH3h7S0tZI3iyCckZGru5EHUNd/GIqlFZLjVydWlkSpBVb94T
    p/Yt+3qYFADYPEWpnMRnBZo4ZTqDOOLZFOJyeVpj8BEla1Vt1vn1ckFc1Io5UsLz7/pt4YMcpIo4MbpdN16P7HRp31N70CpESqSiK4HbeiZKoO93xwB4FG52
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=vSs20nPzsOeNIgY-z1gA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeEBIAH convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 2 May 2018 04:00:07 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:48080 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeEBIAF (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:4:2>);
        Wed, 2 May 2018 04:00:05 -0400
Message-Id: <5AE9700002000078001C0064@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 02:00:00 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with
 explicit constant
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-2-boris.ostrovsky@oracle.com>
In-Reply-To: <20180430162339.17143-2-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
> Latest binutils release (2.29.1) will no longer allow proper computation
> of GDT entries on 32-bits, with warning:
> 
> arch/x86/xen/xen-pvh.S: Assembler messages:
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (40 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (40 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)

I think this is a mis-configured binutils build - even if targeting 32-bit only, it
should allow 64-bit arithmetic (i.e. be configured with --enable-64-bit-bfd).
Note how, for example, this

	.long	1 << 32, 0x10000 * 0x10000
	.quad	1 << 32, 0x10000 * 0x10000

assembles consistently with a warning on _both_ values on the first line
with what I'd call a properly configured binutils build, but errors only on
the shift expressions on each line for an (imo) improperly configured one.
The only viable alternative would imo be to simply disallow .quad without
--enable-64-bit-bfd, but I guess that would break a number of consumers.

In any event I'd like to suggest to drop this patch.

Jan
