Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZM87C793GVvUKwAAmS7hNA
	; Thu, 07 Jun 2018 18:21:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10939606FA; Thu,  7 Jun 2018 18:21:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=permerror (0-bit key) header.d=cray.com header.i=@cray.com header.b="KzU79UeE";
	dkim=pass (1024-bit key) header.d=crayinc.onmicrosoft.com header.i=@crayinc.onmicrosoft.com header.b="FBZG/KDB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 459C7605A2;
	Thu,  7 Jun 2018 18:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 459C7605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=cray.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935269AbeFGSVs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:21:48 -0400
Received: from esa1.cray.iphmx.com ([68.232.142.33]:16228 "EHLO
        esa1.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933152AbeFGSVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=cray.com; i=@cray.com; q=dns/txt; s=cray1024;
  t=1528396371; x=1559932371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=arE87VMKBQx74lOWVPZllMaB83O+JYFaAWOPG9cNKdU=;
  b=KzU79UeE3flUO7P6i2R+CyjIF99NGyHeO675EBfLNjs4rAzDZdopY9a2
   DfZ36Dvnu9AziFSt+OVjHq1Hx3hL9NZYeVxC2piW1gakt1aHSas1razU0
   dB2ySoZLuv3yanepGB8ZahUjJKS/RerVnJ3ChmnbQFUyt7h65m0OWvXKw
   M=;
X-IronPort-AV: E=Sophos;i="5.49,487,1520899200";
   d="scan'208";a="20372355"
X-Cray-OBMMKR: 1433258124 20372355
Received: from cray-smtp-2.cray.com (HELO CFWEX01.americas.cray.com) ([136.162.34.11])
  by esa1.cray.iphmx.com with ESMTP/TLS/AES256-SHA; 07 Jun 2018 19:32:50 +0100
Received: from CFWEXHYBRID.americas.cray.com (172.30.88.178) by
 CFWEX01.americas.cray.com (172.30.88.25) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Thu, 7 Jun 2018 13:21:44 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (216.32.180.22)
 by mail.cray.com (172.30.88.178) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Thu, 7 Jun 2018 13:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=crayinc.onmicrosoft.com; s=selector1-cray-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qozNTs1R/tjhpk33XX0KYVGEAAfXYEtQe3sG4yw1rBQ=;
 b=FBZG/KDBRQzZFFyR+JWN7R9LjUOkZxKsAKVdfMs8Tn5ESW90OSw6PjSHYbMUNPtGZXN/N3nsJXXhFO0zW1DksMPOykct0Xe2q/3FJkDRYjrTpO9clsx/8dqu/RV2A/aH06Uyob320Sa3J8qYXHO+c2Zt1yndHTfvP6gGM3tDtV8=
Received: from DM5PR11MB1451.namprd11.prod.outlook.com (10.172.36.22) by
 DM5SPR00MB239.namprd11.prod.outlook.com (10.175.226.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 7 Jun 2018 18:21:42 +0000
Received: from DM5PR11MB1451.namprd11.prod.outlook.com
 ([fe80::4053:a878:fe79:26ee]) by DM5PR11MB1451.namprd11.prod.outlook.com
 ([fe80::4053:a878:fe79:26ee%10]) with mapi id 15.20.0820.015; Thu, 7 Jun 2018
 18:21:42 +0000
From: Ben Evans <bevans@cray.com>
To: NeilBrown <neilb@suse.com>, James Simmons <jsimmons@infradead.org>
CC: Oleg Drokin <oleg.drokin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 10/11] staging: lustre: move ldlm into
 ptlrpc
Thread-Topic: [lustre-devel] [PATCH 10/11] staging: lustre: move ldlm into
 ptlrpc
Thread-Index: AQHT/aQqQ8mBFCFbe0qoj06MBZYRRKRUjnB3gABL/IA=
Date: Thu, 7 Jun 2018 18:21:42 +0000
Message-ID: <D73EEFA7.FCA6%jevans@cray.com>
References: <152826510267.16761.14361003167157833896.stgit@noble>
 <152826511923.16761.9237280635711887801.stgit@noble>
 <alpine.LFD.2.21.1806070546210.23188@casper.infradead.org>
 <87sh5zlyf4.fsf@notabene.neil.brown.name>
In-Reply-To: <87sh5zlyf4.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bevans@cray.com;
x-originating-ip: [136.162.34.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5SPR00MB239;7:TRBYhFZDJNYwXzUhNcsIN45a8PcmJhxvLK5oVn9f2Mik8eqq24Cx7uG/8UALcVBT2iohh4qIh5pfxg+lQbCnDgU9OszWXcAjSNH/M8zd3gKL+uLHe1BTqCD6hsJzvq9lDkyXcZdayL4GlAJznETetBtxYKCHFzN/Eje6UGrx0lw6tl4DxKoBBgemkM//yaJMyjAlC3U3is/MrdzXGF31YUHuMMmqYdf4a4qqHCSyHNnOwwJ6BsTZnhY0wythelnv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5SPR00MB239;
x-ms-traffictypediagnostic: DM5SPR00MB239:
x-microsoft-antispam-prvs: <DM5SPR00MB239E0B45FF61AFD9DEE1019B1640@DM5SPR00MB239.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5SPR00MB239;BCL:0;PCL:0;RULEID:;SRVR:DM5SPR00MB239;
x-forefront-prvs: 06968FD8C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(366004)(39850400004)(376002)(51914003)(174864002)(199004)(189003)(76176011)(93886005)(5660300001)(6512007)(54906003)(110136005)(8676002)(316002)(102836004)(68736007)(2900100001)(66066001)(6246003)(476003)(6506007)(8936002)(86362001)(2616005)(99286004)(6116002)(3660700001)(4326008)(59450400001)(14454004)(486006)(105586002)(106356001)(6486002)(7736002)(478600001)(53546011)(3280700002)(5250100002)(3846002)(2906002)(53936002)(229853002)(36756003)(26005)(25786009)(11346002)(97736004)(446003)(186003)(81156014)(81166006)(6436002)(305945005)(13693001)(129583001)(94096001)(17423001)(156123004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5SPR00MB239;H:DM5PR11MB1451.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5dQHC85zeNIcynjyokGKkjL6kMSybZOj8D1eAjdPkQGO1JsPOu4XcaC7wiEf37K+VZxgSVN7wMfdfJth86uxKiqMIZPeLgQc7uFr60bRGFcSLmEg0OB5JGDl1WLIpGjQ7dqtPMjWy3eYKxD+QLSUVPigZ6FnIQaQ38zW6RjlcoPjMPRRuJlFu5VC9gEQbS6R
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <796DC05CE3B55F43BEC0B9C653CC617F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 54287903-fc78-47b1-8387-08d5cca38513
X-MS-Exchange-CrossTenant-Network-Message-Id: 54287903-fc78-47b1-8387-08d5cca38513
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2018 18:21:42.6239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB239
X-OriginatorOrg: cray.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/18, 5:48 AM, "lustre-devel on behalf of NeilBrown"
<lustre-devel-bounces@lists.lustre.org on behalf of neilb@suse.com> wrote:

>On Thu, Jun 07 2018, James Simmons wrote:
>
>>> The ldlm code is built into the ptlrpc module, yet it lived in a
>>> separate directory.  This requires filename editing in the Makefile
>>> and make it difficult to e.g. build the .s file for code in ldlm.
>>>=20
>>> All the ldlm files have distinctive names so confusion from having
>>> ptlrpc and ldlm in the same directory is unlikely.  So move them all
>>> into ptlrpc.
>>
>> Nak. The reason is it would be nice to keep the directory structure.
>> What really needs to be done and Oleg has looked into it is to reduced
>> the number of modules created down to two, one for LNet and the other
>> lustre.ko. This also is a step in the right direction to remove the
>> create struct obd_ops and struct md_ops pointer madness. Well their
>> is the issue with obd echo client but we can deal with this at a later
>> date. Also the number of EXPORT_SYMBOLS and things will greatly reduce.
>
>Yeah, you are probably right.
>I had a bit of a look at how to build everything into a
>single module.  You can do with by having a single make
>file that lists parts from other directories - the same way
>that ptlrpc includes files from ldlm - but that is rather ugly.
>
>I've very nearly got it working using the lib-y infrastructure.
>I can build lnet as a single module, but the dependency calc isn't
>quite right so things happen in the wrong order.  The build
>fails the first time because some files don't exist, then
>succeeds on the second run.
>Hopefully I'll figure out how to make it work tomorrow.
>
>Thanks for the review,
>NeilBrown

Would this be client-only, or could the server code be added as well with
an ldiskfs/zfs module?
