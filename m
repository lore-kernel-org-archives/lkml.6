Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D3BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037B02085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037B02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbeKGCMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:12:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40610 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389380AbeKGCMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:12:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so17623060qki.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mSE/CnPe+apf4nMSIKLe+8JhfT5FCMvi4o2vYS4TSPs=;
        b=EI8Nzk5JR5StFwBs9lxmFCMHiyzvzsAVk0gYeEucn7zutrxe5kOGV7rRZROOsidZT6
         0h2mat1sDQROipEukwu51+XJEcybGpdUAOB09TjSyjEXJ+7mcwH5omok2euRsj1fbrNO
         XRIA715yAVBEF2kqb2Q1hnDXDwTBA9pvXYoFyTIjtaixEI9ngzD6n3+7FL5Ul7qPfeen
         GWVKoicqpbOUBoBduXGOxgsJc/03phs962h5yV9lrd7+kbBEv7PvJbfnGFRdIbWsDEqo
         rHmm94mToyKqegQq8DUOZG78nhK0zfynfaZkdfT9oSBZAZK8vTvG1ZE8E9eJx9vT8lsg
         kLFA==
X-Gm-Message-State: AGRZ1gINwqQn8Y7yKsL3VRfouhRPh4J18SDzWilLWp/gQsv7n4EtS/9E
        SVOok4kShmQvQLKIPnQijRkWaQ==
X-Google-Smtp-Source: AJdET5d/YweaZXdpbK/QOjoP74919o1FYfXk3fZLvd5ruvQnPq09AYOq38X4mLqJlfeSSE0cFh7IuQ==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr24167785qkf.332.1541522765700;
        Tue, 06 Nov 2018 08:46:05 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id f19sm6308289qkh.20.2018.11.06.08.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 08:46:05 -0800 (PST)
Date:   Tue, 6 Nov 2018 09:46:03 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        Alexander.Levin@microsoft.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Message-ID: <20181106164603.w46wspmdj5e4slwe@cantor>
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

Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>

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
