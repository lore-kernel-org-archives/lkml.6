Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934023AbeCGQQf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:16:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45482 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:16:34 -0500
X-IronPort-AV: E=Sophos;i="5.47,436,1515427200";
   d="scan'208";a="72960586"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>
CC: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 3/6] lib/scatterlist: Do not leak pages when high-order
 allocation fails
Thread-Topic: [PATCH 3/6] lib/scatterlist: Do not leak pages when high-order
 allocation fails
Thread-Index: AQHTthJ29ElMPnlnbEiOlFlrboqlxKPE8yeA
Date: Wed, 7 Mar 2018 16:16:30 +0000
Message-ID: <1520439389.2890.16.camel@wdc.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
         <20180307124712.14963-4-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20180307124712.14963-4-tvrtko.ursulin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0814;7:+epKcE+7MxnRsXx65kvqQcb5gHOJD9qsIbugpeHCuOFRbPK05i1V7wEGiuA2F5NcjX4bYMjhCqo/3WSOugi9AHwVxird4f6EbopO9CFeE5NeuT21cGPRWKkkOwLwY7g81KK5sbLR43h9ZVeSdDMVsEhyRSbLRhqGELoFi41SiXafx6o4iBF0Ez8Jc9PDIRSeKNtZSlS4CLxYkrnCEGsG6LEbQMSCFGRjrARw2HX3VjoRfPDehe3ngIqYzr515xJB;20:qhSZfK8UN/Rbqk+Qezjir5f/xvhG7kNMYbp/pK1V9bCWqbIqWr2ukBPyb2Nvy6/zN9b1svvusedDlLsl+R+2xEtwa3qeNggHnIQkZjMQuQXKnBeNMTsKKATrJq9GPiEkGGWkQk+BEpBu0/ogk/8gBcXY9UUGFTL5PR1fN4xWXBQ=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7f5ddc7-dfbe-4124-4f91-08d58446c9ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0814;
x-ms-traffictypediagnostic: MWHPR04MB0814:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0814A9D19D636C57E06C8C5798D80@MWHPR04MB0814.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB0814;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0814;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(366004)(39380400002)(199004)(189003)(377424004)(3846002)(186003)(25786009)(478600001)(68736007)(72206003)(6116002)(103116003)(26005)(2950100002)(106356001)(229853002)(8936002)(8676002)(3660700001)(54906003)(316002)(81156014)(81166006)(4326008)(2501003)(2906002)(5660300001)(110136005)(105586002)(6486002)(66066001)(5250100002)(3280700002)(76176011)(102836004)(86362001)(6506007)(59450400001)(305945005)(7736002)(6512007)(97736004)(6246003)(2900100001)(99286004)(14454004)(6436002)(36756003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0814;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 3i01C1QFqO6siAyRWREVmMqcBfeEK1mH0Jo1Qoo7k/ZT3Q9Ce98ypZWTTwsNt0r6FATPsML/ctYYiCG+vWx4VBZ5NUqEQwNrUdarIlMUjyz6LGMAhVvzk/t/aMvhG61LxuDhOw7skSOsov2H5NxQmvbik89NJFOn6y18ILY/L0fTolW+wgV7LjUHLUS0TdoNKmWRHUwGuyC5FqD2aRUhtjVGcfGmZypQMjfIux7Mv34/8y+ZmpkL6friO23OIAhZrViPaXRkLUPET7nEbuD6NxLniQaCCLwe0k4MnQ9JXhweugjbNGznk1NO4JdyNrsSxitSa7DUnDmMUhzHpPsx7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <37BBBBDCE889EC4AB78F69AC4267790A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f5ddc7-dfbe-4124-4f91-08d58446c9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 16:16:30.6761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0814
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27GGfwg006791

On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 9884be50a2c0..e13a759c5c49 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -493,7 +493,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
>  {
>  	unsigned int chunk_len = PAGE_SIZE << order;
>  	struct scatterlist *sgl, *sg;
> -	unsigned int nent;
> +	unsigned int nent, i;
>  
>  	nent = round_up(length, chunk_len) >> (PAGE_SHIFT + order);
>  
> @@ -517,11 +517,12 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
>  
>  	sg_init_table(sgl, nent);
>  	sg = sgl;
> +	i = 0;
>  	while (length) {
>  		struct page *page = alloc_pages(gfp, order);
>  
>  		if (!page) {
> -			sgl_free(sgl);
> +			sgl_free_n_order(sgl, i, order);
>  			return NULL;
>  		}
>  
> @@ -529,6 +530,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
>  		sg_set_page(sg, page, chunk_len, 0);
>  		length -= chunk_len;
>  		sg = sg_next(sg);
> +		i++;
>  	}

Since the entire sg-list is zero-initialized before this loop starts, since
the sg-list is not chained onto another sg-list before this function returns
and since sgl_free_n_order() checks whether or not each page pointer is NULL
before freeing it I think we don't need the new loop variable 'i' and that
we can call sgl_free_order() instead of sgl_free_n_order().

Bart.
