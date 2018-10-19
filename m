Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB20AECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C4820843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cy+uNphZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C4820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeJTHPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:15:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeJTHPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XvCEkyluSs7jGXv7Lo56mq9keFZ/azWA2mq/i3R/8mY=; b=Cy+uNphZ1C4zjPmU87pSTWeAK
        H7ZTKyRsqu4WhkOJ30pugCBS7831mV3QM1cmb8CnINhb7qvLgMeD2yV8tNUO+m1xs009MQ635I6zw
        BHpzpatRi09XE9PvgBUSV4STjTdd1pVLWlUYC9S5qovA4oXCe5M5N8KcQCuG6xUeIPe9WHClUFvRx
        G2uZbq+Hlwo9/jMjsSWZYUXbjfUS0zAIOunCuQxQSGTxQMGTAJEuezNigYFEu7BtwwYPOMTcTX+0z
        WN403RmxgULlzIRyhNBOuCkSqcypZCk8c4j/2vtOGhe+dN5UqIvrFfCnx7Mb4HfkFa0vw4qrThww8
        /CVF0k3gg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDdrr-00010O-Iz; Fri, 19 Oct 2018 23:07:43 +0000
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
To:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, jejb@linux.ibm.com,
        Alexander.Levin@microsoft.com, jsnitsel@redhat.com,
        jmorris@namei.org, linux-kernel@vger.kernel.org
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a55a53a8-1308-aff3-afb8-6cbe0ffa1bee@infradead.org>
Date:   Fri, 19 Oct 2018 16:07:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019101758.1569-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Feel free to ignore my comments.  I don't know anything about TPM.

On 10/19/18 3:17 AM, Stefan Berger wrote:
> Extend the documentation for trusted keys with documentation for how to
> set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../security/keys/trusted-encrypted.rst       | 31 ++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 3bb24e09a332..6ec6bb2ac497 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -18,10 +18,33 @@ integrity verifications match.  A loaded Trusted Key can be updated with new
>  when the kernel and initramfs are updated.  The same key can have many saved
>  blobs under different PCR values, so multiple boots are easily supported.
>  
> +TPM 1.2
> +-------
> +
>  By default, trusted keys are sealed under the SRK, which has the default
>  authorization value (20 zeros).  This can be set at takeownership time with the
>  trouser's utility: "tpm_takeownership -u -z".

It appears to be TrouSerS or maybe just trousers (no ').

BTW, is this still the current location for it or has it moved elsewhere?
http://trousers.sourceforge.net/


>  
> +TPM 2.0
> +-------
> +
> +The user must first create a storage key and make it persistent, so the key is
> +available after reboot. This can be done using the following commands.
> +
> +With the IBM TSS 2 stack::
> +
> +  #> tsscreateprimary -hi o -st
> +  Handle 80000000
> +  #> tssevictcontrol -hi o -ho 80000000 -hp 81000001
> +
> +Or with the Intel TSS 2 stack::
> +
> +  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
> +  [...]
> +  handle: 0x800000FF

Is that handle value important?  It doesn't seem to be used later...

> +  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
> +  persistentHandle: 0x81000001
> +
>  Usage::
>  
>      keyctl add trusted name "new keylen [options]" ring
> @@ -30,7 +53,9 @@ Usage::
>      keyctl print keyid
>  
>      options:
> -       keyhandle=    ascii hex value of sealing key default 0x40000000 (SRK)
> +       keyhandle=    ascii hex value of sealing key

s/ascii/ASCII/g

> +                       TPM 1.2: default 0x40000000 (SRK)
> +                       TPM 2.0: no default; must be passed every time
>         keyauth=	     ascii hex auth for sealing key default 0x00...i
>                       (40 ascii zeros)
>         blobauth=     ascii hex auth for sealed data default 0x00...
> @@ -84,6 +109,10 @@ Examples of trusted and encrypted key usage:
>  
>  Create and save a trusted key named "kmk" of length 32 bytes::
>  
> +Note: When using a TPM 2.0 with a persistent key with handle 0x81000001,
> +append 'keyhandle=0x81000001' to statements between quotes, such as
> +"new 32 keyhandle=0x81000001".
> +
>      $ keyctl add trusted kmk "new 32" @u
>      440502848
>  
> 

ta.
-- 
~Randy
