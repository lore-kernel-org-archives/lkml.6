Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60507ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064620664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 08:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F064620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJ1RbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 13:31:18 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:23613
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbeJ1RbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 13:31:18 -0400
X-IronPort-AV: E=Sophos;i="5.54,435,1534802400"; 
   d="scan'208";a="283541470"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2018 09:47:16 +0100
Date:   Sun, 28 Oct 2018 09:47:15 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Himanshu Jha <himanshujha199640@gmail.com>
cc:     Sasha Levin <sashal@kernel.org>,
        Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [RESEND PATCH 2/2] staging: vboxvideo: Use
 unsigned int instead bool
In-Reply-To: <20181028075209.GA1938@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.21.1810280932030.2450@hadrien>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com> <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com> <20181026204225.GH2015@sasha-vm> <20181028075209.GA1938@himanshu-Vostro-3559>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The "possible alignement issues" in CHECK report is difficult to figure
> out by just doing a glance analysis. :)
>
> Linus also suggested to use bool as the base type i.e., `bool x:1` but
> again sizeof(_Bool) is implementation defined ranging from 1-4 bytes.

If bool x:1 has the size of bool, then wouldn't int x:1 have the size of
int?  But my little experiments suggest that the size is the smallest that
fits the requested bits and alignment chosen by the compiler, regardless of
the type.

bool x:1 has the advantage that anything that is not 0 is considered true.
So for bool x:1, x = 4 is true, while for int x:1, x = 4 is false.

But the :1 adds instructions, so at least for only one bool, where little
space is saved, it is probably not worth it.

julia
