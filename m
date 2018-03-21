Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623928-2-9798718676873552433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623928; b=kxw4fTRftD1Y8xRQokJ2pMNijZXb4FAJNGFNkLBD3/V0lEi
    TlG7ja3T9WJTwhLnjI2//V915WZKobhUmiagMZs3FqaxTksoRKua0kT5vTW2ajqE
    rVaCk7ldCL5KDFAzatGxI71VAYpWyrjNSSbhPkkSqrzwKPXYQuyHupDneLy10Pbo
    bF4ATyYe0/BQ8darPy16S44Lho9wBcd84daUdvhylBFdDKN10nAAgCSDZdj0JESC
    4K83KlzoQRroBcgUmn17ATe6K41YF4n2gk5tXKB1G3i7QvKg7zihvx1/vLAJnCtd
    I5gI1vCRxqKEz9O+PW/bnQo/Vo5jBS2bBsfHnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623928; bh=4+AAmbIxt0XD4gJx0n6Ct8P98U
    qWATRT/6R83pnN/5c=; b=KnVcoXCMJkm2g833Z96m/TSPmgtd61+zQb1aG4Kogv
    yNIwCIBl2KiLV8F3hRaPt8EwcC8Pf4BTmbP83rIP2wZejBYKHSmrD6y4u4Sqceo4
    NT0dwQLMTthOiHdySvy9u6b9oRWdyw4VmFm/xTM0JGToyf3eVYAbuHWZI94THull
    4CALWpWfFMiGBZ5pwT7CdZjwwkFWiM/7KquDZJ0nltqsTxs2ubv3LOiyiXV84Gdi
    IMTY5UPpFTWlt4quQQcA7PynuvWUZNEYEJx6I+UpQrP4m6nvHAv/Z1c1USUW0+Ju
    Fn5cCR0ErLhJaWAzvhAhPRkoLi3eQxvbJk/AONtEH7mA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCUJSq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:18:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCUJSq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:18:46 -0400
Date: Wed, 21 Mar 2018 10:18:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] aio: add delayed cancel support
Message-ID: <20180321091842.GO14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-8-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:30AM +0100, Christoph Hellwig wrote:
> The upcoming aio poll support would like to be able to complete the
> iocb inline from the cancellation context, but that would cause
> a lock order reversal.  Add support for optionally moving the cancelation
> outside the context lock to avoid this reversal.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  fs/aio.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 0b6394b4e528..9d7d6e4cde87 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -170,6 +170,10 @@ struct aio_kiocb {
>  	struct list_head	ki_list;	/* the aio core uses this
>  						 * for cancellation */
>  
> +	unsigned int		flags;		/* protected by ctx->ctx_lock */
> +#define AIO_IOCB_DELAYED_CANCEL	(1 << 0)
> +#define AIO_IOCB_CANCELLED	(1 << 1)

BIT(0) and BIT(1)?

Anyway, not a big deal...

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
