Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23939C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C94250E8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UImFkxkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C94250E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeGBNPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:15:11 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44699 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeGBNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:15:06 -0400
Received: by mail-ua0-f196.google.com with SMTP id v15-v6so10017968ual.11;
        Mon, 02 Jul 2018 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cew5eadQLlZR92u21/oB4VMEfkUNLxZXnZ8DngIAUhc=;
        b=UImFkxkzHUIU4WQ3hU6rFyxEKhsmURrRuTElJes+gXtCgb8zd1b8RDDzykbuQ0k1Dd
         G4oBVKaOKM1RO+E3OCBiHU0ASGb/pLtUrDv8hdAxO3/UQcNL7H2rifWHKCjQBkOrOzs3
         FEndnf/dH4ozopdeuqz+E/AmppyX4ceEW27Wp6bYc4/i2UPVk4eQYzpJVrpqQEWy5SLU
         H8wfhRcQcibHFpfZriVri3r19WCdWL+LY+RvL2R4j27XiojNdZp9oMcZEDu5DavtDOv1
         R0xGvztPRh52wpv80kAPBXQwRBRUR62BSaMkyS/erjESuxIwVg5vg0hKaXpWDK7yQqtp
         sAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cew5eadQLlZR92u21/oB4VMEfkUNLxZXnZ8DngIAUhc=;
        b=dUvXVW9JcBT9+ZolgYEX4+ZXAHB6rSbBpu/gtJIcij0JDLQJGS8jUdrbeZYTWGW0LV
         hgGTpxy5OaBzERHnqoxndRfUyYbuvbS/U1oKrPJ9VZMDZm/BmjKisM7nJkawUxJCMpLf
         xM022mypsC9lDByJWtsbBGFxMR0j1s0eugB9nCeqp5SvXssH7aJQuc9zgLbb3ixSC+BE
         nM51mGQUYB5BtXpF19tbPpCil073L9QPr0whVDz5O+d5X8b039tztn5r5Pbp82EiL3aN
         ALCEB7mcFJInQxfP6FKmZSTAhLuxERVZe2s+SsjGvvhkKcnRh5aXpLcUr3R4EWgH+nxo
         86eA==
X-Gm-Message-State: APt69E3UH9SU5UKOS29s/lqv+aQxIz+EqLdCVW5kQ31tOFrB05NGdLV3
        vLk8oNiFZosJC5e00SmMoucJdjsU9k3+uGnOkX8=
X-Google-Smtp-Source: AAOMgpdDfZxgsmZB4IQFM5BfrY41nErkJQawsuIrKYnybs57oZPRbkbRMEIK0Lk63opaOzBhU8issd0URtNcRMP8b7k=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr15673169uai.47.1530537305576;
 Mon, 02 Jul 2018 06:15:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:15:04 -0700 (PDT)
In-Reply-To: <20180630121024.18993-1-colin.king@canonical.com>
References: <20180630121024.18993-1-colin.king@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 16:15:04 +0300
Message-ID: <CAHp75Vf8AAnmvdWsUPyRY+13vi43Ta=FiaVEhNwn1+QyN88K0A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-smbios-wmi: make function
 dell_smbios_wmi_call static
To:     Colin King <colin.king@canonical.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 3:10 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The function dell_smbios_wmi_call is local to the source and does not
> need to be in global scope, so make it static.
>
> Cleans up sparse warning:
> symbol 'dell_smbios_wmi_call' was not declared. Should it be static?
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/platform/x86/dell-smbios-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
> index fbefedb1c172..88afe5651d24 100644
> --- a/drivers/platform/x86/dell-smbios-wmi.c
> +++ b/drivers/platform/x86/dell-smbios-wmi.c
> @@ -82,7 +82,7 @@ static int run_smbios_call(struct wmi_device *wdev)
>         return 0;
>  }
>
> -int dell_smbios_wmi_call(struct calling_interface_buffer *buffer)
> +static int dell_smbios_wmi_call(struct calling_interface_buffer *buffer)
>  {
>         struct wmi_smbios_priv *priv;
>         size_t difference;
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
