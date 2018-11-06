Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52629C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2379220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2379220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbeKGABH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:01:07 -0500
Received: from ms.lwn.net ([45.79.88.28]:37966 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388690AbeKGABH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:01:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 57A322CD;
        Tue,  6 Nov 2018 14:35:37 +0000 (UTC)
Date:   Tue, 6 Nov 2018 07:35:36 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.de>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <C.Emde@osadl.org>
Subject: Re: [PATCH 0/2] Docs/EDID: Fixed and improved EDID documentation
Message-ID: <20181106073536.58b14759@lwn.net>
In-Reply-To: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
References: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2018 09:48:33 +0100
Christoph Niedermaier <cniedermaier@dh-electronics.de> wrote:

> A problem was found when EDID data sets for displays other
> than the provided samples were generated. The patch series has
> no effect on the provided samples that still match the data
> used in drivers/gpu/drm/drm_edid_load.c.
> The provided samples use small values for XOFFSET, XPULSE,
> YOFFSET and YPULSE, where the error doesn't occur. This fix
> corrects the use of that values in case of high values, because
> the most significant bits were treated incorrectly.
> 
> The previous version made it necessary to first generate an
> EDID data set without correct CRC and then to fix the CRC in
> a second step. This patch series adds the CRC calculation to the
> makefile in such a way that a correct EDID data set is generated
> in a single build step.

This seems reasonable, I guess; I've applied both.  It seems to me, though,
that this stuff is in the wrong place.  Perhaps we should go one step
further and move it to tools/ ?

Thanks,

jon
