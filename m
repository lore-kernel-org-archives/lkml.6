Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233DA21527
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO79ZKVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233DA21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934461AbeGFSl3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:41:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34059 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934112AbeGFSl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:41:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so5013629wrt.1;
        Fri, 06 Jul 2018 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1KWO5GdKgR7n0a/u5iMWpW4chwxTqjo+WjjPLSZuXKI=;
        b=cO79ZKVFPVjDsarMDWJzTuxcW0RvowocjbDb4P2tpIqj8KFxcygutvPwe16LcTjqu6
         MSs79LUkd+uEKiSHtlBy3vTGiv4pajjXdEBLf+WsDGfXfShWMAIlpJ4jP9i5M2wauAbZ
         YunPqR88dSzQFn9YBttWAILJzbUBRoJI86uMLPdfSRw/YYz/rUaWt9DQ5IAjCKOCHExx
         8vEIknaFKSO89DmhWbAKubXLCAOeXsznXN4B95iKiKPjuIConPD4k6pBc6W0t9KHG5Ya
         RwCcUU6ZsZ//qz9+TefODCm4VP+1+Yxcu0G3if64okfImb6FdNCb6FhDb+rv8iC+dbAS
         LuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1KWO5GdKgR7n0a/u5iMWpW4chwxTqjo+WjjPLSZuXKI=;
        b=OStsL1Fh5JIjV3GSVMcrkKdoRsELFq8QCa4WrjApSk38/C0whdotGju8nCY98J8Ef2
         HdbzMbNfowImIT5CkPK7ZbPaXqosGY717D6EI7lfhQyvMKpTOdhcMq7YPowhxxzlrYJy
         JqpL8x3r5q9xGKOdQvm4/JLJiN61B0JL7JiUOtkeGdAbpvCfs3apzxNLAmBohZ15SzoS
         ZcQ7EUMqnp/UVeb7TBRkzI7YyudPDqBi9P+D+CNzUYBfXdFbkC9BHDYJHn0YvNUNCk6F
         2JjNPK3NXoTyilULyENbKIP3taI7paP74EFnHQl1gLtvB/p47R+7pOmq4TnORhOq9pFu
         CdGw==
X-Gm-Message-State: APt69E2uqVHa4225mZ6X9CI442hStcD4C6kEdB/pgV9rpxmIqcysjaVU
        +BRJqJxlGM0dFhGNL4ae/X8=
X-Google-Smtp-Source: AAOMgpegTGaDhv4SmsyqqsNi0675f/dKKyw8O/Js/Sacn7NT2Z2J5X9Sp2ShqmFGy90ESO7T4VVxVA==
X-Received: by 2002:a5d:4091:: with SMTP id o17-v6mr7642914wrp.133.1530902486075;
        Fri, 06 Jul 2018 11:41:26 -0700 (PDT)
Received: from [192.168.1.14] (ARennes-658-1-259-104.w92-135.abo.wanadoo.fr. [92.135.242.104])
        by smtp.gmail.com with ESMTPSA id b33-v6sm238977wrg.45.2018.07.06.11.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 11:41:24 -0700 (PDT)
Subject: Re: [RFC PATCH 0/1] net: phy: skip autoneg of ethernet(fec) on
 network boot
To:     Masahiko Kimoto <masahiko.kimoto@cybertrust.co.jp>,
        Fugang Duan <fugang.duan@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
References: <1530857230-31124-1-git-send-email-masahiko.kimoto@cybertrust.co.jp>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <8a437ead-5ded-57c4-c44f-95986442d626@gmail.com>
Date:   Fri, 6 Jul 2018 11:41:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530857230-31124-1-git-send-email-masahiko.kimoto@cybertrust.co.jp>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2018 11:07 PM, Masahiko Kimoto wrote:
> Hello,
> 
> This patch introduces auto negotiation skipping for Ethernet.
> It is useful to shorten boot time on network boot like the following
> environment;
> 
>  - target board is NXP i.MX6.
>  - NIC is fec.
>  - using u-boot as boot loader.
>  - boot from kernel and initramfs obtained via TFTP.
>  - mount remote file system and switch root to that.
>  - thus all file system is on network.
> 
> In this case, u-boot and kernel initialize NIC three times,
> once in boot loader, once in device attach and once more in phy attach.
> Each causes link auto negotiation and wait several seconds.
> However link state is stable after reset by boot loader, therefore we
> can skip hardware re-initialization of NIC in kernel.
> 
> The patch skips link down in Ethernet(i.MX's fec) driver and initialization
> in PHY layer if kernel option 'anegskip' is supplied.
> 
> By this patch boot time becomes 3secs shorter.
> 
> I think current patch is dirty hack, because;
>  - modification is split into PHY and Ethernet driver.
>  - in the case of two or more Ethernet I/F exist, currently there is
>    no way to specify whith I/F skips autonego.
> 
> I would like to implement such skpping auto negotiation feature in generic
> framework. How should we implement these requirements?

I completely acknowledge and support the use case, but your
implementation is definitively not the way to go. In my experience the
problem is usually that there may be a disagreement on the
Pause/Asym_Pause advertisement bits and that alone is responsible for
triggering a re-negotiation. Can yo check if that is the case here?

Thank you
-- 
Florian
