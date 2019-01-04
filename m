Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF44AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0B2218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546617186;
	bh=1X2YWCiiAw6GXRwBak3l2fbQ50ZWUEPB4S95Nrr5h2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=guiM1Kz7rCG/b6TjuwZc2976k+V2s9EfC4Tzcw03hnJYysdQso7QVG2QYd+uMgjJx
	 cOJUOLVV2RpXGLH58huEiyRXM7TwXNdUGsu7ZsQLuPZ/cto1RpzEsZyZwgXSNRmnIC
	 Ya3p9nrauemUxyY96beWXflkAJyb0zkWi3Nja8lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfADPxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfADPxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:53:05 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BAD21874;
        Fri,  4 Jan 2019 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546617185;
        bh=1X2YWCiiAw6GXRwBak3l2fbQ50ZWUEPB4S95Nrr5h2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTfXivrHU/jq1REgJf8/EmqL90xMZBO2umo6MBSYr8lozUO6F6pEuDWRah1YmgYKj
         CSXNt50+yhgGpn1mrURAqAJq8KYbYQaTk+MdRdMHspyqtgglblgYssI5OoDglUwnOg
         l3VpvGraRiGcJfojZxIxy2AwJm+eJmegqAozLCIU=
Date:   Fri, 4 Jan 2019 21:21:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1 0/3] Add PM Runtime support
Message-ID: <20190104155127.GP13372@vkoul-mobl.Dlink>
References: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-19, 11:17, Pierre-Yves MORDRET wrote:
> Use pm_runtime engine for clock management purpose for both DMA, DMAMUX and
> MDMA

Applied, thanks.

Folks have been moving away from using conditional compilation around pm
calls. __maybe_unused is a better choice so I am fixing that up, will
send patches shortly

-- 
~Vinod
