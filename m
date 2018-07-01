Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9007BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530C2259B4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530C2259B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965244AbeGAS0n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:26:43 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:37011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753200AbeGAS0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:26:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8AA6D181D341D;
        Sun,  1 Jul 2018 18:26:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bird78_56799f9de8425
X-Filterd-Recvd-Size: 1503
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Jul 2018 18:26:34 +0000 (UTC)
Message-ID: <653914f26dc8433a3f682b5e7eb850ab94bd431d.camel@perches.com>
Subject: Re: [PATCH 0/3] cast sizeof to int for comparison
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>, linux-usb@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Date:   Sun, 01 Jul 2018 11:26:32 -0700
In-Reply-To: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 19:32 +0200, Julia Lawall wrote:
> Comparing an int to a size, which is unsigned, causes the int to become
> unsigned, giving the wrong result.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)

Great, thanks.

But what about the ones in net/smc like:

> net/smc/smc_clc.c:	
> 
>         len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
>                              sizeof(struct smc_clc_msg_decline));
>         if (len < sizeof(struct smc_clc_msg_decline))

Are those detected by the semantic match and ignored?
