Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeDJFcr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:32:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58291 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbeDJFcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:32:47 -0400
Subject: Re: [PATCH] xen/pvh: Indicate XENFEAT_linux_rsdp_unrestricted to Xen
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1523299904-18199-1-git-send-email-boris.ostrovsky@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <c5b43925-4ee4-f64f-a044-3217d8cb116a@suse.com>
Date: Tue, 10 Apr 2018 07:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523299904-18199-1-git-send-email-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/18 20:51, Boris Ostrovsky wrote:
> Pre-4.17 kernels ignored start_info's rsdp_paddr pointer and instead
> relied on finding RSDP in standard location in BIOS RO memory. This
> has worked since that's where Xen used to place it.
> 
> However, with recent Xen change (commit 4a5733771e6f ("libxl: put RSDP
> for PVH guest near 4GB")) it prefers to keep RSDP at a "non-standard"
> address. Even though as of commit b17d9d1df3c3 ("x86/xen: Add pvh
> specific rsdp address retrieval function") Linux is able to find RSDP,
> for back-compatibility reasons we need to indicate to Xen that we can
> handle this, an we do so by setting XENFEAT_linux_rsdp_unrestricted
> flag in ELF notes.
> 
> (Also take this opportunity and sync features.h header file with Xen)
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
