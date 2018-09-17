Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E305214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E305214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeIQRUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:20:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeIQRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:20:42 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F10CFBE0;
        Mon, 17 Sep 2018 11:53:41 +0000 (UTC)
Date:   Mon, 17 Sep 2018 13:53:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 4.4 107/107] ubi: fastmap: Erase outdated anchor PEBs
 during attach
Message-ID: <20180917115339.GL13057@kroah.com>
References: <20180723122413.003644357@linuxfoundation.org>
 <20180723122418.865465132@linuxfoundation.org>
 <1536086378.3024.19.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536086378.3024.19.camel@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 07:39:38PM +0100, Ben Hutchings wrote:
> On Mon, 2018-07-23 at 14:42 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > commit f78e5623f45bab2b726eec29dc5cefbbab2d0b1c upstream.
> [...]
> 
> This results in a couple of error paths in ubi_wl_init() wrongly
> returning 0.  Fixed upstream by:
> 
> commit 7233982ade15eeac05c6f351e8d347406e6bcd2f
> Author: Wei Yongjun <weiyongjun1@huawei.com>
> Date:   Thu Jan 18 14:05:05 2018 +0000
> 
>     mtd: ubi: wl: Fix error return code in ubi_wl_init()

Thanks for the report, now queued up.

greg k-h
