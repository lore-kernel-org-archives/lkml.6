Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeDHK3F (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 06:29:05 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:37760
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751727AbeDHK3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 06:29:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
From: Peter Rosin <peda@axentia.se>
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <20180408073435.i5nq2ngx2fslaz6a@katana>
 <336870c2-b6fb-3933-708f-67036bd6668a@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <fe039693-385a-9379-1257-22b79fbc13ea@axentia.se>
Date: Sun, 8 Apr 2018 12:28:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <336870c2-b6fb-3933-708f-67036bd6668a@axentia.se>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:4:3e::32) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96e2a941-edb1-4495-3bf2-08d59d3b8a04
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:ydI2LBG5y2MwafWKVZWk23to4EoS9+lKPagAUyepEVk0Y8hEG+tTiOiOwD9kURF65eaRevqSoTBOMa4GMifQdAZaM0+L+9gKYStPrdERY8Pzg9fKKgPAFdWBAg9BikjFchHokGsHhxZa44ratNlBafoqAlZ59nf7C2hW/9DEFqD9wSYJDTT6FMsZjqhefkkTFydUrgkduZJmJO4M0l8YJ3ZQE+uqksL+jjF8ArU/zVoIHvJa3ydhLx1657bYKhKn;25:KJihPhZWwj9MGYmG3v7h24hYIJRGNP1++21EkzX95oPwlKUvDZTaqwZYuIP2UPEV4W185yV7QkoQurzyMaBI+yMacN6m1vu+twUCTlBzTi6L2wX0u96+nToyEnIMHQ4j/oymcjruqIa9KQzwkIpRbx8eua0TXGw1JkQHfAt8B2I+wqEdOPmBLPtiinXO+c2cl1J23s5pbKGW+s9t/8q+1xM2NVwdN52srhFHxZuQacbgfq14ZwigFHhBuDYlCRNQA/e3Aqpbpe3vKaJ6gmXYkFqKYaqvnjeSVUz0sMzMHSwXdg7zdM3l+CQlbDEcc2E11UjfDpGML8T1c6gI/R7hww==;31:bUt3ExvhXogEm5FC0QHsM9EV2jJF3mEpoKV7owmvRj7GLEI0Rd86C9c7r1ou11WUA13d+cYt/dSYVECsg9ha1+ddY6V7/4+uP9lGXWvXhUy+m/Xn7WCAWG7ri2NJaw4V36AXSSu+eLq3HTk5Tq9HOgZCXYUsrj47nl0ahKfGrh7iE0tnr87kWf/JgPuq1YrkLqNj7RHYdtLq6gfaI7eDlWz16gEpGuFPS6dhZ1+HsJo=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778897D9062DD104B1D1C96BCB80@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:7e6F7c4dHw0yiPey/l60bRrpCezbPe9GGRc4wjsKcc6YpgzLja4tEDRInZM5TRLzsqjmksZkLeLnYBIYb/rQuZSvkKIbFltx+UthbJXmC2M+XvQT0htQke+IiyNoMaH8z05LowJe3vQrMt214FLVInz17zf8dnS4/KHFzAnc/pl86NIIjZphDBNhsp73Y0UBex+cFO0LXJdAbyTkOP72k2suOY6dhguN6djuSJYxD0tV4yzcFCL9AGwHBq1itvGxw9KQ8yrjSFudoxkY4Ich4w==
X-Forefront-PRVS: 0636271852
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(346002)(39380400002)(366004)(376002)(199004)(189003)(377424004)(36916002)(76176011)(53546011)(386003)(74482002)(52116002)(23746002)(7736002)(8676002)(81156014)(81166006)(15760500003)(486006)(53936002)(6246003)(68736007)(8936002)(305945005)(5660300001)(15650500001)(65826007)(59450400001)(230700001)(36756003)(186003)(47776003)(97736004)(50466002)(66066001)(65956001)(65806001)(4326008)(26005)(106356001)(77096007)(58126008)(316002)(16526019)(16576012)(478600001)(110136005)(229853002)(105586002)(64126003)(2906002)(3846002)(6116002)(446003)(2616005)(25786009)(86362001)(3260700006)(11346002)(476003)(6486002)(117156002)(31686004)(6666003)(31696002)(956004)(217873001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR0202MB2778;23:XM+kMcRuWGiwY4POZmltCrOMWcajqzbugzr?=
 =?Windows-1252?Q?OwjcJV8ASuRogXzyWqV9luei5pJ98s04VI0RBWL/UZrCiGBB4gMmpkLV?=
 =?Windows-1252?Q?rIc8YLxO32iATgm598nr3hE00VacGEcxG5ks1lfrpngIKvl1YuvFFsDg?=
 =?Windows-1252?Q?FOn6PWGOTWBQDLLUCudeKAXpFI5hx0EsQWFKkyt0RxLhgNNSsL2Xu4Cr?=
 =?Windows-1252?Q?9gnSUFGhWPNGlLz6cmb6kMIsCAUJDHYhpJ+Yo1gEFKP5dGFgTczddWjk?=
 =?Windows-1252?Q?XWGwqm+S0EDDOhlHjzuVCdJEQ2Qgha3Vx4Ek4qCOmXukbAARvbMdEnMu?=
 =?Windows-1252?Q?7JMxwSQSDMemXfbxzCrGW3y6nGZT1ILJJPxvqiAEcCTFtmGXPc6eTRVY?=
 =?Windows-1252?Q?B2NWx4ghiPPhqWOlnUN5d33OmWp9oASNPC06Pf667Idvv9gytAOTy9b3?=
 =?Windows-1252?Q?xsxF37PjqCRq+f6RUK64w8Ti8oxNr83vaMn5bqp4E7N3s9o4djS4pIxT?=
 =?Windows-1252?Q?NAJDcj8h1S5qWHdTYFQV1gGIsDonHpCHrJbtjh02xKtM4ryOlRyZIN/3?=
 =?Windows-1252?Q?Hi0K94p2LBCMsGpIM4BryyFWuEmaSKracOSvXIKAqfp1Hibitbaar/Ds?=
 =?Windows-1252?Q?+yYtHxXIS4Mdf4plIBZe9EozqSeajwwD1zwTvNrv9s/V1+LiP7yr/kn/?=
 =?Windows-1252?Q?4k1+n3IfZPECf6Vr4cVacAnG+7gv2YA+9TGhvrVLcNUu4SdASF0IEfoD?=
 =?Windows-1252?Q?FX3FTKbD6JF6fiEhLrJB8IqydbVwKWA9q9FdR/kgekHwrXSrbdAfX/Qi?=
 =?Windows-1252?Q?2ZqeKSEtYkIiP5MMQKbaJG+RUUmRcRxHhjGBE6X4IhBAFQIr4y7k6XKc?=
 =?Windows-1252?Q?BtveoPuW35mV/LMFk91tF8ZEAv1g+ohrLccBNihYHHA749xXM/MmmL9k?=
 =?Windows-1252?Q?s8GjNct3IAZgFpCM0fLzIhiadOf08ixdRHw0gRecog9GnJ1Zk29MmiKi?=
 =?Windows-1252?Q?xYnra/pkW5ua4GMApfyH9uc4PT43E63OBF+tA3/NF01iTmYHH6TKlRn+?=
 =?Windows-1252?Q?Km1hYzfK7lAZjbH6RbpOh8qy8Z9s1YCkByMQB5NwSsfvX8caPoyZ0D1g?=
 =?Windows-1252?Q?+E61qvYv3ELELDnDYLr3N+LzNqq3gz+OHODc7Eid6SgsPBp14vx5v/sf?=
 =?Windows-1252?Q?8dnQJHcL5aOPgWJ/rNhKMpay2LTSdqAE7zQThptBGvBsa+1PUSgKvkI2?=
 =?Windows-1252?Q?mVKe8qbOzsPgOF03hpQc8teVmWrtF0gUYdQmTN7uN809CIZvHqqFaSe7?=
 =?Windows-1252?Q?ID8EEtlHjtgdArCmpTghYxpUyKntUz0YQGReVPbKXNuqjEWdtY2Pv1nx?=
 =?Windows-1252?Q?EmM/YpF1sqCsIOT2ZDN+sXXcvJhojGdO5hwDiJv9whGRGv7SHCRNty7u?=
 =?Windows-1252?Q?2A7xoR5W0JVIwjfjB9GaMewBaqFLA7AeX4LLBy7w6SLzhqBpZm0+VQSF?=
 =?Windows-1252?Q?p5skLF2/5Vk0LireetjfoyMiWD3T2qxt765Uv6FlRGVF2hWFthUeISeL?=
 =?Windows-1252?Q?+a6ywQLlyXfOE1VM4LmB7tnrQnZ+w3VGTOPYYGmajddYlVCjAmRnFSRu?=
 =?Windows-1252?Q?8UWSixYWhJPBfy/y6L51s1YdjbJ/lR0r98fnL0pXiICR2IdY8b8el9Mu?=
 =?Windows-1252?Q?rqbsn/dFDbj51pitXodP/ijznylEgR6k6/gdLId2D39ji1inFGJSo04M?=
 =?Windows-1252?Q?xQ49v4WHXvAKWrQep7Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: GSNXl+6tp017zqpcGMflPBjGmS4StbihQmk+w4qIL4a+HD+6ahU2wiO52yrO1XDtgjcJwdpM+Aa+nvN0D6upgJpfKQ0wYAcT9l5ssVIFgUND1ETCYGnCYD8ma7jhFYXmfA6WdLIAnM5F7roELALSbH0c9n96eqSuMOvTABqpqQd30f6udAC7s9Kh4dEG6Heh
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:UyOpsVk7xN469ypXPnrcGwGs+/eyXLiUb1tvupoA6guSiwLUo2EPyqxq5Riwg170szBhokxf7B5xo2Utz43DSQEV0eWkN5BYmlvEgJyDATZPVrSMdLrCwZhLrl0imfGsCnqyzpPrXQacTsaWX7WlBvitMjl+dcE4FflbMbfUiBHIOkKDg7b7YA6C8qg20cJKqy/jX2bcZqF4WREpV1K0ikEp+O2zsutJQtMIgt9k7kgKGgJJSTFLrIepD8R5G6mbcVy043Mz5hyiRCOfRgh1hTPmuPaY04PuRkttKJpkggZ23ke2F208ggXwa0E8TQR+qxbcq7SzWthSvYpTiNqnyT/9ACbDYKS/q0RaaAEDrQAtbD3qJOOJ9UHKd3tL0K/bvIp+ZguhShS0alfMf+TZTxZ8Oba/xqaQOrv5eOtzrAczyBuENHQEZe2MwsfFlJQfjvfxl0hHYlB475B7cTYc2Q==;5:U1S9X4WZ+w5oEhOvZFljO7eiQ+C8z9bC56dqmzCQ/+8rHPngchN9hPwHBbp/VMjBgn/7ZF952KYt0Evxd0s62UK+aeGta/21qrCOTv+s6WoMzrjOgz3DKvmz9cIQ6LTFl3mHC4AcplDvpQu8Jf4S6o5NVFBkJB6EBxvVi/0hC54=;24:dM/K2Nj2BqUXKVYfJudF4K43AssxCl6qHMFQ78AAo/k5daEOvdmzWmdGmkh8iLVt83m/ENkvX+RXbQZxFFZxRvXa8VG/5GhaLX6wQ0YIOQ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:+xVs/4ybTU3B73AGNfi9IAEhBwUL9YsPVR7G1giX8R9cPzYQS6lTiurXplHT+LA+OmbCVUv01clxbtDT56AgYeZPX5EYo0BaWcvYQTbv4CBA944DgGYQu+kZrHMpcZgxqJxEoSgdZyfpvQmOCu4SuajR+8hq46Z84yy2qMfRBHwRJyHcc1fifftPnRmvh0f4MDAR6+R/vLpt27nV0DVf5jtbaRprwSF1XG+dnrysBSrlQ8DlJDJiPhuQZe+K4rBd
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2018 10:28:58.1332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e2a941-edb1-4495-3bf2-08d59d3b8a04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying to self...

On 2018-04-08 11:08, Peter Rosin wrote:
> On 2018-04-08 09:34, Wolfram Sang wrote:
>> Hi,
>>
>> On Mon, Mar 19, 2018 at 09:10:58AM -0700, Guenter Roeck wrote:
>>> Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
>>> I2C device id") added a function to return the standard I2C device ID.
>>> Use that function to verify the device ID of a given device.
>>
>> I am very open to these patches, just...
>>
>>>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> RFC:
>>> - Compile tested only
>>
>> ... I would really like to have them tested. After that happened, Peter
>> and I can figure out who should apply them for seamless upstreaming.
>>
>>> - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
>>>   against all parts from a given manufacturer ?
>>
>> Can't we just add it when we need it?

Is it really reasonable to verify just the manufacturer? I don't see the
use case? I mean, we can never know if the verified manufacturer will
release unexpected chips further down the line.

>>> +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
>>> +			real_id.manufacturer_id, real_id.part_id,
>>> +			real_id.die_revision);
>>> +		return -ENODEV;
>>
>> I wonder about the ERR loglevel. ENODEV is not an error, I'd think?
> 
> Well, in this case someone has said that I2C addr <xyz> is a <uvw> device,
> but when verifying the actual device at that addr, that's not what is
> found. Hence, I think an error is appropriate? On the other hand, a driver
> that can handle different kinds of devices might not want the error. But
> for that case, maybe the driver should be using i2c_get_device_id() and
> figure out the details by itself?

Maybe it should just be -EINVAL, and that's your real objection?

Cheers,
Peter
