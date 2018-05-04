Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeEDH1V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:27:21 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com ([104.47.2.116]:54170
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751189AbeEDH1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:27:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525300581-27217-1-git-send-email-wang6495@umn.edu>
 <4390a69e-a297-313d-044d-abf846eff1d1@axentia.se>
 <CAAa=b7e5_E_7zSaAfTm8kSA_2MkyYXv-xS=ZH1AY9-u_s+Y+CA@mail.gmail.com>
 <82973b7b-b6ef-6d42-df5c-be3ea72212fa@axentia.se>
 <CAAa=b7dgSUitBM+swrcb95Uk=Zdt0Li_dwcuskzux6m7QvKFxA@mail.gmail.com>
 <f36dda27-b7c2-6650-7638-22e80371fde9@axentia.se>
 <CAAa=b7e+MHgvVa0H9KP+KtyVNSCC9D+Vk6zLinCjYHsWqBzXGg@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8100306b-1aab-718e-258c-f69e6ab51446@axentia.se>
Date: Fri, 4 May 2018 09:27:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAa=b7e+MHgvVa0H9KP+KtyVNSCC9D+Vk6zLinCjYHsWqBzXGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0047.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::36) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:AbxQ2VHofYIp8ExC8abZjQ6iqcBBUWnVy5UM5y9Id7FYRDzcXQuJ/0KIEhGO1EgwiTHZF3iQj10MknGG8qd9lwJGLYYWt+Yfdz3cLGpw57I5e2bfsAVsdFQEcpuvE1VuSJ7dGu93Ac3hF/yIb2pXyRvQGHtSu4+jFp2bdPccNU6QFyRJqyaITNLlsYMd6Kr91Ks6QBFxgF9NRhIimukQDdhAvffdYmRuOqj1YhWTMxFH5Rpe05dMXJ9t57j3wRQR;25:Z2PZ1EVCYaaDkGK3wPPyIqE7p0PZc5NRVGM1jEFbyTFPGLn98fFWl+gOhLqm55uSY0Yc26WQL/mu+M4xy/kl7XHDhKOuRQpHvUEhKOvBSCkATq+gnLgprDtLG+LJecDgqbUl65u3QFomjBWME4tZgG8sgZgMmg3JHIf7XriHP97TJ+hvquksP8Mc6LjtM3bqNvwgwqaSmt2gP6Ez3FSfkbGSimTMjL0Vf7GX3i+OoVmhMjStFtStfePg2Gkj9VmK3fZvh7v+EouK5IVXAMFr4kZ/Zh1LmssouTXfqSGQQxu3fU8M0hm/4SUGAPscnoD/+8K2R3Ijsud0UK253b2sEA==;31:/gn4GYx5iFu89MGIMLzI7JkxtOkEQUm2Vi7Nv1yJOVJA22zlsfdUsP4aleIHMS6loL05nHehBNd3NtEurTTneKmHGorxRo/9ZOC2udDnDdJkvfY48Vag4UJ3BKLONqilJ7E43HBxaarOvpX/GMUkYTsQdSyffKXhX16fOn3Iv+sjAyq6lcEcGHDIyTAhBD0xX67RMIZDB2rnYBW0cn7iXpbHliokGeNniPari+JPX7M=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277819CF9A23B71F6408EFB2BC860@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(788757137089)(8104003914727);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:RxRDT+Ps2Oz7HoWD+hddXVI8wcqD+pMtz6exSDw78RLw1ZMsbrZrwFdgEfx9nk4VuMPCh/U01wLn8oMeeVDiVcHAjfdztCUXJ4M7tfC3eMAV+9yXryOYf/f1RX2QGDa79DxcRJ80z6WobZK0IRZPezU4bKOQiwmXbIp6F18YMt2WjEuzESsVLTYPdCcqsJVTeM3tfL1wAd653U2p0Qx/bykZNP9M4QuFMrLfVSLtaTQAeEq7hi8VR7aN6JSBtTBr7SGpmuFqbE5TJqFClWR4ChIdpwD9/Xx64i3Qjv1+7yURX524qzaXWXK2XCqmadIMxOzzZuAr8Rn/lwbEmqijgZmYDrcnscKyDuKWaGiqLWmdyHfqiknmdUnhBFiYHO+I
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(376002)(39830400003)(396003)(346002)(199004)(189003)(377424004)(3846002)(2486003)(11346002)(36916002)(65826007)(476003)(4326008)(47776003)(106356001)(105586002)(93886005)(956004)(2616005)(446003)(65956001)(5660300001)(23676004)(76176011)(66066001)(65806001)(31686004)(54906003)(36756003)(316002)(97736004)(16576012)(52116002)(64126003)(58126008)(486006)(52146003)(26005)(230700001)(6666003)(6486002)(53936002)(6916009)(53546011)(6246003)(6116002)(2171002)(68736007)(229853002)(86362001)(74482002)(7736002)(50466002)(59450400001)(386003)(478600001)(2906002)(81156014)(77096007)(305945005)(3260700006)(25786009)(186003)(117156002)(81166006)(8676002)(31696002)(16526019)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6ZTNQVmFPZEd1VllzcHVwY0hMWjdpQ0lB?=
 =?utf-8?B?cytTcm82YitzTFJsbm92VHpqSDlZZzdNbmQyVzA3QUsxSHBKeDFoV0dzNnZC?=
 =?utf-8?B?SjZmd2JDUkxFQ2dqb0hpTVNlMU15aHZmQk5JSnZ4Ylo0VVRRZVZYNUdpWndq?=
 =?utf-8?B?UjZZRXNFSHlTditGaHdpY0FrenVFYUpMdzQ3UHcrNjJUeDhhd3lFaGJMOXRD?=
 =?utf-8?B?b0pmTkdkc0ErTVRmSk1OMWVYZDlOWkNTOWdBTTN4QldLRU1rVDNudkY0NTR0?=
 =?utf-8?B?RDhkVVdQQ2lyRUFWazIreVVLSWJ1KzZWT3o4aXF3UzloZ1NtUWxSMi95bDVs?=
 =?utf-8?B?b0djakxZSnFKdFdLempkUVd3ckFCS1BZcEFrWHZFQkZwS29hYlVGNkx5MkdX?=
 =?utf-8?B?QStPMDZkazJEWFZiL1JBcURtUHU3ZWxtV3dvWHh4M3hMN2VlenBMSWhYNlRD?=
 =?utf-8?B?VjN4QjA5ekxSNk5GeEdXeTR1Y0hmRlRUYVpEdFpweis2c3pZS3lKL2RUOHlp?=
 =?utf-8?B?emEyZzcvbTFYcEFsUkNiSzJFR202a0lBWnN1YURtTUlDWEd2YUhaS1VzckJO?=
 =?utf-8?B?b0Y0RTZ0Q0dyS0ZPcldBSjFZS2hicktsRCthUG1YbDBTR2lpVEtFSy9SYnJI?=
 =?utf-8?B?cjhoMGFnNDQ0dDJ5cTY5SDVjdG9HbnJTUkY2bWtYQjdDZzl2M1hYSE1sOHJ0?=
 =?utf-8?B?Y3A3dDBJSWNzb0VHdyt2akhGbkdlUTNEWmdMNERpVUR6aEtwWTMvYWtKODR5?=
 =?utf-8?B?MDZYTmFPUWpUTHdBU3VuWm1hcjFuNjMwU2paWjNEZ1FTYmFCSXBPQVpXWFFh?=
 =?utf-8?B?S1JYdWJGblc4VDNVMDVrUnYzcjVSZHZ2VzBkdURLVDZQT1B1VnlTcVlMdkMz?=
 =?utf-8?B?alRKcmk5aHk5NmRZRlpIS1NSSmNTQlMxc2RnMk9wQWNxeXRobVBGakxNL29C?=
 =?utf-8?B?aUhZMEZtdWZkRk52OGxVM2R3a2E3S0RsaXlxOWN1TUphditOdDNWQVZtaHlT?=
 =?utf-8?B?ZGM5WTJsNy9yUnl0MlFjbWFPOW9ONDRsY0p5dVBjUUw4QmdWeDBjbjBXaUQw?=
 =?utf-8?B?OG0vRjB1ZnFYTHhOMGdtb3BkczRWVjcxNkxXaE0rUXEwRjhmRTZKSzUrTng3?=
 =?utf-8?B?Tmp1WUFSMXdNWFdoL3lZVERob1pBSTBUY244M2FPcC9FNFhIcFdzcjRhTHpq?=
 =?utf-8?B?eHdjK3Vpa1pUY2pEOWdDUmsyUzRMVW4rbWdZclUyeEFCSDBzb3haV2Z0Q20y?=
 =?utf-8?B?SG0vMzVEQ0tvclF3QURFVk8rMHpVNGtVSVE3djRuTkl2UnYrcVA5bXNyQjZw?=
 =?utf-8?B?MmR3SHJZWFRHWmVqaGRKL2tFZUJRNzl2STVLRU42WTBRdFc0Vm1IK0Y1QzhK?=
 =?utf-8?B?VVFndHgxMnlrV2FHWXRTTWFKNWhoeWtrdFZjL252Z2FIelV3WTBpeXhYRXlz?=
 =?utf-8?B?WDhDcWZGVzNMLzRpd256Q0hUVlpKZkd3N0dWWnZlMDcwd3dRUGpCaWZtVlVj?=
 =?utf-8?B?elNsdVZITE5CLzUrZGhxcUc5WjJuY1ZRTVdHMnVZRFNOYTdoVzAvb0t5VnA5?=
 =?utf-8?B?SHlxMU5ndktxTmFweGlsczB2UUhVTUlhLzlOamxMNXJrUFY2L21RTEFZbmxY?=
 =?utf-8?B?aVBGRzV6eVBRY2tteHJnNTRUcWJEV25uZHluc2VHbjNVUXlnb2l6ZWZjYytZ?=
 =?utf-8?B?VEZWMktuVXA2VjlBUXVyTXVKUDZac0twd3lrVENUa0tNdkk3SUVldThjblZV?=
 =?utf-8?B?NEMwVTM1NWdVRm9ZejJZUEg3dUQ1WGQwTG5kYSszMGFyNVJOUi9McDJHTCta?=
 =?utf-8?B?Z3c4OVJTYzVCVGFtb09nekxENld1MUwzOXVRK0NkbXFpa3hCb0JTLytQQ25m?=
 =?utf-8?B?a1VVVVJGOUlnQ29VNEpta1lSZFVBT2Z1MGRZSGhoMkkzeVNINXpvTHJXczdn?=
 =?utf-8?B?cG5IblFuNmZSdStkMnRUK3pObWJmSjBNZFhveWRmSTdtYStGKy93Q2JZenZs?=
 =?utf-8?B?RGFxOGs5eTFVVlJYUVlBQnpzTmtxdmxiZDNFQnM4M25QRGxkVDhPM2VIQ2Fu?=
 =?utf-8?B?cWIwWnlSU3AwRko5SmVTK1J4MkhjeWFVb1lRZDEza1pmSkNJQUo5UnhCelox?=
 =?utf-8?B?cW5JdytiNHVYeUoyb2IycTdhdFpwQ1A0a1VhcUdJU0RXZHFGVUM5YXFHVEhz?=
 =?utf-8?Q?cgjaFQG7FmHoQEYI3BuO6xXoLIyjI2AXtCofud3n4f0s=3D?=
