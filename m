Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19A4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434E0208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434E0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbeGJOdv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:33:51 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:57793 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933283AbeGJOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:33:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 45DF418224D7E;
        Tue, 10 Jul 2018 14:33:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: line20_212500badf42e
X-Filterd-Recvd-Size: 1434
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Jul 2018 14:33:47 +0000 (UTC)
Message-ID: <e4e25250dbea658f25dcf10504f3147731b5d2e9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Jul 2018 07:33:46 -0700
In-Reply-To: <20180710121014.31119-1-geert+renesas@glider.be>
References: <20180710121014.31119-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 14:10 +0200, Geert Uytterhoeven wrote:
> Print an error if none of the Signed-off-by lines cover the patch
> author.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -13,6 +13,7 @@ use POSIX;
>  use File::Basename;
>  use Cwd 'abs_path';
>  use Term::ANSIColor qw(:constants);
> +use MIME::Words 'decode_mimewords';

Is this a typically installed perl module?
If so, what perl version installed it by default?

