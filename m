Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6914BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17577216E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BV3h+zr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17577216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeHJKou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:44:50 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58768 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeHJKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:44:50 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7A8CcV0053278;
        Fri, 10 Aug 2018 03:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533888758;
        bh=/VBXEJ7Bd+LqYj6f6c/SJkqqcpYT+glZgN7Apv9qC98=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BV3h+zr9F3SXY+dHvLvwg6dAPDDAS1bypstMiRgm+BUkcngVAPnVRHvPkfvvAhwor
         W5kSSjKMc8rlF7zIS7CsMwQHhgc05FdBRFFd6kG6hu8Rs9EedHc7xMPgM4ogAZ3x4T
         +jPzx2WTJnIpWwRnJqeJtKhAXMsXlM2Po63Z5Tf4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7A8Ccdb006979;
        Fri, 10 Aug 2018 03:12:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 10
 Aug 2018 03:12:37 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 10 Aug 2018 03:12:37 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7A8CRPN001830;
        Fri, 10 Aug 2018 03:12:28 -0500
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808155548.s7p4xqsjywz3psrj@ninjato>
 <CAMpxmJXVNiyqF4qaYtNhPUG3mSZVdvBSGUqDYK-nh59BKeh=Gw@mail.gmail.com>
 <20180808164402.GH7275@lunn.ch>
 <CAMRc=McfSZQvdXgrKDagb_TE1g-WzEhSpst1z_o5Z994cv3MjA@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <78917b7c-fb9b-2f88-1813-8cf951e60677@ti.com>
Date:   Fri, 10 Aug 2018 13:42:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McfSZQvdXgrKDagb_TE1g-WzEhSpst1z_o5Z994cv3MjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Wednesday 08 August 2018 10:22 PM, Bartosz Golaszewski wrote:
> 2018-08-08 18:44 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> On Wed, Aug 08, 2018 at 06:27:25PM +0200, Bartosz Golaszewski wrote:
>>> 2018-08-08 17:55 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
>>>> On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> This is a follow-up to the previously rejected series[1] which partially
>>>>> removed the at24_platform_data structure. After further development and
>>>>> taking reviews into account, this series finally removes that struct
>>>>> completely but not without touching many different parts of the code
>>>>> base.
>>>>>
>>>>> Since I took over maintainership of the at24 driver I've been working
>>>>> towards removing at24_platform_data in favor for device properties.
>>>>
>>>> Wooha, nice work. I can't really comment on it but wondered how you want
>>>> to upstream it (after reviews)? Pull request of an immutable branch for
>>>> nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
>>>> it. Probably same situation for arm-soc...
>>>>
>>>
>>> I initially wanted to merge small parts of it starting with v4.18, but
>>> there were some voices against merging APIs without users. I'm not
>>> sure how it should go in. There'll be a need for multiple immutable
>>> branches most probably...
>>
>> Hi Bartosz
>>
>> What this series does is show all the different parts are now
>> available, and can be reviewed as a whole. Once that review is
>> completed, merging in parts then becomes possible.
>>
>> It looks like you could probably merge the nvmem, mtd and net parts
>> independently via there maintainers for 4.20, since i don't think
>> there are any dependencies. The arm-soc changes in 4.21, and the
>> removal of the platform data in 4.22?
>>
>>      Andrew
> 
> We need the first batch of SoC changes for the net part and then the
> second batch depends on those net changes. Also: dragging the merge
> for this over a year is a bit overkill.
> 
> Sekhar: I know you're usually provided with immutable branches from
> framework maintainers for the SoC changes - is it ok for you to
> provide the net maintainers with an immutable branch after applying
> the first part of davinci board file changes?

Yeah, sure. I will be happy to do that to speed merging. Will take a
look at v2 you posted.

Thanks,
Sekhar
