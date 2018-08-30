Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95AAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5E420837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu5nn62g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5E420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeH3WUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbeH3WUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:20:12 -0400
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A428D2082A;
        Thu, 30 Aug 2018 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535653008;
        bh=54WR5WCK7hpB0B0GD7Bm9uCJ70mjIo40+zFyayVgfQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iu5nn62gYDQ6XaC1scYkYv21vHqRgJSGg451t6OuK2+SzIdnwHzE+VWxE84wXEZBo
         YqpBoLNbJTAYQtfrpC/CtiCqKI+7fegTcScgfyKNSNMtv+a2GQqBGp8xONPbk9qme3
         br9/JgrlhKz/yNw/40AVvca0VcXUYrVPxFQpdfjM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0F8AB141C3F; Thu, 30 Aug 2018 15:16:46 -0300 (-03)
Date:   Thu, 30 Aug 2018 15:16:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Sandipan Das <sandipan@linux.ibm.com>, jolsa@redhat.com,
        kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH] perf probe powerpc: Ignore SyS symbols irrespective of
 endianness
Message-ID: <20180830181645.GD6097@kernel.org>
References: <20180828090848.1914-1-sandipan@linux.ibm.com>
 <1535447918.l2974vvvvj.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535447918.l2974vvvvj.naveen@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 28, 2018 at 02:49:15PM +0530, Naveen N. Rao escreveu:
> Sandipan Das wrote:
> > This makes sure that the SyS symbols are ignored for any powerpc
> > system, not just the big endian ones.
> > 
> > Fixes: fb6d59423115 ("perf probe ppc: Use the right prefix when ignoring SyS symbols on ppc")
> > Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> > Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > ---
> >  tools/perf/arch/powerpc/util/sym-handling.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> LGTM. Thanks for the fix.
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo
