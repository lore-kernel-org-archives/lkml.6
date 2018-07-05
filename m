Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05853C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB19C240F1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB19C240F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeGEOIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:08:53 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:42473 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753323AbeGEOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:08:51 -0400
Received: from [IPv6:2001:983:e9a7:1:de5:ba8:3e5e:1644] ([IPv6:2001:983:e9a7:1:de5:ba8:3e5e:1644])
        by smtp-cloud9.xs4all.net with ESMTPA
        id b4wCfipEnEJtcb4wDfAvlQ; Thu, 05 Jul 2018 16:08:50 +0200
Subject: Re: [PATCH v5 00/27] Venus updates
To:     Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org, Alexandre Courbot <acourbot@chromium.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
 <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <150eb3b4-8b64-6050-6a4e-e06cfaf113cc@xs4all.nl>
Date:   Thu, 5 Jul 2018 16:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMG9o2xqWlYGmM1SiUjwmyY2GHy2E6NZk9DE1iewD9xBVOHdRnvReAfl7BOvqWtjiT9bQTolA5VNiYk946fsDukzegStcGgR9ojm6+hvBqIVtLDEBODC
 KaoXGP+gvMdnFh/ynnbD+eYta5DTr+s83xb3hiYUfosYCnShoiAXqGdj+O93/I9fh85vE2cfP8odTi3fRTpG06fvD1nGGzuM3rsQ8Yd7jXWLACk68555FJXZ
 ZDVUpQvP2gd7r8lOptx6vjqzuudsD08H34mYPRGtfhXzcxV58uFCJwOrW+84ttgdDPrY/w9lZ2YOuBq+YLe7s6vQLjBo497K6QYjTBGryCR9BhIGLITHzmnX
 uNuRBUh6IksAgnwYnv5G1rQUbGZelFzYdM1v2/RIHngRXCwU+pVzVMGrpd++ppIiZiTuvpbkrHKRlptYO6Dq+VKNh2zwEUtgH0fF0EWkvBstiBC/Ny8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/18 16:07, Tomasz Figa wrote:
> Hi Stanimir,
> 
> On Thu, Jul 5, 2018 at 10:05 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi,
>>
>> Changes since v4:
>>  * 02/27 re-write intbufs_alloc as suggested by Alex, and
>>    moved new structures in 03/27 where they are used
>>  * 11/27 exit early if error occur in vdec_runtime_suspend
>>    venc_runtime_suspend and avoid ORing ret variable
>>  * 12/27 fixed typo in patch description
>>  * added a const when declare ptype variable
>>
>> Previous v4 can be found at https://lkml.org/lkml/2018/6/27/404
> 
> Thanks for the patches!
> 
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Are we waiting for anything else? Otherwise I plan to make a pull request for
this tomorrow.

Regards,

	Hans
