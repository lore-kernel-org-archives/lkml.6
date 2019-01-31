Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F32084A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2Au2Wuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfAaTJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:09:13 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44977 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfAaTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:09:13 -0500
Received: by mail-yb1-f193.google.com with SMTP id k189so1740635yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8fjBnAJZSl8AF6MC9WwDmKLAQD48z+2Z7E1HHoPggk=;
        b=U2Au2Wuu/oZZJ6BoFB8Ko6gv5XNheS6jLlO6wJFfDGW9jF7yfRPNLfKz4JoCoybXHC
         ayzos/2N9500wuznC9aX3Jk10EvWm/h8NzUw0KQ/PFWC9WZYOeSXo4CkllQ1gP9D0oJS
         avhJuWANE4gALiqiksxGA1xYQJd/DR6OMRKGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8fjBnAJZSl8AF6MC9WwDmKLAQD48z+2Z7E1HHoPggk=;
        b=Yl/TUm62JmemzHhr57Eht5t9g8ULyGRRNKA8mdEHphL1fW4PCLESt2bSbR5TGKQLvn
         qRCWCjFPFqODaDZrOKHc/xIo06/8LS2wgXgfDpf2OU3zCtnLAQXxC+gga2a3FnoRPAQa
         kDpxlUFquN2YyQcC6N8c8WBOb+pzGc3v5H+C16lJuGHUu1WXeNcrFV74d98/rlIWoE+/
         gneREHCVMqcIit4SJCeQdCCBQs7xFz5oiUhvSQ17h6n9vEbS0Cb1w60I8mnY5Aj75BuO
         VHbKSzNOTN4Qwm6S6Fjxi7UiKMIgJJKX8Vt4wbT/1l51K1z9i2PIzsP997rTIWTJ4i+T
         e9GA==
X-Gm-Message-State: AJcUukeI5mhcXspb/7tRTUtuyXDifqdXhUsO1PYw6VfqXnnvtt0PFEAg
        FAKaDnHbAs5WCl5lkbBYzfArZ6dG+Hf6S2szAfnTcg==
X-Google-Smtp-Source: ALg8bN4Nh2VccqiZgz4stkHucHy5ELWyU2xFXPDcLXZpR3HBaIYNhebQ04q2r+xa5q0hIzSuH2f/Sh2W4LbLC+NlxJc=
X-Received: by 2002:a25:ba84:: with SMTP id s4mr35249543ybg.325.1548961752339;
 Thu, 31 Jan 2019 11:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20190108092654.13113-1-anders.roxell@linaro.org>
In-Reply-To: <20190108092654.13113-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 31 Jan 2019 20:09:01 +0100
Message-ID: <CADYN=9LXeLv=cxJSJmWLybHqDhDx=nG3arfc32cjwB42iSb7vA@mail.gmail.com>
Subject: Re: [PATCH] selftests/kvm: add missing executables to .gitignore
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 10:27, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Fixes: 2a31b9db1535 ("kvm: introduce manual dirty log reprotect")
> Fixes: 7edcb7343327 ("KVM: selftests: Add hyperv_cpuid test")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/kvm/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 6210ba41c29e..51ffd8a8bc38 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,8 +1,10 @@
>  /x86_64/cr4_cpuid_sync_test
>  /x86_64/evmcs_test
> +/x86_64/hyperv_cpuid
>  /x86_64/platform_info_test
>  /x86_64/set_sregs_test
>  /x86_64/sync_regs_test
>  /x86_64/vmx_tsc_adjust_test
>  /x86_64/state_test
> +/clear_dirty_log_test
>  /dirty_log_test
> --
> 2.20.1
>

Does this make sense or should I redo it?

Cheers,
Anders
