Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeDIH0u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:26:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751767AbeDIH0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:26:48 -0400
Date: Mon, 9 Apr 2018 09:26:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Martin <bugs@mrvanes.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: fix battery level reporting on BT mice
In-Reply-To: <20180403175220.GA148162@dtor-ws>
Message-ID: <nycvar.YFH.7.76.1804090926190.28129@cbobk.fhfr.pm>
References: <20180403175220.GA148162@dtor-ws>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018, Dmitry Torokhov wrote:

> The commit 581c4484769e ("HID: input: map digitizer battery usage")
> assumed that devices having input (qas opposed to feature) report for
> battery strength would report the data on their own, without the need to
> be polled by the kernel; unfortunately it is not so. Many wireless mice
> do not send unsolicited reports with battery strength data and have to
> be polled explicitly. As a complication, stylus devices on digitizers
> are not normally connected to the base and thus can not be polled - the
> base can only determine battery strength in the stylus when it is in
> proximity.
> 
> To solve this issue, we add a special flag that tells the kernel
> to avoid polling the device (and expect unsolicited reports) and set it
> when report field with physical usage of digitizer stylus (HID_DG_STYLUS).
> Unless this flag is set, and we have not seen the unsolicited reports,
> the kernel will attempt to poll the device when userspace attempts to
> read "capacity" and "state" attributes of power_supply object
> corresponding to the devices battery.
> 
> Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198095
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied for 4.17, thanks.

-- 
Jiri Kosina
SUSE Labs
