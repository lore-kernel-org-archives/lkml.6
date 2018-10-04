Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C8AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073D020877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073D020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJDU1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:27:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeJDU1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:27:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 863A7AD12;
        Thu,  4 Oct 2018 13:34:14 +0000 (UTC)
Message-ID: <1538660052.1254.4.camel@suse.com>
Subject: Re: [PATCH 2/2] cdc-acm: correct counting of UART states in serial
 state notification
From:   Oliver Neukum <oneukum@suse.com>
To:     Tobias Herzog <t-herzog@gmx.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Thu, 04 Oct 2018 15:34:12 +0200
In-Reply-To: <1537647071-2691-2-git-send-email-t-herzog@gmx.de>
References: <1537647071-2691-1-git-send-email-t-herzog@gmx.de>
         <1537647071-2691-2-git-send-email-t-herzog@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sa, 2018-09-22 at 22:11 +0200, Tobias Herzog wrote:
> The usb standard ("Universal Serial Bus Class Definitions for Communication
> Devices") distiguishes between "consistent signals" (DSR, DCD), and
> "irregular signals" (break, ring, parity error, framing error, overrun).
> The bits of "irregular signals" are set, if this error/event occurred on
> the device side and are immeadeatly unset, if the serial state notification
> was sent.
> Like other drivers of real serial ports do, just the occurence of those
> events should be counted in serial_icounter_struct (but no 1->0
> transitions).
> 
> Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
Acked-by: Oliver Neukum <oneukum@suse.com>

