Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeDJIpU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:45:20 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:28561 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeDJIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:45:17 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="51099963"
Date: Tue, 10 Apr 2018 09:35:44 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <jgross@suse.com>, Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen/pvh: Indicate
 XENFEAT_linux_rsdp_unrestricted to Xen
Message-ID: <20180410083544.q54rapngqie4ler3@citrix.com>
References: <1523299904-18199-1-git-send-email-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1523299904-18199-1-git-send-email-boris.ostrovsky@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 02:51:44PM -0400, Boris Ostrovsky wrote:
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

Reviewed-by: Wei Liu <wei.liu2@citrix.com>
