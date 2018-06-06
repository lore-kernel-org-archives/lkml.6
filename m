Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EB2E60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeFFMmC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:42:02 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10878
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752120AbeFFMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:42:00 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520895600";
   d="scan'208";a="267844644"
Date: Wed, 6 Jun 2018 21:41:53 +0900 (JST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: mchehab@kernel.org, hans.verkuil@cisco.com
cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: unnecessary tests?
Message-ID: <alpine.DEB.2.20.1806062139460.4445@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file drivers/media/tuners/mxl5005s.c, the function MXL_BlockInit
contains:

       status += MXL_ControlWrite(fe,
               RFSYN_EN_CHP_HIGAIN, state->Mode ? 1 : 1);
       status += MXL_ControlWrite(fe, EN_CHP_LIN_B, state->Mode ? 0 : 0);

Could the second arguments just be 1 and 0, respectively?  It's true that
the preceeding call contains state->Mode, but in a more useful way, so
perhaps it could be useful for uniformity?

thanks,
julia
