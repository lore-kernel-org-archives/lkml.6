Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77066C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DE726DAC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNhJv9bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DE726DAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933628AbeFZUaU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:30:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40070 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbeFZUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:30:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so8598534pfe.7;
        Tue, 26 Jun 2018 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K2sngbATib69Jr7lmX6FSNeYGWGovLUmKz581Pr+41A=;
        b=bNhJv9bSGSA6q5NTFzHQIKpzVnndnGUe9uU2TAs/U7jXodF8HXKseZaXpjQRw7sfVD
         OVY1vmHJjwNInWMBzSxWGnEqMl1MSjKq0gD0Ozg7+s1kGrt+4Rn2pggnFQ9+GXXvfo4X
         VVE8Jj3LFdmnu48f00pPYtI4Di2hy2cv1aFlzogY6vu2KBDQHBNlJBihnMQW7cydurgo
         VDXTPsCkaiWxVOgsGi5f0Kp7WNK5sN2Bv8vhOUaDGSjNgNvvec63bYPLmPEarnSUgfim
         89oV/wH9arCJIeVueEy7XMR8SlYZzBlTnzIWSbRKqb5cqJtevDgOgl0NFvebFWFQtSjf
         RIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K2sngbATib69Jr7lmX6FSNeYGWGovLUmKz581Pr+41A=;
        b=ebi3Ox6uKQpFwCPTOXpoIEF6xrazfwbsxJpQLiTN2TaWw+km6JltA0s1Vj4+YjTwzX
         J8conQAyR1cI/EBdKB/rw2QRwDHMEkZOJEV/Hc47XOvBeNuqbyLw+WlT072qruTUmrJ7
         tpExM7lBmw7Za2t6GUDqgV6POM5Ys2MSnx9A2R2PZnIdChnLRiJ5PPdX+v4OTv7wM453
         FWolGibg7mPh+SZtlwL+xcXYzFi1NxoP/Bkh3sEmDjjXB4e6E6kXTtbmtmXKzJlfCE73
         s6/tHwySgmmWdEnAKiGMJvC1rGXrs7NLmtZXO6wOEyFIn5x8oh311yx3na3F2eKSuG2T
         GLHQ==
X-Gm-Message-State: APt69E0Bcovor19CBv40RckTiNYKsPJrv4fDiqIhCGKQ+3C1+RzaSFGD
        J+AAnvPKy2HBx9zL/JP4g934oLh7
X-Google-Smtp-Source: AAOMgpeclxMKDIosdezwsS/sHiEbnd+Em/dxnO62Eh7hjzPal/nrYFmH3mA05J8ZUKDaG6T9kaXdpA==
X-Received: by 2002:a62:da07:: with SMTP id c7-v6mr2977662pfh.106.1530045015852;
        Tue, 26 Jun 2018 13:30:15 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id l8-v6sm4147178pfb.102.2018.06.26.13.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 13:30:14 -0700 (PDT)
Subject: Re: [PATCH v3] ARM: dts: BCM5301X: Add support for Linksys EA9500
To:     Vivek Unune <npcomplete13@gmail.com>, hauke@hauke-m.de,
        zajec5@gmail.com, jonmason@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180222223844.98527-1-npcomplete13@gmail.com>
 <20180618174159.86150-1-npcomplete13@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <32c1b4db-acb8-35ae-eab9-f4e85a204e09@gmail.com>
Date:   Tue, 26 Jun 2018 13:30:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618174159.86150-1-npcomplete13@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 10:41 AM, Vivek Unune wrote:
> Hardware Info
> -------------
> 
> Processor	- Broadcom BCM4709C0KFEBG dual-core @ 1.4 GHz
> Switch		- BCM53012 in BCM4709C0KFEBG & external BCM53125
> DDR3 RAM	- 256 MB
> Flash		- 128 MB (Toshiba TC58BVG0S3HTA00)
> 2.4GHz		- BCM4366 4×4 2.4/5G single chip 802.11ac SoC
> Power Amp	- Skyworks SE2623L 2.4 GHz power amp (x4)
> 5GHz x 2	- BCM4366 4×4 2.4/5G single chip 802.11ac SoC
> Power Amp	- PLX Technology PEX8603 3-lane, 3-port PCIe switch
> Ports		- 8 Ports, 1 WAN Ports
> Antennas	- 8 Antennas
> Serial Port	- @J6 [GND,TX,RX] (VCC NC)    115200 8n1
> 
> Tested with OpenWrt built with DSA driver and Kernel v4.14
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

Applied to devicetree/next, thanks Vivek.
-- 
Florian
