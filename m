Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B54E0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635C4208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0b3Qch8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635C4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935602AbeFMT4B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935206AbeFMTz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:55:59 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06AC208C3;
        Wed, 13 Jun 2018 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528919759;
        bh=OjcQne4oo/YJyaFpLexsY6vxMMBXsZGFjAhB8XiwedY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0b3Qch8UKQ7Z016cxOQFz/K8pWlMqjOlwqBNHNmj2VLB/rhDQheBeoXNCnPz7yZ8k
         xYit91dFk7JjhgNUVyGC4Uc8bsZnSMAPj4DLBWi1OCZ87VGHxjL+Y+X83XAbrAShKD
         jKiYZfS9xj9XiEswqD4qhBYJWW+Ly+IuxHLG8JQA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 820D71450F4; Wed, 13 Jun 2018 16:55:56 -0300 (-03)
Date:   Wed, 13 Jun 2018 16:55:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/2] perf record: Support s390 random socket_id assignment
Message-ID: <20180613195556.GD2686@kernel.org>
References: <20180611073153.15592-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611073153.15592-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 11, 2018 at 09:31:52AM +0200, Thomas Richter escreveu:
> On s390 the socket identifier assigned to a CPU identifier is
> random and (depending on the configuration of the LPAR) may be higher
> than the CPU identifier. This is currently not supported.
> 
> Fix this by allowing arbitrary socket identifiers being assigned to
> CPU id.
> 
> Output before:

Thanks, applied both patches in this series,

- Arnaldo
