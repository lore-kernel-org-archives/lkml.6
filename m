Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003052183F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547127860;
	bh=OolbA9aGphu2cjQZEXQLcUdpYRZzKQHPy0SRTPOcFJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qM/s2gToH7y4Lo9tSw7rqtKGnzlLP2RowSnPYbjldzRgmAnbprA+Vwi8/y9zXgnYV
	 7RM+GykaUnaxF+xqwcrRCTpK8Fi0lebQbvEdM08UuzyhToPymm0ST1wBCCbPC6H9JJ
	 FZig8oWdeZe5xztyUBZ5FTRybXXovJIfn0cn5k6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAJNoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:44:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbfAJNoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:44:18 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17EC20879;
        Thu, 10 Jan 2019 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547127858;
        bh=OolbA9aGphu2cjQZEXQLcUdpYRZzKQHPy0SRTPOcFJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFw8CK5KSL8a0kDnIMAxgneW/G9iDqkWN/YdMUMpoJ5C0ZR5pjPAfczXN6gubumLX
         Os4OSgZTeei45D2gG4T8a6Y6TRDomlgKBCwYPFWLPEnxGoG4ZnhSODjScJOaIvoQlD
         xan72CEzwJ3b7P3rEHdvEH2luIMlMQS3j/o5TT+c=
Date:   Thu, 10 Jan 2019 21:44:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20190110134402.GB30487@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
 <20181208015835.GM3987@dragon>
 <20190110064256.GA25218@dragon>
 <dc0ef959-78a0-2a32-c0f9-e8da11e035e6@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc0ef959-78a0-2a32-c0f9-e8da11e035e6@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:44:03AM +0000, Vokáč Michal wrote:
...
> > What happened to this?  It seems the patch did not hit v5.0-rc1.
> 
> Hi Shawn,
> Rob actually asked you a similar question two days ago..
> 
> https://lkml.org/lkml/2019/1/8/754

Oops, it seems there were some miscommunication between Rob and me.  Let
me fix this by queuing this patch on my tree now.

Shawn
