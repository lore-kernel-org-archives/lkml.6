Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEKVNo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:13:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38776 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbeEKVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:13:41 -0400
X-Google-Smtp-Source: AB8JxZrOSE8azWh0pG2/xS/COZBTucu78tZ1pElEsTq+e71MVqtCQeinrmLJKq4JicsJRTHpoE+erQ==
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
To: Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Ingo Molnar <mingo@kernel.org>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b3970608-95dd-3d4f-140c-3d7cbd12cf8d@kernel.dk>
Date: Fri, 11 May 2018 15:13:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180509013358.16399-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/18 7:33 PM, Kent Overstreet wrote:
>  - Add separately allowed mempools, biosets: bcachefs uses both all over the
>    place
> 
>  - Bit of utility code - bio_copy_data_iter(), zero_fill_bio_iter()
> 
>  - bio_list_copy_data(), the bi_next check - defensiveness because of a bug I
>    had fun chasing down at one point
> 
>  - add some exports, because bcachefs does dio its own way
>  - show whether fua is supported in sysfs, because I don't know of anything that
>    exports whether the _block layer_ specifically thinks fua is supported.

Looked over the series, and looks like both good cleanups and optimizations.
If we can get the mempool patch sorted, I can apply this for 4.18.

-- 
Jens Axboe
