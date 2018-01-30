Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeA3TqP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:46:15 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44671 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeA3TqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:46:14 -0500
X-Google-Smtp-Source: AH8x2249jeLe9gXn1mKVTgEtJMNdggQKQPufQw4pBoxH/p6w0I22w6Y+cTBA+/H30jBLYRSjo35vXe4dhJMaEfmA5rI=
MIME-Version: 1.0
In-Reply-To: <20180118065054.29844-1-bpoirier@suse.com>
References: <20180118065054.29844-1-bpoirier@suse.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 30 Jan 2018 11:46:12 -0800
Message-ID: <CAKgT0Uc+sSREnAvF=TTDp2FFxGcro6JmDpE2KdnEYk5rDE3Tpw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [RFC PATCH] e1000e: Remove Other from EIAC.
To: Benjamin Poirier <bpoirier@suse.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2018 at 10:50 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> It was reported that emulated e1000e devices in vmware esxi 6.5 Build
> 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
> overrun interrupt bursts", v4.15-rc1). Some tracing shows that after
> e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
> on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
> icr=0x80000004 (_INT_ASSERTED | _OTHER) in the same situation.
>
> Some experimentation showed that this flaw in vmware e1000e emulation can
> be worked around by not setting Other in EIAC. This is how it was before
> 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt", v4.5-rc1).
>
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---

Hi Benjamin,

How would you feel about resubmitting this patch for net?

We have some issues that have come up and it would be useful to have
this fixed in the kernel sooner rather than later. I would be okay
with us applying it for now while we work on coming up with a more
complete solution.

Thanks.

- Alex
