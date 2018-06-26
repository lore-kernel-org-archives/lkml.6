Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39130C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC53326D50
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC53326D50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbeFZTOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752127AbeFZTOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:14:42 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8587226AE7;
        Tue, 26 Jun 2018 19:14:41 +0000 (UTC)
Date:   Tue, 26 Jun 2018 15:14:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console
 takeover
Message-ID: <20180626151440.03749d0f@gandalf.local.home>
In-Reply-To: <20180626183612.321-1-hdegoede@redhat.com>
References: <20180626183612.321-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 20:36:09 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi All,
> 
> Here is v4 of my patch-set, to delay fbcon taking over the console (and
> binding to fbdev devices) until there actually is some text output to the
> console. This is intended for use with the "quiet" cmdline option, in
> combination with a bootloader which leaves the vendor's logo /
> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
> 
> The end goal here is a boot where the firmware shows its boot graphics
> and these stay in place for a couple of seconds until the GUI loads and
> the GUI then smoothly takes over the framebuffer without any distruptions.
> 
> This patch-set spans 2 subsystems.
> 
> Petr, the printk subsys change is really trivial (1 line addition) can we
> get your Acked-by for merging all 3 patches through the fbdev tree?
> 
> Changelog:
> 
> Changes in v4:
> -Keep the comments about which fbcon functions need locks in place
> 

For 1 and 2:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I'll let others handle patch 3.

-- Steve
