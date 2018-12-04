Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE22C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A320672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0A320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeLDWAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:00:38 -0500
Received: from namei.org ([65.99.196.166]:57642 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeLDWAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:00:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wB4Lxkjh022787;
        Tue, 4 Dec 2018 21:59:46 GMT
Date:   Wed, 5 Dec 2018 08:59:45 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v8 00/14] Appended signatures support for IMA appraisal
In-Reply-To: <20181116200712.14154-1-bauerman@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812050855270.22148@namei.org>
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Thiago Jung Bauermann wrote:

> On the OpenPOWER platform, secure boot and trusted boot are being
> implemented using IMA for taking measurements and verifying signatures.
> Since the kernel image on Power servers is an ELF binary, kernels are
> signed using the scripts/sign-file tool and thus use the same signature
> format as signed kernel modules.
> 
> This patch series adds support in IMA for verifying those signatures.

Are you saying you use IMA to verify kernels during boot?  From a Linux 
bootloader?

> It adds flexibility to OpenPOWER secure boot, because it allows it to boot
> kernels with the signature appended to them as well as kernels where the
> signature is stored in the IMA extended attribute.

Just to clarify, with these patches, IMA will be able to verify the 
native form of signed kernel modules?  i.e. without xattrs at all, and 
this will work with existing signed modules?



-- 
James Morris
<jmorris@namei.org>

