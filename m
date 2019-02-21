Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD04C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C66620880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="tjR3T8yu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4FPsMzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBULtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:49:31 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44341 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbfBULta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:49:30 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 193F72F89;
        Thu, 21 Feb 2019 06:49:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Feb 2019 06:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=16ukAG8arJNroPlaftBt9brS5BK
        z+aSbliLB114YW14=; b=tjR3T8yuOdagu2mhKXGJ9thlWMpi+BEZPs7HNvsrOBR
        Ww8Y/RB47ncZ0wy2pD19KpEarNGZQvq1b4dSsE5Gr4giLUuk8ojpbSqtnf4wjrAF
        u5Kq3e3FHi7Bcf4q0Fa/9EOnCqlBSt7hfmaVMHCmrV5u09AfcY+ew7XfWIGjFy/s
        XLQuJBn/3rtb70Qng0/cpmJrG629zcAZUNts/u1ifuHSapq7DaaAoTSNsTeXtQ11
        xdMhJSpiFX7lQhfuXP9qNCYs28SgZjDxXZpD687K6yFUmugMsSMsyoTCFryNhJRG
        jarq+z3cPizyxQ3BbIE7rlFNDiexEzExFWWDwsYb2zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=16ukAG
        8arJNroPlaftBt9brS5BKz+aSbliLB114YW14=; b=V4FPsMzBTGKbQH6XUi92/1
        ZAdL3T/o93fEir+REcxv1JTGmu7fsa/r1vRuBNAvm4rVhTvVrM5oH8i8jDSKIdYJ
        G01XjV7O8ZvSYcaQNMYBqDT04ghc/Z+EFobXiI3mCtQ9mSusRPejbZjo+IWREiHI
        DQ3Cv5mRzFjeE0b3lZOqxyHxjGR60jFGEzUlcp678rw0hsloXuu53bMwuCuta1MH
        2B3mfQIB8xzecCwfdHHlHE82lbGTFHnSdvs9IEcXrQajEnAN22iwXX8ic/AazjVS
        yExjy82y9ANbdyK+txjibsgIqZ7Pj+octCahyL+pwoQCx+urdf9VRTNh7FxmS7/w
        ==
X-ME-Sender: <xms:SZBuXBOat3YJ0PiDmWCWiRjBCJ--EOd0e6gK0rJkPzJvq99eO0TNzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgdefheculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:SZBuXEYfyDdIwt-1itO814RDsg_wZrdtvz9g62CBBmgPs_jdYY52Sg>
    <xmx:SZBuXACluXX6Y_Rr0cBCMcqyZEXPFA2wdAObMk9NS4bD-5H7BjHzcA>
    <xmx:SZBuXKEQ21wOCy4DU28fpARU4DdCOgcP9bTmFz9FOexg2KrMGPwDdQ>
    <xmx:SZBuXA1btjxY_OcUMhpehK3MQCi0wmDMRSWfZbuLgJFqRRa19OAjVA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3EB4E44A8;
        Thu, 21 Feb 2019 06:49:28 -0500 (EST)
Date:   Thu, 21 Feb 2019 12:49:26 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     logang@deltatee.com, stable-commits@vger.kernel.org
Subject: Re: Patch "PCI: Fix __initdata issue with "pci=disable_acs_redir"
 parameter" has been added to the 4.20-stable tree
Message-ID: <20190221114926.GH10737@kroah.com>
References: <20190221054321.B1287214AF@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221054321.B1287214AF@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:43:20AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter
> 
> to the 4.20-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      pci-fix-__initdata-issue-with-pci-disable_acs_redir-.patch
> and it can be found in the queue-4.20 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 44557eb5390967bb678394cfbcef5df39bfa751e
> Author: Logan Gunthorpe <logang@deltatee.com>
> Date:   Thu Jan 17 08:46:34 2019 -0600
> 
>     PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter
>     
>     [ Upstream commit d2fd6e81912a665993b24dcdc1c1384a42a54f7e ]
>     
>     The disable_acs_redir parameter stores a pointer to the string passed to
>     pci_setup().  However, the string passed to PCI setup is actually a
>     temporary copy allocated in static __initdata memory.  After init, once the
>     memory is freed, it is no longer valid to reference this pointer.
>     
>     This bug was noticed in v5.0-rc1 after a change in commit c5eb1190074c
>     ("PCI / PM: Allow runtime PM without callback functions") caused
>     pci_disable_acs_redir() to be called during shutdown which manifested
>     as an unable to handle kernel paging request at:
>     
>       RIP: 0010:pci_enable_acs+0x3f/0x1e0
>       Call Trace:
>          pci_restore_state.part.44+0x159/0x3c0
>          pci_restore_standard_config+0x33/0x40
>          pci_pm_runtime_resume+0x2b/0xd0
>          ? pci_restore_standard_config+0x40/0x40
>          __rpm_callback+0xbc/0x1b0
>          rpm_callback+0x1f/0x70
>          ? pci_restore_standard_config+0x40/0x40
>           rpm_resume+0x4f9/0x710
>          ? pci_conf1_read+0xb6/0xf0
>          ? pci_conf1_write+0xb2/0xe0
>          __pm_runtime_resume+0x47/0x70
>          pci_device_shutdown+0x1e/0x60
>          device_shutdown+0x14a/0x1f0
>          kernel_restart+0xe/0x50
>          __do_sys_reboot+0x1ee/0x210
>          ? __fput+0x144/0x1d0
>          do_writev+0x5e/0xf0
>          ? do_writev+0x5e/0xf0
>          do_syscall_64+0x48/0xf0
>          entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     
>     It was also likely possible to trigger this bug when hotplugging PCI
>     devices.
>     
>     To fix this, instead of storing a pointer, we use kstrdup() to copy the
>     disable_acs_redir_param to its own buffer which will never be freed.
>     
>     Fixes: aaca43fda742 ("PCI: Add "pci=disable_acs_redir=" parameter for peer-to-peer support")

According to this tag it is needed in 4.19.y as well...

now added there.

greg k-h
