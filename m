Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6DEC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD920850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfASBuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:50:40 -0500
Received: from utopia.booyaka.com ([74.50.51.50]:33992 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfASBuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:50:40 -0500
Received: (qmail 9298 invoked by uid 1019); 19 Jan 2019 01:43:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jan 2019 01:43:58 -0000
Date:   Sat, 19 Jan 2019 01:43:58 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Johan Hovold <johan@kernel.org>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/5] riscv: treat cpu devicetree nodes without status as
 enabled
In-Reply-To: <20190118140308.9599-5-johan@kernel.org>
Message-ID: <alpine.DEB.2.21.999.1901190140510.8813@utopia.booyaka.com>
References: <20190118140308.9599-1-johan@kernel.org> <20190118140308.9599-5-johan@kernel.org>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Johan Hovold wrote:

> Follow the Linux convention and treat devicetree nodes without a status
> property as enabled rather than disabled, while also allowing "ok" as a
> shorthand for "okay".
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

... although I probably would have phrased the commit message slightly 
differently - something like "Use of_device_is_available() in 
riscv_of_processor_hartid(), in place of an open-coded test."  That frames 
the change as one that removes custom code in place of an existing 
standard function for the same purpose.


- Paul
