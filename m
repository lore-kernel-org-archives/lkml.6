Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C93C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0B2188D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtCxRJtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF0B2188D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeHQOKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:10:41 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36792 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:10:41 -0400
Received: by mail-qk0-f194.google.com with SMTP id 93-v6so4614395qks.3;
        Fri, 17 Aug 2018 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CUsC62g54doCArXu/DfL3KpmKexz6XW1nK3ogLhAdR8=;
        b=JtCxRJtkV2osiw2+4rMcuABL/imLjv38PW3cPZoB/ldA8+gW597cJ8Al0m6linAv6E
         bbtwvy/U2oCO9N33QeE4PBG/iBIHKf+BHFR+AwttLRfytxGiN1svnfLDPQoVXuglxtBU
         xyJfehcl4LnKatQIWWfiJM4Z0ww/ePv7w8sqcmj6J3t1ggkhejL++x1YlpU4SNLpBt3p
         8UdluolUShclb9OcSRumX+p1OjwXS6axXiy0O4o773EkGMwQUah5gwoWst0VYxl/c5df
         Cy+MPHPBuAs8bp9uR/eWfFp4J7D90L4behYtN5Oq1aklz92QMXFznTV+AU+DU1qzJNtq
         ka7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CUsC62g54doCArXu/DfL3KpmKexz6XW1nK3ogLhAdR8=;
        b=ffQJVAFW2Ue4pN9cOl/44JLh3ewy803zGqXQQCNJZnxjZfDCg9jIVG/K1fHqC9MqVQ
         vMZ0vvhKLWJvI7sQDhMcdD8/QseGZIV5DwnroZtXKq5SlUv6pnqAeNd/stLx4djx3qm2
         ZgB0E2msUOS1wigfLAFEoxtReRTQKKgYtIyipT/XCHl1uXlZ7aNkUdx/fIQrCuRGxF/x
         5iEtyNBc6KzE+82ZTZCe+QngQ+uLeKt5+GhSSfM4/GOlmn/R+K8XvzLPCz1Ia5Vw0k+l
         hpSNnJ3QNHteAZlp5nF4qIlPie1NhytyPLNYo8hJuPDkCCh45eFzZpq+5SYVT3rt257W
         EQRQ==
X-Gm-Message-State: AOUpUlEpZODPnz2O/CszrJdXHF2ms07c5lakfVP3YZ3tJcb4cPjn/6a8
        2R/XrXdaKfM9Gp37jMx6XFUQojPELTqDv6v1lSg=
X-Google-Smtp-Source: AA+uWPxCslBEBjLVVrAmZD5fhJyhOjcVGXcrNSGnDuFVyYs46stSGIdMdgfKQ8KgSQG5/mChRREC67w4kohvix9k8d8=
X-Received: by 2002:a37:7004:: with SMTP id l4-v6mr29813198qkc.83.1534504058839;
 Fri, 17 Aug 2018 04:07:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 04:07:38
 -0700 (PDT)
In-Reply-To: <7ccdc39d7e255547e851497ef9f449715b45f8bd.camel@kernel.crashing.org>
References: <7ccdc39d7e255547e851497ef9f449715b45f8bd.camel@kernel.crashing.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Aug 2018 14:07:38 +0300
Message-ID: <CAHp75Vd1ZZDJtASfFpr=eE+zaEiOxH3ohdSOe1aTcE3qEMd_QA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Silence "unsupported" message a bit
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 2:27 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This driver prints that "Unsupported machine..." message on every boot on
> ThinkPad X1 Carbon laptops (and I assume a number of other systems), which
> causes graphical boots to "glitch" a bit and is rather annoying ...
>
> Make it a pr_debug instead.

Thanks for the patch. Unfortunately it doesn't apply.
Please, check your mail clients and tools for formatting patch (it
produced at the end spaces instead of tabs)

>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 8952173dd380..7f7192e8fdab 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2216,7 +2216,7 @@ static int __init acer_wmi_init(void)
>         if (wmi_has_guid(AMW0_GUID1) &&
>             !dmi_check_system(amw0_whitelist) &&
>             quirks == &quirk_unknown) {
> -               pr_err("Unsupported machine has AMW0_GUID1, unable to load\n");
> +               pr_debug("Unsupported machine has AMW0_GUID1, unable to load\n");
>                 return -ENODEV;
>         }
>
>



-- 
With Best Regards,
Andy Shevchenko
