Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2519967-1522792393-2-8057805483244501253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522792389; b=QmXW2aQc08/lgdYYm3faNkEbqIpXHSpEj8RzNoybgrsFax17oh
    ERsZqshLR3w41iGqj/FIm+1osVMN59KJLfYOShb4Blyl2nJW0Ecb6C+e0a0tPXoO
    1iyivrxAQDU27ZqL56dv3wuv+lG1NaDWD+vL9YjnVdjJUday6rO2p6oNiwkMIaZ/
    ktdQ/JIV7/UpDsw+PalHy/+8RetiSYzPR+Xn6HknVZkfn/bDIgRfKh1caG2WUK0n
    gnNVg73Z6LaTM6zXlGo6ky5WUC81eKFjjQj3upIegqH5yFaQFQcDb3pekVnjKHbr
    wukvEE3fIq1k3BEXCO/DiXEc/U8DTOWg8Slg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522792389;
    bh=m5FlwxJ5YFeZV+twLULESWOEOCa/uUnMakBRrtz3n1E=; b=Ljg/NECt5zrB
    r9sgIe0LA+w2pB7o8yka7xZhLbRoxYNa4h1pK1zo470PDPAsbHloJu4IaO8vxeHQ
    K/ijAFnlDiiq30s7P+Xx/3AgknCNqTpGGIK5jSHe829CAYracLumq66t7/HX+6Km
    yzrRklfN0amt6IwxkNis+hhTdM7ZKE5C8iJ0OsH0TY3twOYK9hNueaP45Nvdmd/3
    MBxKYYBXHV47i3kdEZG5teyq/YAB0/g57qMrr+y4v9rY5/YLzMXLrtIXjoOdUddx
    ubN44nnZ3XWkKa3HelHiVtX0JPp2MgvbEOiSa9cb87iaFk5UmJzDW+EvUTHsGGhk
    SxNyA/1Kqg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCYC9is0bWWq8dG6NZaCzfEEaEU6WWsCQlDur1ZUUTn4S9pNtQmiCUyCwi2UKwoExeGUzPKTyaulYlPOMvygRB3tyR6ad3rBSrbryhfmlFwhb8XOIxf7
    G48LsMU65Jp8DLYYdQyo5dQkmYvRyOvKKaYs+wz7DJsPRDdTCl9U5ITatSEn/R5imVxC6s/AT2imzDBMGVI3HZX9g8vpbvHci/O4dJ2+32zU+Hit4IEo4Rsb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sAzz4vkG5TfnxegHEakA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeDCVwv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:52:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeDCVwu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Apr 2018 17:52:50 -0400
Date: Tue, 3 Apr 2018 14:52:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        serge.hallyn@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        jannh@google.com, prakash.sangappa@oracle.com
Subject: Re: [RESEND PATCH V4] pidns: introduce syscall translate_pid
Message-Id: <20180403145248.fb4cd8c5ccd270ca77fd18f3@linux-foundation.org>
In-Reply-To: <678f275b-8d78-9b0f-177f-5ff5c9c55657@oracle.com>
References: <1522706249-11578-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        <20180403143838.614ecc083835d07d409a699c@linux-foundation.org>
        <678f275b-8d78-9b0f-177f-5ff5c9c55657@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 3 Apr 2018 14:45:28 -0700 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> wrote:

> > This changelog doesn't explain what the value is to our users.  I
> > assume it is a performance optimization because "backward translation
> > requires scanning all tasks"?  If so, please show us real-world
> > examples of the performance benefit from this patch, and please go to
> > great lengths to explain to us why this optimisation is needed by our
> > users.
> 
> One of the usecase by Oracle database involves multiple levels of
> nested pid namespaces and we require pid translation between the
> levels. Discussions on the particular usecase, why any of the existing
> methods was not usable happened in the following thread.
> 
> https://patchwork.kernel.org/patch/10276785/
> 
> At the end, it was agreed that this patch along with flocks will solve the
> issue.

Nobody who reads this patch's changelog will know any of this.  Please
let's get all this information into the proper place.

