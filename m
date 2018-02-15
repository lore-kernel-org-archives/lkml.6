Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165751AbeBOUT2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:19:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:15619 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033426AbeBOUT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:19:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="201501934"
Date: Thu, 15 Feb 2018 13:19:20 -0700
From: Keith Busch <keith.busch@intel.com>
To: Julien Durillon <julien@durillon.xyz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG? NVME Linux-4.15] Dracut loops indefinitely with 4.15
Message-ID: <20180215201919.GA7076@localhost.localdomain>
References: <CAPVZMnqi0dF1u=Q223trP=mtvYd80Ydp5wamtz3Vt3xhRY-FEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPVZMnqi0dF1u=Q223trP=mtvYd80Ydp5wamtz3Vt3xhRY-FEQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:49:56PM +0100, Julien Durillon wrote:
> I opened an issue here:
> https://github.com/dracutdevs/dracut/issues/373 for dracut. You can
> read there how dracuts enters an infinite loop.
> 
> TL;DR: in linux-4.14, trying to find the last "slave" of /dev/dm-0
> ends with a maj:min of "249:0" which does not exist in /sys/dev/block.
> In linux-4.15, the same thing loops as "249:0" exists.

The problem is dracut assumes the 'dev' file for an nvme namespace's
parent device contains a maj:min for a block device. It's actually a
character device, and its maj:min happens to also be be the same as the
device mapper's block device.
