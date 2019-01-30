Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D57C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3782087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnbgL1au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfA3QDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:03:46 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39556 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730990AbfA3QDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:03:19 -0500
Received: by mail-vk1-f193.google.com with SMTP id s184so7605vkd.6;
        Wed, 30 Jan 2019 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lp6uXM/TfIp0Qie0v7D1DfEWMwi5ctpf7VE7GYw6ryk=;
        b=SnbgL1auqrzxR6ZHfDKlPpLxtsIf8ozGrHh1AmhLF7M/SPrYojUQonCdzoTk3WUrYv
         NxpxzM72R2ywLRXZAyJmSXn7183H4UFncQBoXMOOpsTIi6//9Z9kKd9K+uKIFta4B7YO
         91jEtRy8Ob0pl+zWw0qO78vNULvLcue+3CXEnFLEytb5QUSVlVQnHpKUnC+R/Ush7X7C
         Bt03idpWLvetJak+yXNgmvPyuvT8+7aII0OTLNOM66doFxYfnYyBCHcrsIaqTBSoOHPV
         Aea3+ArylcFmvI9KmPmv4uPhkm5uCHhnOpT/z9jOzaI74Kszpn+j7e2aIYsI9QMMcXV+
         Seag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lp6uXM/TfIp0Qie0v7D1DfEWMwi5ctpf7VE7GYw6ryk=;
        b=VmvPEyTfriJ8xr4ZLugD46npyH+D5u8vvEQR3t5s7fATH6Y+pNrH/AtH7scf67x0O8
         Itp0IznR+1rdKmQvmnKGe3BPNEtEoOvab2iw91HZXFRu0MK0F7KHuYog9JDou9gxt3s6
         UnBmVCP5xuXtGLSLuZyCo84aEECWEB6a4xt6RJj+77ftwO9CeT7HCxRV9H2m52XubDKx
         PW+9cZbBhHO7lVRQrwA2Ww9i3O84xD23qnzBJEIsn4HceuTKtIvYB8B0xJit+iukBy+v
         9/9uY53+Q/gmBH5qe8FPDInl0LLmtfGaLPPBedzjqQ/x1stB4lWTW2i9YK29zPE4JzkW
         H8Ag==
X-Gm-Message-State: AJcUukfzHI2ZKeeleKwea4PYp/BDbnUW7WEJXXiDRpuXsXN0osMqTiAW
        4fiROeePJvqxe24yCkx3nHc2E3gymiJ5FczK6ec=
X-Google-Smtp-Source: ALg8bN6TLddIgDN3MBRuKXXk+BDZx9uJhjc/tnggzJdB8s09bgfjYssJdQvzYeG38q6ZnSPq/4cPrqZFwLYOIfiahNc=
X-Received: by 2002:a1f:a597:: with SMTP id o145mr12939753vke.67.1548864198441;
 Wed, 30 Jan 2019 08:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20190128100424.30278-1-ross.lagerwall@citrix.com>
In-Reply-To: <20190128100424.30278-1-ross.lagerwall@citrix.com>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Wed, 30 Jan 2019 11:03:05 -0500
Message-ID: <CABo9ajD5B2D=DoxD+-mm9EkCfBXUyB9Zb7h7B8aUoazcb-tCSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix crash in cper_estatus_check()
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 5:06 AM Ross Lagerwall
<ross.lagerwall@citrix.com> wrote:
>
> v2 changes:
> - Address Boris's comments.
>
> ---
>
> I recently encountered a crash in cper_estatus_check() when called by
> bert_init(). Patches follow to fix the problem. Note that I cannot fully
> test the patches since the hardware error record on that machine has
> been cleared.
>
> Ross Lagerwall (2):
>   acpi/apei: Fix possible out-of-bounds access to BERT region
>   efi/cper: Fix possible out-of-bounds access

For both patches:

Tested-by: Tyler Baicar <baicar.tyler@gmail.com>
