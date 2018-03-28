Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3590885-1522282224-2-3360861436708032568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522282224; b=ZZW8WB9sLaUx3EkLAj0cOackTj2PA3yZKIWoWV111/8d0qk
    e5k8+pCK5KxITVMDhQE302RcwHOBA5GTcZxrOnsIWjrgEszKk+GPBqCi9YIBpn4g
    IXd6moHW3RVefKCUMOUh1cPPe6k6+mR5NdlFOe+lIHSMF5liUnRYa6dDIvLGRBhQ
    QH6vjpPX/hSx0ds2Y62PGCu4l0AXBeSCw3jVYb6LdKzopiwHz25wMEyd4p5S4+Qh
    Hp+cLFnOC0ZWJXssacTqDfiDbSkCvb9rQZXh3dYnaGB9gSHebqGISjGSn39nmKVF
    b8NAceUqYQtERXSRI2fv/kdKmaHNcQ855wVq94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522282224; bh=zDZxevSFVaGRCLpXi5RFqNoYRa
    S7DKW4f1fSndnJit4=; b=CwupduPrkFi1lFJQVd77NqV2KKhB3D3MQE/qTyY0cD
    qYTTy30oTAhUh0QOgBflXrEK3L68IsPLMn4PKmDR8EnckwWxBHZ6gVbH4v5WrOWd
    r7aUpysxTSlhgIoXN0W4u9/t3/MMdl5MR1kW4+ESVXqFMZbKKW9gC1TAMlcdOKeo
    P8iyzCYvXmvstB+ahs06JKr7feyLRBUuYT8aZ98tFc84oX4Xj4akh50oPNYs0qB4
    FpX4R9TBhyfzqe0fb+H1iEBB7P6tuIMUVWIF/Tr0k+C0IbgDq8SiG9za6cszsEw8
    9sh2hcdCu9015oLPX5rmUDnipLxgVLBtGkqXtbA4ytbw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFsEXZO/BWWGoEVem6de/bGXFy0rBGbzEW91kxCupe7AZQhkfLBIba/s0lw9QwSK4ER+U5V5aFdLyy23tU7yg+VRmBDJRjNtgAYZpdhPmuTatS+S28B/
    0cTiJ7ZyL58bceCG1wkbMKPFSw+OzsO6Q1eLG5QfEOFPumGiUAPmlyIrddA0QbzSf0+uor3cuQVX6qnpCAyKI34ahnBpTsQnG+Eh1Tj5ZW2KZ/C+IaJx/kHO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=8oh0bYV-WXwv-0dorlEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbeC2AKW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 20:10:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:37412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeC2AKW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Mar 2018 20:10:22 -0400
Date: Wed, 28 Mar 2018 16:57:59 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        esyr@redhat.com, jannh@google.com, khlebnikov@yandex-team.ru,
        linux-api@vger.kernel.org, serge.hallyn@ubuntu.com,
        linux-kernel@vger.kernel.org, prakash.sangappa@oracle.com,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        oleg@redhat.com, akpm@linux-foundation.org,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [REVIEW][PATCH 13/11] ipc/smack: Tidy up from the change in type
 of the ipc security hooks
Message-ID: <20180328235759.fmnldverphwzq5rt@linux-n805>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <87vadzqqq6.fsf@xmission.com>
 <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
 <877eqejowd.fsf@xmission.com>
 <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
 <87a7v2z2qa.fsf@xmission.com>
 <87vadmobdw.fsf_-_@xmission.com>
 <87y3iikp1y.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87y3iikp1y.fsf_-_@xmission.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018, Eric W. Biederman wrote:

> /**
>- * smack_of_shm - the smack pointer for the shm
>- * @shp: the object
>+ * smack_of_ipc - the smack pointer for the ipc
>+ * @isp: the object

Nit, but while at it the @isp description does need some love:

"@isp: the pointer for the ipc perm structure"
