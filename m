Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933849AbeEIK4o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:56:44 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:46145 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeEIK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:56:43 -0400
X-IronPort-AV: E=Sophos;i="5.49,381,1520899200";
   d="scan'208";a="72822053"
Subject: Re: [Xen-devel] [PATCH v2 1/3] xen/pvh: enable and set default MTRR
 type
To: Roger Pau Monne <roger.pau@citrix.com>, <linux-kernel@vger.kernel.org>
CC: Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20180509102129.14832-1-roger.pau@citrix.com>
 <20180509102129.14832-2-roger.pau@citrix.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Message-ID: <fbe18be3-0e2e-723f-a625-015c6aad89a3@citrix.com>
Date: Wed, 9 May 2018 11:56:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509102129.14832-2-roger.pau@citrix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/18 11:21, Roger Pau Monne wrote:
> On PVH MTRR is not initialized by the firmware (because there's no
> firmware), so the kernel is started with MTRR disabled which means all
> memory accesses are UC.
>
> So far there have been no issues (ie: slowdowns) caused by this
> because PVH only supported DomU mode without passed-through devices,
> so Xen was using WB as the default memory type instead of UC.
>
> Fix this by enabling MTRR and setting the default type to WB. Linux
> will use PAT to set the actual memory cache attributes.
>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

I'd argue that this is a bug in PVH starting state.

Do you know what mechanism is used to bodge things to WB in the first
place?  I'm not sure that setting the default MTRR type is going to be a
clever idea in hindsight when we come to doing PCI Passthrough support.

~Andrew
