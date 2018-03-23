Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCWQEX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:04:23 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:36260 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeCWQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:04:22 -0400
Date: Sat, 24 Mar 2018 00:04:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: george.cherian@cavium.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium: cpt: Replace mdelay with msleep in
 cpt_device_init
Message-ID: <20180323160411.GG2186@gondor.apana.org.au>
References: <1521384638-23251-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521384638-23251-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 10:50:38PM +0800, Jia-Ju Bai wrote:
> cpt_device_init() is never called in atomic context.
> 
> The call chain ending up at cpt_device_init() is:
> [1] cpt_device_init() <- cpt_probe()
> cpt_probe() is only set as ".probe" in pci_driver structure 
> "cpt_pci_driver".
> 
> Despite never getting called from atomic context, cpt_device_init() calls
> mdelay(100), i.e. busy wait for 100ms.
> That is not necessary and can be replaced with msleep to 
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
