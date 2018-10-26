Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55B7ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7202085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhE9nvAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7202085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJ0FU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbeJ0FU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:20:57 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D1C20856;
        Fri, 26 Oct 2018 20:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540586547;
        bh=y6GHLD3iTfoUWTyAENeES4MoLFw0vJUADnQ3lSdtbhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhE9nvAq/8DD2EwHleLGhktokBMxiQspgqXH8QJtPNQ0JDIYI27gisXZK81Jvo52G
         fj7sCIkZ2YRYWLnVYD6CSnJHxT3hVSObtJjWgy1UXNfKCq0pXHJpbCqere9dyG3wPO
         MFQBn8QnRkv/WK3SlajbUhB2uT40b1g5IcQtzmW8=
Date:   Fri, 26 Oct 2018 16:42:25 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [RESEND PATCH 2/2] staging: vboxvideo: Use
 unsigned int instead bool
Message-ID: <20181026204225.GH2015@sasha-vm>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com>
 <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 04:04:45PM -0300, Shayenne da Luz Moura wrote:
>This change was suggested by checkpath.pl. Use unsigned int with bitfield
>allocate only one bit to the boolean variable.
>
>CHECK: Avoid using bool structure members because of possible alignment
>issues
>
>Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
>---
> drivers/staging/vboxvideo/vbox_drv.h        | 14 +++++++-------
> drivers/staging/vboxvideo/vboxvideo_guest.h |  2 +-
> 2 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/staging/vboxvideo/vbox_drv.h b/drivers/staging/vboxvideo/vbox_drv.h
>index 594f84272957..7d3e329a6b1c 100644
>--- a/drivers/staging/vboxvideo/vbox_drv.h
>+++ b/drivers/staging/vboxvideo/vbox_drv.h
>@@ -81,7 +81,7 @@ struct vbox_private {
> 	u8 __iomem *vbva_buffers;
> 	struct gen_pool *guest_pool;
> 	struct vbva_buf_ctx *vbva_info;
>-	bool any_pitch;
>+	unsigned int any_pitch:1;
> 	u32 num_crtcs;
> 	/** Amount of available VRAM, including space used for buffers. */
> 	u32 full_vram_size;

Using bitfields for booleans in these cases is less efficient than just
using "regular" booleans for two reasons:

1. It will use the same amount of space. Due to alignment requirements,
the compiler can't squeeze in anything into the 7 bits that are now
"free". Each member, unless it's another bitfield, must start at a whole
byte.

2. This is actually less efficient (slower) for the compiler to work
with. The smallest granularity we have to access memory is 1 byte; we
can't set individual bits directly in memory. For the original code, the
assembly for 'vbox_private.any_pitch = true' would look something like
this:

	movl   $0x1,-0x10(%rsp)

As you can see, the compiler can directly write into the variable.
However, when we switch to using bitfields, the compiler must preserve
the original value of the other 7 bits, so it must first read them from
memory, manipulate the value and write it back. The assembly would
look something like this:

	movzbl -0x10(%rsp),%eax
	or     $0x1,%eax
	mov    %al,-0x10(%rsp)

Which is less efficient than what was previously happening.

--
Thanks,
Sasha
