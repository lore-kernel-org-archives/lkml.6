Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D04C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 03:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796CA21933
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 03:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796CA21933
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeHRGbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 02:31:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:52817 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeHRGbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 02:31:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7I3Oqop028558;
        Fri, 17 Aug 2018 22:24:53 -0500
Message-ID: <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Date:   Sat, 18 Aug 2018 13:24:51 +1000
In-Reply-To: <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
         <20180817044902.31420-2-benh@kernel.crashing.org>
         <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
> > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
> 
> Just to be clear, if I understand correctly, this is a pure revert of
> 44bda4b7d26e and as such it reintroduces the problem solved by that
> commit.
> 
> If your solution turns out to be better, that's great, but it would be
> nice to avoid the bisection hole of reintroducing the problem, then
> fixing it again later.

There is no way to do that other than merging the revert and the fix
into one. That said, the race is sufficiently hard to hit that I
wouldn't worry too much about it.

> > The new pci state mutex provides a simpler way of addressing
> > this race and avoids the relative includes added to the powerpc
> > code.

