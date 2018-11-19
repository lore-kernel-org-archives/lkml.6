Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A924BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7653420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7653420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeKSUNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:13:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:33870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbeKSUNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:13:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E973AF4F;
        Mon, 19 Nov 2018 09:50:30 +0000 (UTC)
Message-ID: <1542620466.2630.8.camel@suse.com>
Subject: Re: [PATCH] usbnet: use tasklet_init() for usbnet_bh handler
From:   Oliver Neukum <oneukum@suse.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, linux-usb@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org
Date:   Mon, 19 Nov 2018 10:41:06 +0100
In-Reply-To: <20181116155035.19025-1-ben.dooks@codethink.co.uk>
References: <20181116155035.19025-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2018-11-16 at 15:50 +0000, Ben Dooks wrote:
> The tasklet initialisation would be better done by tasklet_init()
> instead of assuming all the fields are in an ok state by default.
> 
> Note, this does not fix any known bug.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Acked-by: Oliver Neukum <oneukum@suse.com>
