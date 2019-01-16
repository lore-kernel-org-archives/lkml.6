Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6769C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB7520675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfAPQP0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:15:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbfAPQPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:15:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A51264E937;
        Wed, 16 Jan 2019 16:15:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4359C5C239;
        Wed, 16 Jan 2019 16:15:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190107090449.d364ii24zervlsfq@sole.flsd.net>
References: <20190107090449.d364ii24zervlsfq@sole.flsd.net> <20190106133608.820-1-vt@altlinux.org> <1893001.R2IGJoHzOM@positron.chronox.de> <20190107080710.r4bh7gkqdysxmlnn@sole.flsd.net> <1714084.mfT8VG1pOj@tauon.chronox.de>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     dhowells@redhat.com, Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] crypto: Add EC-RDSA algorithm
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21601.1547655320.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 16 Jan 2019 16:15:20 +0000
Message-ID: <21602.1547655320@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 16 Jan 2019 16:15:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:

> > Regarding your comment (2), I am not sure I understand. Why do you say that 
> > the DER format cannot be parsed by the kernel's ASN.1 parser? For example, 
> 
> It can, but DER is stricter than BER. For example, in DER 'OCTET STRING'
> length field should be encoded in just one byte if it's smaller than
> 128, in BER it could be encoded in multiple encodings. This does not
> seem like a big deal, though. With BER decoder an improperly DER-encoded
> certificate could be successfully parsed.

Whilst that is true, I don't think it's that big a deal.  DER is a subset of
BER, so a BER decoder ought to be able to parse it.  Note that X.509 is
supposed to be DER, but we use a BER decoder for that too.

David
