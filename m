Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B685C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A3E218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeLRRNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:13:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32944 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeLRRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:13:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so7634645wmh.0;
        Tue, 18 Dec 2018 09:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IQhfY5INzjr4C44djkoAfq1J8x/wxrc+DdJ8P9ZZbC8=;
        b=h/vQ5KR/XJfzWUwRItKyEi364dMGFAcqQj1m2ypDXqW8mkjG3NqICg09Hnzq23+sOq
         csruTaBEv8e9rlyI1NNze0QTNBzRjSXyDEYSHDbiRxgZjBybDqfn9e1j6OpyMdfucb+5
         iITyHVvOzadkUyvw8mgt9tbzLSyzuXgMIYpkNMNDnwbNAa79fsrAJQIh+pxmCNJc9/F8
         e0wzNluVdpJfyGLj44Gu5UFOBrhouQBKDA0oLjF8VKyumZWHVP7ELWLp4TkazKM0QNBA
         7JEAzrg/ZgLASXL8qbpMyJU6b+MmlDEB5Q0qy2QMqhtXifWaW8tTDN4yvAl047jjpeWx
         ciBg==
X-Gm-Message-State: AA+aEWbaKPm5myYyqwTuWXa/1AaB1nzpLtd0gm2fkcmkRGJmyhEGSwhi
        q5g/DcFYy5Eh9aOX/JfIDAeepOUL
X-Google-Smtp-Source: AFSGD/VrZiCEd1GpmRHKx11A152dsPIG6AZJFThvCXwIKBZdIfdAIDFypmPsjz1mbIqf5SGf1Sq0Lg==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr3977075wmd.110.1545153227970;
        Tue, 18 Dec 2018 09:13:47 -0800 (PST)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id j14sm3058314wrv.96.2018.12.18.09.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 09:13:47 -0800 (PST)
Subject: Re: [PATCH 33/41] scsi: osd: osd_initiator: mark expected switch
 fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <09026c2661bf3c4bcf41dbb265cf1dae2c3487fd.1543374820.git.gustavo@embeddedor.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <ee906c63-72cd-8d3c-d5c8-50dc59d984d8@electrozaur.com>
Date:   Tue, 18 Dec 2018 19:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <09026c2661bf3c4bcf41dbb265cf1dae2c3487fd.1543374820.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/18 06:32, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

ACK-by: Boaz Harrosh <ooo@electrozaur.com>

> ---
>  drivers/scsi/osd/osd_initiator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
> index 60cf7c5eb880..cb26f26d5ec1 100644
> --- a/drivers/scsi/osd/osd_initiator.c
> +++ b/drivers/scsi/osd/osd_initiator.c
> @@ -1849,6 +1849,7 @@ int osd_req_decode_sense_full(struct osd_request *or,
>  					32, 1, dump, sizeof(dump), true);
>  			OSD_SENSE_PRINT2("response_integrity [%s]\n", dump);
>  		}
> +		/* fall through */
>  		case osd_sense_attribute_identification:
>  		{
>  			struct osd_sense_attributes_data_descriptor
> @@ -1879,7 +1880,7 @@ int osd_req_decode_sense_full(struct osd_request *or,
>  					attr_page, attr_id);
>  			}
>  		}
> -		/*These are not legal for OSD*/
> +		/* fall through - These are not legal for OSD */
>  		case scsi_sense_field_replaceable_unit:
>  			OSD_SENSE_PRINT2("scsi_sense_field_replaceable_unit\n");
>  			break;
> 

