Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941094-1520068191-5-13553018991450888070
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
    t=1520068191; b=BAinwUVk977msJiaf7l3zHQYBrQ8GTga296h1JmBnZCzrm9
    ypexb8TWiq8P+kiJVR4FNqKUaRq7kyONNL0nWBAT4tQJ1Y+ifGFVobXsbBIomyc1
    C+WCnfZ4u28yTMUtDoY8ji4rUaahxJ0t4huDKIWX1ijJT9emR1s/EKg0CD95iIKJ
    /D4G2ojgcWa2NsAxFjtv04yzTARipWh3JqiuFUQ3ezVgSXW51Tpm0iSgBRClDHRd
    6VtuWIHn0XYd6GhkPKX552cWcEmH6ugrXHeJ77ltWikTSG2Z6pAjl6l/HYuvyZ4A
    or8dAL6oRa9FhbwJcINXM8n6z58UHD+cRMGa77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:references
    :mime-version:content-type:in-reply-to:message-id:sender
    :list-id; s=arctest; t=1520068191; bh=K3XMaw7jyHr8cgwpyCUBxi3yxQ
    P4A1jV4cucf8g6PJQ=; b=JgyFIevggVk9TiDe7/bp016JRGUCUoAJrDYEExjo/F
    HI0yDPj3DHBijgKwBMKiyGBxdk82qr6NtVIlIMvTTHjXYhfOXE+p5sMfqeOcADDd
    vgoAUmeL/cEYi2SYUr3bwdIUoDRtjI1YBz50iIEu4Q/hkjXx2JzZgU2x/6gLRGkk
    ts6kmGovQv3vsl+1UUus+k/jjnROID+jBEDXUhInYz5+Rx/S4Zs42Il1BEN06mnX
    Wp0s8X9cxYp25z0C/bVYhRGgbHXLoctT8aNnVSk9rCQczDi1waHf5dtQv8FDmZDa
    xHcfNrSn5YXHSQCWMkDIcQKNKPyPAbwBIBQlfXDvrlsw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeCCJJp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 04:09:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751568AbeCCJJn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 3 Mar 2018 04:09:43 -0500
Date: Sat, 3 Mar 2018 11:09:28 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-api <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, crml <criu@openvz.org>
Subject: Re: [PATCH 0/3] userfaultfd: non-cooperative: syncronous events
References: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180302153849.d9d7b9a873755c6f5e883d0d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302153849.d9d7b9a873755c6f5e883d0d@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18030309-0012-0000-0000-000005B83CBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030309-0013-0000-0000-0000193448C4
Message-Id: <20180303090926.GA14011@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803030114
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 03:38:49PM -0800, Andrew Morton wrote:
> On Tue, 27 Feb 2018 10:19:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > Hi,
> > 
> > These patches add ability to generate userfaultfd events so that their
> > processing will be synchronized with the non-cooperative thread that caused
> > the event.
> > 
> > In the non-cooperative case userfaultfd resumes execution of the thread
> > that caused an event when the notification is read() by the uffd monitor.
> > In some cases, like, for example, madvise(MADV_REMOVE), it might be
> > desirable to keep the thread that caused the event suspended until the
> > uffd monitor had the event handled to avoid races between the thread that
> > caused the and userfaultfd ioctls.
> > 
> > Theses patches extend the userfaultfd API with an implementation of
> > UFFD_EVENT_REMOVE_SYNC that allows to keep the thread that triggered
> > UFFD_EVENT_REMOVE until the uffd monitor would not wake it explicitly.
> 
> "might be desirable" is a bit weak.  It might not be desirable, too ;)
> 
> _Is_ it desirable?  What are the use-cases and what is the end-user
> benefit?

It _is_ desirable :)
With asynchronous UFFD_EVENT_REMOVE, the faulting thread continues before
the uffd monitor had chance to process the event and the memory accesses or
layout modifications of faulting thread race with the monitor processing of
the UFFD_EVENT_REMOVE.  Moreover, for multithreaded uffd monitor there
could be also uffdio_{copy,zeropage} in flight that will also race with
those memory accesses.

I have elaborate description of the patch 3 in this series.

-- 
Sincerely yours,
Mike.

