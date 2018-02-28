Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3768768-1519806386-2-7757213988729828459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519806385; b=daPxSeSl8Mo6AdSu5HUfaXnorqVoTCU5MV+nKou8Dsj90Ad
    pDCA9KCFxTdZZ832nNt/QORg84tj6o7sg+oERAHYu6heNKD2dV968BKu7UIg21oC
    yKT+TYAYsorUaPZJI2FmnYWcAXn59PznwN5LgxgEojql3QwX0VnRxWkvYLpcOrgW
    ncRKQ5tC2kqbJYJVvG4UTbrz3sanmK/NDt1Rmb8EC4BJjIj0zxLJgKKcj90XqO0s
    5Eyu6zXTRqYePeE6Kj0aXgiTnfZ/U+79Z9e+eKa5CLxAgx5AFU15WEdBcGzbwXn5
    2+BLJ2dV06skJ9NgBntpi1e2F5SZWhHpwai51+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:references
    :mime-version:content-type:in-reply-to:message-id:sender
    :list-id; s=arctest; t=1519806385; bh=1peaiUnSGjmhBz7HfK+EAPDaxI
    /Z+Cq/ZqhEdGwBK7I=; b=uW+oRQvn90Py8+fEhXu79ipNkYuLoRBNIzyJGg7JSB
    7eB2yTuds2sEn6j7cJ6qWmOxJY5GkYUWQKM7jDRdqcgOKxU9EhMUTlD7oRslumhI
    M75ag1V5iO1W6BROBAyybN6rFjk4RFMALzpuwan8c+3isngRSRFbp1bDXqlnbyc+
    oZuBkzJAU40aESYrKc1IcfpoN0RdYysZJ0NiEmGhzcCh/vuK5LwA9zOgzYM0Fjap
    gjhKzY64yLpzX/C/9tTBksjF+a6NGcy6u+LXpb8TF1yIbGedQbobuI/WMY5xdJVv
    mOkeg+j90BCuY1/3JICBBo13uqbFvAX2t9/NKJa5E1bw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeB1I0X (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 03:26:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751882AbeB1I0W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Feb 2018 03:26:22 -0500
Date: Wed, 28 Feb 2018 10:26:14 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-api <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, crml <criu@openvz.org>
Subject: Re: [PATCH 3/3] userfaultfd: non-cooperative: allow synchronous
 EVENT_REMOVE
References: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1519719592-22668-4-git-send-email-rppt@linux.vnet.ibm.com>
 <1a2ed216-74ac-5fe2-abff-21d670eeb96d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2ed216-74ac-5fe2-abff-21d670eeb96d@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18022808-0040-0000-0000-0000041836D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022808-0041-0000-0000-0000261B3853
Message-Id: <20180228082613.GD15048@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280102
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 11:21:02AM +0300, Pavel Emelyanov wrote:
> 
> > @@ -52,6 +53,7 @@
> >  #define _UFFDIO_WAKE			(0x02)
> >  #define _UFFDIO_COPY			(0x03)
> >  #define _UFFDIO_ZEROPAGE		(0x04)
> > +#define _UFFDIO_WAKE_SYNC_EVENT		(0x05)
> 
> Excuse my ignorance, but what's the difference between UFFDIO_WAKE and UFFDIO_WAKE_SYNC_EVENT?

UFFDIO_WAKE is used when UFFDIO_COPY/UFFDIO_ZERO page are used with
UFFDIO_*_MODE_DONTWAKE flag set and it presumes 'struct uffdio_range'
argument to the ioctl(). Since waking up a non page fault event requires
different parameters I've add new ioctl to keep backwards compatibility.
 
> -- Pavel
> 

-- 
Sincerely yours,
Mike.

