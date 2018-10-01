Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC022C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3FC205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3FC205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeJARjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:39:13 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33034 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbeJARjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:39:13 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 4010B2008DB;
        Mon,  1 Oct 2018 10:55:54 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D99A220650; Mon,  1 Oct 2018 11:38:53 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:38:53 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: pcmcia_resource: Replace mdelay() with msleep()
Message-ID: <20181001093853.GC7482@light.dominikbrodowski.net>
References: <20180730134256.8901-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730134256.8901-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:42:56PM +0800, Jia-Ju Bai wrote:
> pcmcia_fixup_iowidth() and pcmcia_enable_device() are 
> never called in atomic context.
> They call mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied to pcmcia-next, thanks.

	Dominik
