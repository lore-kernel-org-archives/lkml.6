Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeDIHav (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:30:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38329 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbeDIHau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:30:50 -0400
Date: Mon, 9 Apr 2018 09:30:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hidraw: Fix crash on HIDIOCGFEATURE with a destroyed
 device
In-Reply-To: <20180405230936.4572-1-rodrigorivascosta@gmail.com>
Message-ID: <nycvar.YFH.7.76.1804090930390.28129@cbobk.fhfr.pm>
References: <20180405230936.4572-1-rodrigorivascosta@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018, Rodrigo Rivas Costa wrote:

> Doing `ioctl(HIDIOCGFEATURE)` in a tight loop on a hidraw device
> and then disconnecting the device, or unloading the driver, can
> cause a NULL pointer dereference.
> 
> When a hidraw device is destroyed it sets 0 to `dev->exist`.
> Most functions check 'dev->exist' before doing its work, but
> `hidraw_get_report()` was missing that check.
> 
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs
