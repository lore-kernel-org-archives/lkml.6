Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDFFC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2CA26D17
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2CA26D17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeFZQjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:39:47 -0400
Received: from namei.org ([65.99.196.166]:33120 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbeFZQjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:39:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w5QGdgTe018477;
        Tue, 26 Jun 2018 16:39:42 GMT
Date:   Wed, 27 Jun 2018 02:39:42 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KEYS: Miscellaneous fixes
In-Reply-To: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1806270239220.18107@namei.org>
References: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, David Howells wrote:

> 
> Hi James,
> 
> Here's a bunch of miscellaneous fixes:
> 
>  (1) Fix the handling of the X.509 signature BIT STRING.
> 
>  (2) Fix a section declaration.
> 
>  (3) Fix rounding in KDF.
> 
> Could you pass these on to Linus please?

Sure, the RSA one is already merged.

> 
> The patches can be found here tagged thusly:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 	keys-fixes-20180626
> 
> and also on the following branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes
> 
> David
> ---
> Eric Biggers (1):
>       dh key: fix rounding up KDF output length
> 
> Maciej S. Szmigiero (1):
>       X.509: unpack RSA signatureValue field from BIT STRING
> 
> Nick Desaulniers (1):
>       certs/blacklist: fix const confusion
> 
> 
>  certs/blacklist.h                         |    2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c |    9 +++++++++
>  security/keys/dh.c                        |    6 ++++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 

-- 
James Morris
<jmorris@namei.org>

