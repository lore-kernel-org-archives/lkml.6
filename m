Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3523DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0198A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PezxzrDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfAQCrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:47:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42066 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:47:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so5150170qke.9;
        Wed, 16 Jan 2019 18:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg1vNvR5pbrB66mtDDBifmLfQdSn09IgrAfhdxtpDvE=;
        b=PezxzrDR7iDernYmPx9IwD3FED9nyblCOHyFkvJxWHVwAa1qOVjqaLr+/76p3ugaCZ
         /WguOh2eYTQ1Ujzf6pjnGtlzTJB3VlfyNJcPZgWWQA2mt4lk1iICCPUqfeW/Ubfm8bpq
         pCj1EzorH3dxFc9sz60hzXUyURyTtnGVzL/Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg1vNvR5pbrB66mtDDBifmLfQdSn09IgrAfhdxtpDvE=;
        b=ue/bL4Y/qfZKlff5IZYQ6OjcT0DVQoGXITE5JUrIOojwhna4jYqo7OdGgDz8SwqiWH
         0bceLkUA8y/L65j2mzNivOxbNQTWXGX2P0wt6PNUO4JqjbXPOg69PHrMof2P3sP8dkgk
         Lc/zTu2IP4rhUyrWElHMpl5IO/MvHo062rBXQTor7vEplAFjuOirk2Uee78lLg2kX+u7
         B6CjWlF4czX4lBxMar0ZJpWEu26Pp3O23SnPu2qWT+SQFvHxWH5OTICqN1eOK5bI/rfG
         G3adeoCzdkChYBUHayKkvwWVdUtekfzi+qgaHkykGKCOJzozbXdngYXYM+KiSgoWPSP6
         ykFA==
X-Gm-Message-State: AJcUukdQLDAFwBnbOAcLyZ3ia5UFXG/1i3cRw91RidMcTGNhpvWGAiaJ
        hJFIR6xuDKzY9qkXxEP6F4kSIQ0dILBlgNsVwDo=
X-Google-Smtp-Source: ALg8bN7MVmbeu1Q3GqsgLUzW/P2tCyvjTvWLcDPvaWwZQoPKRx6ZlZhqRPTC6t/zvZQAlc0roWP5/JNrvgDGr5Qhcyg=
X-Received: by 2002:ae9:dec5:: with SMTP id s188mr9168191qkf.127.1547693261504;
 Wed, 16 Jan 2019 18:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com> <20181217200405.2904551-3-vijaykhemka@fb.com>
In-Reply-To: <20181217200405.2904551-3-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 17 Jan 2019 13:47:30 +1100
Message-ID: <CACPK8XcErvKa6ROTonrxc5nd=keDCEL2QniQAwWaAO0FrTQVGg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: aspeed: Add KCS for Facebook
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 at 07:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added kcs device in Facebook Tiogapass device tree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel
