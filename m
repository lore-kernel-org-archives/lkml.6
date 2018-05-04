Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEDFEt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:04:49 -0400
Received: from mail-eopbgr00112.outbound.protection.outlook.com ([40.107.0.112]:4159
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750866AbeEDFEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:04:47 -0400
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <82973b7b-b6ef-6d42-df5c-be3ea72212fa@axentia.se>
Date: Fri, 4 May 2018 07:04:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAa=b7e5_E_7zSaAfTm8kSA_2MkyYXv-xS=ZH1AY9-u_s+Y+CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:2e::36)
 To DB6PR0202MB2775.eurprd02.prod.outlook.com (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:fkmNrEEKUJ0siZOoSpvT0rrVzeMp1gqOzd485TB1bn7DfydgSel1QDb36ePCIKNBSk6sl90Tv+Dgybz3CDEtDxxAWhSCkWD/7EE6MIySjxQk7+5ji8OBhthVUH3QhYFDeWmCOpb1+/y6CfKqmYgK+9uwG85/OCINVZag7UOOtifolU2NE4YkkW7liUNcIC6BZgykPNFD4W/n0usXmzzjAhPYKY1mkAAdAdEUL0nYcDdIc7xiE9cWLamqYz/OIuL8;25:Av19edpc6vwZ3h+pSirnT+q3X1YgMKJavKdDQ77HdKMDoDXNYq6uFzGXRg8/ulM/AgRUDVASFZKryWLxVGSEXYky7qs8SbLfmk9CESB8n+ko0IhBRZwaSMlQCtDXV0cy1gDjSrAFHeW6VM/XVvACMgday6lRJrmIPmxCGxAZ6CM/dBHT74Je02GkVdCi56HPKSktYlfgKF9UDy8JCu+XecPEWHr4xINelY1ZmWf0aGq+Le3SV6WQZiDP7gyGeyFMoHkhLPZ27Rov6Xfda8M7BdYX0IDgVYYsQaXo26fJvBW2re6PhpnH8Va+Wi2PTCVzWmidFJD1r890R04OfUSm+A==;31:km1Jmy4z9+ORFV6HAipDdV8tsHrdzIsStVRSM88Hdetj4bESfxB9T3Nmh/+QoixDCG/YCo7bpifnBnGNWmWI2FsNQedyYmryIX8/0XFw5tkso3qOZpf4eRPhQfBDe0BVaVt6MPiUgsVG+gdEJwq5m9KqbmzjGdhysu1Ny/tMYh+ZMWl+eh/hxnq1UFndtHAmjz5lXg4FAD5sO6763Mgya+LPm8zQ11+NA7TYcLJqq+c=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB277593C1F706784A5A11707ABC860@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(8104003914727);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:eFNR58z8sBCA1Z9VzYQaOCILu64Z3rJoA0mHcDId1K7Ynszo7P38m0SWAzPG/aXPx/A5TP4AcofzDgxWd1nX523A3+nz0/7ARRyEw9IEzuV93HIEnM0uXI2Wd0YD1ap3ROoudH6EPlK1EDVFenSE1Ay9aS4zz3zsDR7mwB2Wso3zwgEV5lWIV47NWv57fuDI/7Vg5iuGfoLpGO7aVRgKdcrmou3M9lzpN5ckyOesLcrfUEdVLivOXO/dmVTnQivEk9dmzDB+2NlDc/GegnC9cR0cVbhEPYFJ7js6FoEj93rp2h/7eF4DV/WYBBYz87ywqL/BAFBVS5arZ86pBpSg2jccEthXW7lCcaYvFr3CPGY=
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(39380400002)(366004)(39830400003)(396003)(377424004)(189003)(199004)(81156014)(68736007)(86362001)(52146003)(6916009)(31696002)(77096007)(26005)(50466002)(54906003)(478600001)(97736004)(47776003)(81166006)(25786009)(3260700006)(36916002)(486006)(5660300001)(476003)(11346002)(956004)(316002)(6666003)(58126008)(66066001)(2616005)(65956001)(59450400001)(23676004)(117156002)(65826007)(53546011)(52116002)(186003)(65806001)(16526019)(16576012)(386003)(446003)(105586002)(8936002)(3846002)(305945005)(230700001)(6116002)(8676002)(7736002)(2486003)(2906002)(76176011)(74482002)(36756003)(106356001)(6486002)(2171002)(6246003)(229853002)(64126003)(31686004)(53936002)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6WG52RDF2QjZMcnYvVFVwVWR3bkk2Znlt?=
 =?utf-8?B?VDJWN2M2RDNja3grazhRSmlFQlZNRVVsSGNUUmhFTXpMaklQY0ZZeDdiR0tC?=
 =?utf-8?B?UXlINUhRVzhLRG1xR2YzQzl3ZmVhV2dwMFlqUkJobjhUZ1JHd1BBVml1Y3Q2?=
 =?utf-8?B?NDBLQ2NacUc1a0wrbmg3cHFYODdGS0NFZllmTTkybjlaTjFOU2RTd25WY2h1?=
 =?utf-8?B?dUp1blRlV1VoVE5kdHc0clZYWktHMXU3aWpPZk8yQWJMVVJsTHk3aEJ5bUFU?=
 =?utf-8?B?ZXNoVnpjcDR2UkhDclJNOTF3eDJnV09IV2JwZ0JrL01Rc3ZnNEU3RUV1K2VL?=
 =?utf-8?B?cXF2ZTVKSHFCN2JmUzlST3ZmRmZOeDR3aGhyZk9Sa0Z1cUZZVTJ2eTZZa1Fy?=
 =?utf-8?B?NlFVQk9GTUx3YU9oOUZoYkhsakNjdEtGTi9FWVQ1NCtKR3MwU0prcm10cExQ?=
 =?utf-8?B?MlZucytqcWY2azJvTC9EaEM5UnpoTElYdVpXTExuL2cySTkxWVRsRVVUcjUz?=
 =?utf-8?B?eWZRU3RaNFh6dG1HS2Qzek1ZZENnT1FkNlRubjdCTlNOa2s1WVlJNTdYY3I0?=
 =?utf-8?B?ME8vaEZrVy9FaHJMQ2IwVFI5cWFLMDVabW1wU2R2ZmR5dWNlS3dGdm1kVklj?=
 =?utf-8?B?T1FpcDZzdktjSCs2akVLL2pUc2h2K2VCOWNiRlptTlhYSGR6dzdra2xZYXgy?=
 =?utf-8?B?NUtnaGgzZ3JuMVBMTkRjbnJuaUQvcU9DNzJCVGZGTWc5NWpXd05kaVZqQjdX?=
 =?utf-8?B?VzJwaENhWS9PQm1JREE3djZNMTN1N3phRkFxWVIva0gyK3lhWkZTbDMzbVZu?=
 =?utf-8?B?TFJjVWpwM0VueGd6bkk4a0x6QVRUNkJvT1Z5ZFFDS1hVQWFCOFJyUXZQRkFz?=
 =?utf-8?B?c3RzOG9aZHpabkk2aFpCUnI3K29SbWQ0UHhBL213dFdkZW5RcWw2NU5lSDNJ?=
 =?utf-8?B?TlNZaTRyRDZydk9FNGc3bEFNRXlKKzVyUXdZdGwrZFVSUW5rQVYxRW5PaXps?=
 =?utf-8?B?RlZDMXV3WklrMWdZTkVGeGdabVJxOVNwWnFtSUF4dTRYZzdwakhtM0VzTHFv?=
 =?utf-8?B?VVgwMkRoa1lLNkJoQnZvRmJjMWptb3B3ZW9tKy95b2RvYkNjNGdVUWVDYkpY?=
 =?utf-8?B?NS9GN25oT2NYVVc3K2ZGbjI2enFWYWNnV051VElEYTlKbzVPaDhvZXZDdUdP?=
 =?utf-8?B?Rm9HZ2gxK1dFSitlSWQ3cmdLRHIyQmt2NGh4RmhTTUJTeVBhYVNBRjVLWS80?=
 =?utf-8?B?L1NZTyt2N1pHaXVEbXNLUnJKS2tQam5EdmhXd1N3OUZLM0owRENsMVptTnll?=
 =?utf-8?B?T2VkcjZLUHZLN2NpTHVZb0JOQ2U4UFFqQ2N6VnVjdnptN2FnRUs5ZmFvQVhV?=
 =?utf-8?B?ellzaTAwU2pZUUw1TUNBLzhtNTdGNVpSMUwwYmIxZWk3cnV5d2xYNjFpSlpu?=
 =?utf-8?B?UlBtY3dWUFcwYUVSNmdMdjdiY2lCblJWNmZtYjlnd3ljVzc2aVBLMC9wbWQx?=
 =?utf-8?B?emxwY0ZCd21TbldZSHhLSEh4TC9rNThwZFpZSW5OVDZaeVFiZ25SbGZVSHYx?=
 =?utf-8?B?M2lOWFY3R0NQRWVzNnlUaFVVNHNMTEZaNVVuYm90alV3L1pHaUZhQUk3THll?=
 =?utf-8?B?Y0RlOXIyNWlxYlMrRFgyNVBHYzEyZ2pRd0t0dDlxNXNicjdaR1hyVUZXZDQ1?=
 =?utf-8?B?cXhiR204bW9YcXBGOUkwMDIyK1NsV2tkbWwwaFpUWkZGU3gzUlV5d2RhTWRQ?=
 =?utf-8?B?TTlYQzdkcTRHWTBJdmlQaENFeHk1c2I2SHBqN2xCRnpvSURqN1pYcmJaM21I?=
 =?utf-8?B?WkppeFBEaWpIbVlvM3lUY3B6eVJFQXhyR3MvR3JpTE5sZUF2ZW1FbjdwbWpY?=
 =?utf-8?B?cXI2bElUUUNzRFpuSDJuc0xjYTJIWmJXS2U3bngrWnp6UWgvQVpCbU1UVXJM?=
 =?utf-8?B?bDNsTVlOZEl0MGtQbzBCV0poSHJ5WFcraTZ4WFhVd28xa2NhdFlCZi9GeWVQ?=
 =?utf-8?B?QWU4SnhvRHR6YmN1S1REcmduUUhwVW5IWmJIYU1wajMvdXhUT0FrOG5ONXI5?=
 =?utf-8?B?NnNONXFzVW1CUzlxUitIR0tuSFRnRDdaTGdXOWFXZ1FTTWxtMzdsRS9EVmZK?=
 =?utf-8?B?M0JlaEgwekVlRWw0VEp0SWhFeVkrMGZDdEVpTHpvV1BvN09TSENlRzJVWUFB?=
 =?utf-8?B?N2kzMU9WZGlpWVNrc0ZxQit0d2J6alE9PQ==?=
X-Microsoft-Antispam-Message-Info: /CDc9ukBpsCiI1pOt7UdvHx2VsIUD0WBv8p8hc3+BTcKl0oAS1yAEB66jNWzSXkv9LlFj5YPdg5s/qhsjgBu5p86VGVTtkNc5C/CStOmm4bPHECelz9u//OFaEaABmu660BXYeI0sG+o6uPvaya0BNIxtEzoOzV2XjKtWn1kVPei0F3c+DZ5o3XYSIrdNAg2
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:Pe1jKTnt0hcakJY6GSZfxm2GRgLh+uIkP48H57LFDMjfcjEUrDIyVfzzSFABA08ab8r7YMgzQ1k57XWFJh949+C23w3pHTc2e34C+eaEcs9E6xOaJQwfKkBoPx6ebHsGQirtp3v+DgOWcTf7nJZZV2ge5rens1z8izYjHjjPm6P/TCWb6nwcixFfe+ogcfpS6ZKjtwgVIX2Qt2WxFxX5ezpKERd2eqn4k2OKQuw4fnWIxFewazlAzUXGOoyw844bJbtR85uR5BtNJIgfZh7KXetcXDyA+KPtzOp/GPqcerI+dba9UdyAx+f4OoFN9nXEQ9ZmCETYRANDmC6BY6/1Yo7pGT902GGxphiV66ZSGkftBl6FnwxYw7SNkvo2gZYtlAVwDaVV/SnRG6wBoPq57iU2vqN+GJkd1hBKEwsDZq/oPjIo9ugo1Tkw186wSk+1FdQHpC60i6XW5NLWhSPEUw==;5:cVfTNi1XkQN91T0nvmH7/axzQzixFXkIb8FJvtuqLHW/x7v+xBDWOeyi+b4R+dK8B2NnZl7dvR6idrq00sgWPGDGGZiDOE9/jQnRgyBOQzZ22pcJEcJfKHpE1MfoBlarHxZui6OzNxkqZ68IXTAFmuYB0N2H8dREYCWeGq50lmQ=;24:NXl87mqDF3ii43sKubCjOCJluVQ0b1FTv4HHKHZMrpY54ANh6RVOu6mStWjxydRW2YKLjrqpUEG53tNMery624SFKP3SFZSQEPPYYXLJR24=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:4MCQtHLc6Co0qzjNSwV77NMiB2mP1nzqycrDi+fffRU8V7+FCeEK3oxdhmnGTtgf/wHhm2p8SbenCW8CTqAaz5wPYhvkv7Ac7syckelGNuXV9Dd8bvDOFmw6lU4sCH8kJxYjlh+Jd//wKSn9/1UC9PXT+yWmr9bPm4zCD9G1oOUggqt9qXDxXGL3Mgju5sYZk+eq1/Vvub66yL1dwb5IG5zSidEfRtclGc9qBOP/QcX0R4pXgak4mEX18ZR+dXbe
X-MS-Office365-Filtering-Correlation-Id: 538953df-ec66-4c8c-ab51-08d5b17c8d11
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 05:04:44.0474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538953df-ec66-4c8c-ab51-08d5b17c8d11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 06:08, Wenwen Wang wrote:
> On Thu, May 3, 2018 at 3:34 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-05-03 00:36, Wenwen Wang wrote:
>>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>>> which are used to save a series of messages, as mentioned in the comment.
>>> According to the value of the variable "size", msgbuf0 is initialized to
>>> various values. In contrast, msgbuf1 is left uninitialized until the
>>> function i2c_transfer() is invoked. However, mgsbuf1 is not always
>>> initialized on all possible execution paths (implementation) of
>>> i2c_transfer(). Thus, it is possible that mgsbuf1 may still not be
>>
>> double negation here
>>
>>> uninitialized even after the invocation of the function i2c_transfer(). In
>>> the following execution, the uninitialized msgbuf1 will be used, such as
>>> for security checks. Since uninitialized values can be random and
>>> arbitrary, this will cause undefined behaviors or even check bypass. For
>>> example, it is expected that if the value of "size" is
>>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>>> value read from msgbuf1 is assigned to data->block[0], which can
>>> potentially lead to invalid block write size, as demonstrated in the error
>>> message.
>>>
>>> This patch simply initializes the buffer msgbuf1 with 0 to avoid undefined
>>> behaviors or security issues.
>>>
>>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>>> ---
>>>  drivers/i2c/i2c-core-smbus.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
>>> index b5aec33..0fcca75 100644
>>> --- a/drivers/i2c/i2c-core-smbus.c
>>> +++ b/drivers/i2c/i2c-core-smbus.c
>>> @@ -324,7 +324,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>>>        * somewhat simpler.
>>>        */
>>>       unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>>> -     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>>> +     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2] = {0};
>>
>> I think this will result in the whole of msgbuf1 being filled with zeroes.
>> It might be cheaper to do this with code proper rather than with an
>> initializer?
> 
> Thanks for your comment, Peter!  How about using a memset() only when
> i2c_smbus_xfer_emulated() emulates reading commands, since msgbuf1 is
> used only in that case?

I was thinking that an assignment of

	msgbuf1[0] = 0;

would be enough in the I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_BLOCK_PROC_CALL
cases before the i2c_transfer call. However, this will only kick in if
the call to kzalloc fails (and it most likely will not) in the call to the
i2c_smbus_try_get_dmabuf helper. So, this thing that you are trying to fix
seems like a non-issue to me.

However, while looking I think the bigger problem with that function is that
it considers all non-negative return values from i2c_transfer as good<tm>.
IMHO, it should barf on any return values <> num. Or at the very least
describe why a partial result is considered OK...

Cheers,
Peter

>>
>> Cheers,
>> Peter
>>
>>>       int num = read_write == I2C_SMBUS_READ ? 2 : 1;
>>>       int i;
>>>       u8 partial_pec = 0;
>>>
>>
