Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E060E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547750552;
	bh=m1JMg2ex/8W7ZSttaJuBS/mnYiAzn2eosXhW5/JJjyg=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=QOYOQrYg6NF6CnvWHTnMtJJVvoSSTitr79PZ+NOCd0F8fFp1pz7Izi3MWbRFysyrx
	 jKL5fCBjTa9zzlqF6BGFQtshWGvkiS5A4wmTAQx4u1YXxo+CZKLX937e8InIWoI799
	 rY1Q7bNrhmimJrNwg5cvdi3yr/LzcC/u7bZpADKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfAQSm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfAQSmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:42:25 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475CF20851;
        Thu, 17 Jan 2019 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547750545;
        bh=m1JMg2ex/8W7ZSttaJuBS/mnYiAzn2eosXhW5/JJjyg=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=y49Pvqe/4jCvg5YO8oSFiqkb5+bfHEu9O3tlX3fplPxi0pdwuTSPSSh/e9hY8vSZn
         CZDErODrYJEOwlsfDzuEk4awA607IUYbLjpTTxA6RTmf8zUuB3Z1kZUK1mEVCJCzRA
         GEGfg2aAw3Tr+yEMcG+YUsdYRt0Bzp+u87Phi7uA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
User-Agent: alot/0.8
In-Reply-To: <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com>
References: <20190116083440.11b6839c@canb.auug.org.au> <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com> <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Fabio Estevam <festevam@gmail.com>
Message-ID: <154775054438.169631.5111867106558251203@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 17 Jan 2019 10:42:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabio Estevam (2019-01-16 17:25:21)
> On Wed, Jan 16, 2019 at 10:44 PM Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Ok sure. Does this matter to scripts? Is it documented in
> > Documentation/process/submitting-patches.rst? I've seen both types, one
>=20
> From Documentation/process/submitting-patches.rst"
>=20
> "If your patch fixes a bug in a specific commit, e.g. you found an issue =
using
> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters =
of
> the SHA-1 ID, and the one line summary.  For example::
>=20
> Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")"

Yes but 'one line summary' is not clear to me. Does it mean the summary
line? Or the one line summary on one line regardless of commit message
column wrapping? Sorry to be pedantic but I can see how this can be
misunderstood.

