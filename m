Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B947C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAAC21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Nb9+utIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAAC21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeIZPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:40:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42398 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbeIZPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:40:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so1250418edr.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhejO/DktRJf7LBGlHCpVXGMIE5pxjaSeDyBO5GVSX0=;
        b=Nb9+utIoJg5smgtAgf8Pgg2aoEXgvryzX6OMadvcgDAASufPmwqmNGMZyLFMrklvoX
         DJvEDNxuTsU3kbBtCk5U+SdnGyEqBg1GGIzY6/pHlG7v01ASYSyERkJR+pG4PvLLpKVH
         vTLU4nImhd4rGBVqpz6QizNvkzosJTAzpjA6YXzjCrj9wf+eELkXahzjRNUhDhk6BAeI
         4RG0EjaNkReLgxdxQaQMMC1KBgKFVQqEuMp79gIfftCoU9ZE3/9IBhdhsJ0sCKuxeOO/
         01olWEt6ftRg+8UPbCtUwtCEZNMQUGsv390ZIkk7gRNmfbvZyzpp0hXL4Zy7Fwr8j8Be
         lTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhejO/DktRJf7LBGlHCpVXGMIE5pxjaSeDyBO5GVSX0=;
        b=m7UEA79VD4BS0DBvCDXFVWLVDbY0627KxDH4MoEkUuld9n8HJi+oatWi2afT1meJKS
         K8Lz3CHK44mV0CudCrelQ2chdSfG/NMI382kxnQYwgo9NqP7MsOBNtj8UuZVFOPC2eWT
         fIol5AB//hhc9zSy4ZeWiKc7APxaGcZ/NvZlTfPr8fMTGejznV9874PcN4wL9s04kEl5
         5IPpE7umZQrjK5FfMWsiHNofaTO5+Ohf0cnNTm3S795Im44jvOBJObTg51BXC7/SzaUy
         t5hLnGTVqq5YemIuVJflLkn5MH13MqopUB4zyEVRTstjcdtpHueG8L0ZBEGwQt19yc8T
         Z6Ww==
X-Gm-Message-State: ABuFfoh8Q6JBhKYMTkwNwbMERPdHcTifn632mbjmNyzsaD+ilCe8wRqS
        Od8Ziu5hH8kj5IbjzQ/FeywXpEddItKpgQ==
X-Google-Smtp-Source: ACcGV62fJMsELY7O9zhZ+nR+QjnjdX1xqIRoYbJNLOmRg+wir2p0x9X7iPO4o7scnqxzGjQkLNtBNA==
X-Received: by 2002:aa7:d616:: with SMTP id c22-v6mr8799272edr.240.1537954082492;
        Wed, 26 Sep 2018 02:28:02 -0700 (PDT)
Received: from shemminger-XPS-13-9360 ([213.244.170.154])
        by smtp.gmail.com with ESMTPSA id j23-v6sm8280325edh.29.2018.09.26.02.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 02:28:02 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:27:59 +0100
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     =?UTF-8?B?SMOla29u?= Bugge <Haakon.Bugge@oracle.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: if_arp: use define instead of hard-coded value
Message-ID: <20180926102759.52c06799@shemminger-XPS-13-9360>
In-Reply-To: <20180921103930.1420679-3-Haakon.Bugge@oracle.com>
References: <20180921103930.1420679-1-Haakon.Bugge@oracle.com>
        <20180921103930.1420679-3-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 12:39:30 +0200
H=C3=A5kon Bugge <Haakon.Bugge@oracle.com> wrote:

> uapi/linux/if_arp.h includes linux/netdevice.h, which uses
> IFNAMSIZ. Hence, use it instead of hard-coded value.
>=20
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>

I tested build of iproute2 with updated header and there is no issue.

Tested-by: Stephen Hemminger <stephen@networkplumber.org>
