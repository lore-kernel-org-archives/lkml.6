Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDJAlZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 20:41:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53844 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeDJAlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 20:41:20 -0400
X-Google-Smtp-Source: AIpwx49J9eh7VC3Dx1fNZm/333qA9XLO8BC/98FRcao7zm3ulmHMTiepPGI2s6wZ8c/2ZWNjHchVERNK5gUFjsvPAP8=
MIME-Version: 1.0
In-Reply-To: <2863317.1ZoR41yQkl@bear>
References: <20180311150151.GB15443@localhost> <2863317.1ZoR41yQkl@bear>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Mon, 9 Apr 2018 20:41:18 -0400
Message-ID: <CAJz5OpdV1=L3fsQESZusAp8Cir9wE-VqPXqBa=zOGjBcPE78DA@mail.gmail.com>
Subject: Re: [PATCH v4] dmaengine: pl330: flush before wait, and add dev burst support.
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 2:34 PM, Frank Mori Hess <fmh6jj@gmail.com> wrote:
> Do DMAFLUSHP _before_ the first DMAWFP to ensure controller
> and peripheral are in agreement about dma request state before first
> transfer.  Add support for burst transfers to/from peripherals. In the new
> scheme, the controller does as many burst transfers as it can then
> transfers the remaining dregs with either single transfers for
> peripherals, or with a reduced size burst for memory-to-memory transfers.

Hi, what is the state of this patch?  I just noticed in patchwork it
is now listed as "Not applicable"?  The original broken-by-wordwrap
patch is listed as "Accepted"?

https://patchwork.kernel.org/project/linux-dmaengine/list/?submitter=178687&state=*

I found it has a bug handling dregs btw, I'll include a fix for that
in the next version or as a follow-on patch as appropriate.
