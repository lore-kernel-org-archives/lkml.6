Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198EFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3AF206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3AF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeHVMv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:51:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36971 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbeHVMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:51:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so965291eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4gZgHYFtAOsRBbtOpshUWqf23GdX/yEWtqUopGHMMo=;
        b=QRVs6LSpb0CYNOXmKP+i8YphVGIa3yHxSbZXiHnu0B2H2fR35SQzHxZ64iXZ2DzC6I
         kLthA1UDPEgsKyZV6c5hNTNjDYO1PHL0zLTZROhqAF+C2R0LUPzN6eGYGi0RB4TwSnes
         vzg4K0QpGTNPtATNoQeI8K+8WfpDAz6r1uDFBdl3lTP2lWwhjFcYgbYge1bW8Cnzknpn
         SEqEX//9S2+kMaxOGRpWXqa9iI9/oxdPdROLk2eg+C0hTrzrFgtDno1H9ZIl4E1Y7cZO
         5Cx2uOassU83CaEHRLlcyhigzXko0ufemxcJM+Wjie6K7A5tr/yWnvxEGMvqkbzimuq5
         pTww==
X-Gm-Message-State: APzg51DEpKs85MKpOymrAwTG7M0HnVVGWs0+nVukPUxvKHNMrM0NHvWA
        oBwHkKBXewiAg2sFJp/IIqmjjeDwzE8=
X-Google-Smtp-Source: ANB0VdZbCMXr/HnnJMbRHgSPruDI6niyBB5mgVFc6WIpMXl2VnosVMswHrrszcfVJnEako3fuC0OFg==
X-Received: by 2002:aa7:c988:: with SMTP id c8-v6mr2098405edt.165.1534930039827;
        Wed, 22 Aug 2018 02:27:19 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h23-v6sm517273edr.86.2018.08.22.02.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:27:19 -0700 (PDT)
Subject: Re: [PATCH 00/14] ata: ahci-platform: add reset control support
 except for existing drivers
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cd35711a-5308-519d-7064-b82220a36d57@redhat.com>
Date:   Wed, 22 Aug 2018 11:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-08-18 09:36, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device, and
> add the flag indicating whether to use the reset. Existing drivers
> set 0 to this flags.
> 
> This series solves the issue of the previous patch [1] that was already
> reverted [2].
> [1] https://www.spinics.net/lists/linux-ide/msg55299.html
> [2] https://www.spinics.net/lists/linux-ide/msg55379.html
> 
> Kunihiko Hayashi (14):
>    ata: ahci-platform: add reset control support and the flag to specify
>      using reset
>    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
>    ata: ahci_ceva: add second argument of ahci_platform_get_resources()
>    ata: ahci_da850: add second argument of ahci_platform_get_resources()
>    ata: ahci_dm816: add second argument of ahci_platform_get_resources()
>    ata: ahci_imx: add second argument of ahci_platform_get_resources()
>    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
>    ata: ahci_mvebu: add second argument of ahci_platform_get_resources()
>    ata: ahci_qoriq: add second argument of ahci_platform_get_resources()
>    ata: ahci_seattle: add second argument of
>      ahci_platform_get_resources()
>    ata: ahci_st: add second argument of ahci_platform_get_resources()
>    ata: ahci_sunxi: add second argument of ahci_platform_get_resources()
>    ata: ahci_tegra: add second argument of ahci_platform_get_resources()
>    ata: ahci_xgene: add second argument of ahci_platform_get_resources()

When you change a function prototype, you must also change all
the callers in a single commit, so that all intermediate commits
will compile without errors, otherwise you will break git bisect.

Otherwise this looks good.

I suggest you split this like this:

1) Add a flags argument to ahci_platform_get_resources(),
    without adding support for any flags yet, so this just
    changes the function prototype and passes 0 for the new
    flags argument *everywhere* without any other changes
2) Add support for a AHCI_PLATFORM_GET_RESETS flag, basically
    your current first patch, minus the prototype patches
3) A patch which passes AHCI_PLATFORM_GET_RESETS for the
    generic ahci_platform driver (so break this out of your
    first patch). Also describe in the commit message of this
    patch why / for which platforms this is necessary.

The idea of doing 3. separately is that we can easily revert
it in case of problems while keeping the core functionality
in place. Note I do not expect this to be necessary.

Regards,

Hans


> 
>   .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>   drivers/ata/ahci.h                                 |  1 +
>   drivers/ata/ahci_brcm.c                            |  2 +-
>   drivers/ata/ahci_ceva.c                            |  2 +-
>   drivers/ata/ahci_da850.c                           |  2 +-
>   drivers/ata/ahci_dm816.c                           |  2 +-
>   drivers/ata/ahci_imx.c                             |  2 +-
>   drivers/ata/ahci_mtk.c                             |  2 +-
>   drivers/ata/ahci_mvebu.c                           |  2 +-
>   drivers/ata/ahci_platform.c                        |  3 +-
>   drivers/ata/ahci_qoriq.c                           |  2 +-
>   drivers/ata/ahci_seattle.c                         |  2 +-
>   drivers/ata/ahci_st.c                              |  2 +-
>   drivers/ata/ahci_sunxi.c                           |  2 +-
>   drivers/ata/ahci_tegra.c                           |  2 +-
>   drivers/ata/ahci_xgene.c                           |  2 +-
>   drivers/ata/libahci_platform.c                     | 35 ++++++++++++++++++----
>   include/linux/ahci_platform.h                      |  4 ++-
>   18 files changed, 49 insertions(+), 21 deletions(-)
> 
