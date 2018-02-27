Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715436-2-5590000677307329928
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
    t=1519715435; b=gGsJT+gRD1jdu+5XL/z+RPfmbeg8Q+FToLUxqj8Gagh/VNW
    AusBIsIEJaTsmJk6PBrMACpTse20LThVMGojJH5fIYRd0oi7tbgk7QACuBcvOzS3
    Cc3p/AAE9Jq/HGBu5ilhyTdOJlD2WoYxQtX8U6a6KffBcm0Tsn1HaZ9Y1uVhPWGa
    qiO+yr4NJT1T1UCKC8wH1H0Q1OeiSWdSqVXgqYXtM6kw/BZdzOAxPcUnca0fTiHq
    wW35sKyEyvfzArxu6iMVGEcxW+owcQSFtZ85VEF8apl1HpETP9xI3/b8SPBxyfXb
    Tr73QVZwnXB6f2JiRghS1LegU+aVQBOtTaSXbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:references
    :mime-version:content-type:in-reply-to:message-id:sender
    :list-id; s=arctest; t=1519715435; bh=6dLV0g8GkttqV+yJ8D8JfRXT7X
    9g0S9HyIVy9IXpvPY=; b=YRnkVb7rimxuowmnjDiOUMlNJMPSGiERHmKT7YagXT
    bSlEG1GN0yXwMZhqbnsc7p/7/rq+keb8vBcbvtBKi41Iu+1v450BbHhocwG50qzh
    LfXcPJyyfI4FdgZPmdhrZ4vCaIJdpl7Mf2ew1yT1OkIxv8ZMzrhsIhROmaM5DxXx
    i94p38ntpQ+8ZHV04SLHjdJBh5d35Js7tmLLlvFbqYIrpM1EkHOxOiqbsvDZDIgk
    T/YW5jRaGLtGsuwz7bcn/cXnvyEzhsKKyzi7ylU9z8FHR4630CjEYVKv9Av2RiGE
    eWcRzazlRtDnYBKrJQBCzSpdY/4V981BVNvfb5BNkGBg==
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
        id S1752122AbeB0HKe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:10:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751974AbeB0HKb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 02:10:31 -0500
Date: Tue, 27 Feb 2018 09:10:20 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Nathan Hjelm <hjelmn@me.com>
Cc: Open MPI Developers <devel@lists.open-mpi.org>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        rr-dev@mozilla.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, criu@openvz.org,
        linux-mm@kvack.org, gdb@sourceware.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [OMPI devel] [PATCH v5 0/4] vm: add a syscall to map a process
 memory into a pipe
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
 <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
 <B9A6330F-48FE-4260-A505-3FF043874F0F@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9A6330F-48FE-4260-A505-3FF043874F0F@me.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18022707-0040-0000-0000-000004383E01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022707-0041-0000-0000-000020DA6873
Message-Id: <20180227071020.GA24633@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270085
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 09:38:19AM -0700, Nathan Hjelm wrote:
> All MPI implementations have support for using CMA to transfer data
> between local processes. The performance is fairly good (not as good as
> XPMEM) but the interface limits what we can do with to remote process
> memory (no atomics). I have not heard about this new proposal. What is
> the benefit of the proposed calls over the existing calls?

The proposed system call call that combines functionality of
process_vm_read and vmsplice [1] and it's particularly useful when one
needs to read the remote process memory and then write it to a file
descriptor. In this case a sequence of process_vm_read() + write() calls
that involves two copies of data can be replaced with process_vm_splice() +
splice() which does not involve copy at all.

[1] https://lkml.org/lkml/2018/1/9/32
 
> -Nathan
> 
> > On Feb 26, 2018, at 2:02 AM, Pavel Emelyanov <xemul@virtuozzo.com> wrote:
> > 
> > On 02/21/2018 03:44 AM, Andrew Morton wrote:
> >> On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >> 
> >>> This patches introduces new process_vmsplice system call that combines
> >>> functionality of process_vm_read and vmsplice.
> >> 
> >> All seems fairly strightforward.  The big question is: do we know that
> >> people will actually use this, and get sufficient value from it to
> >> justify its addition?
> > 
> > Yes, that's what bothers us a lot too :) I've tried to start with finding out if anyone
> > used the sys_read/write_process_vm() calls, but failed :( Does anybody know how popular
> > these syscalls are? If its users operate on big amount of memory, they could benefit from
> > the proposed splice extension.
> > 
> > -- Pavel

-- 
Sincerely yours,
Mike.

