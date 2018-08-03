Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC52C4646A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C012B2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C012B2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeHCWQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:16:08 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:39828 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeHCWQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:16:08 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 644EF20026;
        Fri,  3 Aug 2018 22:18:17 +0200 (CEST)
Date:   Fri, 3 Aug 2018 22:18:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Hocko <mhocko@kernel.org>, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sparc32: tidy up ramdisk memory reservation
Message-ID: <20180803201816.GB7789@ravnborg.org>
References: <1533210833-14748-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1533210833-14748-3-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533210833-14748-3-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=voM4FWlXAAAA:8 a=CucM_c5qC89G46TZzaAA:9
        a=CjuIK1q_8ugA:10 a=IC2XNlieTeVoXbcui8wp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike.

On Thu, Aug 02, 2018 at 02:53:53PM +0300, Mike Rapoport wrote:
> The detection and reservation of ramdisk memory were separated to allow
> bootmem bitmap initialization after the ramdisk boundaries are detected.
> Since the bootmem initialization is removed, the reservation of ramdisk
> memory can be done immediately after its boundaries are found.

When touching this area could you look
at introducing a find_ramdisk() function like
we do for sparc64?
It is always nice when the codebases look alike.
Then you could combine your simplification
with some refactoring that further increases
readability.

See:
https://patchwork.ozlabs.org/patch/151194/
for my attempt from long time ago.

	Sam
