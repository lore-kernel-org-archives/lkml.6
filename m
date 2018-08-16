Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7DAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40F120C51
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i3kEcdUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40F120C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeHPUxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:53:22 -0400
Received: from mail-eopbgr690108.outbound.protection.outlook.com ([40.107.69.108]:36076
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbeHPUxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF1RUHHRwy1AfFJ2/VWVE3oEGoQijwqS7Mjt6iWla0g=;
 b=i3kEcdUPGVZIrwAc964AiHRLOnMv891NZgs/TPqBvN0ytBc5iIGpCmaUwYMwqzNuOUAg0gJUqHj0XxeNiTWQRh/q03fKgi2H/i38MxvCaBoQGbzFlIA3whAkjZ7Hz5ily0jCXbGWeEm1zeofTAynQ0NQF6wAtXNsHG8GizVrY5I=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0796.namprd21.prod.outlook.com (10.175.112.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.6; Thu, 16 Aug 2018 17:53:26 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 17:53:26 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 2/4] mm/memory_hotplug: Drop mem_blk check from
 unregister_mem_sect_under_nodes
Thread-Topic: [PATCH v3 2/4] mm/memory_hotplug: Drop mem_blk check from
 unregister_mem_sect_under_nodes
Thread-Index: AQHUNKY0YNeOSw06u0iBJH1J85oJq6TCqsKA
Date:   Thu, 16 Aug 2018 17:53:25 +0000
Message-ID: <20180816175325.xd4qmlauh65qszsk@xakep.localdomain>
References: <20180815144219.6014-1-osalvador@techadventures.net>
 <20180815144219.6014-3-osalvador@techadventures.net>
In-Reply-To: <20180815144219.6014-3-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0796;6:7opmAZY0n9uePc+97MS6YwzhFY6xjA9uYbB6vRkYN09pQQY1qhDaeJpto07pEnRMlX8RWcfWh+1WmSqcHjTfcBN3AhnA1NtJuJNmtzPf1YqS2aiHFaKiXGc+WsGR63Wy2aCCi6hfioJiPo4+cTq9nl+KruGWm0TSsFkevwNRl6xUJwqS/8Sk+kfqJP1RqOd6/FHgI7QgosFDjp9Ep7XnFCVnXpXcq4QHmevwHnNhUS0DtWOe01W97rCF8eCJSKmZ957/4WtJaPAINuS9cozvtC1MiopazkRFbs55uifloF20/odyCecVSZN80z4GzfFMOb2FkiSY0ozE8qB/P7GF7Yso81SR7wkqqh5U4pmI29o4zmbe1HetRZFuHTfflPlpUK7zoGi0einFV/166LIU75Qm7aknnSsAPUQZ+/nE6qizW9DvtyVuTHv2xCSCoOQ+xYWXgSk+ze+UaVKce4lBGw==;5:VtiG1YqI1lCMVoUYMIb87P//ntoBcUAMQ2bdvZcyO3UQdh78Csj83sM0IrDC9P+pwHaoyVZKfP5AYzx6oqhbTiZhnDZGBbvniJE2UD+RZQILIEqPjj4eVFy9ZkN8QrvCEixfqdQ1ja6ISngpS8xV9oX0bNY4Au+Q+vGxsUeudIQ=;7:hRCH+mVSmCg2UTu96NWQ00m/+kFmbKnc1eyFsq0+7bhZD46o6kdW16wTYHa2jjaNm0QaoM/Jg8lzGGB5RQny4Ob9vRIQLMVwKzpJ5koyQFgxz+O8k0noO9c6ir1sOHLpWcH3afza6FrV7vdb/I5lpm7wMgjEv0Mje+P9DD6z1qQij9zseG0yeg+Rq59RS6B/FRlwLOry0TcUwZ+BW1WeZEGaJiZSognUYxPvLk7GF0rkiWx+KNBrnN0JBPu2kMQ9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1cc38c7d-3b4e-421c-789d-08d603a12ac0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0796;
x-ms-traffictypediagnostic: DM5PR21MB0796:
x-microsoft-antispam-prvs: <DM5PR21MB07968F49ADE2EDD2B83A19F19D3E0@DM5PR21MB0796.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231336)(8210008)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:DM5PR21MB0796;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0796;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(10090500001)(316002)(14454004)(6246003)(25786009)(2906002)(5250100002)(8676002)(81156014)(81166006)(8936002)(53936002)(54906003)(72206003)(2900100001)(3846002)(105586002)(486006)(97736004)(106356001)(6436002)(6116002)(22452003)(9686003)(6512007)(478600001)(68736007)(10290500003)(6486002)(476003)(229853002)(186003)(33896004)(446003)(53546011)(86362001)(5660300001)(6346003)(11346002)(6506007)(76176011)(256004)(1076002)(99286004)(66066001)(6916009)(39060400002)(305945005)(26005)(7736002)(102836004)(86612001)(4326008)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0796;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: Uhxhp9M1ubC6FUyfLDZ6S8P/+q/esnES0SsLw8KWTj8a0XvF4VTv2YUFcf9fiSjpsttfjv5oTyPkMZuy0qVtWQeRqKvMy9vp4/jiPMYq5hDEL1crBBZd52cU5WCYfTilfK0BKO92dYE3XoCp/YwmItWbM4/fYjOBMTgtm/Byv+m38o586Ap7NVUp458RPt1rvIFAx4XyVjDAO0rqzHo4mk8OrIsP2CT7gCUO4HWB4MuLId67SxCjgiPjLhOlKamSjRfs/mH+xkGKrQYnI8ojXVhNp/huGTlR/4dk/Y7ZfE8fK0YP1ukz7S693PhLTUiHoOXlsrHcB6SPeb5eD/YB14MuuTeMaJWO1586uB3N0Sg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F1C39793C0BC942BFE08BC4D9CCDD1A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc38c7d-3b4e-421c-789d-08d603a12ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 17:53:25.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-15 16:42:17, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
>=20
> Before calling to unregister_mem_sect_under_nodes(),
> remove_memory_section() already checks if we got a valid memory_block.
>=20
> No need to check that again in unregister_mem_sect_under_nodes().
>=20
> If more functions start using unregister_mem_sect_under_nodes() in the
> future, we can always place a WARN_ON to catch null mem_blk's so we can
> safely back off.
>=20
> For now, let us keep the check in remove_memory_section() since it is the
> only function that uses it.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

> ---
>  drivers/base/node.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 1ac4c36e13bb..dd3bdab230b2 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -455,10 +455,6 @@ int unregister_mem_sect_under_nodes(struct memory_bl=
ock *mem_blk,
>  	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
>  	unsigned long pfn, sect_start_pfn, sect_end_pfn;
> =20
> -	if (!mem_blk) {
> -		NODEMASK_FREE(unlinked_nodes);
> -		return -EFAULT;
> -	}
>  	if (!unlinked_nodes)
>  		return -ENOMEM;
>  	nodes_clear(*unlinked_nodes);
> --=20
> 2.13.6
> =
