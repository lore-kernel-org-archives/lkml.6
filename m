Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8398CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411FD24FD2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411FD24FD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeGANTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 09:19:03 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:53692 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeGANTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 09:19:01 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fZcFn-0003We-TF; Sun, 01 Jul 2018 21:18:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fZcFj-0008AP-Kx; Sun, 01 Jul 2018 21:18:55 +0800
Date:   Sun, 1 Jul 2018 21:18:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Farhan Ali <alifm@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
        arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com,
        frankja@linux.ibm.com, jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH v3 0/2] Detect & register virtio-crypto algos only if it
 can be supported by backend
Message-ID: <20180701131855.5sjnvyvhiq7ktzg3@gondor.apana.org.au>
References: <cover.1529422492.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529422492.git.alifm@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:41:32AM -0400, Farhan Ali wrote:
> Hi,
> 
> Currently the Linux virtio-crypto driver registers the crypto
> algorithm without verifying if the backend actually supports the
> algorithm.
> 
> This kernel patch series adds support for registering algorithm
> with Linux crypto layer, only if the algorithm is supported by
> the backend device. This also makes the driver more compliant with
> the virtio-crypto spec [1].
> 
> I would appreciate any feedback or comments on this.
> 
> Thank you
> Farhan
> 
> Reference
> ---------
> [1] Virtio crypto spec proposal https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00816.html
> 
> ChangeLog
> ---------
> v2 -> v3
>     - Add Christian Borntrager's acks for the patches.
> 
> v1 -> v2
>    - Modify comment as suggested by Arei (patch 1)
>    - Modify error message as suggested by Arei (patch 2)
> 
> Farhan Ali (2):
>   crypto/virtio-crypto: Read crypto services and algorithm masks
>   crypto/virtio-crypto: Register an algo only if it's supported
> 
>  drivers/crypto/virtio/virtio_crypto_algs.c   | 112 ++++++++++++++++++---------
>  drivers/crypto/virtio/virtio_crypto_common.h |  25 +++++-
>  drivers/crypto/virtio/virtio_crypto_core.c   |  29 +++++++
>  drivers/crypto/virtio/virtio_crypto_mgr.c    |  81 +++++++++++++++++--
>  4 files changed, 202 insertions(+), 45 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
