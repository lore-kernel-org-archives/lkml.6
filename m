Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A09C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A4C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeLML6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:58:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40572 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeLML6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:58:15 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9910672CC6C;
        Thu, 13 Dec 2018 14:58:12 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5D4174A4A14;
        Thu, 13 Dec 2018 14:58:12 +0300 (MSK)
Date:   Thu, 13 Dec 2018 14:58:12 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Tudor.Ambarus@microchip.com
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] akcipher: Introduce verify2 for public key algorithms
Message-ID: <20181213115811.22ebsv6y6vqclfrz@sole.flsd.net>
Mail-Followup-To: Tudor.Ambarus@microchip.com, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20181211165938.1150-1-vt@altlinux.org>
 <b2e6060c-1e2a-c2c5-0484-715646d16201@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <b2e6060c-1e2a-c2c5-0484-715646d16201@microchip.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tudor,

On Thu, Dec 13, 2018 at 10:26:53AM +0000, Tudor.Ambarus@microchip.com wrote:
> 
> On 12/11/2018 06:59 PM, Vitaly Chikunov wrote:
> > Current akcipher .verify() just decrypts signature to uncover message
> > hash, which is then verified in upper level public_key_verify_signature
> > by memcmp with the expected signature value, which is never passed into
> > verify().
> > 
> > This approach is incompatible with ECDSA algorithms, because, to verify
> 
> I would love to have ECDSA in kernel but unfortunately it hasn't reached kernel
> because there is no in-kernel user for it. Do we have an agreement that we will
> add support for it? If not, who will benefit of these patches?

I will post patchset for EC-RDSA support (which is slightly different from
ECDSA, but is the same algorithm family). This is intended for use in IMA.

Even though EC-RDSA is different from ECDSA it will require the same changes
that I propose in these RFCs. Basically, after EC-RDSA is implemented and
hooked into IMA it will be much easier to implement ECDSA.

An additional use case is future possibility to implement other signature
schemes out of tree, which is currently not possible because API is very
RSA-centric.

Thanks,

> 
> Thanks,
> ta
