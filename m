Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeEDPiY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:38:24 -0400
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:25803
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751196AbeEDPiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:38:21 -0400
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
 <8100306b-1aab-718e-258c-f69e6ab51446@axentia.se>
 <CAAa=b7d+4j53s1rB-0zchZE1xELsa3t1=-WaijKoMWYoJjqFJA@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b91fc5a3-98a4-5388-cb38-0f0fccaa68c7@axentia.se>
Date: Fri, 4 May 2018 17:38:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAa=b7d+4j53s1rB-0zchZE1xELsa3t1=-WaijKoMWYoJjqFJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:7:28::22) To DB6PR0202MB2773.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;3:96T88sCPIqx6W8TDLTSWnSQerPiC9CjTBxVc6WiaYbOL7yLxc+D0YVOW5ihP/01X3mhQtl/wf5rDNjy1toR3sk83VRc79wOXOr9/dFaGFuNF5NKXVzEm5WaemjPGy3j9OaGP4GNQREMOYZjeEJqTZvsLBU4jWXq9Uft/c5zBtvOWnzQR+3oMjBS3LIDhQRD+urhU1BVz8slX5CYRCypT+k/MY6X00PY8xau9aTSbdiDN9pnLP1Z9iXhpqFwDbHhY;25:w56yAnA4sJtDlTpe/araere+qNZRSckJwBXtnxEegXYqUyGuZAntcl89JN/hfe9qXO2qWuncCQJ2j1hkTU597lOHd7VYc3kDGO8KGAREMArZBXnNQBnP72SB63llCKEFcGbcjK2c0eomLfmKGxsClb5/IW51ZnM0yj3QdyRsBgVfOqWzuTgNhU8Tf3cphp5MKw7o+Cehu3eLGIvZNwKa9RkhQiyQI9EzDvDVE3JtiBuFjHwWILuZZAR2XPoEssGUYz9chxhHqzD3y5tbNFBZZ6M2IC1hv3eynvHPHw79SooiSzAfCZmaoFVtxerhBlVcVZT4mK6vyUgjlfOAtLa5bA==;31:aC8uLTb0k0ZXd15SAqyjNak6rRjBTAIGEv+J1JYKh1s8fex1rs27pquONfgoCfmGQ8YDn6TuHGl3B1ATnizLADE6KRvqn0S3ICc0VNczlXXrXiQWRy55U+t+ad2Wud0ISu3j2YKEHQHu3wiFLP6u0k72qfVyQtMJkq0f/uWE0X6fTeqdeqOsSWXGxYKb68VC8kfDq6aUujshYQkSSJeMhcHpiLrrq2TN4KbP1sksMSg=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2773:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27735AA3104E02587E8CA7F3BC860@DB6PR0202MB2773.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(788757137089)(8104003914727);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2773;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;4:5fzzgur/OUfcZ7a2JsSQHDCrx8Nda+Z3VlK1cuN2aPq1dqUOAVMGGl64c0QLpsRsNOx6x9vM1KuJTvpBDsifvKcQ1rGmD2GPGRyblbCu9q9sW/GuIYBlQ3bNOSnFZ8bspLv65Xtwd6Ups2h0nYFDvdd9VaZ2sNpuA4g+8SwcjOb2aGhf3vysr9hWSRmPi0W/gVrSYFNS1o2b4wnmolcQWiZT3zIRyCkgEWPnhNWrdiv1tPj2TITs85GO1+jrFQa5CONXkrXhUbcsHzX8dc8A1BrAo8uyn7Fl2IVw9A9XjsrEiEMOPkE1hmHKlwCtEhIzlTpUcN8s/+LF12jXAUMquJ1qiXBaL9Wm+pTVijlWNvT/oyByL83I/FPqp85EBc/S
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(376002)(39840400004)(346002)(396003)(199004)(189003)(377424004)(86362001)(16576012)(26005)(25786009)(6116002)(316002)(117156002)(65806001)(6246003)(478600001)(54906003)(3260700006)(68736007)(97736004)(66066001)(47776003)(65956001)(31686004)(93886005)(52116002)(64126003)(74482002)(58126008)(3846002)(446003)(2171002)(53936002)(105586002)(36756003)(4326008)(476003)(11346002)(50466002)(5660300001)(7736002)(106356001)(956004)(6666003)(230700001)(2616005)(8936002)(36916002)(76176011)(53546011)(186003)(52146003)(65826007)(31696002)(59450400001)(229853002)(8676002)(305945005)(23676004)(81156014)(6916009)(2486003)(6486002)(77096007)(486006)(16526019)(386003)(2906002)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2773;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzM7MjM6UEtUVGQ1QmNkaEljZHYxeWtvWXYwNjEr?=
 =?utf-8?B?TVRGbFpPNVNUcEJsRG5vbTVXRHE1dUVtUFUrNDBUWWdoZytsdDRNcllMNDNL?=
 =?utf-8?B?UHRydEdYcEZkNDZMaXQwTFBPUVdOalFuczJoM3oxeGdpUE90R0JvWStnWnUw?=
 =?utf-8?B?SmtiKzhSNkF0cTBsZlZHalVHL1lkRmIrR1hsa3pObzFTVkxoT3Zwbi8wYTNX?=
 =?utf-8?B?WmVYcXNtRW0rcGVQVzVJT0xSaUhRNWxzMUNuZUt0RmdoRjU5bXJyazRYNXk4?=
 =?utf-8?B?VGRPc0RpTDhKbHFYb0Vjc012SThVeVZ5QUJUVElRQ1RhN1RQK3dBcENqRm1V?=
 =?utf-8?B?bXk4VGt0VlZLN0cvcEtmSHNPSkcybVVLSjhpTm8yTzlCWmNYNGJ3QlZHcDVk?=
 =?utf-8?B?Tm05YjdPbUVFOGFrTzFkdndJZ3VCRkRjUURYblVwQnQyNjUwT0ZIRlVwQ2Fk?=
 =?utf-8?B?azR5c3BaZjBkV25zYUYyMmtVRnFjeWpiR3YrdlhYSmJzS0NobWFsc1hFZTB1?=
 =?utf-8?B?VzNZK0FKUkxVcVY3c0NLVTErYno2cmxSUTFzMWYxOTFRVUQ0aG1JMWhXdHAv?=
 =?utf-8?B?aXJmYzdrWncxTEh6WDVHQXBZc3liZlJ5VHBSc291QkVRa1N2RmRLUVI2WEM4?=
 =?utf-8?B?NUpWNVRXWWV5NEY0dVNTZU5BVHJhMjhweGEyNnV1UGl5ZHIxOS9RTFhhWDRK?=
 =?utf-8?B?QU96ZndaQ3d3UU0yQkxmN1U3MGlMd09BS2NtWWhnTlVNR0tTbWlpbnVqa0Fv?=
 =?utf-8?B?YUJRMkFUVktEb2R6Vy9hZnJrS2pmWCsyK3ZSRmRnRjhxWEQvNWdIcmNPK2I5?=
 =?utf-8?B?RElVV1RPNmFYdXFKMloxQUorTWJReGk4WElUdmNjQUpGWjF1b05FaDBQdFZP?=
 =?utf-8?B?T1VYRHdwVHZGSmR4Ykc4NHJRZS9tQ1ZHM0l5MnZsbmQvY0hmdXZaaFAwd3RM?=
 =?utf-8?B?Y005a0M5T1pvYm9mS1VQbjNyT2xjc0R4VGt3bGgvUkp3TkFNWFgzZVJuUUlE?=
 =?utf-8?B?SG5ieTQvanhmaldTUTQvS2FSRVRuYisyTTFFUVNmbkI3V2xiMzhwbzgzR00z?=
 =?utf-8?B?SkFrR3hPWGtBKzFFRThRK25DRENNdmloMmJTYW5NV3dhT2pUS284Y2lMbGJJ?=
 =?utf-8?B?UXBuL2Y2SjU4ODl5WFFSYUtQRy81SGYwREtoZktTZjhaTGI5cjVseHJEcFRO?=
 =?utf-8?B?OXgyc0dBaGhVZ245UnpzTnJPTGx1MUJMTjdqQzI2bXhnUVpzTnk5S2s5eUtY?=
 =?utf-8?B?MGhFZjJjMFJkVTVOZFVaOEpWREVOUys1ZzVOSEVzSERKWHQ2VHBMdzFKdWM4?=
 =?utf-8?B?UURZVURaQVZvUkp4UW5iMk85dEtyU1FQeCtJM3k0WExVSEExdU5PUUs4amdm?=
 =?utf-8?B?RzlsbGpPVWs2aDV3bzl0dzMrN1VtYzZYSGhrQ2s5NXV2ekxjTE1NMTR1MzZv?=
 =?utf-8?B?UkVnRkIyRlFRcDZJc3lYVCtPamNGOVJ3U0J2dWxQOFhSMlZDbHlGcEJWVUhu?=
 =?utf-8?B?eWtoREZrVHJVUS85TnlNYmhLTmNYN3Nia3VqWWR4TEZBZGZuYWJFQTZ4RGZm?=
 =?utf-8?B?eVI2azBUMk5YbTk1c0lySWMzeHhaSVp2VWJZVFB0cDlPNVQvWW5mVWlDTnFw?=
 =?utf-8?B?blgrSjdQbkVadmZmeFRoSnJoakduOHU5V1RadHdDMzNaQ20vLzJvU2MwZUpa?=
 =?utf-8?B?K0MzNUdHbDh2czZsc2hadnVEWTRCVGh4bkdMVVNIMW9GVWpncUV3YkZnRVZu?=
 =?utf-8?B?V1lpNG91TTBIdDhlNE1iVTlKWGh3L1c2N1JnRFBLeVNRVjNNY2IvejBNcHhT?=
 =?utf-8?B?YVkzU0MrZDBtZlBTaXVYUklxVHpUeHlOTmI1VkRFREo5K1BHL0ZFK0I2R1d4?=
 =?utf-8?B?b3JmUjVtQWNBQUIxUzBLWTJGMGhZeFdYQlh4dEZ3Rk9MaWo5SW9zQ0ZDNHQ3?=
 =?utf-8?B?SmRFL0Z0d2xZa3NOelQzV1JRc3hsQmd4dHRPZTcvMWNibGdnVXp0eGF2b3pz?=
 =?utf-8?B?SC9RZytqMjNBUmJRc1BEQisveWpJVWdRUklLczBpbEpyeSsvdGJRdWxPVDVF?=
 =?utf-8?B?R09tNTR4cWxBZ2JmSi9VcEh6VklWdHlOSWxtWjlONnI4MUhEaVdSVnZPeXJs?=
 =?utf-8?B?YzlpaVJHUFFQdGZZQ1ZYRndkVXhpUnJua0Y4OHVLZkE3K0xMbjIwbDBsRS9C?=
 =?utf-8?Q?+yJPA2LeS8hyDa9HnZtb4kCJUaUtD5WFu/zeP7JsDxBY=3D?=
