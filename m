Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACC1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563A92084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="VM3J3Gso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563A92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeGRHHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:07:08 -0400
Received: from ozlabs.org ([203.11.71.1]:48375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbeGRHHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:07:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 41VnMm480bz9s89; Wed, 18 Jul 2018 16:30:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1531895444; bh=33sXJ1/2SsjO+KopthrL7dH0AI8N06TZoqoIxx2GX58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VM3J3Gso/Yf8yRtAHyXtYt5H8PG8ixjIPtcUAHLzmCOSfs+dWrQSQDTIwQn8EVjZ7
         LBQ9WbpA6d+f/IeI4NhxT7xzQofOSsHQ7YlsWkzdQAWOflIRDRKASBmqOC9VYI2heL
         OJVI67GKNW1JE6IS7BybbNZ7v9AGTxpWC91vFyewx1h+/MtJgspgL77kDkZ6LOb0QQ
         V9FUjpqTFXh1/BsUv+0CQ+IGR1+yxnlQiL4Jj1Rir1VsUu6EvWZ/WNOc71g9twVpyf
         I4eEl8hqdV8H6BEGVLwG6zG/enWtukUNNL96cBA08sYe5Uzvu+b457Una/i6sxPofy
         y03H5QsCfSuVA==
Date:   Wed, 18 Jul 2018 16:29:07 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: add of_node_put() in success path
Message-ID: <20180718062907.GB27453@fergus>
References: <1530946387-6607-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530946387-6607-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 08:53:07AM +0200, Nicholas Mc Guire wrote:
>  The call to of_find_compatible_node() is returning a pointer with
> incremented refcount so it must be explicitly decremented after the
> last use. As here it is only being used for checking of node presence
> but the result is not actually used in the success path it can be
> dropped immediately.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit f725758b899f ("KVM: PPC: Book3S HV: Use OPAL XICS emulation on POWER9")

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
