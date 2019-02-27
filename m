Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0427C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80111218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lerh3YpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfB0FFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 00:05:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44684 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfB0FFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 00:05:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id a3so7378572pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y6MKlThRi7iocLXrinu5vt4XQ93V36AlWjL0gnRGdjg=;
        b=Lerh3YpVKS+TbKb7D5L+/YZkEV7c0elTvkZLzLswUS3OuddSSSALZt2OsuwEhP7mt1
         0K2DXwHYJOARFOK/nYU69pTvk+S71YnyiW/rfx9LcD2LoNDgq412CZ95PJUveBn7q8cq
         1B10F903IwKwYklQJu1wgtnce8TPFZOq1Hj7MXSAsnpRFzuEvW1h15icilKLlhKNQdJP
         RqSJNY3qUUsNFUcCgM//omJvAARDOmq28749F+rBbc9F8scRMgyyO1OCt4Q7Oj35FR9U
         0mCwmCJ3L8Tazh23uT+Q+pOfy33TSA/+kQ8Rka/p20anRZSCkhv2LbwjoTDmnMSZTIAv
         ZAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y6MKlThRi7iocLXrinu5vt4XQ93V36AlWjL0gnRGdjg=;
        b=leGu2yxEtyOZnDMWN+SxYr/QVlcvAehA+V/S6TQysDzOALTWPLYqzfLdghdfS3FJnM
         rWI7h4dqsE7QAKaBiBq3iztzRWSggCq0hIxvak9U8mzegAk/lZnosXBhG1RJesak94LM
         tXh9JxvH3aDl8dVG7IRypI4Ah2CgwqZAxR1qJ4J5j0lAY181zHRRBuW1uWzy+eKgAkiX
         VeAmsyparr+ht/+I0oi63Jw7YwpzQ3Fu6uqgF90tyJHqWUOhEUGD8alYH7PChua/u+Ko
         CkwvqHneIq8wYn0Kyj3V7u7v42TtGnZIC3eEdeTM8eRlDHajcWqSUfIkV1C8eRIx8M81
         A+Ww==
X-Gm-Message-State: AHQUAuY/E2lViVdSdArrD6RJe8DvgRK3ppnwfY0uwENdPRPehlRl/9rH
        DKZrPKOyi8okX/2e2wsedgY=
X-Google-Smtp-Source: AHgI3IZPf3U7OZDjidVGvyIeHfc+Hc7asT/pKyMuT0nkCVPVpbbdMLrIY3yg74oOiw94ciocVlVT5Q==
X-Received: by 2002:a65:5108:: with SMTP id f8mr1153951pgq.441.1551243900258;
        Tue, 26 Feb 2019 21:05:00 -0800 (PST)
Received: from [10.230.1.150] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h64sm28585378pfj.40.2019.02.26.21.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 21:04:59 -0800 (PST)
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Patrick Venture <venture@google.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, joel@jms.id.au, andrew@aj.id.au
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190221222537.137331-1-venture@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
Date:   Tue, 26 Feb 2019 21:04:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221222537.137331-1-venture@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2019 2:25 PM, Patrick Venture wrote:
> The ASPEED AST2400, and AST2500 in some configurations include a
> PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> in the BMC's memory space.  This feature is especially useful when using
> this bridge to send large files to the BMC.
> 
> The host may use this to send down a firmware image by staging data at a
> specific memory address, and in a coordinated effort with the BMC's
> software stack and kernel, transmit the bytes.
> 
> This driver enables the BMC to unlock the PCI bridge on demand, and
> configure it via ioctl to allow the host to write bytes to an agreed
> upon location.  In the primary use-case, the region to use is known
> apriori on the BMC, and the host requests this information.  Once this
> request is received, the BMC's software stack will enable the bridge and
> the region and then using some software flow control (possibly via IPMI
> packets), copy the bytes down.  Once the process is complete, the BMC
> will disable the bridge and unset any region involved.
> 
> The default behavior of this bridge when present is: enabled and all
> regions marked read-write.  This driver will fix the regions to be
> read-only and then disable the bridge entirely.

A complete drive by review, so I could be completely off here (most
likely am), but have you considered using virtio and doing some sort of
rudimentary features (regions here) negotiation over that interface?

If I get your description right in premise maybe emulating the AHB side
on the BMC as a PCI end-point device driver, and using it as a seemingly
regular PCI EP from the host side with BARs and stuff might make sense
here and be less of a security hole than it currently looks like.
-- 
Florian
