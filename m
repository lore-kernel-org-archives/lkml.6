Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeB1JvV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:51:21 -0500
Received: from mail-he1eur01on0088.outbound.protection.outlook.com ([104.47.0.88]:55184
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752043AbeB1JvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:51:17 -0500
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>
CC: Chuck Lever <chuck.lever@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
 <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
 <0f90134c-3d40-1d24-711f-e4ab32802bd8@mellanox.com>
 <c1bcd5cc-381d-2d94-1278-f9fb5c9c0b14@grimberg.me>
 <20180227220958.GA21714@ziepe.ca>
 <193aaf91-c9d1-38b1-a89f-45f129ca5798@mellanox.com>
 <d2875648-20d9-43b9-abf1-8ecbf049c4bf@wdc.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1e7c373f-21bd-4d45-3dd6-68467bf09d0d@mellanox.com>
Date: Wed, 28 Feb 2018 11:50:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d2875648-20d9-43b9-abf1-8ecbf049c4bf@wdc.com>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(396003)(376002)(2980300002)(438002)(51444003)(189003)(199004)(186003)(4326008)(3846002)(2906002)(6116002)(2950100002)(2870700001)(47776003)(93886005)(316002)(16576012)(58126008)(36756003)(65956001)(50466002)(65806001)(64126003)(65826007)(8676002)(31686004)(26005)(6246003)(8936002)(81166006)(81156014)(77096007)(106466001)(478600001)(229853002)(31696002)(7736002)(54906003)(5660300001)(53546011)(305945005)(86362001)(76176011)(106002)(16526019)(356003)(336011)(59450400001)(67846002)(110136005)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3262;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT028;1:+KIuzh4PwasciLZnCaYCQe4vDlb1hejIs1ai8TrFdhfFM4kizfQjaVletd0cCn+BgSizYe/jk/Rxvte9TXqDisKvF+wjZKJxs046fGDzvFr1cQcdyxeVOu8ga/pKqbUY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 085bc17c-6c47-42c4-8c9d-08d57e90ce16
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:VI1PR05MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;3:yPr1ODR+nkPB0pKvACupoLj/lKyNGb4JysTMdN1xtyNnnYZxChcfz4GtHnimhZ+mUJlAGuDZvRFHGJ/WKSrKnR64C5NNy98fknSsszCVjY2Q3uA+yYzIBPn+pgNcq85WSfNwc0TxDElijwGc1sRJJyWWlVBe44nF7r/Ev7TzgQJ4BKNNYnySJhbph5Vf5tl8s/Jm8dzXwbbLBVLvfRfMgxNlvfC+PKwQrnJM3kmOpmT4/SSZ9vFKYPZQj2NbqHDmLQIq6lFmnzm1wUdXtV5gzqr659kXn1Yun2peyXRiAXVvMc3sqfJUNXvuW001OVR4csyTQ4h9xhfPT5t8tO0JNZvvQK/5RSqwCIoh6fxJ2CM=;25:UaZ/USwJZ4k26UTq+JqOyBnxcOPGEKftQsfnv8DR5uCPejV4RQYdtEXl03gBlb/0tH4AQ+pSIYVqP24TFvp0tXIgZic4N1nv4dTPPSiYatJUkN95CnBrkIU0hTmKXDF9nANMIWdF1BDt9C0YT8QqtSMdpjttp8WavA94eWm9rxi8awMhOOiKP0oljaaPSESTKHk2Qkl4cwvdtkcc/UshcPEX117SynRtYkjlSw2bik8whdYtTvEcALxliN4p/QxlI0MyoabAvBRiNMDP5hW5bea9b+g21UycoDPaY/aIShuef8Ib+qZhhcH7WeTjUS610LzbtIzmzOQ6ntCcQukfeA==
X-MS-TrafficTypeDiagnostic: VI1PR05MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;31:QQoEJbtwPSW9Zpz6XHVxIog81iRJd1nEHCsqSjCFvU36S1dZp5kWk22q2KxM9uXRgW23XCW73PIdp9zkXlTd70IZjeaQ6fNfASKwqvOSkISKOlmwOHedPevYXqYaekXHJXmFToWTP4veoJAhV2OE17VzzKKH8etrgBbxCA/xbEkPA0ELss4/kNlrHBz/BWxLTTjK5bPRZ5TFZLCsPhn7+jvc+flB7KTh8uFxF1Ldgyc=;20:SdPHa0g1zXLhB0R1XqzLwEDKU+fNHS5hJu61JA4TZdfoqZPVTZF7KhhJNcrRcuFTGoF/mioATmlxEc2oCMye0y+WsJjgzZ4GYV8NA9JfBU1hU7iY7hKn5nauyuYGy2Hi8HjVTpA4OqsNzyU7wkJzCohTMUE4RfdB/ObNnaeTJreo7T9lr2GVHG+m/86I64OhJU2Q62C8oMteLlWoRE9gPf+D1CGA5TwAp9/lGCQsMqeXYJJUV626W0WK9GJVE77tetxarRw/Z9rimvMuXSderYSmf2pEN3K+H/C0xBG/Q+FiroKmvKz2x0S7JQLfUNb9dBTI2yFyY3PW5T1zkXpMVjOV4ron+qIvgmTlVk2Ny2fXEurAShPHVexB1FSlGEdsV03o+Brw06iiP2RmI0SCyM5JYJvWY3qZ/i76xWhxuWXa4QiqPE/NCiTWILZDgYrU9AQIJNPvPSrfAopcCEyrMuDZXqtpDIueMbXd+n26VoCx0hcNuGt2XUjd9xfCKKFr
X-Microsoft-Antispam-PRVS: <VI1PR05MB3262B953A1D4E1BD9EE2E948B6C70@VI1PR05MB3262.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501217)(10201501046)(93006095)(93004095)(3002001)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR05MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;4:CNMwbd0LssJHbT6alXI71qrFpPa/YDjNNvwrP9KgPp5jB38pm8Bh8Ht7MQg2sBNfc+hqdSzLS44u7Ep9XYOfO7u4BjfloYqY4KVFhdxYg/hIrsZFpYOwx+MQIz9yPV3I40lbO5UWhdYD/vyp34KhS4IGtJnFAqj+g8MaiB++BrUNuYm29wCFYrz+JGNyXNq4MkmVlPaIwAZsKrIoXQ9pFQZYgcZdRSu7zasyiF6A2qLHtEdb0EWMYVVKZouG2wFGyIkGcrVUSq0OOoaaSPR78w==
X-Forefront-PRVS: 0597911EE1
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;VI1PR05MB3262;23:nNxqUTf6haMwysUD7rSLxRbu4/van6bi0EwZ+?=
 =?windows-1255?Q?2vs3ns844SYRcwJnnH/Yzx74brEuUPgpwxb2Yd7hq8Xw6IZMzMGxpf8F?=
 =?windows-1255?Q?PR7+swLEt9TF+K9kLzwEXe/XAQ3i7/e3mqI34W8ELDHLZMOqniKBR04e?=
 =?windows-1255?Q?tu+ZQMoVgl5O85K5LuB0Qge/i0OuP5qBNMA5lT3AFST+6QkEb5cTIiSz?=
 =?windows-1255?Q?uK9DZGkFhAEjjEhStkgMLPU3XQiMNgGVZSO7JpCOz5YZ13vdqi3JWL5o?=
 =?windows-1255?Q?7N2VF1GGHIf2nuPaU5HTrJ9CmWtwB1Df528fNZSwgkZwyr1/GDrBhgVJ?=
 =?windows-1255?Q?iYxp6kwT7pJtDLv1QBgVajR17EiUxRr9I0Fu3d7FhNPOPDVSdbZjom3M?=
 =?windows-1255?Q?/+IP/GZPacDv1YOInW+XrTBVPXRZ/BFbflFJg/mWw47R5UCOs9HRTBiT?=
 =?windows-1255?Q?vrl5ht8wkwubBKQK6eL6lqVd8p+1ZfYu8QnYBn447LWzc/qEAFvT3CqV?=
 =?windows-1255?Q?rpMvmlHU9VfLI98A8j+9ShzA6vrdcbH3JA5X+rAOZyQkSOkXjX7Rq/mJ?=
 =?windows-1255?Q?1Oo9wuB6xpgfVSU3G79HYFY96WnBtQehRscgXX/f4wSRvWu96jmwlxR+?=
 =?windows-1255?Q?S1XAhqbRPutw8UsPa82lQEXjU/VGzj91d1Z4AlHLb6cX0O+wH6QQtVYc?=
 =?windows-1255?Q?8i7DwmaiLL8OfkmWyyTivvef7dzxx8z4lvRoETkNv31nM1j2kBKf5fTt?=
 =?windows-1255?Q?h8gXUfqZLWito8HoDcV8bzJY+mm1M4pTBeICaA/VB8e+ESgqZibV9y7/?=
 =?windows-1255?Q?FjZtrKWJsuoyG6bBRtwTNNo4qGIY4FPmCEjW0Jod7kQWlPwQ0C4MX/48?=
 =?windows-1255?Q?9aKthTy84JNEwwzF2Wco9+Vdg8a7m5zuvcKXesKl35+BzEOBa0drPqnb?=
 =?windows-1255?Q?HasrSi4idFnh7J5qK6/gRd6bbXS0D+axAO9Yz559BAdZu9L0dC3qFakt?=
 =?windows-1255?Q?RubOSIjXmo685R5BhGcuk5uLIam/ZyJzCMA37ZrcBpwSkdB6ShuE2bWd?=
 =?windows-1255?Q?eSz1Jd/qcbeP5r0ZJ95shmr7Orsn6Ieh7dtVzEYmAKtjJNAec0k7EQZW?=
 =?windows-1255?Q?9zeLlbemKKEaW/SKtIF8cJ+KbGOuMF1GEt3FBnc6O3AErjdVKLtLA9BP?=
 =?windows-1255?Q?WJlG0KVSVSmco3nTCJ3joLG1xHNWWvUfzEPkUCVa51KHqpwMp5jer5eW?=
 =?windows-1255?Q?D9G157I/aEKW92wE6sM71O2+Z5avv6M495IEtgf/ibvzWYy1hdLOydCO?=
 =?windows-1255?Q?TL4rFSwZ9E3yUGR6/RhNLhvkPn1B/jaAwCl4ONLbWNGq5q4AqAPdbJ8X?=
 =?windows-1255?Q?arR7SW98EvR?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;6:41l29g0HlcZ87w26gqAiqPUAakYwk4uZxYs5ooJzvBGPDfzVMTKRQWqlGXxD8FWgGnWsnQV5O17PoBw3wo7RMejfSxZZv21HVsF9HGNwJDyaPiyK099G4JvEezKP0fVMV67qlmic+vwS+aZ8x9NO6es/bmeijUKj0lIBt0+SGVTkYxc7zXGnhmX1JMsr7TCnuSg/mxxIN7Q6mQESkven6yt4eqTwjypwG/UnqGUmLz2j5W2oACIwuRY7BK7KVgrt5331959XqAdt++k9pvyoqe1tsPsx+hTCtgqCUOGLFyeSz/0+cLHEOyj2cVEUrDNuKoyFplr12r/TceXVOwI06+yKnJQDDAbnjrz45D4Z7vI=;5:dY0tMGVusw/iOMj9F0tNMN4/atOrE/Insmsd/z8MdUF0NZ8/h9DxTkz4wRwPjc/rC1q0cJmJIEvGGWRvN7t8ar4DOW036DIznj3NYFVfwbqL5TjKcHwV9g/xgWdteaiaegl6ElaF+Kefvwd111YvG/bzKZbf6b24gEtownc/V4w=;24:X9lQw/L/Qdruw5Cv+Mdy0tSUmFEqBEa0BCXsOdjM4NaQuo9Pw8yWx5MaJkIeDklKNIeMAuJi8Gio9bJNQaVC+lEJ8Apy7Fb8O5e1pjcXwjg=;7:z0A6bGdruT/32H7mPHrcS0N0aXK4WASZxKcNC9RK9GQ4zupF4Nrby7JLVrUT0VfdPt0G85GWMusfAxYlUIKv4yOh23COUqGaMWeohTNY4XMWUAXb0L6AljoFQTInztXqE1LP7ykqqXb/ZOs5/v1c+Jns3PecC94bdNHZu2oztHWiT/x029LKsjXnlWSWkVmDhPxchvKBXS4h6g8PsfVtCIYGc+nRffjB+/zVXcMPmwyq14Kh3RC+YUMnVCFYrQKs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 09:51:13.7486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085bc17c-6c47-42c4-8c9d-08d57e90ce16
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3262
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/2018 2:21 AM, Bart Van Assche wrote:
> On 02/27/18 14:15, Max Gurtovoy wrote:
>> -static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
>> *poll_wc)
>> +static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
>> *poll_wc,
>> +                          int batch)
>>   {
>> -       int i, n, completed = 0;
>> -       struct ib_wc *wcs = poll_wc ? : cq->wc;
>> +       int i, n, ib_poll_batch, completed = 0;
>> +       struct ib_wc *wcs;
>> +
>> +       if (poll_wc) {
>> +               wcs = poll_wc;
>> +               ib_poll_batch = batch;
>> +       } else {
>> +               wcs = cq->wc;
>> +               ib_poll_batch = IB_POLL_BATCH;
>> +       }
> 
> Since this code has to be touched I think that we can use this 
> opportunity to get rid of the "poll_wc ? : cq->wc" conditional and 
> instead use what the caller passes. That will require to update all 
> __ib_process_cq(..., ..., NULL) calls. I also propose to let the caller 
> pass ib_poll_batch instead of figuring it out in this function. 
> Otherwise the approach of this patch looks fine to me.

Thanks Bart.
I'll make these changes and submit.

> 
> Thanks,
> 
> Bart.

-Max.
