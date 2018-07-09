Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A208C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173EC208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173EC208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeGIM3L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932568AbeGIM3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:29:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05E67AF43;
        Mon,  9 Jul 2018 12:29:08 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:29:07 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jason Andryuk <jandryuk@gmail.com>
cc:     linux-kernel@vger.kernel.org, john-s-84@gmx.net,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] i2c-hid: Fix "incomplete report" noise
In-Reply-To: <20180622162549.9563-1-jandryuk@gmail.com>
Message-ID: <nycvar.YFH.7.76.1807091428570.997@cbobk.fhfr.pm>
References: <20180622162549.9563-1-jandryuk@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Jason Andryuk wrote:

> Commit ac75a041048b ("HID: i2c-hid: fix size check and type usage")
> started writing messages when the ret_size is <= 2 from i2c_master_recv.
> However, my device i2c-DLL07D1 returns 2 for a short period of time
> (~0.5s) after I stop moving the pointing stick or touchpad.  It varies,
> but you get ~50 messages each time which spams the log hard.
> [  95.925055] i2c_hid i2c-DLL07D1:01: i2c_hid_get_input: incomplete report (83/2)
> 
> This has also been observed with a i2c-ALP0017.
> [ 1781.266353] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
> 
> Only print the message when ret_size is totally invalid and less than 2
> to cut down on the log spam.
> 
> Reported-by: John Smith <john-s-84@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

