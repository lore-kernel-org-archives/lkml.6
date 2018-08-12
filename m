Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4D1C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341C821A0A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341C821A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeHLMug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:50:36 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45547 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeHLMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:50:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so22656574oic.12;
        Sun, 12 Aug 2018 03:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hv836ykTFyIPOTStksy5CgZouVn3JayzASEjtWbmT78=;
        b=dnaSQCcwHZaYCRK+l3K0CEJ/hdkHxK15gDjf/KT2OcIDg8R0PZfTsxxHDAb7j2XNmq
         wpEqfDqjkyxfcoJxFrJtbKKnwq9bRxf7gClxUQLdU+DjfZDI+jc5swrFBMZe3EZxhIYY
         m9GnqwtD3Z7b+iTlcrLnyF+8uqtRvNAk87rNOgaxCwQw+oHnflOfYSEKngtp0y+XKMKs
         COyx/ZhQqctRuTJXhE7I/EMfekl8/KVaz9AngYIOyy9kv/j4cv/u7eKyu7nkZkAvdRau
         aLQ1I2qrPik+YjP23AKKu2EXnvmdj+eKya3SYMA/8gSuojPVTeDCu3oQhQNSXJO70jI+
         q+JA==
X-Gm-Message-State: AOUpUlFRGIlPlWAJGVaCLShHGZcaVgsazwROa/LO93rW3cqveBw83KcB
        AQCSwszbHjExxfOZibjucP8UhATGsBFhyxLQSCU=
X-Google-Smtp-Source: AA+uWPzYenAJSnilqPSW8PREC3lTAcW4iyLrREbipdGVi6ABSc888W0JE7JxbOXPy7KgkcvoPCVXFUoQRsUqEpixsyE=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr14752008oih.227.1534068785196;
 Sun, 12 Aug 2018 03:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533989492.git.puwen@hygon.cn> <e282c406c34d5cdc92f7ec0bc12e9406405544d8.1533989493.git.puwen@hygon.cn>
In-Reply-To: <e282c406c34d5cdc92f7ec0bc12e9406405544d8.1533989493.git.puwen@hygon.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 12 Aug 2018 12:12:54 +0200
Message-ID: <CAJZ5v0i=KMjQEqkJmO-XSgnjTUYBepXzOTohQV62sUqXLi+QJw@mail.gmail.com>
Subject: Re: [PATCH v3 14/17] driver/acpi: enable Hygon support to ACPI driver
To:     puwen@hygon.cn
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 3:36 PM Pu Wen <puwen@hygon.cn> wrote:
>
> For Dhyana processors have NONSTOP TSC feature, so enable the support
> to ACPI driver.
>
> Signed-off-by: Pu Wen <puwen@hygon.cn>

This patch is fine by me, but I'm assuming that the series will be
handled as a whole, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_pad.c       | 1 +
>  drivers/acpi/processor_idle.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 552c1f7..a47676a 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -70,6 +70,7 @@ static void power_saving_mwait_init(void)
>
>  #if defined(CONFIG_X86)
>         switch (boot_cpu_data.x86_vendor) {
> +       case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
>         case X86_VENDOR_INTEL:
>                 /*
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index abb559c..b2131c4 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -205,6 +205,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
>  static void tsc_check_state(int state)
>  {
>         switch (boot_cpu_data.x86_vendor) {
> +       case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
>         case X86_VENDOR_INTEL:
>         case X86_VENDOR_CENTAUR:
> --
> 2.7.4
>
