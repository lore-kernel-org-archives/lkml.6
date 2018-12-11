Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21642081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544522842;
	bh=LXHml/Uve5wVCTjJwp+U4ppI8WnmmADPNw81zJsP5rc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2JHP0MT//u4ULraUdNPY56gNJG0IYhfsFEaXV5Abu186baEiPZ5h70tnXKCrucJh6
	 QB+lK6crKBzrh48hcXcl7X47FXwJFFu81dKOOghyqRlnOFLV9Ft9XQ+EO11k9els8F
	 jRaITL8JKt1avOsUTcAaos/3md+1SvqbCnUIYCIM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21642081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLKKHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:07:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42179 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:07:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so11524162oiw.9;
        Tue, 11 Dec 2018 02:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXHml/Uve5wVCTjJwp+U4ppI8WnmmADPNw81zJsP5rc=;
        b=tbR0aIZfIdoWmlrkxyCpTxZ+2yaMvxsCkOsT4dekxqxNsBJihs197ZxFXd1C3nml0J
         Pb89iGRYaa9sgx3yY4mDFXHtqEVpQkrl8ofYg3QF+/IPrvcUxTcSbjoW5U4/xpITW51G
         Q/aWrLKEXUEwL9plzcTpvdHLlNKD87FIhCcvuelcYyl1TbQmaCktixrmYahcO68i7/D4
         zHmV2IgIiG+7fqHen2+WZhs87kXYE5GOG6eXvZ+w1IZmtxRnZUad+PZgpvfYSQAsoDmm
         L3aMBXcTJ4zEQz4tmpepogu23Ljc5A7SKaWsc75hVFr500iSPMu5mlqHeqAKXLF4r12a
         LRjQ==
X-Gm-Message-State: AA+aEWbJEf9gSmtZRK6+OulGsZ7SCp4BX1mPVhsQBiwlqGOF8p3vRUP3
        r0oguWPpAi7pEkakMHZ/TW1OoTvOvLbh/Ix4RT0=
X-Google-Smtp-Source: AFSGD/Vn1PP+FASMV7zxOIQbWxnCQZIyWu6VeYuLnww/3AfvmxCONTOS1Ph+3RjLGSp1pvgWVIBVVShAi9dmG6kdZgU=
X-Received: by 2002:aca:368a:: with SMTP id d132mr956821oia.193.1544522839776;
 Tue, 11 Dec 2018 02:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20181210181315.5023-1-okaya@kernel.org> <20181210181315.5023-2-okaya@kernel.org>
In-Reply-To: <20181210181315.5023-2-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 11:07:08 +0100
Message-ID: <CAJZ5v0htmHTgRa9TZ7f0XcGEt_XMmfEYhcQ=N2Lcn1V+TxPzxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     okaya@kernel.org
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 7:13 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
> out calls that depend on PCI.

I would prefer the subject to say something like "Allow CONFIG_PCI to
be unset" or "Allow PCI to be disabled in Kconfig".

It is somewhat ambiguous otherwise and one has to look at the patch to
see what it really is about.
