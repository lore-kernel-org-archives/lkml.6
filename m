Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB72C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E8320811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfBEPTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:19:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56770 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfBEPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:19:05 -0500
Received: from mail-yb1-f199.google.com ([209.85.219.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gr2V5-0004xN-52
        for linux-kernel@vger.kernel.org; Tue, 05 Feb 2019 15:19:03 +0000
Received: by mail-yb1-f199.google.com with SMTP id e10so1592892ybr.18
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xj37CtNcS/y5pi4Gq6YdkdO+q+j/uv4oSoSjroFz6HI=;
        b=RPMh4VJN0Vs95VNPvRJzXIsFJw515Pr24QiZHvLQsmUkUc3KiIpn+FFcuG9XUXl7qp
         J/76t+Mi8mUaRrIDxMRG8KWUJunFY7XI8AtdVTOcsdWW2EWtZn0GowCNtwNX0+4Bdr3Y
         y71ouCEOEs+KUxR2TSI/i6QFJReugIbKx5AjUX3TZ8BUp78HEKK/i2FSwSPk467RK0PJ
         vs17JSvp+78nmR5M2AxArH0M6acMnEaImJ7nFZRHMLNAsgLYvzBrUUWqXALU623ZsFqj
         rFAThrjCTip/ubsxHW1ECbL/2LsnrqqNcbWt1ICpV6azde5z4THScUEsIi5ygslz61Eb
         6JNQ==
X-Gm-Message-State: AHQUAuak6PWO3W0FDSjQ7SadlVB3856RjtxF//Zhg6wZ4zpQtxqRA+tz
        k2bhEMfXXdrnJZh6KftHgQkxJTioCmGACIpo65H2uM4fp2ZrLMqTctqyQZKR5Fshw+c92ZT0aZO
        GjLswy9IRUpULJZZ2rLLBuSzV/CO77zPxStOwAaeNhg==
X-Received: by 2002:a25:2fc6:: with SMTP id v189mr4327473ybv.121.1549379942001;
        Tue, 05 Feb 2019 07:19:02 -0800 (PST)
X-Google-Smtp-Source: AHgI3IY7S0RpTDRGdHQDsUVkaz7/giuZ+rR/DJC16+6c1ojJ9/HgzvMs3KUBAoSM31CKWjr5HnACCg==
X-Received: by 2002:a25:2fc6:: with SMTP id v189mr4327413ybv.121.1549379941393;
        Tue, 05 Feb 2019 07:19:01 -0800 (PST)
Received: from localhost ([2605:a601:ac2:fb20:2df6:439b:8b17:3e1f])
        by smtp.gmail.com with ESMTPSA id f188sm1418274ywc.70.2019.02.05.07.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 07:19:00 -0800 (PST)
Date:   Tue, 5 Feb 2019 09:18:59 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/ima: require signed kernel modules
Message-ID: <20190205151859.GD16362@ubuntu-xps13>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> Require signed kernel modules on systems with secure boot mode enabled.
> 
> To coordinate between appended kernel module signatures and IMA
> signatures, only define an IMA MODULE_CHECK policy rule if
> CONFIG_MODULE_SIG is not enabled.
> 
> This patch defines a function named set_module_sig_required() and renames
> is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
> call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
> being enabled.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

With respect to interactions with the kernel lockdown patches, this
looks better than the patches I saw previously. I don't feel like I know
enough about what's going on with IMA to ack the patch, but I feel
confident that it's at least not going to break signature enforcement
for us.

Thanks,
Seth

