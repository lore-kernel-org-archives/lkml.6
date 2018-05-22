Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827271-1527008411-2-11422146724590090843
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roenda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527008411; b=bZ9x3oQSiLddWDOjojhDltcHHpZHB60UMbRFuj0F29Gyz8kT47
    U3E5KKO3XFGBX+nvv59awjuGSLqvIW+na5q9husmBZr7IsPBRJFmQAbD3amYQPAM
    Fv4k+B3OUwiCTah1rTqOulR+cZRPj/XZ0iSZSfvJ6j4i/xY9Dnv4Y4V0IK6QKadt
    8r7Qy/QofbRuHaVMftxPo67MhiESriL/L3nvKfFNuvDIQazZs1QLaDeCUGfLVPfh
    Gws6dkFIL6g1kv+rZJA6iztbaI6koYoGuwvSEzTceUVRwJfYDSKuPz2S4qxwuc+z
    RbaYYkUiDM41IF1gDqIKuZfsacgHuAHK5D3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527008411;
    bh=sBjNmUyVEnnxQJBFVSev8jPQOcbE0+RczUKLT4P+EZo=; b=X4AaDl+Wj8hl
    /7+pTJ4gmc1QBgz+UCO2Kuo9tRMl7MpET8kHsL2ZJ/iU9HW1mgtiNnKhOIhamwc0
    3ihRVlU30oKVOboczDvR8hN0V1hoKCTWdzcUWDerJLKlvublWbstPplvvDR/dRQj
    1sVcuNsmE0g8ckuVolamafl7FDAk0K5m5TB9DtpYtdzyDrtB1SbiY5PSPzagWKDb
    2IKpl30XNfzK4NBpEai8Y3NZq7bYSTbbIK/eBdmcD2Piwj/7l3wDEjzUStcTmoHn
    E6D9LPTASVBjPLE1UdKCHMeSYync3MmK0UHOAa8C4eiXz141qoJfmq667oJJxXTm
    XkG0+PpZNQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=cogentembedded-com.20150623.gappssmtp.com
    header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=Nc3r3KkJ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=EQu/Fyj5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cogentembedded.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=cogentembedded-com.20150623.gappssmtp.com
      header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=Nc3r3KkJ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=EQu/Fyj5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cogentembedded.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJiQ52Pc8qRzqu5mDbWPrY2gh0p80Uh0xFSVsZyQgoWf/ibBdhBEhj94U+XWXChOi8xSUKWd1ws8fRiWxB/g8FSy2fFPEkeUW/idTyl86oVlM7W8/76g
    FqRqU6Rkq4Z4s8egNAUxTxcgH/CBZm2SJ05KDxsgNgwVMt6gxWuXJNlKmxJf3tyMdF86QXw+HVxaUrQZ/lC3ZAw4WD0deSjlp9/1DFKqd7jLAa8KhgGOr0Qh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=HYoMzZx8KD6dLKicvQQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEVQ7q (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:59:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54973 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeEVQ7n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 12:59:43 -0400
X-Google-Smtp-Source: AB8JxZr1CuLOykO5VxxvUef/VWzbxW5bL66Ixkmk7vVoClK0M641yqpYjonNRs1Jnuew6wDV+HgJ/Q==
Subject: Re: [PATCH 30/31] timerfd: convert to ->poll_mask
To: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180522113108.25713-1-hch@lst.de>
 <20180522113108.25713-31-hch@lst.de>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <77dea8cf-d7e0-75ff-91c4-3bd0379e7464@cogentembedded.com>
Date: Tue, 22 May 2018 19:59:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180522113108.25713-31-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 05/22/2018 02:31 PM, Christoph Hellwig wrote:

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/timerfd.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/timerfd.c b/fs/timerfd.c
> index cdad49da3ff7..d84a2bee4f82 100644
> --- a/fs/timerfd.c
> +++ b/fs/timerfd.c
> @@ -226,21 +226,20 @@ static int timerfd_release(struct inode *inode, struct file *file)
>  	kfree_rcu(ctx, rcu);
>  	return 0;
>  }
> -
> -static __poll_t timerfd_poll(struct file *file, poll_table *wait)
> +	

   Stray tab detected! :-)

> +static struct wait_queue_head *timerfd_get_poll_head(struct file *file,
> +		__poll_t eventmask)
>  {
>  	struct timerfd_ctx *ctx = file->private_data;
> -	__poll_t events = 0;
> -	unsigned long flags;
>  
> -	poll_wait(file, &ctx->wqh, wait);
> +	return &ctx->wqh;
> +}
>  
> -	spin_lock_irqsave(&ctx->wqh.lock, flags);
> -	if (ctx->ticks)
> -		events |= EPOLLIN;
> -	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +static __poll_t timerfd_poll_mask(struct file *file, __poll_t eventmask)
> +{
> +	struct timerfd_ctx *ctx = file->private_data;
>  
> -	return events;
> +	return ctx->ticks ? EPOLLIN : 0;
>  }
>  
>  static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
[...]

MBR, Sergei
