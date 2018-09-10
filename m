Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B71CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463A020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="ay+p8c4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463A020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeIJRLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:11:37 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:42914 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:11:37 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 9EE9CAE002F;
        Mon, 10 Sep 2018 14:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536581867; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnEB40uucdogXTgR8/fIjWo1YsFtEnwRrjMsNpd45uw=;
        b=ay+p8c4XccyosqK6z+J/GJxjtwcbFlunqZbmM7tJ3S8VQiMUvrFo80wYCeLbcSvixwkkbt
        ti1si5VQRc7kbAXKU1LF4c1U4alqioLwjUDh5A4+50msrOLRWYQD9H0goRM6egXu7C1t4S
        Ae3TNI88ZKO06xYvP7iLDiQxzjEgzWnp5fEk4oEku+4S5XknluRw8h2aiXaIfD4rD2Jmzt
        JCMa2VT6VZeyZbf2LUpmsheEOULvsvKzF33CzGktyot8aABj6Jm8mHbdE2EYm7HKluaGtn
        Tm9U2QAmet776TQUVVivLm7FTem3OEePSyvpGC9zEegcXSJGdEoxG59TkWVN+w==
Subject: Re: [PATCH v3 2/3] dt-bindings: add bindings for mtd-concat devices
To:     Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20180908131345.8145-1-kernel@nospam.obeliks.de>
 <20180908131345.8145-3-kernel@nospam.obeliks.de>
 <CACna6ryWCwKZJm2rq0_KeaKve8Ym9zi6AU+Kat9cpYAqtzCMdg@mail.gmail.com>
 <bf3d2900-aa99-e39f-24af-aa57d1f41928@nospam.obeliks.de>
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
Message-ID: <879f9dae-c983-a2f0-61c5-dce49bed945f@nospam.obeliks.de>
Date:   Mon, 10 Sep 2018 14:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bf3d2900-aa99-e39f-24af-aa57d1f41928@nospam.obeliks.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.09.2018 um 14:13 schrieb Bernhard Frauendienst:
> Am 10.09.2018 um 12:51 schrieb Rafał Miłecki:  >> I think you forgot to include the documentation. Please 
***describe*** >> that binding. > You are right, I'm afraid I was 
mislead by some of the rather sparse > documentation files in the mtd 
directory. > Would something along these lines be sufficient?
I'm sorry, I have no idea why my Thunderbird+External editor insists on
breaking quotes like this. I will switch to a different mailer for the 
mailing
list.


