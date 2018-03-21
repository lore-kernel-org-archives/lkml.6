Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeCUUty (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:49:54 -0400
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:38183
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753006AbeCUUtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:49:49 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Keith Busch <keith.busch@intel.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Sagi Grimberg" <sagi@grimberg.me>
Subject: Re: [PATCH 08/12] lightnvm: implement get log report chunk helpers
Thread-Topic: [PATCH 08/12] lightnvm: implement get log report chunk helpers
Thread-Index: AQHTsjo6pnTlBYHwUEGiV7wnL2ExmaPak/6AgABLfwCAAFF5AIAAFt5f
Date: Wed, 21 Mar 2018 20:49:45 +0000
Message-ID: <9478CAFD-0F68-4C18-A75A-6FD5551B554E@cnexlabs.com>
References: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
 <1520004080-27760-9-git-send-email-javier@cnexlabs.com>
 <8a0a3bad-26a4-ca2f-4bd8-5c71858f6d00@lightnvm.io>
 <20180321143617.GD12909@localhost.localdomain>,<67b77f5d-fa35-1199-10c5-12fb8a324a64@lightnvm.io>
In-Reply-To: <67b77f5d-fa35-1199-10c5-12fb8a324a64@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [80.163.36.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB2658;7:ZIOYkEb8NCpkiQvJoz/6BFn8CjJz36axZ2xoiY2lhZMU03HvwJUWLGQ9zfo582PiULCjj6G7A5Ani5zf9HouulI2oHJfgh1fUAf3ZQg4ssf83Mcn/fQxoExNoJlD0/z7pwLwKXhOGWRdIW4QqeN9/LpmxdKW2YPyxp9UAs8P048gN+wDsMoFBNIy4mGU7c/jBOHWsrrwWPqz/B2w9OVToP95ZdS2l7kp89EPLK1xfYdBlt6M2Adv6smeVuChnqYW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b6c07275-e1d9-4867-731b-08d58f6d4767
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR06MB2658;
x-ms-traffictypediagnostic: BN6PR06MB2658:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-microsoft-antispam-prvs: <BN6PR06MB265886D9603B7EC86F07BC87BAAA0@BN6PR06MB2658.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR06MB2658;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB2658;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(39380400002)(346002)(366004)(396003)(376002)(189003)(199004)(54906003)(33656002)(66066001)(6436002)(8936002)(6486002)(2906002)(6116002)(105586002)(81166006)(36756003)(2900100001)(81156014)(3846002)(25786009)(8676002)(4326008)(3280700002)(6246003)(6916009)(2950100002)(3660700001)(106356001)(6512007)(53936002)(229853002)(53546011)(6506007)(186003)(102836004)(77096007)(26005)(478600001)(14454004)(68736007)(76176011)(86362001)(83716003)(575784001)(97736004)(99286004)(7736002)(59450400001)(305945005)(93886005)(82746002)(5660300001)(316002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB2658;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ezcIRdo3Da7wzaITYsX9+JN2J5K8RnPuNfYaJSNrhVlYJFw5ozBw8CTBAzGL543TI+yRytJDJcfzo5h9wHXYESnpR1tdX7/a01QIziPAjn/lY5FLg/rWPeOvJ82JziodLfQkRrO9O5DvFqKO+DXlU1ayBE4ApU+Y2IGe30n8xc2M10VhJTALD/G/dbNw62OKRkABmUbho6OhfBGJbqnhnhn/kmkOPycVcg28HXqLBl0hnJLgmvaF5SL9xCschQiid99lWF9oBdx7ucHlLeU8qJC4pddlF6mnQN8uh2JFsmMfe/ancV9Kco6rs9yFD95tT3xomoo4VwMDCJqc2RWF7A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c07275-e1d9-4867-731b-08d58f6d4767
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 20:49:45.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2658
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LKo52P010851


> On 21 Mar 2018, at 20.27, Matias Bjørling <mb@lightnvm.io> wrote:
> 
>> On 03/21/2018 03:36 PM, Keith Busch wrote:
>> On Wed, Mar 21, 2018 at 03:06:05AM -0700, Matias Bjørling wrote:
>>>> outside of nvme core so that we can use it form lightnvm.
>>>> 
>>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>>> ---
>>>>   drivers/lightnvm/core.c      | 11 +++++++
>>>>   drivers/nvme/host/core.c     |  6 ++--
>>>>   drivers/nvme/host/lightnvm.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
>>>>   drivers/nvme/host/nvme.h     |  3 ++
>>>>   include/linux/lightnvm.h     | 24 ++++++++++++++
>>>>   5 files changed, 115 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 2e9e9f973a75..af642ce6ba69 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -2127,9 +2127,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>>>       return ret;
>>>>   }
>>>>   -static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>>> -                u8 log_page, void *log,
>>>> -                size_t size, size_t offset)
>>>> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>>> +             u8 log_page, void *log,
>>>> +             size_t size, size_t offset)
>>>>   {
>>>>       struct nvme_command c = { };
>>>>       unsigned long dwlen = size / 4 - 1;
>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>> index 08f0f6b5bc06..ffd64a83c8c3 100644
>>>> --- a/drivers/nvme/host/lightnvm.c
>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>> @@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
>>>>       nvme_nvm_admin_set_bb_tbl    = 0xf1,
>>>>   };
>>>>   
>>> 
>>> <snip>
>>> 
>>>>   diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>>> index 1ca08f4993ba..505f797f8c6c 100644
>>>> --- a/drivers/nvme/host/nvme.h
>>>> +++ b/drivers/nvme/host/nvme.h
>>>> @@ -396,6 +396,9 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>>>>   int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
>>>>   int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
>>>>   +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>>> +             u8 log_page, void *log, size_t size, size_t offset);
>>>> +
>>>>   extern const struct attribute_group nvme_ns_id_attr_group;
>>>>   extern const struct block_device_operations nvme_ns_head_ops;
>>>>   
>>> 
>>> 
>>> Keith, Christoph, Sagi, Is it okay that these two changes that exposes
>>> the nvme_get_log_ext fn are carried through Jens' tree after the nvme
>>> tree for 4.17 has been pulled?
>> That's okay with me. Alteratively, if you want to split the generic nvme
>> part out, I can apply that immediately and the API will be in the first
>> nvme-4.17 pull request.
> 
> Will do. I've sent the patch in another mail. Thanks! :)

It’s fine with me.

Matias: do you take that part of the patch out directly on our tree?

Javier. 
