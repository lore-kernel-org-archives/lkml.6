Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbeCGQKm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:10:42 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38022 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGQKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:10:40 -0500
X-IronPort-AV: E=Sophos;i="5.47,436,1515427200";
   d="scan'208";a="72960109"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>
CC: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] lib/scatterlist: Tidy types and fix overflow checking
 in sgl_alloc_order
Thread-Topic: [PATCH 1/6] lib/scatterlist: Tidy types and fix overflow
 checking in sgl_alloc_order
Thread-Index: AQHTthKDmR4Kd0LaQkSfrEgTVD+F9aPE8YIA
Date: Wed, 7 Mar 2018 16:10:37 +0000
Message-ID: <1520439036.2890.13.camel@wdc.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
         <20180307124712.14963-2-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20180307124712.14963-2-tvrtko.ursulin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0830;7:61GuQ8T+Rq0CJI12FWo9VX6+Tf2basPxqurV5jnyVb0Nzgh/DR8PCyY1TGMK4koy2A4TqGxYiIvSxCFvQg01ZbCxdXBarLCCfrMwjHvMLsDXg6ZNsc8yCGKR3VSe8sOzbpfWHdED3FY3te797xqzFju5RRk71XVsP+IG2ESd41H2PWz1HLt58qw7geKFfHaKGp18EbaG1sOaCHMaqn4JhTuiSS9y3+RIF+i7aAscWdFkfLqliv7WbDhh4S/uWazA;20:jJaiHs3sLDJgA/1cWbn2yEHfwNSG4b8jv34xK9tBaFBgW5iaAEofmEw/fJW1/sE3dfvHE1FF1FzeV0JWcPUoydAWSLbI/p3tnbouL+FS2bNSodZJHHiiP8em+2jkErqnecEYvvMfWidRnkJp9D/QvbuVeNg4zCn/jLiqg2+Yl20=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15be84e3-a7c0-4054-e582-08d58445f75a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0830;
x-ms-traffictypediagnostic: MWHPR04MB0830:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB08309A97E6BD80046A54B3F698D80@MWHPR04MB0830.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0830;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0830;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(199004)(189003)(51444003)(377424004)(99286004)(81156014)(81166006)(8676002)(106356001)(4326008)(26005)(6116002)(3846002)(186003)(305945005)(316002)(59450400001)(105586002)(2906002)(68736007)(229853002)(6506007)(102836004)(2900100001)(72206003)(110136005)(54906003)(7736002)(3660700001)(76176011)(478600001)(86362001)(25786009)(14454004)(6512007)(2950100002)(2501003)(6246003)(5250100002)(8936002)(36756003)(53936002)(6486002)(97736004)(103116003)(3280700002)(66066001)(5660300001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0830;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: HvRCCRxxJuJj6T+udPUIy3NVoTG/wO9kLHlrOxf4UHvKp9s8gRTmYH3XPWqFYd+Q/YmJrHUfj8IinA0lkhYsm+UEPW5O4FSossa9+xJ6I1YPsyjFrqKvbBMvd5aywNVmw7CPmPEFZZonVTrS3Xn3C+rc9FwMBysX8b5TWteGfYFOGj8gparVV5TlHLc91SznJ2QtRFh5BKpZr/emgwpaS2iacJukr7jw4935CCUTPAqfJ+U0CG4YxkJsCnS5zp/nZCV88Jy4zYclAazgNnMfsUpD/XxG4jqFdGre3HRlcuXBXuqt4XHmWSzs0QkqqGuBMWZIqOwSlIIYNrSiOmrqag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <670DA51732E3544F801DF420EDFB2A09@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15be84e3-a7c0-4054-e582-08d58445f75a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 16:10:37.8144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0830
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27GAnmg006185

On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
> sgl_alloc_order explicitly takes a 64-bit length (unsigned long long) but
> then rejects it in overflow checking if greater than 4GiB allocation was
> requested. This is a consequence of using unsigned int for the right hand
> side condition which then natuarally overflows when shifted left, earlier
> than nent otherwise would.
> 
> Fix is to promote the right hand side of the conditional to unsigned long.

Agreed.

> It is also not useful to allow for 64-bit lenght on 32-bit platforms so
> I have changed this type to a natural unsigned long. Like this it changes
> size naturally depending on the architecture.

I do not agree. Although uncommon, it is possible that e.g. a SCSI initiator
sends a transfer of more than 4 GB to a target system and that that transfer
must not be split. Since this code is used by the SCSI target, I think that's
an example of an application where it is useful to allow allocations of more
than 4 GB at once on a 32-bit system.

> 2.
> 
> elem_len should not be explicitly sized u32 but unsigned int, to match
> the underlying struct scatterlist nents type. Same for the nent_p output
> parameter type.

Are you sure it is useful to support allocations with an order that exceeds
(31 - PAGE_SHIFT)? Since memory gets fragmented easily in the Linux kernel I
think that it's unlikely that such allocations will succeed.

> I renamed this to chunk_len and consolidated its use throughout the
> function.

Please undo this change such that the diff remains as short as possible.

> -void sgl_free_n_order(struct scatterlist *sgl, int nents, int order)
> +void sgl_free_n_order(struct scatterlist *sgl, unsigned int nents,
> +		      unsigned int order)
>  {
>  	struct scatterlist *sg;
>  	struct page *page;
> -	int i;
> +	unsigned int i;
>  
>  	for_each_sg(sgl, sg, nents, i) {
>  		if (!sg)
> @@ -583,9 +587,9 @@ EXPORT_SYMBOL(sgl_free_n_order);
>   * @sgl: Scatterlist with one or more elements
>   * @order: Second argument for __free_pages()
>   */
> -void sgl_free_order(struct scatterlist *sgl, int order)
> +void sgl_free_order(struct scatterlist *sgl, unsigned int order)
>  {
> -	sgl_free_n_order(sgl, INT_MAX, order);
> +	sgl_free_n_order(sgl, UINT_MAX, order);
>  }
>  EXPORT_SYMBOL(sgl_free_order);

Do you have an application that calls these functions to allocate more than
INT_MAX * PAGE_SIZE bytes at once? If not, please leave these changes out.

Thanks,

Bart.