X-Microsoft-Antispam-Message-Info: ANRnRQ0zI/bJUCdynfFfZyjccmIKTc+noZqXVR3SrZkdmgfEtgAgc95lV4D/bAcyK0wcDysDgqgxgTCmTqH+wWEJrW3830zs2fAZsyXuCmBL4V0B7Ya7gNf/Hkrbt7Fq7Qs8NxFCfD+IWDLXrj57ltfnkMyJPgxll78ugVCmdLq0U/s4jIdxOsiTO4Hips0u
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:rdxdND/NfYDshn+FuyHbaSMEdgCbeUieRQtGwNnLCTzJyYkS97IETWyiW2dMXe3Fi8+uCl2vRW3FDDt3dqWB6OwdBHiilaeeqAPHwSoxjkep1V2o9rnqEjYqUKZzJhgCyXbJ0BolQZfuIJFvht5Fcc/khHCwKztwUA180j/HBzUC34ANIKynmQ9WwiObbw2+ooN9BO7/xMlv2IlP+gm7IM8uZprguMGZAcy0tDaod5cTqRpPGpOz9qGGyYl3DO654Z+nv9KtD10TeiKaAn6b3ZTuJJUoVxIT5QnySgVJSOHn9Lac5WHlPQ0MoksLxU5hCX15PH5GyD8WnO/y82JG1Gx82gG18XdgLOFPBnHZvZUUWomL9hOqGIlYaeOq7BWoIkwMmQEbe+ColG4PUClcKO9/DJDZER7cBB1Y5M9DDnLAY4yFPgaAM+KPdItlzOh9h35MiNQQ5EIG23scW80Rww==;5:YokHEjyXooXTDPyYnhEsJ8RaKyk/eecF7HJKjqpNyHuT1GRILuJ9t1gAe0ocDAe76QGyNaDkBeLnBf37CcGM3jmbZbFPTfasSSLi+G0eLN40sL60VhBIcK9MGgxDN8ULLnIRjTvbbfEUQU9Bik3Tjn1Qgg9IQTGq5123dMM1lmY=;24:LSs+LqIOEA4C1DltJt7T7eTHEIJiAmVpX6MFv92OCWLXXvvARcZlzih6uMPU1a1MhkbMmnNo+mE+0v+n0sJ2UU5xaD/ZQ4Afyx/Su58Go7Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:l/yLobttV10jRFcaBXTnnDH6wbavk2txkNOlDIDuyE30wHYt6nvxKaaeLjxHAzgtwH+ZugualPf0mbG1VtcGF2RBEM4a8S/3TZ6trODzK4zA+SAw/vVJY5o+1skZEPEEWqvegSD9D58L1vcG+GNapEIr408vIzczAd0LVj48F5qQE6BxwPkCnLQNIxFSf0T5RZzQ0Rz3ZzDoYCxKoubv2I6cc+Y1f8oZCfyRw2ABJMiX+5J5TWMMbjkMtK6B2TRh
X-MS-Office365-Filtering-Correlation-Id: d6872392-210c-49fa-e349-08d5b1907605
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 07:27:15.4422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6872392-210c-49fa-e349-08d5b1907605
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 09:17, Wenwen Wang wrote:
> On Fri, May 4, 2018 at 1:49 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-05-04 07:28, Wenwen Wang wrote:
>>> On Fri, May 4, 2018 at 12:04 AM, Peter Rosin <peda@axentia.se> wrote:
>>>> On 2018-05-04 06:08, Wenwen Wang wrote:
>>>>> On Thu, May 3, 2018 at 3:34 PM, Peter Rosin <peda@axentia.se> wrote:
>>>>>> On 2018-05-03 00:36, Wenwen Wang wrote:
>>>>>>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>>>>>>> which are used to save a series of messages, as mentioned in the comment.
>>>>>>> According to the value of the variable "size", msgbuf0 is initialized to
>>>>>>> various values. In contrast, msgbuf1 is left uninitialized until the
>>>>>>> function i2c_transfer() is invoked. However, mgsbuf1 is not always
>>>>>>> initialized on all possible execution paths (implementation) of
>>>>>>> i2c_transfer(). Thus, it is possible that mgsbuf1 may still not be
>>>>>>
>>>>>> double negation here
>>>>>>
>>>>>>> uninitialized even after the invocation of the function i2c_transfer(). In
>>>>>>> the following execution, the uninitialized msgbuf1 will be used, such as
>>>>>>> for security checks. Since uninitialized values can be random and
>>>>>>> arbitrary, this will cause undefined behaviors or even check bypass. For
>>>>>>> example, it is expected that if the value of "size" is
>>>>>>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>>>>>>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>>>>>>> value read from msgbuf1 is assigned to data->block[0], which can
>>>>>>> potentially lead to invalid block write size, as demonstrated in the error
>>>>>>> message.
>>>>>>>
>>>>>>> This patch simply initializes the buffer msgbuf1 with 0 to avoid undefined
>>>>>>> behaviors or security issues.
>>>>>>>
>>>>>>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>>>>>>> ---
>>>>>>>  drivers/i2c/i2c-core-smbus.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
>>>>>>> index b5aec33..0fcca75 100644
>>>>>>> --- a/drivers/i2c/i2c-core-smbus.c
>>>>>>> +++ b/drivers/i2c/i2c-core-smbus.c
>>>>>>> @@ -324,7 +324,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>>>>>>>        * somewhat simpler.
>>>>>>>        */
>>>>>>>       unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>>>>>>> -     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>>>>>>> +     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2] = {0};
>>>>>>
>>>>>> I think this will result in the whole of msgbuf1 being filled with zeroes.
>>>>>> It might be cheaper to do this with code proper rather than with an
>>>>>> initializer?
>>>>>
>>>>> Thanks for your comment, Peter!  How about using a memset() only when
>>>>> i2c_smbus_xfer_emulated() emulates reading commands, since msgbuf1 is
>>>>> used only in that case?
>>>>
>>>> I was thinking that an assignment of
>>>>
>>>>         msgbuf1[0] = 0;
>>>>
>>>> would be enough in the I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_BLOCK_PROC_CALL
>>>> cases before the i2c_transfer call. However, this will only kick in if
>>>> the call to kzalloc fails (and it most likely will not) in the call to the
>>>> i2c_smbus_try_get_dmabuf helper. So, this thing that you are trying to fix
>>>> seems like a non-issue to me.
>>>>
>>>> However, while looking I think the bigger problem with that function is that
>>>> it considers all non-negative return values from i2c_transfer as good<tm>.
>>>> IMHO, it should barf on any return values <> num. Or at the very least
>>>> describe why a partial result is considered OK...
>>>>
>>>> Cheers,
>>>> Peter
>>>>
>>>>>>
>>>>>> Cheers,
>>>>>> Peter
>>>>>>
>>>>>>>       int num = read_write == I2C_SMBUS_READ ? 2 : 1;
>>>>>>>       int i;
>>>>>>>       u8 partial_pec = 0;
>>>>>>>
>>>>>>
>>>>
>>>
>>> Yes, it is a big issue if the return value from i2c_transfer() is not
>>> equal to num. I can add a check like this:
>>>
>>> if (status != num)
>>>   return -EINVAL;
>>>
>>
>> Right, but make sure to add it *after* the existing "if (status < 0)"
>> check as we want to preserve any existing error. Also, -EIO is perhaps
>> more appropriate than -EINVAL which seems wrong for what is probably
>> a runtime incident.
>>
> 
> Sure, I will place it after the existing check and replace -EINVAL with -EIO.
> 
>>> Also, I wonder why msgbuf1 is necessary if it is replaced by kzalloc
>>> in i2c_smbus_try_get_dmabuf()?
>>
>> It is not always replaced. The stack buffer is probably retained as
>> the default mode of operation (and fallback) because kzalloc is
>> expensive and because kzalloc might fail?
>>
> 
> That means the stack buffer is probably used if kzalloc is failed.
> Actually, the kzalloc failure would be possible if a user-space
> process maliciously causes the kernel to consume a large chunk of
> memory. In that case, the user can potentially exploit this
> problematic code. So it may be better to initialize the stack buffer.

Yes, but I see little reason to initialize more than the first byte.

You hinted in the commit message that there were execution paths (or
implementations) where the second buffer wasn't initialized. Can you
give an example where this matters when the more extensive check on
the i2c_transfer return value is in place? That seems like a bugs
that should *also* be fixed in the affected i2c bus drivers...

Cheers,
Peter
