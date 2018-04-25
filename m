Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeDYHTh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:19:37 -0400
Received: from verein.lst.de ([213.95.11.211]:35208 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeDYHTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:19:31 -0400
Date: Wed, 25 Apr 2018 09:21:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Helge Deller <deller@gmx.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
Message-ID: <20180425072105.GA12308@lst.de>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-23-hch@lst.de> <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 07:43:46PM +0200, Helge Deller wrote:
> This patch breaks a 32bit kernel on a B160L machine (PA7300LC CPU, "pcxl2").
> After applying this patch series the lasi82956 network driver works unreliable. 
> NIC gets IP, but ping doesn't work.
> See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.

Just to confirm:  Without the series it is known to actually work?
