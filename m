Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-278363-1517516225-2-9984158015427561970
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517516225; b=rMSt2kk6WJRF1lq5PWxCXTr4AL7Try6OICQiEU6x9YiWnDt
    hQ7vqPWW5GvUiFXgPNsnCf+kecFOLCNPO38vz1Od2BSQAk8e3o5TfDNIXUYHKv6l
    YfIsq1oQba0sNmx30gkTI6ZIz3bhVsugwExQLs3tOSbKj1SVgI3tWTF34WkKOGSd
    Al9u2sx2lRFtkINVCrY8giLkh9tgqqNWohR+Szw4JpLW3AMF378ktALt+354ntlA
    Z+csCRpI1ex6tqn7zHaAvhv/7erCorP17bVBLLHKUR90Ws8jpHPCAXuHKeQMuUm9
    MDD5TaiVk88vx4KovNQvSgg6wwCRkYoXwVF5Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517516225; bh=RyPf7ty77Yboy+piFfe4scBju8oHQ61Dx+u/aCsGO14=; b=K
    UfsOIDZ/3+GSlUAets+O57vof3I8jIAcmEGvCERtWMDX0uuhF/83Juj6cHs7r+L6
    9WFDKcK78SzxIFdzG0hkyPk/uL++eawvFE7Od6Xa69kWPyQ3gqXwfe6Apy53Nrcq
    VBuSolQK0IyXBwouwiwNKvnpOXKOqWnyPySRFxN5NTycmGh3t2+scvCKqgEkZpns
    9iKufovo7ro1jl6VwfJR30krrSLdjuUqc6+NSY7m1wENVMO9e0O8dZb1mO3Wup9b
    NKIRe//3TN1X18GFBvY4xfMy4vOeRm8iq1rrIjXKvkQAonUKrkr5ft2EhCeoY+hL
    ZyhqryAXlY59GZRqIp6TQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=gzklXrAU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=gzklXrAU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754892AbeBAURC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 15:17:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37036 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754891AbeBAURB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 15:17:01 -0500
Subject: Re: [Xen-devel] [PATCH v2] x86/xen: init %gs very early to avoid page
 faults with stack protector
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org
References: <20180201124019.11693-1-jgross@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b8f04374-97f1-76d5-81b5-3583441833f4@oracle.com>
Date: Thu, 1 Feb 2018 15:17:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180201124019.11693-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=758
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010259
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018 07:40 AM, Juergen Gross wrote:
> When running as Xen pv guest %gs is initialized some time after
> C code is started. Depending on stack protector usage this might be
> too late, resulting in page faults.
>
> So setup %gs and MSR_GS_BASE in assembly code already.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
