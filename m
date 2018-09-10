Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BA1C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926632086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926632086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeIJOMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:12:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56020 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:12:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gerddie)
        with ESMTPSA id 5C120277A94
Message-ID: <1536571118.4810.38.camel@collabora.com>
Subject: Re: [PATCH v7] Add udmabuf misc device
From:   Gert Wollny <gert.wollny@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 10 Sep 2018 11:18:38 +0200
In-Reply-To: <20180910083731.o4rryvermyighbtp@sirius.home.kraxel.org>
References: <1536491489.4810.22.camel@collabora.com>
         <20180910083731.o4rryvermyighbtp@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 10.09.2018, 10:37 +0200 schrieb Gerd Hoffmann:
... 

> > The other question is of course, why did dma_buf_export fail for me
> > ...
> 
> What exactly did you try?

I ran 

qemu-system-x86_64 -enable-kvm -smp 5 -M q35 -m 8G \
    -drive format=raw,file=ubuntu.raw,if=virtio   \
    -net nic,model=virtio  -net user,hostfwd=tcp::2224-:22  \
    -vga virtio

ubuntu.raw = Ubuntu 18.04 (bionic) + 4.17 kernel (from Ubuntu cosmic). 

The VM boots up to a certain point, the last line from the boot log is
varying, as far as I can see it is a few lines after virtio_blk detects
the disks.  

When I add '-display sdl' the Xsession freezes. I was still able to log
in remotely and kill -9 qemu, then X11 became usable again. 

In all cases I get on the host: 
  qemu-system-x86_64: info: udmabuf: init ok

and there it stays, certainly because of the kernel bug reported. 

Best, 
Gert 


