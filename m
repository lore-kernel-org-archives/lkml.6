Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F39DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671BB2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671BB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbeKFGDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:03:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38131 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeKFGDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:03:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so17136750qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iQEet/EtCgZb43MJS3yHnoNwAZwN35U8MBKnqNMR3Js=;
        b=qmKkRJ1mjHpqxDbGp+xcx6kUXmve0WxpORahGvoTZ4e3ZZO8DaxWQBqGyxCfKQe1v5
         uz1WGHlQ0MWNuko3SA9vsjs7HgB2OsMXROvuXdU1VoZeFQfkCujFxuITMIB+Hdu/yjz9
         plfkogY3MSmOI3fqpe9cceaoA/DXir1cgMy83zWckkVilV1AkZA8R4MA0iKks9mgwDuS
         qkAvsjaSrgqAgKWzU1hyzMa0j9gUqu6ItsPrCksRfhcoCjU0GoV45l1ntGX10sge+Xk2
         l/Rgu4us5O+2oqVzQ852bL7OSZOJzICLeVCLyUz/wpW+aSKRbqkNdGvMWpw7+jlYmgPm
         Bh9A==
X-Gm-Message-State: AGRZ1gLpyfz69shoNqTcR3tfMqrPUYuK9I0OQQKqYX8NuDs9UHzpevV1
        /efWThR2CowKyuc11Xo6ST4/1RqXv3o=
X-Google-Smtp-Source: AJdET5c79Nb3gzrnEEvJ1LolaNqGsHReOHbvyHDp1SeZSDWbkm1zVAHZj4M8OIqNHP+mGQOYpeJaDQ==
X-Received: by 2002:a37:c891:: with SMTP id t17mr21478836qkl.31.1541450537811;
        Mon, 05 Nov 2018 12:42:17 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id j67-v6sm9874398qtb.38.2018.11.05.12.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:42:17 -0800 (PST)
Date:   Mon, 5 Nov 2018 13:42:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        Alexander.Levin@microsoft.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Message-ID: <20181105204215.hw6vme5epxcc3nch@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        Alexander.Levin@microsoft.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181019101758.1569-1-stefanb@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 19 18, Stefan Berger wrote:
>Extend the documentation for trusted keys with documentation for how to
>set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
>
>Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>---
> .../security/keys/trusted-encrypted.rst       | 31 ++++++++++++++++++-
> 1 file changed, 30 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
>index 3bb24e09a332..6ec6bb2ac497 100644
>--- a/Documentation/security/keys/trusted-encrypted.rst
>+++ b/Documentation/security/keys/trusted-encrypted.rst
>@@ -18,10 +18,33 @@ integrity verifications match.  A loaded Trusted Key can be updated with new
> when the kernel and initramfs are updated.  The same key can have many saved
> blobs under different PCR values, so multiple boots are easily supported.
>
>+TPM 1.2
>+-------
>+
> By default, trusted keys are sealed under the SRK, which has the default
> authorization value (20 zeros).  This can be set at takeownership time with the
> trouser's utility: "tpm_takeownership -u -z".
>
>+TPM 2.0
>+-------
>+
>+The user must first create a storage key and make it persistent, so the key is
>+available after reboot. This can be done using the following commands.
>+
>+With the IBM TSS 2 stack::
>+
>+  #> tsscreateprimary -hi o -st
>+  Handle 80000000
>+  #> tssevictcontrol -hi o -ho 80000000 -hp 81000001
>+
>+Or with the Intel TSS 2 stack::
>+
>+  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
>+  [...]
>+  handle: 0x800000FF
>+  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
>+  persistentHandle: 0x81000001
>+

Is that the correct option for tpm2_evictcontrol? What I'm seeing
in the versions I have is -S or -persistent= for specifying the persistent handle.

Other than that looks good to me.

> Usage::
>
>     keyctl add trusted name "new keylen [options]" ring
>@@ -30,7 +53,9 @@ Usage::
>     keyctl print keyid
>
>     options:
>-       keyhandle=    ascii hex value of sealing key default 0x40000000 (SRK)
>+       keyhandle=    ascii hex value of sealing key
>+                       TPM 1.2: default 0x40000000 (SRK)
>+                       TPM 2.0: no default; must be passed every time
>        keyauth=	     ascii hex auth for sealing key default 0x00...i
>                      (40 ascii zeros)
>        blobauth=     ascii hex auth for sealed data default 0x00...
>@@ -84,6 +109,10 @@ Examples of trusted and encrypted key usage:
>
> Create and save a trusted key named "kmk" of length 32 bytes::
>
>+Note: When using a TPM 2.0 with a persistent key with handle 0x81000001,
>+append 'keyhandle=0x81000001' to statements between quotes, such as
>+"new 32 keyhandle=0x81000001".
>+
>     $ keyctl add trusted kmk "new 32" @u
>     440502848
>
>-- 
>2.17.2
>
