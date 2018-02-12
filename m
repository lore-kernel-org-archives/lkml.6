Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1442817-1518443534-2-11389191782400641849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518443533; b=o6rT2xropyV5L+ZhvlVxKf9sHlEphUO7CrWky64myeopTiY
    0zExmIkCxthqDUOApA3BfxZAYGwCGwzIdna1nWLjbkGZlb1A+nBX8thIusn9mCk2
    7ilHAeV0TIP1CTY6iW5iTSh2lP+44lXdjBQVMriaYACiwH2eYP45aoyH+r7gf/Bx
    DHCBMgmJZBr8XL11vxnNaeih0PtkSYmnhjtFlH6p7Hu+wKtsQFPmeaRPvbrf9J6P
    5KNxxV2Wf9VyN8by0+5RVNmZ/25f3QRs/kUvq8y806iyS0JP/FsqOG4nw1pXCMjF
    ad5Uilut0bxDwOciH2bQYbXLUA1RXUCoiLCKJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518443533; bh=ALK4FUKzv8Kaih4cJO+bvl+p88zd/qIQ6IO2bytRyi4=; b=l
    lMd+u60OpGGW3gPgM9M8x8N7jzesn75gghZie6D1TFzKNPAxv0UlMx1EKUjr79XD
    4aqtcTHHVCoTrtoQDBQmx7sJRO6cKO/RAjyBHvzmc0/7duCUQr+1LwkxoZBemCq/
    qnzPwZME/gapRXaVucX9xq9UgG5bnWVlvIjPkftbAmaiRfmeFhwDBCBhoR2VSbmH
    s6JhvDMgqMYtWm5c09/yJwH4uo1hbUfMoTc13hnHexjKdlQ+wBSmBPUPjja9hVRD
    U5DWNnphBcirPBPbbUh68HU9AOnVkOh3x82YmNZn+wEbFnr7bxhR9dKv1FyZnZk5
    kja9GH/NAxFzUePl3sKIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934436AbeBLNv4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 08:51:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:60567 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933072AbeBLNvy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Feb 2018 08:51:54 -0500
Subject: Re: [PATCH v2] xenbus: track caller request id
To: Joao Martins <joao.m.martins@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
References: <20180202174233.27341-1-joao.m.martins@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ddafd707-bae8-d025-dfb2-aa958c23ded8@suse.com>
Date: Mon, 12 Feb 2018 14:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202174233.27341-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 18:42, Joao Martins wrote:
> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent
> xenstore accesses") optimized xenbus concurrent accesses but in doing so
> broke UABI of /dev/xen/xenbus. Through /dev/xen/xenbus applications are in
> charge of xenbus message exchange with the correct header and body. Now,
> after the mentioned commit the replies received by application will no
> longer have the header req_id echoed back as it was on request (see
> specification below for reference), because that particular field is being
> overwritten by kernel.
> 
> struct xsd_sockmsg
> {
>   uint32_t type;  /* XS_??? */
>   uint32_t req_id;/* Request identifier, echoed in daemon's response.  */
>   uint32_t tx_id; /* Transaction id (0 if not related to a transaction). */
>   uint32_t len;   /* Length of data following this. */
> 
>   /* Generally followed by nul-terminated string(s). */
> };
> 
> Before there was only one request at a time so req_id could simply be
> forwarded back and forth. To allow simultaneous requests we need a
> different req_id for each message thus kernel keeps a monotonic increasing
> counter for this field and is written on every request irrespective of
> userspace value.
> 
> Forwarding again the req_id on userspace requests is not a solution because
> we would open the possibility of userspace-generated req_id colliding with
> kernel ones. So this patch instead takes another route which is to
> artificially keep user req_id while keeping the xenbus logic as is. We do
> that by saving the original req_id before xs_send(), use the private kernel
> counter as req_id and then once reply comes and was validated, we restore
> back the original req_id.
> 
> Cc: <stable@vger.kernel.org> # 4.11
> Fixes: fd8aa9095a ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
> Reported-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Committed to xen.tip for-linus-4.16


Juergen
