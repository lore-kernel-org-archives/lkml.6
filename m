Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC96ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5EC208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5EC208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeGNMNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:13:23 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46535
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbeGNMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:13:23 -0400
X-IronPort-AV: E=Sophos;i="5.51,352,1526335200"; 
   d="scan'208";a="272990708"
Received: from 76.8.75.174.nyc.electricfiber.net (HELO hadrien.local) ([76.8.75.174])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2018 13:54:30 +0200
Date:   Sat, 14 Jul 2018 07:54:29 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com
Subject: Re: [PATCH v2] coccinelle: strncpy+truncation by strscpy
In-Reply-To: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
Message-ID: <alpine.DEB.2.20.1807140750040.3356@hadrien>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org> <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +msg = "SUGGESTION: strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
> +coccilib.report.print_report(p[0], msg)

This is the first SUGGESTION.  I don't know if anyone out there is relying
on it always being WARNING or ERROR.

julia
