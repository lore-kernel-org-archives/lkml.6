Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cM6OC5w5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="or4frfzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF10F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeGTIBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:01:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeGTIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:01:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7035360B72; Fri, 20 Jul 2018 07:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532070883;
        bh=0oszrjKtfhujdIpOGdSCXFFmw8b2fQ0/Q+EVj7aJltI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cM6OC5w58DakknbA6h69Un0nfIP9VlMKc507LSgLUWDJjAH4OL2OMJmWtaI2bwGTk
         /A361v1oTxof0Pbb6oZIjSEHRdBHMvhGNB9Iun+V8sbtUniXguYKFVSyxfvUrarmAN
         3GXNfVzM2F6rl9ElwwHqC7n/MZefgn487+HTwEGE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 83BAE6078C;
        Fri, 20 Jul 2018 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532070882;
        bh=0oszrjKtfhujdIpOGdSCXFFmw8b2fQ0/Q+EVj7aJltI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=or4frfzCDatsIbLhcp4jgVu1hF6W9NiRU7RbkLatIyNhiQJ+YvAEfsXuhfZEZ9PZF
         L18gBHf+CaR70HdeQ+kp2oZONpN/2eA3HbZp/x92yC2Uii39lZYc7MOHqebyJnwUxZ
         PykM6wHiUJs8W940liEGdxvBeZxI6ownZesM7YSA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Jul 2018 12:44:42 +0530
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 4/5] mtd: rawnand: qcom: update BBT related flags
In-Reply-To: <20180718234255.4e51c188@xps13>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
 <1530863519-5564-5-git-send-email-absahu@codeaurora.org>
 <20180718231526.38046099@xps13> <20180718233637.49a39751@bbrezillon>
 <20180718234144.158217f2@xps13> <20180718234255.4e51c188@xps13>
Message-ID: <cf73ae307c3a155e232788d0257a3c97@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-19 03:12, Miquel Raynal wrote:
> Abhishek,
> 
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Wed, 18 Jul 2018
> 23:41:44 +0200:
> 
>> Hi Boris,
>> 
>> Boris Brezillon <boris.brezillon@bootlin.com> wrote on Wed, 18 Jul 
>> 2018
>> 23:36:37 +0200:
>> 
>> > On Wed, 18 Jul 2018 23:15:26 +0200
>> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>> >
>> > > Hi Abhishek,
>> > >
>> > > Abhishek Sahu <absahu@codeaurora.org> wrote on Fri,  6 Jul 2018
>> > > 13:21:58 +0530:
>> > >
>> > > > Remove the NAND_SKIP_BBTSCAN to use RAM based BBT.
>> > >
>> > > Unless I am understanding it the wrong way, NAND_SKIP_BBTSCAN will skip
>> > > the scan of the on-chip BBT and will scan every block to construct a
>> > > RAM, based BBT thanks to the BBM.
>> > >
>> > > So flash based BBT is already unused and removing this flag is a
>> > > mistake, right?
>> >
>> > ->scan_bbt() is also taking care of building the in-RAM BBT based on
>> > BBM when no on-flash BBT is provided, so I think it's the right thing
>> > to do.
>> 
>> Oh right. Then doing so is harmless.
> 
> Could you please update the commit log to reflect this aspect?
> 

  Thanks Miquel and Boris.
  I will update the commit log.

  Regards,
  Abhishek
