Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 922ADC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EB520891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OFSXMxi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EB520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934819AbeFLWJj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:09:39 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:47108 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934282AbeFLWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:09:37 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5CM9JEx028979;
        Tue, 12 Jun 2018 17:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528841359;
        bh=tr6UAzxWcSxLOMbp6uEPZwYkQ6qryanrGWbYyYJ6VPY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OFSXMxi65Mhe/QK67JbRmOi8URaVe1Pa7GvvUYSO2wZnoAucsKNbTlls8OHpqw40X
         cpqcWDMCuSRRbM4Nc3Z0NA5jBaBceqQlL+K5eamjyquBHcDr6Fe/OqebnRvJtGzoYV
         ZPhX+TKSzuHXxJHmzIFWHXIFrlw/undOSyLfDErw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM9Jqt023998;
        Tue, 12 Jun 2018 17:09:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 17:09:18 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 17:09:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM9Iti013426;
        Tue, 12 Jun 2018 17:09:18 -0500
Date:   Tue, 12 Jun 2018 17:09:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 1/3] Documentation: dt: keystone: ti-sci: Add
 optional host-id parameter
Message-ID: <20180612220918.7cchihtcmmta6pm5@kahuna>
References: <20180605062640.3356-1-nm@ti.com>
 <20180605062640.3356-2-nm@ti.com>
 <20180612213922.GA26791@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180612213922.GA26791@rob-hp-laptop>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:39-20180612, Rob Herring wrote:
> On Tue, Jun 05, 2018 at 01:26:38AM -0500, Nishanth Menon wrote:
> > Texas Instrument's System Control Interface (TISCI) permits the
> > ability for Operating Systems to running in virtual machines to be
> 
> ...for OSs running in virtual...

Ack. thanks.

> 
> > able to independently communicate with the firmware without the need
> > going through an hypervisor.
> > 
> > The "host-id" in effect is the hardware representation of the
> > host (example: VMs locked to a core) as identified to the System
> > Controller.
> 
> So the hypervisor will fill in host-id's for each VM instance?

Yes OR have it's own device tree blobs representation of it's own host
IDs assigned by system firmware. This provides complete independence of
VMs to communicate with the system controller (once the host-id is
provided) without switching to hyp for arbitration (and yes, verified
ability with jailhouse hypervisor and multiple linux instances operating
simultaneously). This also has the added benefit of:
1. The burden of hypervisor from being involved in PM functionality as each
of the VMs can operate autonomously.
2. In TI SoCs which are heterogeneous, the system firmware plays the role
of system master communicating with multiple firmware(running on various
uCs) and OSes running on bigger cores.

-- 
Regards,
Nishanth Menon
