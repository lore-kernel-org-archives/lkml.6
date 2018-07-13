Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4CDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4010C208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="RCvHarF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeGMTWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:22:50 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:59545 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731366AbeGMTWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1531508787; x=1563044787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XO2p/YuHpEWlbN4P8hjfN/kI0DR8uE2w7yCCCqYiEHI=;
  b=RCvHarF0VgUtcbEZh4lPBJd2+LlPoiLYXmiXpFjAgGEKKVE7HWtW4VE5
   Gr/P4Z6mHnprER/J/rzQfKr3G1IsizQndEafRl/+UfyDTYtgGJYL07K84
   5NpjTBjksV+I21v/vYNIlA/25ANxwQ276EAnmv2TtLR4oD9TTMc4u+TZx
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G9AgA390hbmMuZ6ERcHAEBAQQBAQoBA?=
 =?us-ascii?q?YQdgQ4ymC2CDIFylUELhGwCglAhOBQBAgEBAgEBAgEBAhABAQEBAQgLCwYpL4I?=
 =?us-ascii?q?1IoJhAQEBAQIBOjQLEAIBCDYQVwIEDg2DGIFvCQiqR4doglaJAoIWhCKFSIUJA?=
 =?us-ascii?q?odMkhAHAo8fgT0BjC+SFIFYgXRwUIJqgjIajgaMGYEaAQE?=
X-IPAS-Result: =?us-ascii?q?A2G9AgA390hbmMuZ6ERcHAEBAQQBAQoBAYQdgQ4ymC2CDIF?=
 =?us-ascii?q?ylUELhGwCglAhOBQBAgEBAgEBAgEBAhABAQEBAQgLCwYpL4I1IoJhAQEBAQIBO?=
 =?us-ascii?q?jQLEAIBCDYQVwIEDg2DGIFvCQiqR4doglaJAoIWhCKFSIUJAodMkhAHAo8fgT0?=
 =?us-ascii?q?BjC+SFIFYgXRwUIJqgjIajgaMGYEaAQE?=
Received: from esa5.dell-outbound2.iphmx.com ([68.232.153.203])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 14:06:27 -0500
From:   <Eugene.Cho@dell.com>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2018 00:59:43 +0600
X-LoopCount0: from 10.166.132.133
X-IronPort-AV: E=Sophos;i="5.51,348,1526360400"; 
   d="scan'208";a="272508880"
To:     <gregkh@linuxfoundation.org>
CC:     <a.amelkin@yadro.com>, <andrew@aj.id.au>,
        <benh@kernel.crashing.org>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <joel@jms.id.au>,
        <stewart@linux.ibm.com>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
Thread-Topic: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
Thread-Index: AQHUGrwsvtYF8DKemEGBB9m7D+FlaqSNfgPwgABYqgD//6zNEA==
Date:   Fri, 13 Jul 2018 19:06:53 +0000
Message-ID: <8dfaea969aeb4b0fbd049b4e48389b43@AUSX13MPC105.AMER.DELL.COM>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com>
 <bc2d6bd30ce243768d07b2aa5ed9cee4@AUSX13MPC105.AMER.DELL.COM>
 <20180713190320.GB30539@kroah.com>
In-Reply-To: <20180713190320.GB30539@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titusconfig: No Restrictions 04051212
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvIiwiaWQiOiI1N2VkYjQwOC0wNzM4LTQ3ZGMtYjNlOS1jOWI5ZTNkMzQwNWEiLCJwcm9wcyI6W3sibiI6IkNsYXNzaWZpY2F0aW9uIiwidmFscyI6W3sidmFsdWUiOiJObyBSZXN0cmljdGlvbnMifV19LHsibiI6IlN1YmxhYmVscyIsInZhbHMiOltdfSx7Im4iOiJFeHRlcm5hbENvcnJlc3BvbmRlbmNlIiwidmFscyI6W119XX0sIlN1YmplY3RMYWJlbHMiOltdLCJUTUNWZXJzaW9uIjoiMTYuMi4xMS4wIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkZrNStUaWhsUHhsTnBOVUUxeVlRMW1waE1rSWJFQitHMUJFa3pqc0lrbTQ9In0=
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Dell - Internal Use - Confidential =20
>Really?  To a public mailing list?  odd...

Ha yea sorry - I was so excited to show my support, that I jumped the gun :=
)

