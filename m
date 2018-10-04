Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6941DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C3620877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C3620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJDU0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:26:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeJDU0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:26:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96436AF5C;
        Thu,  4 Oct 2018 13:33:16 +0000 (UTC)
Message-ID: <1538659994.1254.3.camel@suse.com>
Subject: Re: [PATCH 1/2] cdc-acm: do not reset notification buffer index
 upon urb unlinking
From:   Oliver Neukum <oneukum@suse.com>
To:     Tobias Herzog <t-herzog@gmx.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Thu, 04 Oct 2018 15:33:14 +0200
In-Reply-To: <1537647071-2691-1-git-send-email-t-herzog@gmx.de>
References: <1537647071-2691-1-git-send-email-t-herzog@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sa, 2018-09-22 at 22:11 +0200, Tobias Herzog wrote:
> Resetting the write index of the notification buffer on urb unlink (e.g.
> closing a cdc-acm device from userspace) may lead to wrong interpretation
> of further received notifications, in case the index is not 0 when urb
> unlink happens (i.e. when parts of a notification already have been
> transferred). On the device side there is no "reset" of the notification
> transimission and thus we would get out of sync with the device.
> 
> Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
Acked-by: Oliver Neukum <oneukum@suse.com>

