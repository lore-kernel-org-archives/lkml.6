Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB2DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC49F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wz38acOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC49F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeGTGGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:06:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34186 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeGTGGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:06:00 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6K5I3Rr083207;
        Fri, 20 Jul 2018 00:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532063884;
        bh=ZXc8xfKsQw8AsSQ9evmoTs5ZawEoc7V/PgQhdfE65nA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Wz38acOxptFiTi4hDhrnSbfYUuT9fk0j4ZlNnc2sBY6nUXKLBb5QDJJVOSmBz3YQh
         9iCUJHMIXzSJGrNWZK0XI53hztSrAKRbHBlUNN5kI6UzRBtUFmjl7GgdkOpuxoWG0L
         zeCnNUwGFXPpaJtpDSr6DB2zEC90jlmXVaOv9LLg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6K5I3qk021755;
        Fri, 20 Jul 2018 00:18:03 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 20
 Jul 2018 00:18:03 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 20 Jul 2018 00:18:03 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6K5HqND018832;
        Fri, 20 Jul 2018 00:17:53 -0500
Subject: Re: [PATCH 5/5] net: add MTD support to
 eth_platform_get_mac_address()
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>
CC:     Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-6-brgl@bgdev.pl> <20180718164737.GE12477@lunn.ch>
 <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch>
 <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch>
 <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
 <20180719152712.GE9119@lunn.ch>
 <CAMRc=MeqnRXF_R1J5G8ySvCr8pZhZMHiV3WHNFun=d8GjiOT9A@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <0355bdd8-f544-c462-99e8-da94488067bb@ti.com>
Date:   Fri, 20 Jul 2018 10:47:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeqnRXF_R1J5G8ySvCr8pZhZMHiV3WHNFun=d8GjiOT9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 July 2018 09:05 PM, Bartosz Golaszewski wrote:
> 2018-07-19 17:27 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>>> Unfortunately: this would effectively block me from improving the
>>> support for older davinci boards.
>>
>> Is there something blocking you from converting the board to device
>> tree? This is something i did with a lot of the Marvell boards a few
>> years ago. For a while, we had both DT and board setup files. After a
>> couple of cycles, we killed off the setup files.
>>
>>        Andrew
> 
> Actually some board are supported both in DT and board files
> (da850-evm) right now, but Sekhar wants to keep the support via board
> files in the kernel so that's a no go.

Its not that I want it that way, but we cannot get rid of board files
till DT has equivalent support.

The bigger issue is not on DA850, but on the 5 older DaVinci SoCs which
do not support device-tree based boot today.

Thanks,
Sekhar
