Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D621C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC6B222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550099120;
	bh=gQqTmPYkyxFsM289AY6sMah+GFE1hey+WkQYKsGUHi8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=G60aQPI70AkTZT/pPzd0Hrvpk8es0dHOLXojatgfPDDD9M7K1suYc1mBB2TqAxshE
	 pxbLLLGx5so6b8IGtCqzQDqUtcmznm4K5RP4LX+qH6+AOwDv09afn7Qb1SyLgB6B44
	 MRpLGn1hz6VxddC/ZCkKPOUy9ITC1UHXtlFg0bL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392781AbfBMXFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfBMXFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:05:16 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7277222A1;
        Wed, 13 Feb 2019 23:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550099116;
        bh=gQqTmPYkyxFsM289AY6sMah+GFE1hey+WkQYKsGUHi8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LyNn0M/VS+W04Nm9fYiF/3Xr6hrYxOaccAyx1JCQwHfmXX1C6rOAxFeYoBj5YYZK3
         X5QX+zVsSFjjUVxLOut8KKqJxDxoRgC7z9NmRV1m5VGw/jG/6sA+jlpswK6kkdnPWK
         o/qBi0gRFyHn5106skNvhnz0c4qznUmJyi20Xls8=
Date:   Thu, 14 Feb 2019 00:05:12 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: steam: fix boot loop with bluetooth firmware.
In-Reply-To: <20190206212754.17929-1-rodrigorivascosta@gmail.com>
Message-ID: <nycvar.YFH.7.76.1902140005030.11598@cbobk.fhfr.pm>
References: <20190206212754.17929-1-rodrigorivascosta@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019, Rodrigo Rivas Costa wrote:

> There is a new firmware for the Steam Controller with support for BLE
> connections. When using such a device with a wired connection, it
> reboots itself every 10 seconds unless an application has opened it.
> 
> Doing hid_hw_open() unconditionally on probe fixes the issue, and the
> code becomes simpler.
> 
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