X-Microsoft-Antispam-Message-Info: MoXQu1ygRyjebRpaaemIvPHWTMhfkVAsFeBN3gC0U35umVF8r49ExlcgI7cZu+nODeLx2EwfsD0ITVByrxSMgWn93AUrLJPHAryxLtGi9+cz1HHwT6kXPAG4IboQqiiklerKUD3usXvblVZYTfIwoUkIWlkhMAcej3dOP44te5UsKJsDtKPuYOJV5rw8th2q
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;6:G0Oy5lVTzYurB8aACgAg8OKtn4+ahgfZRrjCno52PfokVkSWQ+4BdiM7ejNOb6g+HdncvK087Erw8K09yODXRu3tNUjGFVpeZpWOm1HTXgKsdopaa1j5OqFBSA8Yo6uBdg+rvfCtjMlcZlEyMBUYK213QbzvzHYlWNMMVP/YbCYXXsY3LEAfjzjwrdwg4zaDoQ54jmV5QeICffJtRjjqcCTImS+ZhK43Jzb7dTET2oSx+joTgIYgqz1A6XpaUkshF0FO8fZZ5EwVRwLz2VaQhmrifjOpMPGuJaaSiJfxVGs74ehTCCbOC0KrzaVyWGnMy5v+LXGhBf7YBFDVjTCxvnpYbhdhMyxkX7z0MYqexFfwWOsePycgN2rO1c7I+UAqkQIks6ifUWqT2LzImp9kByAkrLkn8/4YLz/A0bUM8VeWx214JFUGp4lxstcuP0fYmMsXDXPth6fU/uOjbBi4hg==;5:/u8SnzrRxKk7Jnl/64lbkxUmnypJb/Debep2HWdEYAhEG9ZSvdnmGyY3kl1tEQ6NuaPSMHZnhJw53kSKMZZl39rAojEcPUrEfcq99qvtYn8p1JdfvLvE8AQTn7yIvC2/jFuOLq1oOXPSajJUpulaOP2o1RQrfds+U2ML3Iy6YXw=;24:UqjY4xboBvp/bjqALDHdBiFgpx/sfAwGBbAdrBuY5xI/W8BbdhaIBg+VbiQBOu7T6dnAuaQIeD4LLyf2JmoQ/dsLjjbX2HMR3DNebdD9Wkw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;7:gh8zq35dSSBA1ngqqXu46SopF7QG0yQw8WPIvVvLUKB/1DOeHuFh8s10Tptj2e1mPdxVy7ymkkndVbwQrfcFPpuAJSSgo8PDOlIjRDvxi+bEpJUDD0oNDnUli+p3AKIFufXdVyC0Vcz9PRenofzXUepZqWYoNnWy/KDNqbpQF5Z0rSkxksUIlfOekx5lhavGxAhlkia1H6uIptGc28K/PIXQr9k2xrzNu7JEHD/D7RRIjWvKzmFjPxsOcazivobz
X-MS-Office365-Filtering-Correlation-Id: 86525dee-11ea-4079-7c88-08d5b1d50ec0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 15:38:17.1595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86525dee-11ea-4079-7c88-08d5b1d50ec0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2773
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-04 16:59, Wenwen Wang wrote:
> On Fri, May 4, 2018 at 2:27 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-05-04 09:17, Wenwen Wang wrote:
>>> On Fri, May 4, 2018 at 1:49 AM, Peter Rosin <peda@axentia.se> wrote:
>>>> On 2018-05-04 07:28, Wenwen Wang wrote:
>>>>> On Fri, May 4, 2018 at 12:04 AM, Peter Rosin <peda@axentia.se> wrote:
>>>>>> On 2018-05-04 06:08, Wenwen Wang wrote:
>>>>>>> On Thu, May 3, 2018 at 3:34 PM, Peter Rosin <peda@axentia.se> wrote:
>>>>>>>> On 2018-05-03 00:36, Wenwen Wang wrote:
>>>>>>>>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>>>>>>>>> which are used to save a series of messages, as mentioned in the comment.
>>>>>>>>> According to the value of the variable "size", msgbuf0 is initialized to
>>>>>>>>> various values. In contrast, msgbuf1 is left uninitialized until the
>>>>>>>>> function i2c_transfer() is invoked. However, mgsbuf1 is not always
>>>>>>>>> initialized on all possible execution paths (implementation) of
>>>>>>>>> i2c_transfer(). Thus, it is possible that mgsbuf1 may still not be
>>>>>>>>
>>>>>>>> double negation here
>>>>>>>>
>>>>>>>>> uninitialized even after the invocation of the function i2c_transfer(). In
>>>>>>>>> the following execution, the uninitialized msgbuf1 will be used, such as
>>>>>>>>> for security checks. Since uninitialized values can be random and
>>>>>>>>> arbitrary, this will cause undefined behaviors or even check bypass. For
>>>>>>>>> example, it is expected that if the value of "size" is
>>>>>>>>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>>>>>>>>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>>>>>>>>> value read from msgbuf1 is assigned to data->block[0], which can
>>>>>>>>> potentially lead to invalid block write size, as demonstrated in the error
>>>>>>>>> message.
>>>>>>>>>
>>>>>>>>> This patch simply initializes the buffer msgbuf1 with 0 to avoid undefined
>>>>>>>>> behaviors or security issues.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>>>>>>>>> ---
>>>>>>>>>  drivers/i2c/i2c-core-smbus.c | 2 +-
>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
>>>>>>>>> index b5aec33..0fcca75 100644
>>>>>>>>> --- a/drivers/i2c/i2c-core-smbus.c
>>>>>>>>> +++ b/drivers/i2c/i2c-core-smbus.c
>>>>>>>>> @@ -324,7 +324,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>>>>>>>>>        * somewhat simpler.
>>>>>>>>>        */
>>>>>>>>>       unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>>>>>>>>> -     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>>>>>>>>> +     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2] = {0};
>>>>>>>>
>>>>>>>> I think this will result in the whole of msgbuf1 being filled with zeroes.
>>>>>>>> It might be cheaper to do this with code proper rather than with an
>>>>>>>> initializer?
>>>>>>>
>>>>>>> Thanks for your comment, Peter!  How about using a memset() only when
>>>>>>> i2c_smbus_xfer_emulated() emulates reading commands, since msgbuf1 is
>>>>>>> used only in that case?
>>>>>>
>>>>>> I was thinking that an assignment of
>>>>>>
>>>>>>         msgbuf1[0] = 0;
>>>>>>
>>>>>> would be enough in the I2C_SMBUS_BLOCK_DATA and I2C_SMBUS_BLOCK_PROC_CALL
>>>>>> cases before the i2c_transfer call. However, this will only kick in if
>>>>>> the call to kzalloc fails (and it most likely will not) in the call to the
>>>>>> i2c_smbus_try_get_dmabuf helper. So, this thing that you are trying to fix
>>>>>> seems like a non-issue to me.
>>>>>>
>>>>>> However, while looking I think the bigger problem with that function is that
>>>>>> it considers all non-negative return values from i2c_transfer as good<tm>.
>>>>>> IMHO, it should barf on any return values <> num. Or at the very least
>>>>>> describe why a partial result is considered OK...
>>>>>>
>>>>>> Cheers,
>>>>>> Peter
>>>>>>
>>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Peter
>>>>>>>>
>>>>>>>>>       int num = read_write == I2C_SMBUS_READ ? 2 : 1;
>>>>>>>>>       int i;
>>>>>>>>>       u8 partial_pec = 0;
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>
>>>>> Yes, it is a big issue if the return value from i2c_transfer() is not
>>>>> equal to num. I can add a check like this:
>>>>>
>>>>> if (status != num)
>>>>>   return -EINVAL;
>>>>>
>>>>
>>>> Right, but make sure to add it *after* the existing "if (status < 0)"
>>>> check as we want to preserve any existing error. Also, -EIO is perhaps
>>>> more appropriate than -EINVAL which seems wrong for what is probably
>>>> a runtime incident.
>>>>
>>>
>>> Sure, I will place it after the existing check and replace -EINVAL with -EIO.
>>>
>>>>> Also, I wonder why msgbuf1 is necessary if it is replaced by kzalloc
>>>>> in i2c_smbus_try_get_dmabuf()?
>>>>
>>>> It is not always replaced. The stack buffer is probably retained as
>>>> the default mode of operation (and fallback) because kzalloc is
>>>> expensive and because kzalloc might fail?
>>>>
>>>
>>> That means the stack buffer is probably used if kzalloc is failed.
>>> Actually, the kzalloc failure would be possible if a user-space
>>> process maliciously causes the kernel to consume a large chunk of
>>> memory. In that case, the user can potentially exploit this
>>> problematic code. So it may be better to initialize the stack buffer.
>>
>> Yes, but I see little reason to initialize more than the first byte.
>>
>> You hinted in the commit message that there were execution paths (or
>> implementations) where the second buffer wasn't initialized. Can you
>> give an example where this matters when the more extensive check on
>> the i2c_transfer return value is in place? That seems like a bugs
>> that should *also* be fixed in the affected i2c bus drivers...
> 
> One possible execution path is as follows:
> 
> i2c_transfer -> __i2c_transfer -> pca_xfer (which is one of the
> master_xfer handlers)
> 
> In pca_xfer(), it reads the status of the i2c_adapter and then
> performs different actions according to different statuses.
> 
> It seems probable that the buffer is not filled with the wanted data
> if the status is not as expected.

Ah, so you're talking about hardware malfunction without any actual
real-life incident. In other words, pure speculation. I'm sure the
kernel is full of problems if every potential HW misbehavior is
considered, and I'm not so sure this particular problem is going
to matter all that much...

Cheers,
Peter
