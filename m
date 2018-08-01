Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E36C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A48F20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A48F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbeHAJAq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:00:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50190 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733123AbeHAJAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:00:46 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9A087CF355;
        Wed,  1 Aug 2018 09:23:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] HID: Bluetooth: hidp: buffer overflow in
 hidp_process_report
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180731220225.159741-1-salyzyn@android.com>
Date:   Wed, 1 Aug 2018 09:16:29 +0200
Cc:     linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        security@kernel.org, kernel-team@android.com,
        Jiri Kosina <jkosina@suse.cz>
Content-Transfer-Encoding: 8BIT
Message-Id: <037EC694-953E-4510-9B34-64035958918D@holtmann.org>
References: <20180731220225.159741-1-salyzyn@android.com>
To:     Mark Salyzyn <salyzyn@android.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

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
> ---
> net/bluetooth/hidp/core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

