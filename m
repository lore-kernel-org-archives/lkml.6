Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D83DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EF7208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EF7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbeHASXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:23:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403813AbeHASXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:23:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57381DCB;
        Wed,  1 Aug 2018 16:37:06 +0000 (UTC)
Date:   Wed, 1 Aug 2018 18:37:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        security@kernel.org, kernel-team@android.com,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Bluetooth: hidp: buffer overflow in
 hidp_process_report
Message-ID: <20180801163703.GA6994@kroah.com>
References: <20180731220225.159741-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731220225.159741-1-salyzyn@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 03:02:13PM -0700, Mark Salyzyn wrote:
> CVE-2018-9363
> 
> The buffer length is unsigned at all layers, but gets cast to int and
> checked in hidp_process_report and can lead to a buffer overflow.
> Switch len parameter to unsigned int to resolve issue.
> 
> This affects 3.18 and newer kernels.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: security@kernel.org
> Cc: kernel-team@android.com

Nit, you only need to bother security@ if you do not have a fix and need
to figure out one.

Also, you forgot to cc: stable@vger.kernel.org to be included in older
kernel releases :(

thanks,

greg k-h
