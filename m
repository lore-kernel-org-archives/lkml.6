Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C253EC282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976172192C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBIUIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:08:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35153 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfBIUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:08:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so6440832qtk.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 12:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=caMuua86ZqM/hQ5LV4/Bwjrk9414QCn+/CUk1mK+b+g=;
        b=XHwgALscxbce0EHLB4BICT739NEqdIy18S0vYNyJ7Xzsdz12fMBjscJFekFrLLys0N
         CkbLOPA3DDERurN6Qk7Dl1E8jdW/CfHm+7nnWfq2XMkknTIAlCCJ/BIuF9/Eb6s5NIi4
         ot2TXwryyXLVZh6mOHTZb2GCN/Ab4C/q6BmwrUpH804Ejv78LEFRzjGo0gazMFJJjbfs
         z+RZ9DXz8eyS7ilZI1ECVKgpDa6kgDYPzgvf0txy1qjz3v7W48k+fu4xc5sQ/WaK947r
         gPjUIWcYZJlPxGPPK0q9uKPGYMilkyk67r96QJBYMxs/M34hSQ/zuJRRxb64ojXnjuNL
         GKDQ==
X-Gm-Message-State: AHQUAuYKveh3oDyzr7P25z611z5NqYyn9EkFX0ixYWb7pYYSiDkfy8lz
        94MYzhXtTl7uZdGhAlru+B41+A==
X-Google-Smtp-Source: AHgI3IYPk69QFI8kEVaL/meFbiMVI0MHnlyH5YDKJpcCxqpE6cz2mjf+mMA5179HD8wjCVCu0avMKg==
X-Received: by 2002:ac8:6b50:: with SMTP id x16mr22013636qts.368.1549742920468;
        Sat, 09 Feb 2019 12:08:40 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id s13sm6776655qkl.71.2019.02.09.12.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 12:08:39 -0800 (PST)
Date:   Sat, 9 Feb 2019 13:08:38 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v4 0/2] tpm: Unify send() callbacks
Message-ID: <20190209200838.2matnb5dqlnr4qdx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 08 19, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.co m>
>
>A portion of send() callbacks have returned length, in many cases just
>returning back what was given as an argument, and tpm_crb has returned 0 on
>success. This patch set fixes and unifies the behaviour.
>
>v4:
>* Return zero already in tpm_tis_send_main() so that it is applied to all
>  call sites of tpm_tis_send().
>* Fixup tpm_ibmvtpm_send() documentation.
>v3:
>tpm_tis_core fix was left out of the staging area :-(
>v2:
>The drivers tpm_nsc and tpm_infineon were forgotten. For this version I
>checked both with find and command and from Kconfig that everything that is
>supposed to be a driver directly interfacing with the TPM core, is included
>(e.g. discluding tpm_tis_spi).
>
>Jarkko Sakkinen (2):
>  tpm: Unify the send callback behaviour
>  tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete
>
> drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
> drivers/char/tpm/tpm_atmel.c         |  2 +-
> drivers/char/tpm/tpm_i2c_atmel.c     | 10 +++++++++-
> drivers/char/tpm/tpm_i2c_infineon.c  |  2 +-
> drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
> drivers/char/tpm/tpm_ibmvtpm.c       |  8 ++++----
> drivers/char/tpm/tpm_infineon.c      |  2 +-
> drivers/char/tpm/tpm_nsc.c           |  2 +-
> drivers/char/tpm/tpm_tis_core.c      |  2 +-
> drivers/char/tpm/tpm_vtpm_proxy.c    |  3 +--
> drivers/char/tpm/xen-tpmfront.c      |  2 +-
> 11 files changed, 22 insertions(+), 15 deletions(-)
>
>-- 
>2.19.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
