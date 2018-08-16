Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4162C2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T26ROPs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4162C2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbeHPUpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:45:38 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:58143
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbeHPUpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XPbk1vqqINla1PhzvQtTAmc5OPK4kLQJRobmMql3uw=;
 b=T26ROPs40yjchiv5adDARmKlWaKY+rkQ4WhneZvFMDbP7jO4W4WiBzuJN3GWaSf+zy9CrXNfBK9wv4b9ets9EISGoUBqUyIHpfNmvsY6p+lRSnYi+LmG1UATCzjBCFnLwYXtEwBQYhdZMG4SXoQg1c7cj2QvePoSNfXBVkQYS/c=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0155.namprd21.prod.outlook.com (10.173.173.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.7; Thu, 16 Aug 2018 17:45:43 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 17:45:43 +0000
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
Subject: Re: [PATCH v3 1/4] mm/memory-hotplug: Drop unused args from
 remove_memory_section
Thread-Topic: [PATCH v3 1/4] mm/memory-hotplug: Drop unused args from
 remove_memory_section
Thread-Index: AQHUNKYz7/cjSBVw10qThdVTfaqF8qTCqJyA
Date:   Thu, 16 Aug 2018 17:45:43 +0000
Message-ID: <20180816174543.e6puawtdomoadnrd@xakep.localdomain>
References: <20180815144219.6014-1-osalvador@techadventures.net>
 <20180815144219.6014-2-osalvador@techadventures.net>
In-Reply-To: <20180815144219.6014-2-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0155;6:LIyIRaufhKMWw20v9ID0AClmTNQhOuNFq8W3Vg568Y04o5+kD7bQLjHN8/4WtuofUbgFTCFH20FBeDKHS5IkRrGykYwiYp/JfFJ5y4nUVvKvHYHC93RrEMzYtTMfwfOoP64rtYgHiRT2b6q+gnA9bPsdxaIJDo6vEv2TQ1oYmEzvhpW18FyJxoSNGsCwpR4nlN4FvyD3VV9qBV6hfidrW4GT9xwSlERsOY8xe7z2KG1odpZbQ8MwG/x2JqLTDb114ppTj+gc2LbV+rgJEYoMel/o5z2I9aXBBJJSOvNlPfMeEajzwVb+HU56oZT7HgDiK6nfna8ZiWWyuVrNOBNeaXg8CEcjzzwP3lq8ZOUqoMs+BcBpfuImUJrPpNoqmaWdh/gNazQmbgjrQVqVriXiaFq8DbTmm88B80xiXfpPGN3BSy6Ec6VFljIJ+iAUMcjPdl/WDDI3ICLmLK7yl0oTfg==;5:z2CcgPPwpVsX1LOTbh0EORuz7OKqhCeNqousNzLAXZmrBHzDK8ubrfTxsplSQxOzl9aaExywK4jNFrMALAKKkZi6K7ifAArTlqmX78e11TZS4lhJuTRUn1qHmS/W1MAQFmGTNK49F+M70r5qzG7qTfyU0+AQAekqALjxu8Rqotk=;7:BF4nMvjUYtcYR8bCJH4lAPOqKTnsTxc1OFOpoIlAnh46TxS7fONc0r5fxGiXFsX6Ip5uv4HrhU67dMOGRUVHjK7pvXtZON9e30Zwif+HJQMCHH4peFf7MLNlyxkflRtskom3ZyUxBD7ze3CR7Y5tG+1kAUELMf9LOywTK+0uuF1mcnA87YDibHrmaHiLmI3FBHM9LzFWNZt9FcJp+QIsK0TIsFug6RiybsGmvQeRnLGzJNKxjBf8jmhm7LNabC8E
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8968f469-4d0b-40c9-3120-08d603a01738
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:DM5PR21MB0155;
x-ms-traffictypediagnostic: DM5PR21MB0155:
x-microsoft-antispam-prvs: <DM5PR21MB0155B85FB97A9B5DF399AA1E9D3E0@DM5PR21MB0155.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231336)(8210008)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:DM5PR21MB0155;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0155;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(2900100001)(6916009)(8936002)(4326008)(6246003)(6506007)(39060400002)(68736007)(53546011)(1076002)(105586002)(3846002)(6346003)(256004)(6116002)(102836004)(10290500003)(97736004)(25786009)(106356001)(5660300001)(10090500001)(8676002)(229853002)(6486002)(6512007)(9686003)(6436002)(81156014)(81166006)(186003)(305945005)(7736002)(53936002)(2906002)(86612001)(7416002)(26005)(33896004)(446003)(86362001)(11346002)(575784001)(476003)(14454004)(316002)(99286004)(76176011)(22452003)(66066001)(486006)(5250100002)(478600001)(72206003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0155;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: VVxgqPr08xmopUrUg4pQ4T8pefpyGGjPRjn1gUVEGwaa5qm/Eepmc74y0aG9WcT+tTTxzPTWzbP73qazmUZf8bIajz+iFjCldFo5e2KCNV7Tp281QP2XqZmR3ao/GegTED+lHjmf/oFE2SvkEZzM9nOHB+NAFSVjq5/+94DHKFeMc50fT367fKpudMGqfeOzOClhF1k1+NfesJ9xzcniM4yf+T/r7FIdVBJdoVLNT2lVLJhls2CMGsHvQDJy9nKQmRs26SGAywW5fWmWKEQNmCrJDlc1IGFkJphzA/gq72vnuf6fsrsUeH9nLabgxR+07lao08m+GBTy0unj9PfVfqujN1xkZGlvd7A3/son2H4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14461EB7149D29409BA6145B64D908DE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8968f469-4d0b-40c9-3120-08d603a01738
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 17:45:43.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-15 16:42:16, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
>=20
> unregister_memory_section() calls remove_memory_section()
> with three arguments:
>=20
> * node_id
> * section
> * phys_device
>=20
> Neither node_id nor phys_device are used.
> Let us drop them from the function.

Looks good:
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>

>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/base/memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index c8a1cb0b6136..2c622a9a7490 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -752,8 +752,7 @@ unregister_memory(struct memory_block *memory)
>  	device_unregister(&memory->dev);
>  }
> =20
> -static int remove_memory_section(unsigned long node_id,
> -			       struct mem_section *section, int phys_device)
> +static int remove_memory_section(struct mem_section *section)
>  {
>  	struct memory_block *mem;
> =20
> @@ -785,7 +784,7 @@ int unregister_memory_section(struct mem_section *sec=
tion)
>  	if (!present_section(section))
>  		return -EINVAL;
> =20
> -	return remove_memory_section(0, section, 0);
> +	return remove_memory_section(section);
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> =20
> --=20
> 2.13.6
> =
