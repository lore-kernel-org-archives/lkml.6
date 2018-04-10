Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-871076-1523403214-2-16098560123783704015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523403214; b=IuxEEfUmkB4xBscSL2EPxGC9G6e3RMz5AXEnum1lpeN6VxNeAU
    VOi9juTRnpkV6AFA9/JU4UaZo/Gbr9u+WJVWWlrefHDKF1yJ1nVB3MwOZMRbZRJD
    xopFlShz32+C8TjvQ3SV5ZBHebFsMyLQdTxwE92PaG6HOz8bBSo0/rd8Mr/C9ndM
    Lu//4/Zh1fszP3Yql8JGuBzHI3x5XQ62H1Adjzq4HODIQd5K1cDicJ2oIymMCFdq
    /egEZ5AJu8/xCQh6fCjZ6tAqEV1p9NUZ2crVquU0qCCWeg5KkMPEwrgScEIc8OLw
    S59j4KW6zu+qv5hOPKQ4tCbdkT9l30eVqTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523403214; bh=gVjk4LX3DjJmPGv6xaFtO4BI3LL4rC
    ymxJEfOJEdtvU=; b=hi2GsPGPttwZ5/J8CRLnnHFa7o6WIDFgu/T79GR4shxLol
    XBxPqfcSl2C/j0mbKZm8vMYIKRB7a+2niZlLtxWVaJgHSoshf5Jx4KUXTcc+W6l5
    2uI5ZBgmlX6jqfen9fS4jIt/GhU4ws6Ir/1ofAq4X8yuvjmly6N4jcsWolUFBG+V
    iyqxu7HB7boa6xw2NPu9L+PBXksZyx8It0OCwhuj/2PPh68PAHAv4xZiuD0cnrXE
    vjGDh2RvWy2achfYYzTyalbEym1FeS5AjgY96Tp6sotPDCt4rKLa3OfW2XnrwZ61
    w5L1Uxf1cP7SqQQEnNVYYnJgGoXa9QkefAIhqYOQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMiRM56LzjdizovUzKCUl108WQBkEnYDytvwRCxeVReAZORRTiZz7m0if/MlEuAD8njWG/TbIjBEd1Aj8CyVnlxeTuH5UTLijGUBPpPVBZi0OxkGuJx0
    CX4fLyg4Y1GxKyFrhaPhmfNGtEN0j3fbRZnrA/mRytgtfvN/QCGk0+AkrFmOoDYZ//ZyJJIO/bw19+pWSiX2+ztUoPzFBRQGUIK8HbYStOF4a4RNpBjvgd+K
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=Nnxo_d0ia_o3i03ekMQA:9 a=ehB9Wzr-P5G7U_D2:21 a=-FWkPecTV8oPWxna:21
    a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeDJXdS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 19:33:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754296AbeDJXdR (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 19:33:17 -0400
Date: Wed, 11 Apr 2018 02:33:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 4.14 134/138] vhost: validate log when IOTLB is enabled
Message-ID: <20180411023210-mutt-send-email-mst@kernel.org>
References: <20180410212902.121524696@linuxfoundation.org>
 <20180410212917.818627954@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410212917.818627954@linuxfoundation.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 12:25:24AM +0200, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jason Wang <jasowang@redhat.com>
> 
> 
> [ Upstream commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ]
> 
> Vq log_base is the userspace address of bitmap which has nothing to do
> with IOTLB. So it needs to be validated unconditionally otherwise we
> may try use 0 as log_base which may lead to pin pages that will lead
> unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).
> 
> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
> Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/vhost/vhost.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1252,14 +1252,12 @@ static int vq_log_access_ok(struct vhost
>  /* Caller should have vq mutex and device mutex */
>  int vhost_vq_access_ok(struct vhost_virtqueue *vq)
>  {
> -	if (vq->iotlb) {
> -		/* When device IOTLB was used, the access validation
> -		 * will be validated during prefetching.
> -		 */
> -		return 1;
> -	}
> -	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used) &&
> -		vq_log_access_ok(vq, vq->log_base);
> +	int ret = vq_log_access_ok(vq, vq->log_base);
> +
> +	if (ret || vq->iotlb)

That's a bug, davem just queued a patch to fix this upstream.

> +		return ret;
> +
> +	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
>  
> 
