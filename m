Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032423AbeBOAzY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:55:24 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:39621 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032245AbeBOAzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:55:22 -0500
X-Google-Smtp-Source: AH8x224cNspxMmzo4eoqc42fjjQO0Ti2IrbDPyYcYtDhe/cXzGCPcJdv+45PUgzS+5WfLQVOE8b4HA==
Subject: Re: [PATCH] of: add early boot allocation of
 of_find_node_by_phandle() cache
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518655465-10759-1-git-send-email-frowand.list@gmail.com>
Message-ID: <96984f12-dff6-73e9-8f45-9573cb9ca4e5@gmail.com>
Date: Wed, 14 Feb 2018 16:55:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518655465-10759-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/18 16:44, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The initial implementation of the of_find_node_by_phandle() cache
> allocates the cache using kcalloc().  Add an early boot allocation
> of the cache so it will be usable during early boot.  Switch over
> to the kcalloc() based cache once normal memory allocation
> becomes available.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> This patch is optional, to be added at Rob's discretion.  The
> extra complexity is not as much as I had feared, but the boot
> speed up is also likely small.

This patch applies on top of:

[PATCH v3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
