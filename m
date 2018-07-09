Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82537208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb84CmQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82537208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeGIR1j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933712AbeGIR1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:27:37 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7620420864;
        Mon,  9 Jul 2018 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531157257;
        bh=96bxi8Zk/JprgdY9O1yvmqLsMwpNF/FYWywHbEQypAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb84CmQqSU+3xC7rqb2rt7PCLIN+ySiBPCREFBPd7ZrhJIBxrtG9qwhA89WeDRvLE
         WkfWHp3vPEs4nEbOr2sU2++ar/L5vY2ro0nKmHqe2U7fL3FdHOvqNrPlYPvsoOE8Yg
         fEilrx0ZKzG2giCeEXiOZxJxqyynFL+zkWyeRgxQ=
Date:   Mon, 9 Jul 2018 22:57:29 +0530
From:   Vinod <vkoul@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     dan.j.williams@intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] dma: stm32: replace "%p" with "%pK"
Message-ID: <20180709172729.GO22377@vkoul-mobl>
References: <20180706130220.21957-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706130220.21957-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-18, 15:02, Benjamin Gaignard wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.

The subsystem name is 'dmaengine' and not dma.
The git log on the subsystem should have told you this

Applied after fixing the tag, thanks.
-- 
~Vinod
