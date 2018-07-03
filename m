Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9168CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A262086E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VXKsxbqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A262086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbeGCVxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:53:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39929 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeGCVxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:53:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so3686162wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yITvdTPMeVytcMHJQWI6CKo632C59d05vuqq4Q5mUWs=;
        b=VXKsxbqKhg/YSPlN3Db+jH71oMl9aq66w4yfXstbPBeopF1y6exy0tmzR5gGp+Qn9/
         JEaf8mK3owcpmYF9LIEIfGuBA3Lcz1a2JqRwxQ8ZHBfUVYJouF97t7VD82XTjvmBanh0
         y48If2SfdaPxXl8XxsgZn4+GUQd2MBRUD/AKwpAO4F+soVOtZzxxKehkbxVX7CyF8EfO
         BjUc7SiPjqoujAok3VHq7qgYdcSCWMCPh68v4KQVMYcaP6C2r9O5++aEwVPJWioQP2KD
         88GfmLFi20vUBJ7toBDeTqIarDcPvLumPmYFXbHOcUOJUGwXfsMpHbFErXfBB0KXKstn
         7nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yITvdTPMeVytcMHJQWI6CKo632C59d05vuqq4Q5mUWs=;
        b=WL8C2fieUn9G3Bjqn8eVIyg9NexOGLdFw7Z67VCM3KaOEaVS3QG94qe13RKOWcBpQq
         UryZaLHcYz2kSfO71hQbRuGvN4jjb40M+D4r2EjBR18OvhPnuAqEo6852CEfkUqIRZgg
         EGxfnbWGsW9zcqw/X+EKfTWq3wcTaimzPkzA9w5d2mQw/N1l5iCGQuZsAjT2qZbwSMpI
         8UA5zlDGSYl9cvUbWko3+UP3bm7xiu2CeE5EFBYeu5Nji+LVk1jTa3jkBP3Jjngq5GmF
         odsWz0YDpQxVSy2As4dIyxAP6q2Cq8Omf3t+Bp64J0QhvMfGxiJOarzUZugGZFF2P6cq
         nazQ==
X-Gm-Message-State: APt69E21rhEaC+6NWqMDb/ojWSogi9gM26PEj92H+dnEpqoHQpx4q5Xy
        sWTpQMHKnWZbXHGpZ4KzG2MpWw==
X-Google-Smtp-Source: AAOMgpdlB5JLnSpS65ihPJQgud3nlt/hd1NGcmzJH0mW5Lv4r8kbBYqY7T5qUQE+D5kbjCnP5kaVoQ==
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr12461218wmc.138.1530654808801;
        Tue, 03 Jul 2018 14:53:28 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 189-v6sm5058184wmy.25.2018.07.03.14.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 14:53:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1faTEj-0007ZX-1Y; Tue, 03 Jul 2018 15:53:25 -0600
Date:   Tue, 3 Jul 2018 15:53:25 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     linux-rdma@vger.kernel.org, Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmw_pvrdma: Release netdev when vmxnet3 module is
 removed
Message-ID: <20180703215325.GA29072@ziepe.ca>
References: <20180628135938.19625-1-nhorman@tuxdriver.com>
 <20180629115206.18787-1-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629115206.18787-1-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 07:52:06AM -0400, Neil Horman wrote:
> On repeated module load/unload cycles, its possible for the pvrmda
> driver to encounter this crash:
> 
> ...
> 297.032448] RIP: 0010:[<ffffffff839e4620>]  [<ffffffff839e4620>] netdev_walk_all_upper_dev_rcu+0x50/0xb0
> [  297.034078] RSP: 0018:ffff95087780bd08  EFLAGS: 00010286
> [  297.034986] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff95087a0c0000
> [  297.036196] RDX: ffff95087a0c0000 RSI: ffffffff839e44e0 RDI: ffff950835d0c000
> [  297.037421] RBP: ffff95087780bd40 R08: ffff95087a0e0ea0 R09: abddacd03f8e0ea0
> [  297.038636] R10: abddacd03f8e0ea0 R11: ffffef5901e9dbc0 R12: ffff95087a0c0000
> [  297.039854] R13: ffffffff839e44e0 R14: ffff95087a0c0000 R15: ffff950835d0c828
> [  297.041071] FS:  0000000000000000(0000) GS:ffff95087fc00000(0000) knlGS:0000000000000000
> [  297.042443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  297.043429] CR2: ffffffffffffffe8 CR3: 000000007a652000 CR4: 00000000003607f0
> [  297.044674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  297.045893] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  297.047109] Call Trace:
> [  297.047545]  [<ffffffff839e4698>] netdev_has_upper_dev_all_rcu+0x18/0x20
> [  297.048691]  [<ffffffffc05d31af>] is_eth_port_of_netdev+0x2f/0xa0 [ib_core]
> [  297.049886]  [<ffffffffc05d3180>] ? is_eth_active_slave_of_bonding_rcu+0x70/0x70 [ib_core]
> ...
> 
> This occurs because vmw_pvrdma on probe stores a pointer to the netdev
> that exists on function 0 of the same bus/device/slot (which represents
> the vmxnet3 ethernet driver).  However, it never removes this pointer if
> the vmxnet3 module is removed, leading to crashes resulting from use
> after free dereferencing incidents like the one above.
> 
> The fix is pretty straightforward.  vmw_pvrdma should listen for
> NETDEV_REGISTER and NETDEV_UNREGISTER events in its event listener code
> block, and update the stored netdev pointer accordingly.  This solution
> has been tested by myself and the reporter with successful results.
> This fix also allows the pvrdma driver to find its underlying ethernet
> device in the event that vmxnet3 is loaded after pvrdma, which it was
> not able to do before.
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> Reported-by: ruquin@redhat.com
> CC: Adit Ranadive <aditr@vmware.com>
> CC: VMware PV-Drivers <pv-drivers@vmware.com>
> CC: Doug Ledford <dledford@redhat.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: linux-kernel@vger.kernel.org
> Tested-by: Adit Ranadive <aditr@vmware.com>
> Acked-by: Adit Ranadive <aditr@vmware.com>
> ---
> Change notes
> 
> v2)
>  * Move dev_hold in pvrda_pci_probe to below null check (aditr)
>  * Add dev_puts to probe error path and pvrda_pci_remove (jgg)
>  * Cleaned up some checkpatch warnings (nhorman)
> ---
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 39 ++++++++++++++++++-
>  1 file changed, 37 insertions(+), 2 deletions(-)

Appled to for-next

Thanks,
Jason
