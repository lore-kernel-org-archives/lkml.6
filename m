Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEGNFZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:05:25 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46837 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEGNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:05:22 -0400
X-Google-Smtp-Source: AB8JxZpwxN+5hytIjdgiFYKUNseTrbTxbgDkYmdrRjDg6KnzEefvgTjOK7Nbm3YxDYEf/1MC2Ron7Q==
Subject: Re: [V2 PATCH 00/11] lightnvm: pblk: small fixes
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5f93b0a3-cc8e-0c16-d01f-c3c1fdf5642f@lightnvm.io>
Date: Mon, 7 May 2018 15:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 11:09 AM, Javier González wrote:
> Changes since V1 (from Matias):
>   - Improve commit messages
>   - Fix error code on read path refactoring
> 
> Changes can be found at. This includes this series, the 2 extra patches I sent
> for pblk and Hans' write recovery on top.
> 	https://github.com/OpenChannelSSD/linux/tree/for-4.18/pblk
> 
> A bunch of small fixes and extra checks for pblk. Non is critical, though
> ("lightnvm: pblk: check for chunk size before allocating it") might be nice to
> get into 4.17 as it is a fix for the 2.0 pblk patches.
> 
> Javier
> 
> Javier González (11):
>    lightnvm: pblk: fail gracefully on line alloc. failure
>    lightnvm: pblk: recheck for bad lines at runtime
>    lightnvm: pblk: check read lba on gc path
>    lightnvn: pblk: improve error msg on corrupted LBAs
>    lightnvm: pblk: warn in case of corrupted write buffer
>    lightnvm: pblk: return NVM_ error on failed submission
>    lightnvm: pblk: remove unnecessary indirection
>    lightnvm: pblk: remove unnecessary argument
>    lightnvm: pblk: check for chunk size before allocating it
>    lightnvn: pass flag on graceful teardown to targets
>    lightnvm: pblk: remove dead function
> 
>   drivers/lightnvm/core.c      | 10 +++---
>   drivers/lightnvm/pblk-core.c | 86 ++++++++++++++++++++++++++------------------
>   drivers/lightnvm/pblk-gc.c   | 10 +++---
>   drivers/lightnvm/pblk-init.c | 38 ++++++++++++--------
>   drivers/lightnvm/pblk-map.c  | 33 ++++++++++++-----
>   drivers/lightnvm/pblk-rb.c   |  5 ++-
>   drivers/lightnvm/pblk-read.c | 75 ++++++++++++++++++++++++++++----------
>   drivers/lightnvm/pblk.h      |  7 ++--
>   include/linux/lightnvm.h     |  2 +-
>   9 files changed, 174 insertions(+), 92 deletions(-)
> 

Applied for 4.18.
