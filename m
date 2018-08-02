Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B69C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946A120862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmllW5JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946A120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeHBD3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:29:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44749 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731812AbeHBD3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:29:12 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so983820oih.11;
        Wed, 01 Aug 2018 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcA18VtzhIyqwwOkL3jjST5vVzEdQV4PIvNyNECHub4=;
        b=cmllW5JWkO09U5tQ9Suw3pCvc9BIMKx/aXRozT4yfFiweLxXSj3Gc38AW1psXahsjh
         QLJbRBizbWlLY1BvmM1uMwqSV905K7HLDep1IbCVcFsCjyf9ZhjoAZOmKq1zu1uKxAl9
         M/6RI+nb3cBsyPR0Th+ES58mWn7bwM9GJ8hysV0E390S6gIUNdHqHXngmv5e7x4RGV5T
         Rhgnduf+8aC7SG2QXTO9lQ3ieyh5yOGBD2AeHhD3k1Io6fG+PPaLjYQ6jwcMteCoVcAR
         m3r0e4yRl31tPza/oPc06Q0mYk/JeRIuCNENU1ForbkVn1V5JUTg8ZQsmL+teYbDXmpr
         sr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BcA18VtzhIyqwwOkL3jjST5vVzEdQV4PIvNyNECHub4=;
        b=qtC/lzrnfU2s1FpOA6pcoqA1zGNnmZSdCYcIoIHpQNt6BIbW21HIew/aHI9tXwldTZ
         cDykfCWV1nJSKZZZj7PJwjkMoiyRKcWYreAMt+0s9wzqzT0CZGQwwopUzpeV9qZ0J/8n
         a/jpbWRclt9h7Sqcy2FlYsAHng+PnOwSc1Fu980Q4pbqmJKTzkukb+xD7aTPiTURMMOR
         wj4incfkTPRgl9r9a7bk+8Ujvn9m2BZeU42nb9v+YHlrAQcFvPXYB7QQYWWika4VepDh
         aBhowj4tSE9zz783YPxykQgiAcyIinGXzySGHUL2ZLBdDlw/HJpiEay8HH7fseM7BQ3O
         KKmA==
X-Gm-Message-State: AOUpUlFA4M/otOwXHDnslWOqj1wP2uVbsCWtZegXtnsQGqcmWKV3TLEF
        MV5/A/tfa3AEu6cepvITeZY=
X-Google-Smtp-Source: AAOMgpe9B0rjQNRlxMCSU+JqD9V7Ny7aqGEQR4MnYq2cZcE3bvHFkM3bxQF245ELU0gXlGwdcf4iDw==
X-Received: by 2002:aca:4a49:: with SMTP id x70-v6mr659602oia.11.1533174032115;
        Wed, 01 Aug 2018 18:40:32 -0700 (PDT)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id q124-v6sm581887oif.8.2018.08.01.18.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 18:40:30 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Add clock config and pm support to bcm iProc mdio
 mux
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <306d1eae-fb0d-4c61-6421-51fa6fc79206@gmail.com>
Date:   Wed, 1 Aug 2018 18:40:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2018 05:53 PM, Arun Parameswaran wrote:
> Hi,
> The patchset is based on David Miller's "net-next" repo.
> 
> The patchset extends the Broadcom iProc mdio mux to add support for
> suspend/resume and the ability to configure the internal clock
> divider. The patchset also sets the scan control register to
> disable external master access.
> 
> The base address of the mdio-mux-bcm-iproc is modified to point to the
> start of the mdio block's address space, to be able to access all the
> mdio's registers. The missing registers are required to configure the
> internal clock divider registers in some of the Broadcom SoC's.

Looks ready to me now, thanks for your persistence addressing feedback.

> 
> Changes from v3:
>  - Removed 'platform_set_drvdata(pdev, NULL)' call (in patch 5/8)
>  - Fixed the return code handling for the devm_clk_get() call (in patch
>    7/8)
>  - Added Reviewed-by tag to Patch 8/8
> 
> Changes from v2:
>  - Addressed Andrew's comments:
>      - Moved to using devm_mdiobus_alloc. Added this as a separate patch.
>      - Changed to reverse christmas tree order for variable declaration in
>        the clock patch
>  - Addressed Florian's comments:
>      - Removed null checks for the clock before calling unprepare in
>        both clock and pm patches.
>      - Added check for EPROBE_DEFER when fetching the clock in the clock
>        patch.
>  - The patch to use the devm API has been added before the clock & pm
>    patches. This patch is now patch '5' in the series.
>  - Added reviewed-by tags to commit messages of patches which remain
>    unmodified from v2.
>  - Modified PM patch to use platform_get_drvdata() in suspend/resume
>    API's, similar to the recent fix that went in for the remove()
>    api.
> 
> Changes from v1:
>  - Addressed Andrew's comments.
>    - Reworked the patches to be based on 'net-next'
>    - Removed 'fixes' from the commit messages, the changes are related
>      to the new features being added.
>    - Maintained backward compatibility to older dt-blob's specifying
>      base addresse with an offset. The correction is applied in the
>      driver and a message is printed to update the dt-blob.
>    - Re-worked and re-ordered the last four patches (4-7).
>      - Added setting of the scan control register as a new patch
>      - Added a call to 'clk_prepare_enable()' in the patch that adds
>        the clock config support, removed the debug message when clock
>        is not passed.
>      - Simplified the pm support patch (removed the array used for the
>        save/restore logic).
> 
> Thanks
> 
> Arun Parameswaran (8):
>   dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
>   net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
>   arm64: dts: Fix the base address of the Broadcom iProc mdio mux
>   net: phy: Disable external master access in bcm mdio mux driver
>   net: phy: Use devm api for mdio bus allocation in bcm iproc mdio mux
>   dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
>   net: phy: Add support to configure clock in Broadcom iProc mdio mux
>   net: phy: Add pm support to Broadcom iProc mdio mux driver
> 
>  .../bindings/net/brcm,mdio-mux-iproc.txt           |   7 +-
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   4 +-
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
>  drivers/net/phy/mdio-mux-bcm-iproc.c               | 108 ++++++++++++++++++---
>  4 files changed, 106 insertions(+), 17 deletions(-)
> 

-- 
Florian
