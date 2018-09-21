Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55E0ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F165321547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F165321547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbeIUUiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:38:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728313AbeIUUiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:38:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30E042337D1E1;
        Fri, 21 Sep 2018 22:49:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 22:49:09 +0800
Message-ID: <5BA504E4.90607@huawei.com>
Date:   Fri, 21 Sep 2018 22:49:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     <airlied@linux.ie>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: sun4i: Fix a uninitialized variable warning.
References: <1537255520-41614-1-git-send-email-zhongjiang@huawei.com> <20180919084719.6ymf6h4eftomfab3@flea> <5BA2106C.2080007@huawei.com> <20180921142654.ahuhswypvscjsuyj@flea>
In-Reply-To: <20180921142654.ahuhswypvscjsuyj@flea>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/21 22:26, Maxime Ripard wrote:
> On Wed, Sep 19, 2018 at 05:01:32PM +0800, zhong jiang wrote:
>> On 2018/9/19 16:47, Maxime Ripard wrote:
>>> On Tue, Sep 18, 2018 at 03:25:20PM +0800, zhong jiang wrote:
>>>> Fix the following compile warning:
>>>>
>>>> drivers/gpu/drm/sun4i/sun4i_tcon.c:1088: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>> bool has_lvds_rst, has_lvds_alt, can_lvds;
>>>>
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> I can't see any code path that would lead to an uninitialized usage of
>>> that variable.
>>>
>>> Which compiler produced that warning? I tried building it today with
>>> gcc 8.1.1, and I don't see that warning either.
>> I indeed  hit the issue.  the gcc version is
>> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
> I've tested with 4.* gcc, and it didn't report any error. It seems to
> be a false positive for this particular version, so there's no need to
> merge that patch. If more people are affected, we'll obviously do
> something about it though.
Yep,  it rarely occur.  I just happen once.  Thank you for reply.

Sincerely,
zhong jiang
> Thanks!
> Maxime
>


