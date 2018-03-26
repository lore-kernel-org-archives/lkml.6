Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeCZQTB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:19:01 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:46582 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeCZQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:19:00 -0400
X-Google-Smtp-Source: AG47ELuHtA3fyro0k5vn+W9xN8eVmtvqz6gkkwE2sDs/fMytOtF+5RuBbRIBKvBdRCspyZ9pKXiglg==
Subject: Re: [PATCH BUGFIX] block, bfq: lower-bound the estimated peak rate to
 1
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        khlebnikov@yandex-team.ru
References: <20180326140624.2295-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5035d1cf-f9ff-013f-87d8-19891d5e8df0@kernel.dk>
Date: Mon, 26 Mar 2018 10:18:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180326140624.2295-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/18 8:06 AM, Paolo Valente wrote:
> If a storage device handled by BFQ happens to be slower than 7.5 KB/s
> for a certain amount of time (in the order of a second), then the
> estimated peak rate of the device, maintained in BFQ, becomes equal to
> 0. The reason is the limited precision with which the rate is
> represented (details on the range of representable values in the
> comments introduced by this commit). This leads to a division-by-zero
> error where the estimated peak rate is used as divisor. Such a type of
> failure has been reported in [1].
> 
> This commit addresses this issue by:
> 1. Lower-bounding the estimated peak rate to 1
> 2. Adding and improving comments on the range of rates representable

Applied for 4.17, thanks.

-- 
Jens Axboe
