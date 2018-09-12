Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4B4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C39206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C39206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeILTkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:40:14 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55712 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeILTkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:40:14 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8CEZJI1013761;
        Wed, 12 Sep 2018 15:35:20 +0100
Date:   Wed, 12 Sep 2018 15:35:19 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>
Subject: Re: [PATCH 0/4] Add specific vt input's key map
Message-ID: <20180912153519.533fb27a@alans-desktop>
In-Reply-To: <cover.1536695070.git.repk@triplefau.lt>
References: <cover.1536695070.git.repk@triplefau.lt>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 22:23:55 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> This patchset adds a way to have a specific keyboard config (i.e.
> keycode to keysym map) for a vt attached input.

Who actually needs this given that you can't even render most
international symbols in text mode and X and friends already deal with
mapping of keyboards at this degree of fine-ness and even more so ?

> - kbd_detach_conf is a bit clumsy because it tries to copy a shared sparse
>   pointer array without using GFP_ATOMIC.

It's not a performance critical path at least. You could look at
switching it to use RCU but firstly I think the question is whether
anyone cares enough to bother putting it in the upstream kernel ?

Alan
