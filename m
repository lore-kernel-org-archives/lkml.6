Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DFAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9032438B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aB84GOCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9032438B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeFVOT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:19:58 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35823 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbeFVOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:19:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id i7-v6so3048991pgp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DL2snFnUYDhEUFTrgOuSuPeD9xlt+4TCtjgL/JVlCMA=;
        b=aB84GOCSCty3NcGHBX/l9SqAOOWOZapV3ISnyySoeOw7gFCQrFrWu0+qJVhVk55cBm
         /93tDy/68UeEwi5g8qtHd7gQcmXvqEOLPzrcXSok5Fcezf7aM5tFxj3zde3sHsew2z2t
         3jDCzGgT7RkqDL2NEL2RwyhHhYVbjtilrUITPVHiyuN8DTEcVqbjIOh0tH4qFahRydMA
         o6LEjSwa5FRiZMXfgfm0/Sinun2XtA3z9L3boA3y1HXvECKD2x9vyierw4qFHAvO3fpk
         u4C+8VFRmCPM/BmdM1ngEdsPWmKk/mZTi5n8FxrBQ2JcFPlXB2bQFeNOKToZok40ysAA
         pfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DL2snFnUYDhEUFTrgOuSuPeD9xlt+4TCtjgL/JVlCMA=;
        b=ipvTURMagYc+bUQOECDayYu4lWuklGVSKa4LUStHNB2xKlbWqrsBbEtnUuhV5/C35f
         lOlN1GGbRrw2Z1JMDIjjcJ4GYirUEqUMpjHtLGg0fDFoj6Myy9pkoZBKkkaXqzjB6Pq4
         iQs/JpbaRNKcSJim7k0+lIW6gv9BsDTFVR+t6/23HkZYeUBdndW7NEDXxwlAw4w0zW5N
         MP9DkQwwHLGEH/KoVXyv480xW6TW1LKxQ0eYG2IbhJMN5ilHihWFQBGMCxBoxDyvibL8
         i/w2ZdO8Bz4rQEP1fIDoRf+JURL+jG8zH6X7YDTgJ1WDlBwbZF1hzmPtWygEzw64ppXI
         1/9A==
X-Gm-Message-State: APt69E25HNiVK8ruvCeRqB2ehykTIBsqbapb+bdZMLljQZ6phV+lKzbl
        VClVlULcFs+nY7lv97lMF9CLqw==
X-Google-Smtp-Source: ADUXVKIBMhHlCSFcxkRxZm1iklwEmwr7UJ2U3C9V6sJPGOR+W+1uYBl8A0lkJU8CJZ5vYYSffPKOMg==
X-Received: by 2002:a63:715d:: with SMTP id b29-v6mr1631215pgn.325.1529677193493;
        Fri, 22 Jun 2018 07:19:53 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 10-v6sm17585068pgb.40.2018.06.22.07.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 07:19:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fWMul-0004iZ-Sl; Fri, 22 Jun 2018 08:19:51 -0600
Date:   Fri, 22 Jun 2018 08:19:51 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ima: Use tpm_chip_find() and access TPM functions
 using it
Message-ID: <20180622141951.GC19151@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-4-stefanb@linux.vnet.ibm.com>
 <1529614425.23843.20.camel@linux.vnet.ibm.com>
 <f4af7347-a9dd-1683-5c2c-faeb45750e2e@linux.vnet.ibm.com>
 <20180622032536.GB19151@ziepe.ca>
 <495fdcf7-b5b9-0341-796b-66fdf537811b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <495fdcf7-b5b9-0341-796b-66fdf537811b@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 07:40:37AM -0400, Stefan Berger wrote:
> On 06/21/2018 11:25 PM, Jason Gunthorpe wrote:
> >On Thu, Jun 21, 2018 at 04:59:55PM -0400, Stefan Berger wrote:
> >>On 06/21/2018 04:53 PM, Mimi Zohar wrote:
> >>>On Wed, 2018-06-20 at 16:42 -0400, Stefan Berger wrote:
> >>>>Rather than accessing the TPM functions using a NULL pointer, which
> >>>>causes a lookup for a suitable chip every time, get a hold of a tpm_chip
> >>>>and access the TPM functions using this chip. We call the tpm_chip
> >>>>ima_tpm_chip and protect it, once initialization is done, using a
> >>>>rw_semaphore called ima_tpm_chip_lock.
> >>>>
> >>>>Use ima_shutdown to release the tpm_chip.
> >>>>
> >>>>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>>>  security/integrity/ima/ima.h        |  3 +++
> >>>>  security/integrity/ima/ima_crypto.c | 12 ++++++++++--
> >>>>  security/integrity/ima/ima_init.c   | 19 ++++++++++++-------
> >>>>  security/integrity/ima/ima_queue.c  |  7 +++++--
> >>>>  4 files changed, 30 insertions(+), 11 deletions(-)
> >>>>
> >>>>diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> >>>>index 354bb5716ce3..53a88d578ca5 100644
> >>>>+++ b/security/integrity/ima/ima.h
> >>>>@@ -24,6 +24,7 @@
> >>>>  #include <linux/hash.h>
> >>>>  #include <linux/tpm.h>
> >>>>  #include <linux/audit.h>
> >>>>+#include <linux/rwsem.h>
> >>>>  #include <crypto/hash_info.h>
> >>>>
> >>>>  #include "../integrity.h"
> >>>>@@ -56,6 +57,8 @@ extern int ima_policy_flag;
> >>>>  extern int ima_used_chip;
> >>>>  extern int ima_hash_algo;
> >>>>  extern int ima_appraise;
> >>>>+extern struct rw_semaphore ima_tpm_chip_lock;
> >>>>+extern struct tpm_chip *ima_tpm_chip;
> >>>ima_add_templatE_entry() synchronizes appending a measurement to the
> >>>measurement list and extending the TPM by taking a lock.  Do we really
> >>>need to introduce another lock?
> >>This lock protects the ima_tpm_chip from going from != NULL to NULL in the
> >>ima_shutdown function. Basically, a global pointer accessed by concurrent
> >>threads should be protected if its value can change. However, in this case
> >>ima_shutdown would be called so late that there shouldn't be concurrency
> >>anymore. Though, I found it better to protect it. Maybe someone else has an
> >>opinion?
> >Why have a shutdown block? There is no harm in holding a kref if the
> >machine is shutting down.
> 
> Looking around at other drivers' usage of the reboot notifier, I find other
> drivers as well that use spinlocks or mutexes during the shutdown. Besides
> that, we do have the shutdown block already when device_shutdown calls
> tpm_class_shutdown() and we get the ops_sem.

But the shutdown handler in TPM an actual purpose, we are doing
something to the persistent state in the TPM itself during shutdown.

I can't see why IMA needs a shutdown handler. You shouldn't add one
'just because'

Jason
