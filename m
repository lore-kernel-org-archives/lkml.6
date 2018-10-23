Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112BFC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D948020665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D948020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeJWV7D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:59:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:48155 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWV7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:59:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 06:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="83757902"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 23 Oct 2018 06:35:33 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 23 Oct 2018 06:35:33 -0700
Received: from lcsmsx154.ger.corp.intel.com (10.186.165.229) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 23 Oct 2018 06:35:33 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 LCSMSX154.ger.corp.intel.com ([169.254.7.171]) with mapi id 14.03.0319.002;
 Tue, 23 Oct 2018 16:35:30 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 00/21] tpm: separate tpm 1.x and tpm 2.x commands
Thread-Topic: [PATCH v7 00/21] tpm: separate tpm 1.x and tpm 2.x commands
Thread-Index: AQHUaBMHlZfugjzXrESpNofEmU+hxKUrgomggAEftwCAADej4A==
Date:   Tue, 23 Oct 2018 13:35:29 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9FB5B2@hasmsx109.ger.corp.intel.com>
References: <20181019182307.17745-1-tomas.winkler@intel.com>
 <alpine.DEB.2.21.1810200419110.9963@jsakkine-mobl1>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9FA974@hasmsx109.ger.corp.intel.com>
 <alpine.DEB.2.21.1810231612030.19836@jsakkine-mobl1>
In-Reply-To: <alpine.DEB.2.21.1810231612030.19836@jsakkine-mobl1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTBjZTllNmYtY2YxZC00ZTNiLWFlY2EtYWJjM2JiNzA0NjRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic2NDaWF5bFl2aVNUdEZMXC9rZTR5RUxwa1JvYWR4OHRRTUx5SzBac2JnakY0dVYycXpBRHBHcUxIYVdlbkpZTlMifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.252.19.114]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Mon, 22 Oct 2018, Winkler, Tomas wrote:
> >> This is the list of patches (assuming that I didn't miss anything)
> >> that still need tested-by tags:
> >
> > Those are just code movements, we are running them form months on our
> > systems.
> 
> I'm not sure what point you are trying to make. You cannot give tested-by by
> yourself to yourself you know. By saying that you are just saying things. It is
> not any form of peer testing.
No, you are exposed to that code base as well, after all you are working @intel.
> 
> >> - tpm: factor out tpm1_get_random into tpm1-cmd.c
> >> - tpm: factor out tpm 1.x pm suspend flow into tpm1-cmd.c
> >> - tpm1: rename tpm1_pcr_read_dev to tpm1_pcr_read()
> >>    (the subsystem tag is wrong in this, just noticed, should be
> >> 'tpm:')
> > When have you established this requirement I missed that and it cannot
> > be deduced from the git history.
> 
> Which requirement?

The requirement that the  subsystem prefix should be 'tpm:' 


Thanks
Tomas

