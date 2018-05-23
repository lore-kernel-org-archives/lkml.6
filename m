Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbeEWBrH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 21:47:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38439 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753689AbeEWBrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 21:47:05 -0400
X-Google-Smtp-Source: AB8JxZrT1AypUh2pRPixgoFyH9uQwl/JJrwzTb1XZwXm+5S+u8soIjLvvrZZPMnqFUb1dBcXcwv09g==
Date: Tue, 22 May 2018 18:47:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bo Chen <chenbo@pdx.edu>
Cc: jeffrey.t.kirsher@intel.com, davem@davemloft.net,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000: check the return of pci_get_drvdata() in
 e1000_remove()
Message-ID: <20180522184702.64cd62f6@xeon-e3>
In-Reply-To: <20180523001743.8492-1-chenbo@pdx.edu>
References: <20180523001743.8492-1-chenbo@pdx.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 17:17:43 -0700
Bo Chen <chenbo@pdx.edu> wrote:

> This check on pci_get_drvdata() prevents potential invalid pointer dereferences,
> and is a common practice in *_remove() functions from other drivers, such as
> 'intel/e100.c', 'amd/pcnet32.c', 'realtek/8139too.c', and 'broadcom/tg3.c'.
> 
> Signed-off-by: Bo Chen <chenbo@pdx.edu>

Why check for something that can never be true.
You are creating dead code paths that can never be exercised.
