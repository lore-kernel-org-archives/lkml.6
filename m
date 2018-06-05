Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeFEPUV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:20:21 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:51580 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbeFEPUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:20:18 -0400
X-Google-Smtp-Source: ADUXVKKUFITR6fsZw4G9xnwF7Byl73O7glZoPZlbQONvDhhOH9m/NXiKU1xAQvzUVgm03bTVM5Ring==
Subject: Re: [PATCH][next] lightnvm: pblk: fix resource leak of invalid_bitmap
To: Colin King <colin.king@canonical.com>,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180605151456.20359-1-colin.king@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5b0a3b83-5e7d-679e-f2a4-a9305da7c472@kernel.dk>
Date: Tue, 5 Jun 2018 09:20:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180605151456.20359-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/18 9:14 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the error exit path when the emeta could not be
> interpreted is via fail_free_ws and this fails to free
> invalid_bitmap.  Fix this by adding another exit label and
> exiting via this to kfree invalid_bitmap.
> 
> Detected by CoverityScan, CID#1469659 ("Resource leak")

Looks good, applied.

-- 
Jens Axboe
