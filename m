Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2005596-1520009717-2-17842815507363728825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520009717; b=DjocbEjCUZeracGFz8a9mRIP9SRt4FEkwq4HuLLhkjpoYAu
    TTHAX9xnUl0NuXXfJPypReIr76Z1IvNF/Ythe5a1itYgngckmm4v8/6QcR9F1sOj
    hR+rf1k4Fs5WZvxt5r5J/r/tQrEny++JzO9zM9F5pBG8uwIBfHUVROW0pDJRtixo
    NBjSdd+13w/HLV/Awh0W3Cxvu6b+snIICfODlkGH0UNKz2NJPmM2JAoEyaV1D9Pr
    WUPJX1d9dNljy2RVy5c+6CNemsIZRPjm182KL5Y1/9hj5148vGWGQfXCGCA+KFEY
    EkQCQ18H57rbYSCK821aizA3S3FrA5P9VOtx/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520009717; bh=gUZr65ehp8+3IMVerHT2wV1+jk
    /IsYhsbj3LM5QE56M=; b=OsKS+yeNBmz1qbGTKrxjoyYzMImBd0HvpzjU17druZ
    wXyz/vSPv85yJJWF73Zx7Y3Vi9xhRiiEit9SlMsXmTV11WyuWtn6uubziXqHjjdT
    +dFCltrSlntr9yFmqo3s3Ua06ZNTKR/U8yWFffRC08wJP9hT1WpNRqy4KjTzDOgV
    HUgg+u1TG7EXTm3N/TRplQCwjd+XEmohqECH5nzqkeTr/+UonExdguzCl/QGP7Fu
    ilxUv/Ly8T7o2WJZqcMaHBPPEeW+dbBzm1kbzX2nbv1gKbrbcKd4ILLcASLRyGbR
    v/eNoOHKkVZCrxTfh+m9Rr+Z4ZvPgNstSqhmenuv2kNA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425736AbeCBQzA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 11:55:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423840AbeCBQy6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 11:54:58 -0500
Date: Fri, 2 Mar 2018 17:54:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Fix scatterlist elements size in spi_map_buf
Message-ID: <20180302165458.GC8704@kroah.com>
References: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 03:55:09PM +0100, Maxime Chevallier wrote:
> When SPI transfers can be offloaded using DMA, the SPI core need to
> build a scatterlist to make sure that the buffer to be transferred is
> dma-able.
> 
> This patch fixes the scatterlist entry size computation in the case
> where the maximum acceptable scatterlist entry supported by the DMA
> controller is less than PAGE_SIZE, when the buffer is vmalloced.
> 
> For each entry, the actual size is given by the minimum between the
> desc_len (which is the max buffer size supported by the DMA controller)
> and the remaining buffer length until we cross a page boundary.
> 
> Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/spi/spi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
