Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2692DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4E420C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4E420C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeIRW2d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:28:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbeIRW2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A13BA308338F;
        Tue, 18 Sep 2018 16:55:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46B0F89236;
        Tue, 18 Sep 2018 16:55:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <14f91823-474e-1b46-d305-12229dac8967@gmail.com>
References: <14f91823-474e-1b46-d305-12229dac8967@gmail.com> <0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org> <fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <1537253993.20009.62.camel@infradead.org> <14067.1537285833@warthog.procyon.org.uk> <745318a0-51bd-be8f-2251-44701ad75830@gmail.com> <19247.1537288419@warthog.procyon.org.uk>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23697.1537289705.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 18 Sep 2018 17:55:05 +0100
Message-ID: <23698.1537289705@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 18 Sep 2018 16:55:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

> In theory the PEM file already contains the type of the certificate, at least
> at a high level.  E.g. private, public, tpm.  So if we accept PEM files
> directly that could be potentially a faster way of determining the parser to
> use and would still work with keyctl update/instantiate, right?

Yes.  It shouldn't be much code, either.  You still have to check for X.509
DER since the kernel currently supports that.

David
