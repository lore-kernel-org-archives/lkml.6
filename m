Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84658606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeFFMjO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:39:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14557
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbeFFMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:39:12 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520895600";
   d="scan'208";a="267844207"
Date: Wed, 6 Jun 2018 21:39:05 +0900 (JST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: perex@perex.cz, tiwai@suse.com
cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: unnecessary test?
Message-ID: <alpine.DEB.2.20.1806062135430.4445@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file sound/pci/ctxfi/cthw20k1.c, the function daio_mgr_dao_init
contains:

set_field(&ctl->spoctl, SPOCTL_OS << (idx*8),
          ((conf >> 3) & 0x1) ? 2 : 2); /* Raw */

Could the second argument just be 2?  It's true that the preceeding call
contains conf >> ..., but in a more useful way, so perhaps it could be
useful for uniformity?

thanks,
julia
