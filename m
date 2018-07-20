Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E436AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5F52064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Xle8Nab6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWKQwsLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5F52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeGTKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:41:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36431 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbeGTKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:41:44 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F347A21C51;
        Fri, 20 Jul 2018 05:54:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 20 Jul 2018 05:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Kj5vbjjb2vmbikBAXl77qXF8J4Qhu
        LMhRjdMlhgVB9s=; b=Xle8Nab6rBsh5kGY8Q/TWvL+HaxmIejjseOTeClS4zgbV
        UagC13/AKr6SrjnJEKmBm+flhyNO/8Pm8RnnoK+jHv3FxMqksLXVN7dFUzxIwrLG
        vvxsnd+jbClTFxAmYwEZvviW5uiKyZDpz+g9/m6J9NcIyIms0iTzTeCgLf5paPWv
        yO/nEreTzV0ZBfo5AELKN4tXRwqWF9oFwL14yYbvYe6KaPnxZYDmUNRF662luZ7S
        AdOdR5HthgMlDyQ03Qn4McTU0XDJNMqtbsFoqqiTTlKpC7abE4KP3DHmml1v2Q5F
        tC4nKRvLEs62yWaNECGCYZ+g7XHrTkolLylupVQZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Kj5vbj
        jb2vmbikBAXl77qXF8J4QhuLMhRjdMlhgVB9s=; b=pWKQwsLPPCTOLcz+425mNv
        oJrzBLhkQ74zzIywIBM+dWzP3urq+l3oAl3jjmUUBUbViJniZSApLIMTxG8mllf7
        koVTHMRDWYD47oIXl/gT5At1a9XhRRBwiiO30Y5a1g2tzucB+IzVScwfhywGAprL
        /Hls3Eeo9/quGZ1N0HOno9jlbaGp640pKSnLGfhTkwRmn2Ax4UuzZZRWwYD3HUZX
        qPQjvMunsUTKsCe/PSZilKFCgQ6j/9IlI2eumiHhGBJuBVPXinworWss6xh35bKP
        bDMR7mZ3sPfybjqZaBZwH+2JgIoxXD9oldSzAv4Tw8GH7ZJzhET8Qm38KHS/rhfQ
        ==
X-ME-Proxy: <xmx:RLFRWxAo9QWm_vLiquBVoJWlso6Ul233QmZz7oE_bAeVL9ShzCA16g>
    <xmx:RLFRWyvM87bj-QY0hjrDtV2YmW3m14M8KfTHs_7vWS9ZqqXOYGgyaQ>
    <xmx:RLFRWzamDepHxPV70LJh6a1c38B0nItxOAzvBwHZqWwhrDL3JNlJeA>
    <xmx:RLFRWw1mfZaClZ0MFgGM3JcnP6lgW72XYMAJIAZjFbJ1dz3Ia8lqeg>
    <xmx:RLFRW4nR30a8oTUaOAVVGESyV9FSSmyLNZ8gC31v_grJ61g79H-lJQ>
    <xmx:RbFRW0fZ4Ot5qh_J_KkvZ6766qn79a6JVWDanrrbcOXxU2MpsLydWg>
X-ME-Sender: <xms:RLFRW-QPhvY0PmKYyEwzDdwkszU5V6sUP2iqdiiuw9rjs3RNhOAUdg>
Received: from localhost (lfbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id 484291025D;
        Fri, 20 Jul 2018 05:54:12 -0400 (EDT)
Date:   Fri, 20 Jul 2018 11:54:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: use-after-free in
 xhci_trb_virt_to_dma.part.24+0x1c/0x80
Message-ID: <20180720095410.GA11904@kroah.com>
References: <95b4bdb2-962f-561e-ac14-79cd44395915@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95b4bdb2-962f-561e-ac14-79cd44395915@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:44:49AM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Using Linux 4.18-rc5+ with kmemleak enabled on a MSI B350M MORTAR (MS-7A37)
> with an AMD Ryzen 3 2200G, the memory leak below is suspected.
> 
> ```
> $ sudo less /sys/kernel/debug/kmemleak
> unreferenced object 0xffff894f8874a2b8 (size 8):
>   comm "systemd-udevd", pid 119, jiffies 4294893109 (age 908.348s)
>   hex dump (first 8 bytes):
>     34 01 05 00 00 00 00 00                          4.......
>   backtrace:
>     [<00000000308e4456>] xhci_init+0x81/0x170 [xhci_hcd]
>     [<00000000269aa18f>] xhci_gen_setup+0x2cb/0x510 [xhci_hcd]
>     [<000000007b70d85f>] xhci_pci_setup+0x4d/0x120 [xhci_pci]
>     [<0000000059f49127>] usb_add_hcd+0x2b6/0x800 [usbcore]
>     [<000000009a16d67c>] usb_hcd_pci_probe+0x1f3/0x460 [usbcore]
>     [<0000000001295c2e>] xhci_pci_probe+0x27/0x1d7 [xhci_pci]
>     [<00000000395bd8f9>] local_pci_probe+0x41/0x90
>     [<00000000a344e362>] pci_device_probe+0x189/0x1a0
>     [<00000000318999e5>] driver_probe_device+0x2b9/0x460
>     [<00000000c29d8a55>] __driver_attach+0xdd/0x110
>     [<00000000975b7f46>] bus_for_each_dev+0x76/0xc0
>     [<000000006bc40955>] bus_add_driver+0x152/0x230
>     [<00000000840ed63c>] driver_register+0x6b/0xb0
>     [<00000000123908c4>] do_one_initcall+0x46/0x1c3
>     [<00000000ce69c793>] do_init_module+0x5a/0x210
>     [<0000000091d4aef2>] load_module+0x21c4/0x2410
> […]
> ```

That's really vague.  Any chance for a reproducer or some other types of
hints as to what you feel the problem is here?

thanks,

greg k-h
