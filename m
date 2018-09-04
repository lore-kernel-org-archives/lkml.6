Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AABC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027A9206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027A9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeIDXGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:06:02 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:35905 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIDXGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:06:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fxGEl-00089s-2H; Tue, 04 Sep 2018 19:39:39 +0100
Message-ID: <1536086378.3024.19.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 107/107] ubi: fastmap: Erase outdated anchor PEBs
 during attach
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Date:   Tue, 04 Sep 2018 19:39:38 +0100
In-Reply-To: <20180723122418.865465132@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
         <20180723122418.865465132@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 14:42 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> commit f78e5623f45bab2b726eec29dc5cefbbab2d0b1c upstream.
[...]

This results in a couple of error paths in ubi_wl_init() wrongly
returning 0.  Fixed upstream by:

commit 7233982ade15eeac05c6f351e8d347406e6bcd2f
Author: Wei Yongjun <weiyongjun1@huawei.com>
Date:   Thu Jan 18 14:05:05 2018 +0000

    mtd: ubi: wl: Fix error return code in ubi_wl_init()

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
