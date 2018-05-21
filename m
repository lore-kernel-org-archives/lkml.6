Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeEUVnb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:43:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6734 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754652AbeEUVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:43:19 -0400
X-IronPort-AV: E=Sophos;i="5.49,427,1520870400";
   d="scan'208";a="78491387"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jeff Moyer <jmoyer@redhat.com>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "bcrl@kvack.org" <bcrl@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "jack@suse.cz" <jack@suse.cz>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "rgoldwyn@suse.com" <rgoldwyn@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v5 4/5] fs: blkdev set bio prio from kiocb prio
Thread-Topic: [PATCH v5 4/5] fs: blkdev set bio prio from kiocb prio
Thread-Index: AQHT8R0hCA0/1Rzwb0GHeBK7YXNPC6Q6rF6pgAAK1gA=
Date: Mon, 21 May 2018 21:43:16 +0000
Message-ID: <d4f44ce3-3f4b-e8d9-4b8a-7f846dfd6d10@wdc.com>
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
 <20180521160147.2372-5-adam.manzanares@wdc.com>
 <x49r2m4u3e6.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49r2m4u3e6.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0170;7:FP3CxOAEouI9mTy3dRJEK2fIcjLLhECeCiMRvh2+Ttjmm9celYGzODKvVL615KZJGTSSqnylOdJgATppmerqFK9/8Y4PmF/9FhmhlQsn11BSUSXae7rMLnHa0T20jdRmxseIY/HnKQTCiOfmsP86cxs/efylkZ9VnNN23ICIC4eZBnDOuc849Fo++zPU3JEBXMmmbbd8iLnTPg5zKh00pjDdZ+ogqnIbM5RUs61Qi3jhlUUFw8OCTn7hF3VN000m;20:OKLv76oNVvuvXsyNVgRnCOtok6LnXHR93OjPOAOWypZcY9jN4TXJbA+/OBWzu35gnQPHvBZjgGnJKrmjJqPq224odHZVi4pMt0jOazbxhx5RpfpVUuFCPa0Ej3gM/G11lL6h5W2bIenHI9nQUSwkgS/xv9km75UPX/s8J81mS1A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0170;
x-ms-traffictypediagnostic: DM5PR04MB0170:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB017065BC172A6D0505DFF019F0950@DM5PR04MB0170.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0170;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0170;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(199004)(189003)(229853002)(305945005)(81156014)(2900100001)(81166006)(6246003)(54906003)(5660300001)(105586002)(2906002)(66066001)(6512007)(316002)(6436002)(72206003)(8676002)(36756003)(26005)(53936002)(7416002)(6486002)(6916009)(76176011)(102836004)(8936002)(186003)(3846002)(106356001)(6116002)(3660700001)(6506007)(31686004)(53546011)(3280700002)(25786009)(7736002)(476003)(14454004)(478600001)(99286004)(5250100002)(4326008)(68736007)(31696002)(446003)(486006)(11346002)(86362001)(97736004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0170;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pFE/eDtIp9Kcy3Hw1BXDI3+jt3s+wX1HDCDjZC0yAcRlkfQeLxefOiErdkgv2yuYkANETdfvcVx5JMdBbkzVz+A+ppPigyeC7QU/Hyrd3uFlkWajwLo2HNv199rwEO1MsjBOE8zOUL6RFmtUJDhMjubW8uJ3xQ+NTrujhDg7FIPcuUaq/3rrXVSWQbay3nxs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE2EC24D79BCCD4797C45A4993BF3654@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cf8b9fd1-3be6-44ee-7eeb-08d5bf63dc48
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8b9fd1-3be6-44ee-7eeb-08d5bf63dc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 21:43:16.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LLhaMe007432



On 5/21/18 2:04 PM, Jeff Moyer wrote:
> adam.manzanares@wdc.com writes:
> 
>> From: Adam Manzanares <adam.manzanares@wdc.com>
>>
>> Now that kiocb has an ioprio field copy this over to the bio when it is
>> created from the kiocb.
>>
>> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
>> ---
>>   fs/block_dev.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 7ec920e27065..da1e94d2bb75 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -355,6 +355,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   		bio->bi_write_hint = iocb->ki_hint;
>>   		bio->bi_private = dio;
>>   		bio->bi_end_io = blkdev_bio_end_io;
>> +		bio->bi_ioprio = iocb->ki_ioprio;
>>   
>>   		ret = bio_iov_iter_get_pages(bio, iter);
>>   		if (unlikely(ret)) {
> 
> Forgot to mention, you should also convert __blkdev_direct_IO_simple.

NP.

> 
> -Jeff
> 
