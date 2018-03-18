Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521413282-3-1523341406327423395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521413282; b=W3yaXf51yxa48s3QHd3HUxNkr++sc3NCC3Mp7RyIM3xZxKP
    XbEWnfI23tIwZjM8wj4Q8w0b33X84fLJgEKQmZu0rZvyWuX6j9xfuhaA+FjLsSCF
    aWbH18UD01UEn+QSXBrlduDokV86PWq4mKnUrmlQ10mW4S+xnTLo9q1HQUGiy3fP
    lK37AlZIIl8nqSZO0ZT9TTrERpYsgVlpP3ch+IQ+7dI1DjpmqDWt4Ey3ZgL19CyK
    4wjuYSjuj/hhWeZ3ftjgX2gE0oDzvOTWj9/cYErKzVBzEIz/COWk5ajg/7k5+pjX
    W5VPIb/wncKDAs5snUwLE2eXzonF3duvwM6eHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521413282; bh=ctq3JDsmXvdyy8n49xng7XzVXq
    wwHz3hqLEPdB5Jhxg=; b=ZKo54YvQSNmLt3S/sXJZp61Z3m8mD4QR6GtQgA/F8u
    NgZpuu1RSL3tmcNfuo+gvp80FgTz/mPPL92vjqrGX08nXWDhXNK/i8CSKw6nwQwU
    dKkjXxNyBhL8nl8/NEuMqEsLze24+SJ9pqLuFk9tuevCFcnQ2sdFQHhRE/cDkYt1
    2pwMQVx5gbqPCX47dIPUhRIKUBi6cnJaX4yFINwopAH+x7wVfITYSSSNNUgmT8ev
    RMUoANwDBveFD0I0pkXx+mda/LGcgdAzylG7zXE2whSt8ODxrb80MmAF2xSMKo7U
    eGOz6aY1LQTWcWaRdsKOzhiootPVTDWL8ZN9brc1Hz0g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ctqA1Lwb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UsbRrRxd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ctqA1Lwb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UsbRrRxd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbeCRWrq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 18:47:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43797 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbeCRWrn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 18:47:43 -0400
X-Google-Smtp-Source: AG47ELt04f4969ds7NkzFkPIK76lLGfKIUoOdiSh5/OjRU5m/WWPSOt+Y+OTEvKDzVi4jWvxjGCYWw==
Date: Sun, 18 Mar 2018 15:47:44 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Anup Patel <anup@brainfault.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] rpmsg: virtio_rpmsg_bus: fix rpmsg_probe() for
 virtio-mmio transport
Message-ID: <20180318224744.GL5626@tuxbook-pro>
References: <1515590217-24256-1-git-send-email-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515590217-24256-1-git-send-email-anup@brainfault.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 10 Jan 05:16 PST 2018, Anup Patel wrote:
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
[..]
> @@ -924,9 +925,16 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  				     total_buf_space, &vrp->bufs_dma,
>  				     GFP_KERNEL);
>  	if (!bufs_va) {
> -		err = -ENOMEM;
> -		goto vqs_del;
> -	}
> +		bufs_va = dma_alloc_coherent(vdev->dev.parent,
> +					     total_buf_space, &vrp->bufs_dma,
> +					     GFP_KERNEL);
> +		if (!bufs_va) {
> +			err = -ENOMEM;
> +			goto vqs_del;
> +		} else
> +			vrp->bufs_dev = vdev->dev.parent;
> +	} else
> +		vrp->bufs_dev = vdev->dev.parent->parent;

I really don't fancy the idea of us allocating on behalf of our
grandparent here, as you show it's not certain that our grandparent is
what someone originally expected it to be.

With the purpose of being able to control these allocations there is an
ongoing discussion related to this, which I believe will result in this
being changed to at least vdev->dev.parent..


I do expect that this discussion will be brought up during Linaro
Connect the coming week.

Regards,
Bjorn
