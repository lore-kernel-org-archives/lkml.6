Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeC1L5G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:57:06 -0400
Received: from verein.lst.de ([213.95.11.211]:45378 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbeC1L5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:57:04 -0400
Date: Wed, 28 Mar 2018 13:57:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dma_zalloc_coherent broken with
        57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7
Message-ID: <20180328115703.GA31426@lst.de>
References: <alpine.LFD.2.21.1803270944490.1726@schleppi> <20180327143341.GA4968@lst.de> <alpine.LFD.2.21.1803271717580.26440@schleppi> <20180327164505.GA10522@lst.de> <alpine.LFD.2.21.1803271900390.18934@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1803271900390.18934@schleppi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 07:04:51PM +0200, Sebastian Ott wrote:
> What was wrong with the old behavior (let the caller decide - the same
> as with memory allocations)?

The old behavior on most (all?) mainstream architectures is that we
always zero the return value.  On x86/i386 this goes back to at least
Linux 2.4.  So common drivers simply expect this to happen.
