Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9027C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64722445
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="dlU85Spz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64722445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeGGDs6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:48:58 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:3401 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932642AbeGGDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1530934752; x=1562470752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UIht7GATF4cezH2r4h3VM4x1t06DkqKHfGIeDsVw5Tg=;
  b=dlU85SpzvNWRFbo3h8BVIKCf6Trugj58OGTINJ3NvJyirwXA/mhG22Ga
   jTvZ79mfZ9/DXca2ZiAPKolp6vuqlhAUbaXKqgPEf5x31QNVOZEueWr3n
   G9CxzKTXRitKhJ07dihzKdMXXixUMsEs65RQZD4FiklyA7SSgcFquUfNr
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FNAgBgN0Bbh8mZ6ERbGwEBAQEDAQEBC?=
 =?us-ascii?q?QEBAYQdgQ0ymCiGRJB1gXoLhGwCgi4hNhYBAgEBAgEBAgEBAhABAQEKCwkIKS+?=
 =?us-ascii?q?CNSKCYgMDeRACAQghJQ9IAgQBDYMlggCrT4hMgTqIboIVgQ+DD4R6hVYCjQ2MQ?=
 =?us-ascii?q?gcCjySNW5IPgUgHgX1wgzqCIw4JjhePQ4EaAQE?=
X-IPAS-Result: =?us-ascii?q?A2FNAgBgN0Bbh8mZ6ERbGwEBAQEDAQEBCQEBAYQdgQ0ymCi?=
 =?us-ascii?q?GRJB1gXoLhGwCgi4hNhYBAgEBAgEBAgEBAhABAQEKCwkIKS+CNSKCYgMDeRACA?=
 =?us-ascii?q?QghJQ9IAgQBDYMlggCrT4hMgTqIboIVgQ+DD4R6hVYCjQ2MQgcCjySNW5IPgUg?=
 =?us-ascii?q?HgX1wgzqCIw4JjhePQ4EaAQE?=
Received: from esa1.dell-outbound2.iphmx.com ([68.232.153.201])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 22:39:11 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 09:38:45 +0600
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.51,319,1526360400"; 
   d="scan'208";a="223247632"
X-DLP:  DLP_GlobalPCIDSS
To:     <dvhart@infradead.org>, <andy.shevchenko@gmail.com>
CC:     <srinivas.pandruvada@linux.intel.com>, <alex.hung@canonical.com>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Thread-Topic: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Thread-Index: AQHUDwyTs6nsEeHVokGyB9ujS48v7KR3cjWwgARzsgGAABHaIIAG9Ny+gAA/AKk=
Date:   Sat, 7 Jul 2018 03:48:54 +0000
Message-ID: <1530935335264.5774@Dell.com>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
 <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
 <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
 <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
 <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>,<20180706235907.GE3041@fury>
In-Reply-To: <20180706235907.GE3041@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.191]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>I strongly advocate for vendors to have more control over their drivers,=
=0A=
>but this scenario really frustrates me. I don't think I can justify this=
=0A=
>to Linus as a fix. But before we just say "no" (because hey, I want=0A=
>these fixes available as early as possible too), let's ask Rafael if he=0A=
>has an opinion or if there is precedent for this in his experience with=0A=
>ACPI drivers in general:=0A=
=0A=
Full disclosure - an updated FW has since been rolled out that reverted thi=
s=0A=
behavior back to previous FW behavior due to lack of Linux support for the=
=0A=
new _DSM.  There is desire to use the new interface (as it did fix actual=
=0A=
problems with the old one) so at some point it may return.  When that happe=
ns=0A=
it would be ideal that people who are (for example) running an LTS kernel=
=0A=
or distro kernel that tracks stable can pick it up too.=0A=
