Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DADC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584F220779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuyNscX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584F220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeGIQKI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:10:08 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35105 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeGIQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:10:05 -0400
Received: by mail-qk0-f193.google.com with SMTP id u21-v6so9977231qku.2;
        Mon, 09 Jul 2018 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pUcR2YZvMkXwXUIXOxMe1kNXKov6U5g5amsuF045Psg=;
        b=XuyNscX0Bz2KeAccozqnAp3dL2ZvZRvqaIjRktb3omiMzjEMKwlgs+YKpb9Rz+rTSd
         v/4wFCvMDEhnooPFaHYWsz/mZdML52cWvibKYxGSRHqbZWjl2fhbcSrTKSuLw6xM3O+o
         FXBnJsuIiyW7OGwbVqn0Cyke/AYY4iFlmJBjXVnHqO3R5SVh5yLrxpAetna08rWchfgC
         2ePr/ygLNFjfWCf2TJbAddql/l/NZUJQn+W5uACd/MIx1gk4WTqw2h2XDQpkDtbaTGsg
         bK8/3IoqzWoeL2IP7QKMt7YVRTpw5U4UxU8BLqMUj8LAIB5gUk5eDkTzVLk4YUUj/n5Z
         Y16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pUcR2YZvMkXwXUIXOxMe1kNXKov6U5g5amsuF045Psg=;
        b=L51KcCzLRVVQEwdVmWYgyts6MondteKh3lXvDdKRw+KPVnbls+TBswZ83PWfSwsRgz
         ZlMSPH06JddpWzk1FxrRKV+Fdm7abN1LKYOB7rQd7Klnet6Db+EsuvJjHFTBgWZe0lHJ
         VRUIV3OVSADuvxrHBN2bSvAVxs2wPxZAV4qMiACy9oTDr5pU8FcL5Tw8OKYmvI0V3zEk
         T67CGNvBg5ldwA1aa8ik1Jnv9+Ux0hfoCfS2RxVXT5NVMrbGxMcq3FQUFQJOJx6r03FZ
         KCO3U9JxofrDP/1qpWrRkZ7R0hW4sdAFoPN5dYrU+I/s0H6lHVjKUMFrt32xHjVIxDFJ
         ePiQ==
X-Gm-Message-State: APt69E1CbhjQ72byvPSJENreTsxxskF21OshmvmfjndA2hUPL/5lt6q8
        Fmp/+wjA8VMogPvVhuvg2TgGLtVr
X-Google-Smtp-Source: AAOMgpfZLV89Y+oIwDwmdwGMhIsB3LSE0jb0UwGQTJhTnTHM2mFPhQgj/lT/tBdgG52Ol3d+6toI7w==
X-Received: by 2002:a37:27c3:: with SMTP id n186-v6mr18149094qkn.387.1531152604187;
        Mon, 09 Jul 2018 09:10:04 -0700 (PDT)
Received: from [10.178.4.240] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id n21-v6sm12067170qkl.34.2018.07.09.09.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 09:10:03 -0700 (PDT)
Subject: Re: [PATCH] net: dsa: bcm_sf2: remove redundant variable off
To:     Andrew Lunn <andrew@lunn.ch>, Colin King <colin.king@canonical.com>
Cc:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180704065436.13719-1-colin.king@canonical.com>
 <20180704142520.GD12405@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <2f4bab8e-6f4f-cec1-77cc-4caeb95ebf2f@gmail.com>
Date:   Mon, 9 Jul 2018 09:10:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704142520.GD12405@lunn.ch>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 07/04/2018 07:25 AM, Andrew Lunn wrote:
> Hi Florian
> 
> I this a bug? It seems to be a result of moving to
> b53_disable_port() in f86ad77faf.
> 
> Before you would handle the CPU port differently than a normal
> port. After this change, there is no difference?

This is not a bug actually but it is not obvious because there was a
separate definition added in bcm_sf2_regs.h for port 8 named
CORE_IMP_CTL. The logic in b53_regs.h is:

#define B53_PORT_CTRL(i)                (0x00 + (i))

and due to the memory map used in bcm_sf2, that would translate into:

8 << 2 = 0x20 which is correct here and matches the definition of
CORE_IMP_CTL.

in fact, the new code is more correct because any port could be a DSA
CPU port, whereas before we assumed that port 8 == CPU port, which is
not necessarily true.

Thanks!
-- 
Florian
