Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DF8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EE720834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeLEB5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:57:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34027 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbeLEB5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:57:20 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E288F9C5B26CF;
        Wed,  5 Dec 2018 09:57:16 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Dec 2018
 09:57:07 +0800
CC:     <liuyu712@hisilicon.com>, Wangbinghui <wangbinghui@hisilicon.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 10/12] hikey960: Support usb functionality of Hikey960
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-11-chenyu56@huawei.com>
 <CAHp75VdSowHk4meQqqUamSjJJoVT59+pMZ1qjmmWd-W5nWBcUw@mail.gmail.com>
 <6810012e-9a77-dfdf-a738-14ce77a3027a@huawei.com>
 <CAHp75Vf_nemtPuMZV-1ezyYaB_BuuDM6uqaBf9DLBWLdCnm4Gg@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <a1168f88-5679-6245-41d8-5ef4be5493b2@huawei.com>
Date:   Wed, 5 Dec 2018 09:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf_nemtPuMZV-1ezyYaB_BuuDM6uqaBf9DLBWLdCnm4Gg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/12/5 1:47, Andy Shevchenko wrote:
> On Tue, Dec 4, 2018 at 3:40 AM Chen Yu <chenyu56@huawei.com> wrote:
>> On 2018/12/3 17:23, Andy Shevchenko wrote:
>>> On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
> 
>>>> +               .of_match_table = of_match_ptr(id_table_hisi_hikey_usb),
>>>
>>> Does it compiles for non-OF case? Why macro is in use?
> 
>> OK. I will add the "CONFIG_OF".
> Why? Is this driver supposed to work without DT?
> 
No. This driver should depend on OF.
Can I solve this by add "dpends on OF" in Kconfig?

