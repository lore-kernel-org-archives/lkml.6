Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C15C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D60320883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="gLru+SDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfAHRFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:05:18 -0500
Received: from sonic313-20.consmr.mail.gq1.yahoo.com ([98.137.65.83]:39004
        "EHLO sonic313-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbfAHRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1546967117; bh=STqDwds8ePdJfK//0Qo0Wf5AWgB1io8VzVSRICzDkM0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gLru+SDlRQAeM4+uyh4n9AAcrSO+1/6/vAbDlqytrceJGkf26w1QJQlu6kduPCajVIUmCGqa6acT25nfHeukmUguuS27gxhRLub77cwiMYgFU0ran25g6C3QNSJyKyxZGcvArchf73O2irrvUO1BM0ut+EyKi8ijTI3LuZlQ94DfUGo9zdLq4q96pXTQ9D+VWtCVC6JVnk+2JtEeGH7M5wO29aTal0ReqTAwMEJCC8X7u9WywsQ8KPf9tVSL+ryaxE6dIOkQZKaYySXyJr9zfj7IqR9xPzWkTC/1/n/ZzQrPS9OV9WeW2r7Qwj8GGd+3XaV7OFSQlT/1ws1F7y1DyQ==
X-YMail-OSG: 7KQ_uicVM1lS3NoGhJQYJy1o2Ya3p5NTKuXAGWn.cITUAcfS8hWK6ZyeKkW2iwA
 JPjeoTSVZItcd9ucUEZeG33cLGc8dmUVxlf5n.AEx_w8ArwHpwjjh5Ik1uD9Xta0WVSk8EiWay0_
 eqblhnji5cS7iifEg.3N4obixXejEqIgNXGBgLRtwhjITCJvXAkjW8kPtsY2O.dgTIifJMytzE8m
 QjJ_.0PyaXbhZ7QJ_PEVK8b4PHEUEC5zloEEtcIf93G199sIXXWuC52P9s3HxJZAk3GHd8igPzKs
 4zaOQWvFt79znhthGARuAUcOVr1.6wUvuEscAExmulj3Wl_RYvX1nFaTylKH6elafrxD8i8eLorA
 pjXTqyeTRoep8xe3tKbij1bFE3q2nmmqr5qQ83fYgLAJkRcJiXFHlEligHoTyzqbg6aSIkq3JvTJ
 mjYRz5ElOKFOyobCNq8BXfO1XJDm9zurS7JnLdy1_r3UFPhXlQkw5JsFx059jk4CpcQ0Khwl.dsN
 hhEw67QBckrPx0E3a7qLI7.ZAhib9JpSkN6Fp1mVnfpotN98ayplcv3R8.VTSm6ZlQHe37TSh4oz
 dtELU.DUnffV0pliyBN3LXMCaMlePbPZnVTIyMIOzk2BPOjb4FYVtjNrDipp5eaYuJzbMsIpahgY
 lwugXTOKXxZV7LK2OWXCphmuNLh.iAKgjtmN4SA3oLZzuo3gNkBOrNb8tjiFpRE3kge_zDrokiEW
 3_bRDCO1aS7KvmAGQz3vVibYCtp6HABqnZZsn_oe4UFJ40CXkfcnn6w9vVCRwziG0WP4J3BipMBg
 EmtKuoUslJBJ9ZAUGixsVROzyAz5DvowhrkNjrJ_2CBFu7qdzQQmLZRv9lRF3qHsO68Kse93J_6V
 AtLaK11.kHJo4CUIuXWJcT65OeAW4y1HP7Eo9Dm7746kJHtwox1peyh1r2hGCnzMaIe3mYnowRy8
 52VsqHzRDGm5UPGB7ia0uCEq_TKaCmbjBydgtIVAu3MPrXpxyzhmeI5ifbQ.Lp0LCe3iJqeSYwos
 Rd0yNJi2ZClWNmQkHrZHVHhKrHe88kx8.BtIZFZ.HgsdDc3oZqQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 8 Jan 2019 17:05:17 +0000
Received: from 36.24.136.244 (EHLO [10.1.1.220]) ([36.24.136.244])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7abfa06ab4aec071b88dc865a06abcac;
          Tue, 08 Jan 2019 17:05:14 +0000 (UTC)
Subject: Re: [PATCH v2] staging: erofs: Add identifier for function definition
 arguments
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
References: <20190108132454.20513-1-realwakka@gmail.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <87ae9184-1fb7-fc76-3f06-113c54d2e932@aol.com>
Date:   Wed, 9 Jan 2019 01:05:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108132454.20513-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/8 21:24, Sidong Yang wrote:
> Add identifier for function definition arguments in xattr_iter_handlers,
> this change clears the checkpatch.pl issue and make code more explicit.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

personally looks good to me.

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang
