Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4321902
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfBATUv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:20:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:25175 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfBATUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:20:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 11:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="114582532"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2019 11:20:49 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 1 Feb 2019 11:20:49 -0800
Received: from HASMSX110.ger.corp.intel.com (10.184.198.28) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 1 Feb 2019 11:20:46 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.55]) by
 HASMSX110.ger.corp.intel.com ([169.254.6.213]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 21:20:43 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: RE: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Thread-Topic: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Thread-Index: AQHUuiILqL/DhC1Ugk6fMR5NQMo3vKXLTG+Q
Date:   Fri, 1 Feb 2019 19:20:42 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA8E215@hasmsx108.ger.corp.intel.com>
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDcxMjQyNTktMmZkNC00MzYwLWFkNzgtZjNjYTFjM2U3ZTgzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieXhjWjdrUFJaSndlMlNzNXVKbUtNMUhNSXdhUVFZdm0yd1p4ZTFtMkFwdWVzNlhXblZkXC8rTFB1QkpEeVpka1AifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.254.159.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The current approach to read first 6 bytes from the response and then tail of
> the response, can cause the 2nd memcpy_fromio() to do an unaligned read
> (e.g. read 32-bit word from address aligned to a 16-bits), depending on how
> memcpy_fromio() is implemented. If this happens, the read will fail and the
> memory controller will fill the read with 1's.
> 
> This was triggered by 170d13ca3a2f, which should be probably refined to check
> and react to the address alignment. Before that commit, on x86
> memcpy_fromio() turned out to be memcpy(). By a luck GCC has done the right
> thing (from tpm_crb's perspective) for us so far, but we should not rely on that.
> Thus, it makes sense to fix this also in tpm_crb, not least because the fix can be
> then backported to stable kernels and make them more robust when compiled
> in differing environments.
> 
> Cc: stable@vger.kernel.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c index
> 36952ef98f90..7f47e43aa9f1 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -288,18 +288,18 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf,
> size_t count)
>  	unsigned int expected;
> 
>  	/* sanity check */
> -	if (count < 6)
> +	if (count < 8)
>  		return -EIO;
Why don't you already enforce reading at least the whole TPM header 10bytes, we are reading the whole buffer at one call anyway.
Who every is asking for 8 bytes from the protocol level, is doing something wrong.

>  	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
>  		return -EIO;
> 
> -	memcpy_fromio(buf, priv->rsp, 6);
> +	memcpy_fromio(buf, priv->rsp, 8);
Maybe a short comment will spare someone looking into git history 
>  	expected = be32_to_cpup((__be32 *) &buf[2]);
> -	if (expected > count || expected < 6)
> +	if (expected > count || expected < 8)
Expected should be at least tpm header, right?
>  		return -EIO;
> 
> -	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
> +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> 
>  	return expected;
>  }
Otherwise ready the first 8 bytes looks good. 
Thanks 
Tomas


