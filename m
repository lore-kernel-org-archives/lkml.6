Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B94C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319DB20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7LNnxFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319DB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeKTAh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:37:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38953 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeKTAh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:37:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id b13so32212567wrx.6;
        Mon, 19 Nov 2018 06:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1F9gfMx0Svn6fNz1X+fiNUl5m+Ih7cGroWrZQMkcmvI=;
        b=C7LNnxFtRG9wj9XdBhMzD+CmObA+STGsctcN8K/VEuUuLvST3s9dnW8xMt4w2vr9WE
         j+fJhjCtWAMD7K8xRQT5wGxY8GtqlGTqdVvKD6aSHgnrlCwbe9ct5u4FS99VTkwN2SxT
         klRntyktbBnuXOYuy7IIMS1Se1mi+qt+F+vPQuVxF8el/mQyae2DiQ4QAHMSwIp9Wkiw
         04XXfVajMWAJcXHBr4EmPnke9vGDg/YBMdQoOIpuHO5/L7s/6h95F2nLMbCy0YAb7DTN
         98LsGO7ntRzGR6AUYHy5nievDNG8WvMrE8DZHeaiQJNW8A7wThq9vuLnSglOWrwxzFl9
         EpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1F9gfMx0Svn6fNz1X+fiNUl5m+Ih7cGroWrZQMkcmvI=;
        b=JFODoo3ftaE2QLv5ENK2gQOIxbXIP8mwffmJTjjtnIa6c4hemUHNM0qc9F/tPCvnbD
         V5MLwyB3++x7Nle5Nqte3R0kVqp8ZwuW9MXpYo+afez/GmnfnsSNMDQo1/+Ak/dNVZII
         5A4Tb53+xvx9+2c9cBnO/t40hn5nZYHfRmM1YYHoTGPJf3bIriw7Te75qTc3aYYgZajB
         8sN3pZ1KdjNZ8ETmI+a7JBcgG7atEnL+3at8ZU/JTk72kYFR97F1kY4UYkgznqkdbOeB
         ybgBEOWJ6FZZk8meYIQoQ9YjwloxRBqh+pSjYXc4c0meqVs5U2ufTqgb2mdOBDrrAz23
         Rmbg==
X-Gm-Message-State: AGRZ1gKbM9B2knhDF1ad+91/odOueP/QpuJpcBuNR2Nepcej1gXhpzdd
        ZQalOMmfUx7eH3QD49kReJw=
X-Google-Smtp-Source: AJdET5cdZkgzwWtEpC7DHnFYFo5KAWlFAfNq1FS1WhDQ6f5a/Y9dUsI517AHzCCDMzIFSRj7wWkqWA==
X-Received: by 2002:adf:f38f:: with SMTP id m15mr18396001wro.111.1542636849504;
        Mon, 19 Nov 2018 06:14:09 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id l17-v6sm37293894wrb.86.2018.11.19.06.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 06:14:08 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
 <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
 <20181119151009.490413d9@bbrezillon>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b22b9bb3-17e3-1971-6986-33132c5ae232@gmail.com>
Date:   Mon, 19 Nov 2018 15:14:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181119151009.490413d9@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 03:10 PM, Boris Brezillon wrote:
> On Mon, 19 Nov 2018 14:49:31 +0100
> Marek Vasut <marek.vasut@gmail.com> wrote:
> 
>> On 11/19/2018 11:01 AM, Mason Yang wrote:
>>> Document the bindings used by the Renesas R-Car D3 RPC controller.
>>>
>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>> ---
>>>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
>>>  1 file changed, 33 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>> new file mode 100644
>>> index 0000000..8286cc8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>>> @@ -0,0 +1,33 @@
>>> +Renesas R-Car D3 RPC controller Device Tree Bindings
>>> +----------------------------------------------------
>>> +
>>> +Required properties:
>>> +- compatible: should be "renesas,rpc-r8a77995"
>>> +- #address-cells: should be 1
>>> +- #size-cells: should be 0
>>> +- reg: should contain 2 entries, one for the registers and one for the direct
>>> +       mapping area
>>> +- reg-names: should contain "rpc_regs" and "dirmap"
>>> +- interrupts: interrupt line connected to the RPC SPI controller  
>>
>> Do you also plan to support the RPC HF mode ? And if so, how would that
>> look in the bindings ?
> 
> Not sure this approach is still accepted, but that's how we solved the
> problem for the flexcom block [1].
> 
> [1]https://elixir.bootlin.com/linux/v4.20-rc3/source/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

That looks pretty horrible.

In U-Boot we check whether the device hanging under the controller node
is JEDEC SPI flash or CFI flash and based on that decide what the config
of the controller should be (SPI or HF). Not sure that's much better,but
at least it doesn't need extra nodes which do not really represent any
kind of real hardware.

-- 
Best regards,
Marek Vasut
