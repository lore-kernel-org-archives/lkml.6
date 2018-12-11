Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40B6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F74A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeLKSxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:53:50 -0500
Received: from namei.org ([65.99.196.166]:59022 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeLKSxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:53:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBBIrUwe012883;
        Tue, 11 Dec 2018 18:53:30 GMT
Date:   Wed, 12 Dec 2018 05:53:30 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Nayna Jain <nayna@linux.ibm.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2 7/7] ima: Support platform keyring for kernel
 appraisal
In-Reply-To: <20181208202705.18673-8-nayna@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812120553170.11653@namei.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com> <20181208202705.18673-8-nayna@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018, Nayna Jain wrote:

> On secure boot enabled systems, the bootloader verifies the kernel
> image and possibly the initramfs signatures based on a set of keys. A
> soft reboot(kexec) of the system, with the same kernel image and
> initramfs, requires access to the original keys to verify the
> signatures.
> 
> This patch allows IMA-appraisal access to those original keys, now
> loaded on the platform keyring, needed for verifying the kernel image
> and initramfs signatures.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
> Suggested-by: Serge Hallyn <serge@hallyn.com>


Reviewed-by: James Morris <james.morris@microsoft.com>

-- 
James Morris
<jmorris@namei.org>

