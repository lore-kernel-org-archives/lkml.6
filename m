Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE90C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AABC2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgwYlEwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AABC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeK1TXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:23:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35314 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1TXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:23:02 -0500
Received: by mail-io1-f65.google.com with SMTP id u19so19282091ioc.2;
        Wed, 28 Nov 2018 00:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=siM6v/1L68XdJs+wF5i4ZFk7Kgv0czl2Db4weIXjO5w=;
        b=sgwYlEwVglaiaiiFIdcSYTwwe9HtwUoyC32lg6kXTRUbi0Shfsz7COLnW15AOh0P+R
         +ccNacU8lIy+acSAzlFpM/dR+i0pSgfb3Avgiugh8mLH08dnuqyidFnzPCcWDB7fuRlY
         0Ato5wkBYMnJUnZIYTrgWeLzYbmoBl1UjIEkT4zIhLK826em6mYDv5DPcGkRxpOvkqiH
         A0nX3ECr5GPVGf0f+wcGkfAh2hKRm2AJc2b876xFsOFq9CphvoaYf+wQz1KOmE/I6oOL
         hLxSkxSWpS72X2/Lp9f62coRqy1HzbzJEMPqI9cYMntG++jSlvjsbOfrkKRxMZfu5XW3
         yiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=siM6v/1L68XdJs+wF5i4ZFk7Kgv0czl2Db4weIXjO5w=;
        b=nNn+d/b7/Kz0/5uWwjakoJVrSLfK0Fn8mrFHzF3icc+3uCqB8PPQ8bGUx6b++j0RRB
         S51E6odIGzWpx3i+uK0tzmHI0oBb/YIHrUbot+2qxKAxE2LPf9Y6JDZprZO/LJp4Nff4
         WL4fQbQEHkb6n2m+avBg2q0Hx5sAUiPI1aOzfhjGVmF0UnTjaDVlEA3kFQky4SAstXiU
         WGNojPu/fJi54EZXS8Ci+6cai2iZyEeAC0O/WaEVg8heLhw3i0qF98sJ0FflPGORL2Yp
         BYBKhdxe6wqRipdp8/9dUqDfWgSN85anrW+y7hU0GsaZX4p/Tne7SK/TPXoxvU75Qi7o
         0Tow==
X-Gm-Message-State: AA+aEWZEYvmpT1tontr/ixMSTq4GslENTQr151Ck5caRBuTHwKefq540
        jO2lKogdnSZrPWi81OYXWOG+0orh
X-Google-Smtp-Source: AFSGD/W5aeVbaDz2kXdxOpdtFhzg/7zgEgad1B4gqgzb+WivODN634KY2hOAvpDDBSBs/PRGeibynA==
X-Received: by 2002:a5e:d607:: with SMTP id w7mr27613046iom.75.1543393334501;
        Wed, 28 Nov 2018 00:22:14 -0800 (PST)
Received: from Schmitz-MBP.telecom (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.googlemail.com with ESMTPSA id x3sm2122207ion.9.2018.11.28.00.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 00:22:13 -0800 (PST)
Subject: Re: [PATCH 02/41] scsi: NCR5380: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <8b4ef418aa7803199954100fd89717f38d61ae06.1543374820.git.gustavo@embeddedor.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <0caad885-94ad-9226-fbf1-996b5d465473@gmail.com>
Date:   Wed, 28 Nov 2018 21:22:04 +1300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8b4ef418aa7803199954100fd89717f38d61ae06.1543374820.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo,


Am 28.11.18 um 17:24 schrieb Gustavo A. R. Silva:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced "Fall through to reject message"
> with a "fall through" annotation at the bottom of the case, which is what GCC
> is expecting to find.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/scsi/NCR5380.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index 01c23d27f290..12073e52a0eb 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -1933,12 +1933,11 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>  					if (!hostdata->connected)
>  						return;
>  
> -					/* Fall through to reject message */
> -
>  					/*
>  					 * If we get something weird that we aren't expecting,
>  					 * reject it.
>  					 */
> +					/* fall through */
>  				default:
>  					if (tmp == EXTENDED_MESSAGE)
>  						scmd_printk(KERN_INFO, cmd,
I believe the 'if we get something weird' comment block relates to the
default branch of the switch, _not_ the fall through from the case above
(extended message received that we end up rejecting). Ordering the
comments like you did just for GCC's sake is misleading.

The comment block should perhaps be moved after the default label. And
it would be nice if the reason for the fall through could be retained in
the comment.

Cheers,

    Michael



