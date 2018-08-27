Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEC9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AE4208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeVjmo+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AE4208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH1CZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:25:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44429 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeH1CZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:25:37 -0400
Received: by mail-qk0-f195.google.com with SMTP id d131-v6so438679qke.11;
        Mon, 27 Aug 2018 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jyeu2ufZvAd7BKX+Q4gGsjWcDNq+HWQoj2bGAvDY+dc=;
        b=IeVjmo+a+tiLRXUF3laz1nwLSbWji7Q4QRmT/iXnyIdIGijp1ycmvUV1UJ1LntkXx4
         DnJrj/RbxN2+i0Fg/E0LYB4S2roDPMJEuOaB1oQznjhwoOGZW3Qyjp4LkHxGe2VIh+ed
         hmCQULrjY177spQelGUsUpNOCOpowjB+wqXcF4cYtS3JoDcbnkCLpT+Ie51kkeNwXGhC
         +miZ9jL0dAdAGegIkFWB8dN40gnxX93em5WJUPHxg27giN5w4bJBmaG6VWYh5LVgZYq7
         mE5xkm2So8bKf8LJgsFdX1hU9EPFx9aISSvOJMzPw8e80xlSoGM9O9P2EaBq9CEE+s7Z
         TJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jyeu2ufZvAd7BKX+Q4gGsjWcDNq+HWQoj2bGAvDY+dc=;
        b=oNisYaEOp5DZ7MZFmBhVtHUqKhEoJrJkuCbuJlQzyfzklif30bCyj4Q3BQtQsSa0/X
         6WeUgGkc+UlI3jB05k58BGjo5CXK4e27y+UYJvuoSu8F+z1RynuAoc3g6A3EdqYAB4Hf
         Hz2J+5V9OssHXTTR6mbRsXOHTwfIaPrhjGeYdZCq2mGdeSydPC63jtmQQpQJsC7AIjnF
         iZ8FzAZ0NK6wcwvIz8FxBqJd2SgID+lVThGX+3cGZYwHmp5APnW7qfExOO05xDmqoWV8
         gSfIIxQCY2/P8NqbYEdndzWLZ+DnDAPQDinnQ8QA1+c3DW4B8ziVmYEoVwgm5dVscnnh
         sngQ==
X-Gm-Message-State: APzg51A/Uith75k/hNXX+ocVz/pIE910Hqt73fv5pmxu6FPsJ1uys0gj
        c0DupHhn+YsgDM8a3FezcC0=
X-Google-Smtp-Source: ANB0VdYRaOE0qn52ZINVMKZy7NomFmJm4qJJIpkNdBWeWiRcU7i2tYthpnkFwxJrhZpire3BuKxPwg==
X-Received: by 2002:a37:5d84:: with SMTP id r126-v6mr15717641qkb.155.1535409419380;
        Mon, 27 Aug 2018 15:36:59 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id w9-v6sm362627qta.13.2018.08.27.15.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 15:36:58 -0700 (PDT)
Subject: Re: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, andrew@lunn.ch
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
 <20180827222646.GF30658@n2100.armlinux.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6d6e6c18-c713-7d7d-a332-da73cca84cbe@gmail.com>
Date:   Mon, 27 Aug 2018 15:36:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827222646.GF30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 03:26 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 27, 2018 at 01:03:42PM -0700, Florian Fainelli wrote:
>> Enable the SFP connected to port 5 of the switch and wire up all GPIOs
>> to the SFP cage. Because of a hardware limitation of the i2c controller
>> on the iProc SoCs which prevents large i2c (> 256 bytes) transactions to
>> work, we use the i2c-gpio interface instead, which does not have that
>> limitation. This allows us to read the SFP module EEPROM, which would
>> not be possible otherwise since it exceeds that size during a single
>> read transfer.
> 
> We shouldn't exceed 256 bytes, since 256 bytes is the "page" size
> of the EEPROM.  The most that we read in one block is either
> ETH_MODULE_SFF_8079_LEN or (ETH_MODULE_SFF_8472_LEN - 
> ETH_MODULE_SFF_8079_LEN), both of which result in no more than 256
> byte reads.

You are right, I got things mixed up here, the controller's limitation
is actually 63 bytes per transfer, I will be rewording the commit
message accordingly.
-- 
Florian
