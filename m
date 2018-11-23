Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66138C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4A920861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="KfIlPIRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4A920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=omicronenergy.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502261AbeKWSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:07:58 -0500
Received: from ns.omicron.at ([212.183.10.25]:37554 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502240AbeKWSH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:07:57 -0500
X-Greylist: delayed 803 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2018 13:07:55 EST
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id wAN7BWul017172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:11:32 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at wAN7BWul017172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1542957092;
        bh=wZlZIlOA+j0fd/p07tZjufPlbIlQTEcqZjIWCx81trA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KfIlPIRwOe9PbOo5QVaoHMAxk4Bq8qD7pQD3mT4IQyhvx/Hltf6GTQxvxfW7eqoNy
         vpcWrb5gl2XurRG559JIT+9oISB7Qk0fwFbQw5RGz5xr39T7ivvQe4FqLZvUc8CjgQ
         9yJenP1NXKhPA4d+tOicuo+v6DjW6NLxCzGCmFHI=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id 94C01A008C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:11:32 +0100 (CET)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 92383A008B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 08:11:32 +0100 (CET)
Received: from EXC03-ATKLA.omicron.at ([172.22.100.188])
        by MGW01-ATKLA.omicron.at  with ESMTP id wAN7BWvh005834-wAN7BWvk005834
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=CAFAIL);
        Fri, 23 Nov 2018 08:11:32 +0100
Received: from EXC04-ATKLA.omicron.at (172.22.100.189) by
 EXC03-ATKLA.omicron.at (172.22.100.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Fri, 23 Nov 2018 08:11:29 +0100
Received: from EXC04-ATKLA.omicron.at ([fe80::44f:42a9:9d18:2000]) by
 EXC04-ATKLA.omicron.at ([fe80::44f:42a9:9d18:2000%5]) with mapi id
 15.01.1466.003; Fri, 23 Nov 2018 08:11:29 +0100
From:   Manfred Rudigier <manfred.rudigier@omicronenergy.com>
To:     Richard Cochran <richardcochran@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Cristian Marinescu <cristian.marinescu@omicronenergy.com>
Subject: RE: [patch 8/9] posix-clocks: Remove license boiler plate
Thread-Topic: [patch 8/9] posix-clocks: Remove license boiler plate
Thread-Index: AQHUcYhLMNyk0PU8j0OJJWhZ3x4j86VdEx1Q
Date:   Fri, 23 Nov 2018 07:11:29 +0000
Message-ID: <559fb263-6c05-4ee7-8789-27c123ba8b9d@EXC03-ATKLA.omicron.at>
References: <20181031182107.726051323@linutronix.de>
 <20181031182253.385909804@linutronix.de>
 <20181101021203.6twk2pucmn42cu6z@localhost>
In-Reply-To: <20181101021203.6twk2pucmn42cu6z@localhost>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.95.180]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>

Regards,
Manfred

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Thursday, November 1, 2018 3:12 AM
> To: Thomas Gleixner <tglx@linutronix.de>
> Cc: LKML <linux-kernel@vger.kernel.org>; Cristian Marinescu
> <cristian.marinescu@omicronenergy.com>; Manfred Rudigier
> <manfred.rudigier@omicronenergy.com>
> Subject: Re: [patch 8/9] posix-clocks: Remove license boiler plate
>=20
> On Wed, Oct 31, 2018 at 07:21:15PM +0100, Thomas Gleixner wrote:
> > The SPDX identifier defines the license of the file already. No need
> > for the boilerplate.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Richard Cochran <richardcochran@gmail.com>
> > ---
> >
> > @Richard: This file is (C) OMICRON, but I don't have a contact
> > anymore. That Cochran dude is not longer working there :)
> >
> > Do you have a contact? If so, can you please reply to this mail and Cc
> > him/her.
>=20
> @Cristian and Manfred:
>=20
> We want to replace the license boilerplate with SPDX tags.  The file,
> kernel/time/posix-clock.c, is copyrighted by omicron, and so we need your
> okay.  All that is needed is a reply to this email with an omicron Acked-=
by tag,
> like this:
>=20
> Acked-by: Richard Cochran <richardcochran@gmail.com>
>=20
> Thanks,
> Richard
>=20
> >
> > ---
> >  kernel/time/posix-clock.c |   14 --------------
> >  1 file changed, 14 deletions(-)
> >
> > --- a/kernel/time/posix-clock.c
> > +++ b/kernel/time/posix-clock.c
> > @@ -3,20 +3,6 @@
> >   * Support for dynamic clock devices
> >   *
> >   * Copyright (C) 2010 OMICRON electronics GmbH
> > - *
> > - *  This program is free software; you can redistribute it and/or
> > modify
> > - *  it under the terms of the GNU General Public License as published
> > by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, write to the Free Software
> > - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> >   */
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >
> >
