Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E3AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDBF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDBF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeILWBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:01:12 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49211 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeILWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:01:12 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B2D75C0009;
        Wed, 12 Sep 2018 16:55:44 +0000 (UTC)
Date:   Wed, 12 Sep 2018 19:03:51 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Elie Roudninski <xademax@gmail.com>
Subject: Re: [PATCH 0/4] Add specific vt input's key map
Message-ID: <20180912170351.GB1119@voidbox.localdomain>
References: <cover.1536695070.git.repk@triplefau.lt>
 <20180912153519.533fb27a@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912153519.533fb27a@alans-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:35:19PM +0100, Alan Cox wrote:
> On Tue, 11 Sep 2018 22:23:55 +0200
> Remi Pommarel <repk@triplefau.lt> wrote:
> 
> > This patchset adds a way to have a specific keyboard config (i.e.
> > keycode to keysym map) for a vt attached input.
> 
> Who actually needs this given that you can't even render most
> international symbols in text mode and X and friends already deal with
> mapping of keyboards at this degree of fine-ness and even more so ?

Let say you share one computer among people used to different keyboard
layouts, so you have plugged in one keyboard for each of those people.
Let say you have encrypted your disk with a long passphrase, the one
that boots up the computer has to enter it. It could be annoying to
learn another layout just to enter a passphrase to boot. This allows to
set an udev rule in initrd to use a different layout per keyboard so
every people using this computer can use their favorite layout to enter
the passphrase.

I am in such a situation and so is @Elie.

I also don't start X server at boot time (or sometimes I switch to a linux
VT) it is not very convenient for me to switch layout to enter my password,
or even to type "startx".

I do agree that it is not an absolute must-have or shiny feature, it is
just a convenient one, at least for me.

-- 
Remi
