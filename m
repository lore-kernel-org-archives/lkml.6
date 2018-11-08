Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E92FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8072081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8072081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKIG0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:26:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:40853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeKIG0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:26:13 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MCxfb-1gCqjq0CjD-009j64; Thu, 08 Nov 2018 21:48:41 +0100
Message-ID: <1541710117.12945.3.camel@gmx.us>
Subject: Re: [PATCH] efi: permit calling efi_mem_reserve_persistent from
 atomic context
From:   Qian Cai <cai@gmx.us>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        will.deacon@arm.com
Date:   Thu, 08 Nov 2018 15:48:37 -0500
In-Reply-To: <20181108180511.30239-1-ard.biesheuvel@linaro.org>
References: <20181108180511.30239-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sr6VZ7qbDoJ2AdeKbKLrFYcoKiJouBM9InoiVlNox5/nUwkL7om
 taCpf2Jb8pmsUgPYLb9yqgQBsq7rTFoEB0FPNpPOxf8DOJTEPj7YH7Un6bos+F65el/DGzj
 3l187puWW25oshIUHN8ImM2yrDYpxAAORO1KfiTlKcIibAu5uu45vCIJ1EKtSRtpw7rQ9Jf
 78thHQVlyLLv2CsNQSFwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lC74UsjpE4A=:rFgNm/19xpgNkFhRL7zTq4
 iFogGwo5j8uPghuj0EHriyyEUbv76cMzN2VYswepoIn6emtPl7ASGmI/IDtY8T3m+xLywPnWD
 XEqQxOIOB5bF7Li0XvXzO+X9idToftEn+rAfALK+Y1uNbi09YEJFu+pJmBja6DyFMD5gZa6kQ
 +6feZ0T2gPs4FgJNSe/RXSqN3glXvRtNDAyZFlT8GaZyR1X4NM4OvmHtgMP2vlalNDEs3g5sF
 UqLxn87tiLVw5CvaEJeO2dZQYlnZ2UylxVRvv5G+///oh/O/Zbqz6w7xkOWtUC2OZ4dd1iKDO
 G0n+XvYh5AQF6i7uCkJrhuPmsCKUfAZg5L8nM1ClBsuLxqqK69v3AjPmKRx/+MXM5hVj6gA17
 s7a2mspVlM13/TFDGdL5Og+liJzXVWlSXYZ1j6M7EzSlQdaacFpKESAzIb/jkyt4LlvEPKDlt
 ziQ/vcmRmW0wF6otxIjxk7guNAA8ymxe7VIZB3iwSNTb7iptGA/I2OAelqZ5ZLTrnAmKZxMG9
 INWrNUVIy/KtUfY8IxE88mgJUF4fGp4FxeVjnShmqAWCCHm9IBhD2uTH/X43g+HpPLSSVTPrg
 UbN9b6yJSyMFVqkfvCdAyydexEL2wuz/iPDvhMufAdA8TNFS3z1/x+tOePc6WMUTBFEN1lGVG
 K+P5HbUIbe08BvsvSs6ZVTTHaMVwpnFIRArCIq2eDVR+GPExbCUH1xIte46abT/KWqGojQ90o
 rK6JWVKrBP5KzBbaQFl6lv+xW8pvOWxhUYKG2ZCind2htlZn99b9ZDIfznLgCuctEclDAWMz1
 qXKjqnRLrd2wmHR/fOAerd8Ew+yKFnM+gvdz4eminyUk2/98xvph3eaFKKlGRJ+yJlavRJGpY
 fzMapUBLhq5ppPxBwp4OckBC75boBC341VloYMKzDMn4ld7Us/SkmXKbIzDbY1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 19:05 +0100, Ard Biesheuvel wrote:
> Currently, efi_mem_reserve_persistent() may not be called from atomic
> context, since both the kmalloc() call and the memremap() call may
> sleep.
> 
> The kmalloc() call is easy enough to fix, but the memremap() call
> needs to be moved into an init hook since we cannot control the
> memory allocation behavior of memremap() at the call site.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Qian Cai <cai@gmx.us>
