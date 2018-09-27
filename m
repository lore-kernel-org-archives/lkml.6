Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B46216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSrv+wD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B46216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeI1Bsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:48:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39574 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeI1Bsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:48:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so6079136edi.6;
        Thu, 27 Sep 2018 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hq9lZIJldLKjNRcRD1CYGPjANIXdnqqBi4N/XXdeyp4=;
        b=iSrv+wD84DXkaH10hcvMFtxcGYEW6IJiDrTuxwH92k6DzAQqptO1EkYT815hN1ysyZ
         pKM+TkhtM0DD8LehhBqYvWWDuU4yzjDlM4foe3kAmvcS3AdeiVUAoMyEA5B0SILZSrKb
         fIVOVxBza3YirxBbR+JQ28xD/twnI+ZmUJjFXCCgTUholdyWnJUquXAIoDIxMia0Cq2Z
         7MNkHxnIkGOupd4ccPmsxDEcxL5Y9P/Kkb4zI7rM1sGtUlLRMsXPRWdDVRsu9TbsR3rj
         2O9bSXFx73fo5LawwBYkuTP7Nrtut3fL5CHxT4enATtxaIMwUQzWD1AzKTaU2YwH8Mpd
         RwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hq9lZIJldLKjNRcRD1CYGPjANIXdnqqBi4N/XXdeyp4=;
        b=GyahyJ+cCmDwlt0if2ANABLM78czdILSPeyTAFpp5u/SjRBhjBhIjZ8jeKxIhGYhlc
         NAIMOXHimqRCa7XH9JgNMzhnnD0+6SuFKd1A5dY8/Vv8evGhemMG+1N87ZEHnvn2vadn
         1XIdI3KVCJ73MQSrdtoJ0EeXG2wEnWt6LvnqUpHmF8Ap0C6MEiB7B+qbeKz6tFNoqZ1n
         CwMmCzsWiv5yYU7L/bger8SIu2b3rD8shgUE1oA7OHgMLImyzVaudPfz9gBDjd7bjozN
         2JKRBcpRyFo9YJiqwP7y8oeyZheEeFYgd7FZvsrPaNQwZN4a103vS7zLVxU1xCEvHCba
         bafA==
X-Gm-Message-State: ABuFfojQw5YBqnPbFzjGosaLPzXqkXM4IFoavXtSXf7ViozgmUGi8uwm
        vhXgfzoZCNck61BIheyWwt8=
X-Google-Smtp-Source: ACcGV63GxZrn9mZM3lKyFHRsfV744pAYTxpaLIaIRgztiNG30hTFwZysWThKqqZKM3z1W6rr1XUvLw==
X-Received: by 2002:a17:906:7103:: with SMTP id x3-v6mr3413281ejj.72.1538076520861;
        Thu, 27 Sep 2018 12:28:40 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id c15-v6sm2268850edm.21.2018.09.27.12.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:28:39 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 0/2] Add support for Microchip Technology
 KSZ9131 10/100/1000 Ethernet PHY
To:     Yuiko Oshino <yuiko.oshino@microchip.com>, davem@davemloft.net,
        robh+dt@kernel.org, devicetree@vger.kernel.org, andrew@lunn.ch
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        m.felsch@pengutronix.de, Markus.Niebel@tqs.de,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <1538079344-6152-1-git-send-email-yuiko.oshino@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <7c84dfed-6864-7b25-38d1-9bed1cfea0bc@gmail.com>
Date:   Thu, 27 Sep 2018 12:28:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538079344-6152-1-git-send-email-yuiko.oshino@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 01:15 PM, Yuiko Oshino wrote:
> This is the initial driver for Microchip KSZ9131 10/100/1000 Ethernet PHY
> 
> v2:
> - Creating a series from two related patches.

When people give you Acked-by or Reviewed-by tags in prior versions, it
is usually a good  practice to add them to your next version of the
patch submission. Also, your patches 1 and 2 did not show up as as reply
to this cover letter, while they should, please fix this if you ever
need to submit new patches in the future.

Thank you!

> 
> Yuiko Oshino (2):
>   net: phy: micrel: add Microchip KSZ9131 inital driver
>   dt-bindings: net: add support for Microchip KSZ9131 Ethernet PHY
> 
>  .../devicetree/bindings/net/micrel-ksz90x1.txt     | 29 +++++++++++++++++++-
>  drivers/net/phy/micrel.c                           | 32 ++++++++++++++++++++--
>  include/linux/micrel_phy.h                         |  1 +
>  3 files changed, 58 insertions(+), 4 deletions(-)
> 


-- 
Florian
