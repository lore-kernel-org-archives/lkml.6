Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656FBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196D02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196D02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJKAjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:39:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbeJKAjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:39:46 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B14996DDC489E;
        Thu, 11 Oct 2018 01:16:37 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Thu, 11 Oct 2018
 01:16:38 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Question on FIELD_PREP() for static array
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, <johannes@sipsolutions.net>,
        <jakub.kicinski@netronome.com>, <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <c8594a75-964b-01b0-382e-88bcb5b462f2@huawei.com>
Date:   Wed, 10 Oct 2018 18:16:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(to: get_maintainers -f include/linux/bitfield.h)

Hi,

I would like to use FIELD_PREP() macro for assigning a static array, 
like this:
function()
{
	static u32 val[2] = {FIELD_PREP(GENMASK_ULL(10, 0), 5), 0};

}

However the compiler complains of non-const expression:
./include/linux/bitfield.h:88:2: error: initializer element is not constant
    ({        \

Specifically it doesn't like the __BF_FIELD_CHECK() in FIELD_PREP().

Any ideas on compiler trickery we could do with the FIELD_PREP() 
definition to avoid this issue (i.e. enforce the check but only use the 
constant value)?

Thanks in advance,
John

