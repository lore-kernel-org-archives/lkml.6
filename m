Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935609AbeEJNgg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:36:36 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:37056
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934693AbeEJNgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:36:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
To: Wolfram Sang <wsa@the-dreams.de>, Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
 <20180510111658.sxf3mvye5q6ihxa7@ninjato>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8f728c2d-b463-507e-2c36-fad22fd99dff@axentia.se>
Date: Thu, 10 May 2018 15:36:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510111658.sxf3mvye5q6ihxa7@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0301CA0008.eurprd03.prod.outlook.com
 (2603:10a6:3:76::18) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:EuhyVt1Z5j4DL0iq+aShiPThsZOAVQZlFRKKHDlRoSGar3+TYSBMc8UaG2Nuo5QuR/1fNmpIJ+oJVkWPVVjldvTjNNnGVc7p56Ig8n29eEaf/oLOBWaJv5amXDqNGScY5+SEeoAn0fuZftATd7NDbEBfNrfn+F6L4z0HzGXSfkKCE116jmzOCntARNvMJApVOvq2jdBD0K6xYCBA+FpHinLB2r90A6P1LLyWZ3XE+Zly0dej4PuH94OPcGks7Tat;25:xSPstEBFr5QJLPOVHqLAlikSIK6Nx7YwymqPGtkdj80Q47VW7hGRu3ifRC7wJIMfmUOmt0HC6eP+YgPWoMzKZzz0jy2ibkAWPMTvbktOcW+N59pN7A2qOGdqCGba9hthai7GZtD7H6W7hfdJSLyM79plkaLPLIeYd49Lla57l5mzs+aLKx/8GhW0hcOoREfQ8Fn8wm2j/Cm7ckE83YnbrCXYwjiO4gL3/FLz6q4ScFq6tTmvSMDTgcQGOHz5hVcR7+ywgTd6gEXdY0HOnFCkL2SOFO/lOTsaX8BCIUFYhvL1NjX9J0j/Rv6ap04YFbYYz8Xy/EOYbHlxV+88u0hDyA==;31:G8ChVFGPUx39EXyLcbZuN7t1l987D3NMd+p0Bro+BCRq6sSNwt6By7TTkfKThWwjaDiwXdzP6Jz74mQAsjkyeznKghuzBMzxZoDdEERbnVTcQCPJzoQfGxXwq6GIs1ac/1BPYzv8dJee3Lf8IQ1IuOIwgN8JMnQykKFQ6cgdA5yAQH2agfdL9xrZB276SKf3mtZ6i/CcK12Z8hPiUk5ZntHz1mYeVGwae3/6WYxS27g=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27843C834A0378C9CD55C2B0BC980@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(8104003914727);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:Fmru3evM1SvCLPYZN9WSYNGvz8BXOMY1kIGOs1qzVWdDsNcJIFuVI6gMP+cX+LOLMRn0KrlHJBU2j0NYjC7m5bHjctEaV2ECV6wd4xfZ9S4aIeAH7292siutafzLSdWHfZjROkL62DGVDyCHepNKLIj+hJNGOekRA2BB6wnwDQ/fv4iZjLDsdfzGCNBwqUKJNkG5b1dSMiQdwysfAjKqpVRrSJqlK3wc+czJn5VDISy+5HcB0iMsRZ4a365j5ZPluvklWnrj/vLXywpyxDSHeHQEZeFvmOcrWMNktMiehbKJf1a/LWG1iBOU+kNUVbSH
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39380400002)(39830400003)(396003)(366004)(377424004)(189003)(199004)(476003)(97736004)(486006)(6666003)(64126003)(117156002)(6246003)(229853002)(105586002)(31686004)(81156014)(50466002)(8676002)(8936002)(305945005)(53936002)(2616005)(25786009)(81166006)(3260700006)(478600001)(86362001)(966005)(3846002)(6306002)(31696002)(6116002)(7736002)(11346002)(2906002)(446003)(956004)(68736007)(230700001)(47776003)(5660300001)(23746002)(74482002)(36756003)(2171002)(106356001)(6486002)(16576012)(53546011)(4326008)(386003)(26005)(66066001)(77096007)(65956001)(52116002)(65806001)(316002)(59450400001)(16526019)(54906003)(58126008)(65826007)(186003)(36916002)(110136005)(76176011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR0202MB2784;23:ZS/nDoAbUywpjhYAKec9lyo5TZ+37XNN1Fh?=
 =?Windows-1252?Q?UKqt6xnsC1rCJO9lR10KR81Elh1z61j/DQMVHNQ4vCMMKtysF5tnSOyQ?=
 =?Windows-1252?Q?t8Jf5Wj7Qtzjro3I6H89Zn2h9BqXJFwxbldxlelhlj+womxtd3oqzKNE?=
 =?Windows-1252?Q?+wB28COa3g9zrZ+l/ml1YJZgvNnWMlujpgyMdC+M85jv+9lZNqsosLEt?=
 =?Windows-1252?Q?fnBCWP0u/Von54wqC6qRyhj7ShDLW4u8IQG38lajHXGq78a4ZUC8f8yZ?=
 =?Windows-1252?Q?eVU5tUP3bWOhLrzb+QUpU7GbBKXeV3rgK3BFBSRj8oJSoYxOw38s87TY?=
 =?Windows-1252?Q?LzlbzfWl/ySFa4YufgXc5E9VxwGbM+dgKguk3NDWVib+1v7UItNdjnGx?=
 =?Windows-1252?Q?EPZnTMBxPdeFUKd4IRSiuhJCva5M0RFMKX3KCddpnn5sGi2CcORYHOkT?=
 =?Windows-1252?Q?82PlIINJvezedp8EfHBmTQ/rFwiHLxyBlmWkTuVhp34ef1602523VT+a?=
 =?Windows-1252?Q?VGPOvVv58mHST5GAsxdhfVTn8Lz77uiEPeaY5if8zcoFp0dW8TLYKslv?=
 =?Windows-1252?Q?iHsnXJbux9CMyUJP+DEjfR/LdUgdsFWFiwmRgS0bAqwRS75JP9u5U10o?=
 =?Windows-1252?Q?W8d/DdHyYxWfBPkikcbwRt/MurmcS0tdWfiX/IRH+Ht8ype6u0Z8BatL?=
 =?Windows-1252?Q?i6TF8qRgnckNl52sEfWRTHbVVJ66OIusXP7qbA0YUTZZjoKT6wXL+Bwn?=
 =?Windows-1252?Q?7v+3TektjOQB6GrvtPTLo7S5vmocfdwZrXKZfbqlw8eNva4GXIJniE17?=
 =?Windows-1252?Q?D18+YHse//rDMm3QZK3VhLf+OFGcdYtePIKeXXQBNDGRT+MgeDY9bR9G?=
 =?Windows-1252?Q?3MaQwSQOl99azjJbRY/2KRPkj1tpd5GdJogNA21OZuE7AeScm6ctirD5?=
 =?Windows-1252?Q?YVaRtCQfNTraX8Lwx5z31yQHop+yPMEwYwLSBs/fxoMaaaOwA7pxuLQw?=
 =?Windows-1252?Q?OZIPdhHPZt2GZVQkoTTzrOCbCrwyLieQkfhCZ4OGaJpDtMeQygh4KVeE?=
 =?Windows-1252?Q?Xk6QjuRoyjw/xcFzrEnJr2ytwnwZRp5YADY6iXg/iLfBsqMMPOVMNIMO?=
 =?Windows-1252?Q?OLTI61BPNymRvctRjfdPn6n5E5WyRMLnUOd9bVhIDdU829sLWsH8/B61?=
 =?Windows-1252?Q?Mc2cX6FLoBaehtYQEwSDKf2nCkOosIlo5Zua3i8BoOXpn74gr0wOF90i?=
 =?Windows-1252?Q?2RRLlhD6Xkw+kr6M6nm/tySSWcav9LWcGhuPE1hA6BXyubd4cRzj9pPF?=
 =?Windows-1252?Q?b30GgsbYfgTxOoEIzBlysozKBXSfjvLe5VbWuZS4+2s6WBiDzGPJv352?=
 =?Windows-1252?Q?kff6YInlqqRGCb3uN6TiQbGIwP+vpAj3MGaFjZzq5eUI4u3keIlkeh4l?=
 =?Windows-1252?Q?a/oM8Ev6SdwYPSj8uCDnjYjud0TNXQ6YOwTq48NtSHyo8ejUpkvasZaf?=
 =?Windows-1252?Q?d8IWS/e/1l1Fx/QyFfWBXCZEmKPncffpyQNc03IYEf1Wy2wuB2RXKSkz?=
 =?Windows-1252?Q?42tvsKRdvJgnmoUpVJCc15V7+vDjX5ia6N85C6COsJtrVxyUdj4LVPEC?=
 =?Windows-1252?Q?lT+4rJQ477mi94KFLSyUtIwsIFnbI1/81nPfOFhqXLpS+nSqgQb/ZOGe?=
 =?Windows-1252?Q?ogXkuk4gjlnXaaAMYIZ5BkCyiksL04mBkGtqoVZLvrePoMVT84i+cohd?=
 =?Windows-1252?Q?geQB3wLVnnKCxlaUfsw=3D=3D?=
X-Microsoft-Antispam-Message-Info: gDpnw7x9obRT588jFO4qDQJoFVMLPt+PeA1VxWkaVQhREq4NfpuYg+tkY+LLAylqkaWvwc+uT1coRF7AmP//IytbyCKglQr/w9nCk8/0HVc12Rp3zvTs2iqjbVA0NZ1K2YR4mVtPB6L42zPRu87/upZ2pPXWqWBi/9Qo2i+ESrJ/TPNYnggFUqvik+aCjF89
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:QmiYaxnS0kaJtm60JEcwYdRr1iwJYVj3bal9AewUAGP4uadPpU8It8L4aeJLzQKlpVUUrsGQRJUARby28yGKoJCVxdETd8RKpCEm06FwZRWgc24OgdUTzqEPtDlMylG6weiZ7yCiPc9pKUDsiW6Me5S2zEJ1heh+LY6OpWhAoKbFZsUvZyN5EtrsjC0yrwd5S09n4/PMya8+VJn/P3MKHCJ7Gnf8EgVPK9i0DxAmlrO1aEmu28NDPM8X3X2ZKgbEuTKjltrRec86USdLoAIP3Ly2RXTzEdk1FhlF5eQATJeJ1nJGpj8I6iKfShIj88zD00MqSRO6KDaNyyuMp9NwO4yg3uGKulGpVZxYLsAP04jWmIYo8VIG1ukX6i5PGgGn6TUQ4vEtnSQDmlRpALNiYvg3Jx9Ub91TRD/IM6ZtOFu3LJSFlGatPFDR0HVRcOLR+v8XjZOlzkUOcqwiudBMAQ==;5:3FW8/GAGE+DWoGO0carBun5GgMuz708MjX0cmpDHKlYOoOAgAZZB06zRntsa6Fp99HCS7F4fhw3zdLD85yQd8qlSqieQYupwNaDBzuqMmj+GxB/jrZH5bpRe9cU0Kt33ofTOhGe3cJ9/Zmu3CaF1A6gAh8EIDhLYR6HScIBi4eY=;24:RQ2GbJMFcdybPMQ5ZvDYCnsMaiRPb9cNKyjg268atVQjGJu8qXjK3A7o2ByrQtvPPX1RmUZCtMcDziAc6ZWLHS1FSmQ05xRvVjaRpPEu6Ss=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:LVRkE45etbhYvl1UuiP6G5UcvwTf1q3qmsxEZGaky9FOODwCtQ0KsDGWZIU+hlgycab/vxS3dAI9E6Tz8eCch96Kz6o43IzeKYqRH4Rky19BB03Y8d0o88/rsTXrhlpcuFDfVPUXNt8F7ENxgRIvUBbynD9+9kNmYHim4jQIQ4Y4sflUcIXRYS74fFRC4kh+xvFbw+264cJCTWSJn2gbcKjg1jO9kQcYJjM8OUlrdjedoM3T7S0DeQkROI9gOVQ2
X-MS-Office365-Filtering-Correlation-Id: b82b6b8b-f22c-49f7-42f2-08d5b67b08dc
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 13:36:27.7428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82b6b8b-f22c-49f7-42f2-08d5b67b08dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-10 13:16, Wolfram Sang wrote:
> On Sat, May 05, 2018 at 08:02:21AM -0500, Wenwen Wang wrote:
>> In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
>> transfer i2c messages. The number of actual transferred messages is
>> returned and saved to 'status'. If 'status' is negative, that means an
>> error occurred during the transfer process. In that case, the value of
>> 'status' is an error code to indicate the reason of the transfer failure.
>> In most cases, i2c_transfer() can transfer 'num' messages with no error.
>> And so 'status' == 'num'. However, due to unexpected errors, it is probable
>> that only partial messages are transferred by i2c_transfer(). As a result,
>> 'status' != 'num'. This special case is not checked after the invocation of
>> i2c_transfer() and can potentially lead to unexpected issues in the
>> following execution since it is expected that 'status' == 'num'.
>>
>> This patch checks the return value of i2c_transfer() and returns an error
>> code -EIO if the number of actual transferred messages 'status' is not
>> equal to 'num'.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> 
> Applied to for-current, thanks!
> 

I meant to comment here but got side-tracked and never got around to it.
But see e.g. [1] and [2] for drivers that will not be happy with this
change. Maybe there are more of those? I did a scan of the drivers in
algos/ and busses/, but there are drivers all over the tree that
implements .master_xfer that I have not audited. Who knows what further
problems this patch will reveal? So, maybe we should be a bit
conservative and only WARN as a first step?

Yes, I know that I suggested this, sorry for not following up with this
in a more timely fashion...

Cheers,
Peter

[1] https://lkml.org/lkml/2018/5/9/871
[2] https://lkml.org/lkml/2018/5/9/877

PS. Also busses/i2c-rcar.c seems like it might return a short "success"
for some sequence of events. But I'm not sure about that one...
