Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB7DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B9223C91
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uv1jc3lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B9223C91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934411AbeFVDZk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:25:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36754 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934292AbeFVDZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:25:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so2329167pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gFufw+TMpbj41ycv0j7cumx0hYzT0alev2jBL1/NrMM=;
        b=Uv1jc3lbUkFZ6kWBogTXkCAMiNQYRjFaUZQU9yaJHg67ve3SsZjCSQb/WFEFDy8CYr
         7Pk46qen334y6/nnSr1UxiF9H/vTm9L9DSVlhptwzFXOvMhK9UbSTUGHypWFgvIbH788
         cX+qu9kxkvUtpGXfCAJzK50LcL7ljP9wP0p0D9LvzdkqPdS0ye5//yFN/idv+HK2tGZK
         EAO1NDTszMIRqnu0pqGOnjYqFp3uQVhC7MTmYHg2NcGZf/f0iKpgajNatoECtlJ8LMu4
         QDJX7xNrGxnEOIKFD3zxQ35lGwMUo1SwHa3rLc/k2qpIORO+TsyC0eDBySME1o1Kvojc
         i3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gFufw+TMpbj41ycv0j7cumx0hYzT0alev2jBL1/NrMM=;
        b=N5nHT2qJrM/3kgpTmxkx2H6U+hyUe9j4svJBNUuWlhuf6Gw4X23PHxdW2VJMpBRzyc
         Ti5KTt5aRBdAy6oFh/9jSJxSaPrEJrWiFUhAOCNCCNpfUiu/h2mT2+DHrDXUp12jz5Sp
         djhViB4Mq6tKO6fouux/n6Bl7jaIQDnmX9bzF6sq1u94PnH6AdkEGhpX5cn4wDckUpTj
         1rFuA/LW3Zxup7qc+1PyndQEkcIXXTOAZyDFUV5VaI606S3cwxP0iSTkNXx6K6dkc/JM
         6er18/e05SZICMsl8Ou7QnXUZU9K3sybrKPCRolq1enYz/kw2KTQeqO2DrIigQwjKYCm
         cSiA==
X-Gm-Message-State: APt69E2qZba5Lsnwa8K1eAIAibp2cZUe+5uhLN5KrLAmG/WxyFFcAMvt
        2porLAeNVR2pjYStdId/K/oBIA==
X-Google-Smtp-Source: ADUXVKIn5k2F6Dd8bfv0tGuz/9tfKQw79XUHYR2G8XQTpqiwCVtBTbYPw0VhUs1+1SH0aSs5RjG/RA==
X-Received: by 2002:a65:5b4c:: with SMTP id y12-v6mr25165938pgr.442.1529637938449;
        Thu, 21 Jun 2018 20:25:38 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 74-v6sm11587025pfj.127.2018.06.21.20.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 20:25:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fWChc-0000Jw-HZ; Thu, 21 Jun 2018 21:25:36 -0600
Date:   Thu, 21 Jun 2018 21:25:36 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ima: Use tpm_chip_find() and access TPM functions
 using it
Message-ID: <20180622032536.GB19151@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-4-stefanb@linux.vnet.ibm.com>
 <1529614425.23843.20.camel@linux.vnet.ibm.com>
 <f4af7347-a9dd-1683-5c2c-faeb45750e2e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4af7347-a9dd-1683-5c2c-faeb45750e2e@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:59:55PM -0400, Stefan Berger wrote:
> On 06/21/2018 04:53 PM, Mimi Zohar wrote:
> >On Wed, 2018-06-20 at 16:42 -0400, Stefan Berger wrote:
> >>Rather than accessing the TPM functions using a NULL pointer, which
> >>causes a lookup for a suitable chip every time, get a hold of a tpm_chip
> >>and access the TPM functions using this chip. We call the tpm_chip
> >>ima_tpm_chip and protect it, once initialization is done, using a
> >>rw_semaphore called ima_tpm_chip_lock.
> >>
> >>Use ima_shutdown to release the tpm_chip.
> >>
> >>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>  security/integrity/ima/ima.h        |  3 +++
> >>  security/integrity/ima/ima_crypto.c | 12 ++++++++++--
> >>  security/integrity/ima/ima_init.c   | 19 ++++++++++++-------
> >>  security/integrity/ima/ima_queue.c  |  7 +++++--
> >>  4 files changed, 30 insertions(+), 11 deletions(-)
> >>
> >>diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> >>index 354bb5716ce3..53a88d578ca5 100644
> >>+++ b/security/integrity/ima/ima.h
> >>@@ -24,6 +24,7 @@
> >>  #include <linux/hash.h>
> >>  #include <linux/tpm.h>
> >>  #include <linux/audit.h>
> >>+#include <linux/rwsem.h>
> >>  #include <crypto/hash_info.h>
> >>
> >>  #include "../integrity.h"
> >>@@ -56,6 +57,8 @@ extern int ima_policy_flag;
> >>  extern int ima_used_chip;
> >>  extern int ima_hash_algo;
> >>  extern int ima_appraise;
> >>+extern struct rw_semaphore ima_tpm_chip_lock;
> >>+extern struct tpm_chip *ima_tpm_chip;
> >
> >ima_add_templatE_entry() synchronizes appending a measurement to the
> >measurement list and extending the TPM by taking a lock.  Do we really
> >need to introduce another lock?
> 
> This lock protects the ima_tpm_chip from going from != NULL to NULL in the
> ima_shutdown function. Basically, a global pointer accessed by concurrent
> threads should be protected if its value can change. However, in this case
> ima_shutdown would be called so late that there shouldn't be concurrency
> anymore. Though, I found it better to protect it. Maybe someone else has an
> opinion?

Why have a shutdown block? There is no harm in holding a kref if the
machine is shutting down.

Jason
