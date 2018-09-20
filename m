Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C59C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D692621525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cantab.net header.i=@cantab.net header.b="vrQh3Hq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D692621525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cantab.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbeIUEnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:43:09 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:56098 "EHLO
        mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbeIUEnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:43:09 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id B96C720BDC;
        Thu, 20 Sep 2018 23:57:18 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id AEE6120BBB;
        Thu, 20 Sep 2018 23:57:18 +0100 (BST)
Authentication-Results: mta01.prd.rdg.aluminati.org (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=cantab.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cantab.net; h=
        content-transfer-encoding:content-language:in-reply-to
        :mime-version:user-agent:date:date:message-id:from:from
        :references:subject:subject:received:received; s=dkim; t=
        1537484237; bh=adwNq1Sh98igLw7ZBuuQcw+9ySXX+yM9DJhQegBuQFM=; b=v
        rQh3Hq1ibUH8eZAm957wZtSI8tuja+B7TmGXls+Niv56JEAyh3DJqbX79K1yCz+5
        2Td1L4Soa086y0P7h5VEUq/3yoI0bH9J+SpTTEPtAgZZ4OIpj+8a37wSf4lX2b25
        SIYswn875wBVOM95gLHnzFH/ByhTX7dD+u0SjMAexCEle+UCV61xtLaFOZt8e+iV
        3V9VUIA95ftIVhw5YjE3FeSE6KCJ5lLcE6jdLN857fJSkb1X4gs77Me6rjNGjiPj
        wBTQVgOnmIOO8olNcFWK9faIEN9oQsypqYrb2i+O0bPdDW07vVAoaCzihshF7r0a
        uJufLEB2oi/JJfGev9wAQ==
X-Quarantine-ID: <S2R4u8QB89eg>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S2R4u8QB89eg; Thu, 20 Sep 2018 23:57:17 +0100 (BST)
Received: from [192.168.0.2] (cpc92884-cmbg20-2-0-cust324.5-4.cable.virginm.net [80.1.217.69])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 4139162FD9;
        Thu, 20 Sep 2018 23:57:15 +0100 (BST)
Subject: Re: Code of Conduct: Let's revamp it.
To:     unconditionedwitness@redchan.it
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <20180920041846.GA4418@1wt.eu> <206423b0a199c1f12e61364d6e687e09@redchan.it>
From:   Edward Cree <ec429@cantab.net>
Message-ID: <a9db544f-db9d-d6c4-67d8-43db2eb591fc@cantab.net>
Date:   Thu, 20 Sep 2018 23:57:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <206423b0a199c1f12e61364d6e687e09@redchan.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/18 10:27, unconditionedwitness@redchan.it wrote:
> Contributors can, at any time, rescind the license grant regarding their
> property via written notice to those whom they are rescinding the grant
> from (regarding their property (code)).

I know others have already said it, but:
This is legally nonsense.  The only way I can revoke someone's rights to
 my code under the GPL is if they violate the terms of the GPL.  If I
 were to do so otherwise, then _I_ would be in violation for having
 distributed derived works of the kernel without a GPL, not to mention
 the obvious reliance/estoppel problems.

Moreover, even if I _could_ revoke the license, I wouldn't want to do
 so; it would be ridiculously petty in itself and the precedent it would
 set would be destructive to the entire open-source community, about
 which I care deeply.  It is _because_ Linux and other open-source
 projects are so important to humanity that I spoke up about what I
 perceive as a threat to it.

In short, "unconditionedwitness", please shut up.  You're not helping.
