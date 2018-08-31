Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E2620839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGaGymjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E2620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeHaEwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:52:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45218 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHaEwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:52:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id z125-v6so417296qkb.12;
        Thu, 30 Aug 2018 17:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gi8uQCyeOAesAT0H3hgEmc0dhqSiFW/SnRDiOwKlqFo=;
        b=MGaGymjn6Yp1YxbZxrRFT0m6jhdEHqbR/E9rWWqbftbP0GfAjo92/1oY9ZqwiRq/90
         4T/MK5nRNtAKCKRopzQoHDTyRKaHUxznPOXscJN3MzFbYbzHDAOev2ZgJLCT5Rq8+mBy
         2yIGC6nF7gplHL3gmvJk0OBLg0HVnmdZL8ky0az3r9lTGjfPZu4pPHReSw2nWuOWZWIX
         ryIoiyEtefvXiUHim4ZVVNtE2esVyRXkQ9dYOkh/p7krhYDT6WwZBzp8t32wYNVBdWx0
         e70+Imhqt2H6q1+t1ya7/AXIj1ieyLRGMmCEli4gOs2u9bJNOwPtSWO/TNyzxnDYKu/R
         2E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gi8uQCyeOAesAT0H3hgEmc0dhqSiFW/SnRDiOwKlqFo=;
        b=piJmsGzQT4iMFkw1LrRM24+wRnYd990FOoeL8Dis9utIVgsrjxH2MKOX8i6+s369hB
         t5cCBVE+Rft5KLv5M9iP4B6DjNhoRQCjS7bxNGT38vDBxcEsIoP6/W1fAo3HQVGjMa+x
         ebE2tsJRbuhoyWN/2CLE6Ng6CiS4hEB9c74gLs8CN82NuO5JgPQczqr4FosQLMMk0GXC
         7sAF4dXb6JiHdHbMGNnf0gT8Puhqa19IXfazktYc2mjwYSYVGMsHQcF2yZjR7xIYbuyC
         9FaLeQbmzmsBLsXmWIw6DkZS+hPrm/5dVCMRRBRrZgkjN9KBnbHA6oUfIwMlDZcceXfJ
         BZtg==
X-Gm-Message-State: APzg51CR+umOHNoV8QdqcF5nFs3MhpUUIUxm1aKoyr8oisoG/VtCA4+B
        UNSP8sR//odaY6yJ8kYDQqU=
X-Google-Smtp-Source: ANB0VdZn4OAwGWfhpM5Ol+x+4Orm849bIRnEx/OAywDnf6klr5FtTSH+/fam6luqVD1UsojPchaBCA==
X-Received: by 2002:a37:a107:: with SMTP id k7-v6mr13490763qke.276.1535676462482;
        Thu, 30 Aug 2018 17:47:42 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id b3-v6sm5020054qtb.80.2018.08.30.17.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 17:47:41 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] net: bcmgenet: fix OF child-node lookup
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-7-johan@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <683bdf11-a662-d17e-8bc5-b3cfd238e463@gmail.com>
Date:   Thu, 30 Aug 2018 17:47:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827082153.22537-7-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 01:21 AM, Johan Hovold wrote:
> Use the new of_get_compatible_child() helper to lookup the mdio child
> node instead of using of_find_compatible_node(), which searches the
> entire tree from a given start node and thus can return an unrelated
> (i.e. non-child) node.
> 
> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the node of the device being probed).
> 
> Fixes: aa09677cba42 ("net: bcmgenet: add MDIO routines")
> Cc: stable <stable@vger.kernel.org>     # 3.15
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
