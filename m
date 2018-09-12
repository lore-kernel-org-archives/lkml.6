Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F1C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C862146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C862146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIMACR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:02:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44551 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeIMACQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:02:16 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0AJI-0006bL-Rb; Wed, 12 Sep 2018 20:56:21 +0200
Date:   Wed, 12 Sep 2018 20:56:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V6 2/2] x86/efi: Add efi page fault handler to recover
 from page faults caused by the firmware
In-Reply-To: <1536693322-8335-3-git-send-email-sai.praneeth.prakhya@intel.com>
Message-ID: <alpine.DEB.2.21.1809122055190.1473@nanos.tec.linutronix.de>
References: <1536693322-8335-1-git-send-email-sai.praneeth.prakhya@intel.com> <1536693322-8335-3-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Sai Praneeth Prakhya wrote:
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index b18b2d864c2c..7455277a3b65 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -61,6 +61,11 @@ struct efi_runtime_work efi_rts_work;
>  ({									\
>  	efi_rts_work.status = EFI_ABORTED;				\
>  									\
> +	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
> +		pr_info("Aborting! EFI Runtime Services disabled\n");	\

This probaby wants to be pr_info_ince().

Other than that:

      Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
