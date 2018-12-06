Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C99C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FCA208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FCA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLFSFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:05:11 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:35961 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLFSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:05:10 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 483402007D;
        Thu,  6 Dec 2018 19:05:00 +0100 (CET)
Date:   Thu, 6 Dec 2018 19:04:59 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 2/3] kbuild: generate asm-generic wrappers if mandatory
 headers are missing
Message-ID: <20181206180459.GA19166@ravnborg.org>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544009286-15705-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8 a=7gkXJVJtAAAA:8 a=c-n4J4-pAAAA:8
        a=X64D9lSbaCuUP_jgSmEA:9 a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=L0NDqeB7ZLmQzAogN4cw:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:28:05PM +0900, Masahiro Yamada wrote:
> Some time ago, Sam pointed out a certain degree of overwrap between
> generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)
> 
> I a bit tweaked the meaning of mandatory-y; now it defines the minimum
> set of ASM headers that all architectures must have.
> 
> If arch does not have specific implementation of a mandatory header,
> Kbuild will let it fallback to the asm-generic one by automatically
> generating a wrapper. This will allow to drop lots of redundant
> generic-y defines.
> 
> Previously, "mandatory" was used in the context of UAPI, but I guess
> this can be extended to kernel space ASM headers.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Nice work!

For the full series:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

Have you considered to warn if generic-y contains a header listed
in mandatory-y - to prevent that they sneak back in.
And to catch when we lift a header from available to mandatory.

	Sam
