Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEBSHT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:07:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25343 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBSHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:07:16 -0400
X-IronPort-AV: E=Sophos;i="5.49,354,1520870400";
   d="scan'208";a="77303237"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fs: Add aio priority support for block_dev
Thread-Topic: [PATCH 2/2] fs: Add aio priority support for block_dev
Thread-Index: AQHT4KRlU5+pa7q22kqU4Hw5WBiSR6QctgwAgAAJdAA=
Date: Wed, 2 May 2018 18:07:13 +0000
Message-ID: <8fda5d5f-1f95-0f44-e194-cdf266dc1336@wdc.com>
References: <20180430165740.2842-1-adam.manzanares@wdc.com>
 <20180430165740.2842-3-adam.manzanares@wdc.com>
 <20180502173322.GB27997@infradead.org>
In-Reply-To: <20180502173322.GB27997@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0378;7:xAGl5XWV/Ofe08gLY8XRJ2Lo6ozd2H2TCFK3aMzSuTguSXATw5YWxYi5MnRSi2/g8ZTCRFdQ4MWQv/f/UgFD+zVRsSf6UyugihK47gXBMrGfrc938eiBPrU4bI/Z94JGePhZHNJw4vQKxrva9jeKs1Q2FdDYq/uC1Km/j9xKUXtGd/N+qterhCmqZKtnSXDC5fkPBDPxF7VI0qX4e9VjD5sso48WaX9gKCvhT+Yar3BUGD1Pl1qR2Przznl2Wz2G;20:t+mJYY5qgR2AYmtjm8UllUrz+rExOnFCrtVZC7qYGCMACPHrjMVc5AJdjHwBr9uU2QEpIZRoYT3RNUl9k1zH7MHQ9VKIValgsXz+eQ/i2MyhZxM85dIrbvJ/grIHWhHMeNiZgRsBc3BdG30KjfyrqpCdp75CgWlr34s/12yBUuA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0378;
x-ms-traffictypediagnostic: DM5PR04MB0378:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB037813605FC47FEA9E49C9DAF0800@DM5PR04MB0378.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR04MB0378;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0378;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(376002)(346002)(366004)(57704003)(189003)(199004)(4326008)(6512007)(7736002)(31696002)(68736007)(5660300001)(5250100002)(3660700001)(3280700002)(2906002)(6246003)(86362001)(305945005)(76176011)(66066001)(97736004)(186003)(53936002)(81156014)(31686004)(2900100001)(486006)(11346002)(106356001)(81166006)(2616005)(36756003)(26005)(25786009)(14454004)(54906003)(105586002)(6116002)(3846002)(478600001)(6486002)(99286004)(8676002)(6436002)(229853002)(72206003)(316002)(59450400001)(6916009)(102836004)(6506007)(476003)(53546011)(8936002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0378;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Ai0dXOQuD6FG1J1S5P1PARtGASavnqcGpsr6RPEuE11Yf0+MFGFyyWQ100BAWVWi18o42xhr2nhurMb2AHZ0NGJV2/ISgpYd5fwuIYow8fJiM5ccyzXkaSIinKiFCAn21zE6hKgzwCKJDTitpf8zowHWgX3KfwWtzuQOozckE/dRs4j3HEO8VQqlshyPDK4H
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D73D308431EE3541B14BF0F313AA6697@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 03cda267-cf78-461d-2e47-08d5b0578800
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cda267-cf78-461d-2e47-08d5b0578800
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 18:07:13.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0378
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w42I7Ppl019802



On 5/2/18 10:33 AM, Christoph Hellwig wrote:
>> --- a/fs/aio.c
>> +++ b/fs/aio.c
>> @@ -1603,6 +1603,15 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>>   		goto out_put_req;
>>   	}
>>   
>> +	if (req->common.ki_flags & IOCB_IOPRIO)
>> +		/*
>> +		 * The IOCB_IOPRIO flag is set when the user supplied iocb
>> +		 * aio_rw_flag field has the RWF_IOPRIO flag set. If so,
>> +		 * aio_reqprio is interpreted as a I/O scheduling class and
>> +		 * priority.
>> +		 */
>> +		req->common.ki_ioprio = iocb->aio_reqprio;
> 
> Do we need any validation of the field here?

With this patch the only consumer of the ki_ioprio field is a block 
device, which will eventually hit blk_init_request_from_bio where a
validation of the ioprio is hit.

I was hoping to get a simple patch in for the block device case and then
go back and look at other consumers of the kiocb and add ioprio support.
At that point it may be worth it to pull a check into this code.

> 
> The only other thing I am a bit worried about is bloating struct kiocb
> with a field for a relatively uncommon feature, but I can't really
> see any much better way to pass it.
> 

I'll look more closely at reusing existing fields for the next patch 
submission. I am hoping that the feature will be used more often given 
that WRR for NVME should be coming soon.

Thanks,
Adam
