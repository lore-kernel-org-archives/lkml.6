Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6505920870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6505920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeKTBos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:44:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729483AbeKTBos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:44:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B049AB01F;
        Mon, 19 Nov 2018 15:20:52 +0000 (UTC)
Date:   Mon, 19 Nov 2018 16:20:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH] HID: steam: remove input device when a hid client is
 running.
In-Reply-To: <20181014173643.9643-1-rodrigorivascosta@gmail.com>
Message-ID: <nycvar.YFH.7.76.1811191620120.21108@cbobk.fhfr.pm>
References: <20181014173643.9643-1-rodrigorivascosta@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018, Rodrigo Rivas Costa wrote:

> Previously, when a HID client such as the Steam Client was running, this
> driver disabled its input device to avoid doubling the input events.
> 
> While it worked mostly fine, some games got confused by the idle gamepad,
> and switched to two player mode, or asked the user to choose which gamepad
> to use. Other games just crashed, probably a bug in Unity [1].
> 
> With this commit, when a HID client starts, the input device is removed;
> when the HID client ends the input device is recreated.
> 
> [1]: https://github.com/ValveSoftware/steam-for-linux/issues/5645

Applied to for-4.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

