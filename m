Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeEOKhC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:37:02 -0400
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com ([104.47.1.108]:15552
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752388AbeEOKhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:37:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 2/2] i2c: core-smbus: fix a potential missing-check bug
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wenwen Wang <wang6495@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525525341-10046-1-git-send-email-wang6495@umn.edu>
 <20180510111658.sxf3mvye5q6ihxa7@ninjato>
 <8f728c2d-b463-507e-2c36-fad22fd99dff@axentia.se>
 <20180515085833.4z4cvsxoqqbny53q@ninjato>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <87286831-408c-b542-46e9-fe8aba151d5f@axentia.se>
Date: Tue, 15 May 2018 12:36:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515085833.4z4cvsxoqqbny53q@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::15)
 To HE1PR0202MB2779.eurprd02.prod.outlook.com (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:jjZxlsXaE6sdnuCnVkLD7oJeOxScw9bwarnqtgE1nCpUacRpsbnh7ptEvRe2dpgwU9p1iPFYZ/sIXJe2YTvi/90Oqx74c10A0Qjf4ufRjPaKAwgEJT5Sjy+9XHjolIg0m2D/dlQMrHsKaPfIdmPLfs/bPwaubUxbsbJR6UGKnJwrY1U4CfPpdVQAm1IDullLu7awJ21rDdOepFYD9/fPpTErWoHdaCxzHRX+4LSy5tr4Q4QMRjPY/C8z1z3d8Nbw;25:m/gmChWkTopmO6oI30kW+7QzIx41/hHQluu4ueo/rUKZoh9LOaUL9JJahzX/bkMQkUsdmH7EHKr+Vzf9oLCdag8b+T8SWvdlTo1NaAJXmPJ/IYjcsT2R9jpnMyl7p8zBd6X0JUEaXcW1ohNPIYCbSrAjO47RGBsNrsZpP4FCVX3oWnW6eaFr28fPWwylBRNoKgZd57k9Lg6ZbkOsRH7iE6hNFN4QEYo7MLGV9vt2HX+lK4IZ3O7c9F/aCvNsypFs0sLVLQuJLsvkAJHsacFuHpH3Xi3D0TWuMMhlmf6gtzSG9wRvrYeU6QwbCXZIb094F9mJRsTRJC8ERKhYceoMOw==;31:9zCxsKf0ED5VuwydwoTjIQY/5P/OWy8PF5hMgCvzdx9PZaPBvaovLuAwdbTJvapIQkslQJ5GTVkKfQFkGXarDNXySzSA5mI2n5RnRF026MdSyVC/OGOKhl+V+gFIPWGZVdLyRGnBu4q24e7KNXx8ita7yLSok9o05B1/ALnzNpb1F3ksCYsapoNSM/89u9BmSGMaYz2NGwGVfiUUBo5J2UUgK2GPyjWiPDboLFFsHTk=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277904AD69C043AEA26BB1ADBC930@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(8104003914727);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:VALZR9oIXZspvMM53TVZ/bd5OWxNWFpEvAn8KlZHbHhV3AXpEwuoNCyxcnHS2jn6dcEojdfh7y2qIQsAhFygReRm5F+HiP1jti+pv94Kt8K+xrki9eqBmcn1tfJREgNGOpUT5HZJFtcAffFo/HlUn/NOvtn5Ox90jV9n0zcmhTUsmw050ag0p1BbmPsl5RpIJzP3ziGP9IdMQ/cq3J3JJjSCl/JA0wk8Ws8yTs72Ckyqwjul/GMrHLnMCbkvqSHedFvVbYGIdchPGoI+lSnCZ/IwFjQd0CXxIp0TzGTfQX1oQILWLCKZVRY4uG1K6TMk
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(39380400002)(366004)(396003)(39840400004)(189003)(199004)(377424004)(25786009)(3260700006)(11346002)(476003)(305945005)(50466002)(23746002)(74482002)(8936002)(2616005)(956004)(26005)(478600001)(16526019)(446003)(7736002)(386003)(65826007)(53546011)(93886005)(77096007)(59450400001)(117156002)(186003)(6246003)(16576012)(52116002)(81156014)(36916002)(81166006)(58126008)(316002)(230700001)(76176011)(8676002)(31696002)(486006)(6666003)(106356001)(6116002)(229853002)(5660300001)(97736004)(2906002)(6486002)(36756003)(68736007)(6916009)(105586002)(53936002)(4326008)(3846002)(66066001)(65806001)(86362001)(31686004)(54906003)(64126003)(65956001)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR0202MB2779;23:iOgQnX/48t1aq8pPkPMakHaoy94SzcGwCad?=
 =?Windows-1252?Q?5b6yU36OHiyjJ2dNPDNRO00U55dFivrCqFwGz6w8m5juyaMOnQqIuXsx?=
 =?Windows-1252?Q?0uhZwVQZ4RB6bihIBZU8RcZULJJzi+bhQwybnotai4t6Ro3gD8Uk0P5+?=
 =?Windows-1252?Q?SlZArWuVGgpwua8DX4cmfFSucO8tgCiGReo2vamyrAibiA5P6/oUug5q?=
 =?Windows-1252?Q?GycVTMyzha1JeDIE+X6+if5ISFU2Qg219SAssXPQjM3g4aSqLRyYLrCt?=
 =?Windows-1252?Q?b4SD3z7x3msyPhzGAiKL6XFQnVLKk8L++We9BPzOhIPWaHznzuIyFMvc?=
 =?Windows-1252?Q?kVbOFY0qib934o251JSLL/o4aHbvKra/AOh5p4+hZEDZ9V9WfcwW5QjS?=
 =?Windows-1252?Q?xeBT6dKwGN08ycSvyE0opgnUHGKRwzheSrES7/8f6yYqOawMUPphfFvX?=
 =?Windows-1252?Q?wUkY9UFnYHvYx+7nQuPcRRonue1MMBU4n9+rqi0EffdTufWcW4SSTdM/?=
 =?Windows-1252?Q?WQHzbqtVSuWG8Ct3uib6oo89KMoznJxPopPL01XjJcfio4i5fBpzKkS2?=
 =?Windows-1252?Q?Dn7fUDO6wC8R2yZmybV6NP2Gti5nskgL69s6rbkDvghEBbsmDWnRX1th?=
 =?Windows-1252?Q?Z5rM6e0nGQ2R6A5NeaEpC3B5NQKX9x/WifQo15ivZTDxTTcHBp+4y/aM?=
 =?Windows-1252?Q?tZafBdNbDzrOaedctpgLvz4rpGxXAhVcjTA5aWWzraL4044ZDuPxwMHo?=
 =?Windows-1252?Q?Cd8w5UqjQ3sBBJnkz2iwN8nY8xVP8a7oQ4N3MFn1+l6y1E5rpE4SW1kW?=
 =?Windows-1252?Q?kPJb33RarxKW4VJWAsillqFLfvjGmG+LEBGdEUoDUDDozPl8KSWMXn6b?=
 =?Windows-1252?Q?unoeQZBhzFAxNsY/hRTwn6tQrCrm7AF+dtEJo9py7Q1UxTBGLY/qTRtT?=
 =?Windows-1252?Q?UTGvAXkY9uJOsEUTjlBGNu8CVj78CXlxJCq5effGwc0d+hlUeheT9X/5?=
 =?Windows-1252?Q?N4Rc+xjCVdWPwIePorPDkal6xzk3Ne8nAQ2m5y8fN7SKUj+nqu/wxX/J?=
 =?Windows-1252?Q?2PDuq68GmJ0vp4RfK0qgP0XOtunbmYePuv79m6+SuE6wM544eUtK0fI/?=
 =?Windows-1252?Q?cUptQ0srT6R4aiFcvwTpASFWxYI2Rb+ZzOaxRO96WSm/rvpZWywKhBGi?=
 =?Windows-1252?Q?ExAueXmDtlFD0AIQVga/lFb0r2ke6eUJuyPlGDTIkC0fyGXFFi15tpsp?=
 =?Windows-1252?Q?0gIgobl4L9OnHfxS0dYjLgOg62E/kQ16uaFl0vUw9kv7pcsG0J3spIJa?=
 =?Windows-1252?Q?zTCKVmf9oPusurleO9V7uItfzrKbeaJsL8e64zlpKV35ZnxQ53XiSQtB?=
 =?Windows-1252?Q?s252r89PZfJJ826vEXZJAHVPkLmBgfDl2AuT7x4QMd3i3/gYJcTTu1WC?=
 =?Windows-1252?Q?fI5QtXWlb40zXvt/mxj928g1ZCSLJaQDAKPtmDlVa1b3FjLYLlcj9pTo?=
 =?Windows-1252?Q?xeCInATdfFBZbeoPRfCzwPw/JVTI78OIgqHXBQ+G3ZdLDwDnlkgO5qTl?=
 =?Windows-1252?Q?q1Z958v4GFi+wEPaw+s9+F+scguNBhOuZ2e8JkFUVaO6BuLkA0Mumu05?=
 =?Windows-1252?Q?yAcDDLDEBBTtjz1ED2diRt1OxqomrrtBhlsiVRhUe755BUci5+PFl1pN?=
 =?Windows-1252?Q?ZOtDX3sz/af6uyd5ckwLtaI1OJjKX9CU=3D?=
X-Microsoft-Antispam-Message-Info: Z7a78ZESaliHlikLN26Nn4ZLAqWDuLOkbxmDzP5Ed2dLWZ+htZltyeF08WitrSeR3ZmnVHAqBNRIpP9mO3ivbPPeow4ZM6nZ1Gt0VompoiooFNi/956wsu7TyyqB0PEUR87y5DgtQnNVAVfm0WQaX2KWNhLm7aiPU8fkJgzTNNUX5gOhOPvHiMu4gUamHaIw
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:pVwNI098bBI79SRoBOeWwMFVu3mu25cJWBNYycXqVCopOsSSv1HReO1P+MyDl5657zBE1yMPlWAOdX5mHNPJd1USifv04NkF9rgnDw7VJPJmeONw8U5H4yGitJd37OP3oFb/R0K54pZS8uWdvRzMj+ujRpY91G/8QuVEahXvyPQUICGPBWwtuEwyCFmPhCiU6Rapta5XMe5rtEUsjsNy4maIE/QwxD69so1M6wStMAX/hm+SYntA+B4V5+LPKtpleMm5O+OtDggCcjyCYzI+Rf5fulbqZVar4VnoNXEb4AFDDbeptGpzA1CX/9FRDcx2H7vUfgyB7mUFdXBYVvZ2J9m+ifY39+Xqo/EhU48Y7Pao3LnuK6Q6eiVC05yp7fhIUMzYCrB7kLhAYDG2R1PrAyJwX962PIrc+pdpNz2gy2prhGzFbgqZtET4FCTqZH28TpO4miuP3lYzxRO2tFC6Ww==;5:WIkzrEwcbr7DtgVrphmIHsShXrCtPelxHUQUmmRKs8wmXG/ksxCLEv7w9u7dt3LJZWxXcLUin2DQwU5ZVSxNoG4MLIBSMOq4N8brVRi+lgZLtCNl/7YopGHv+Wtg8esgcDmv/XJXLkzXNVr+eV98FE8yZ77+Cgepr6e4Z1e5P1M=;24:al7GQoS2tK8aipfl76VkQ5L8bK/Ta0Z0dEVYxC5cTPa7Bh4bYAp7Pqql6lAq7oAvc07WMw95Qs4ZgbiqR1Y2ltRQ7X7Jz7aReFoEXlu6yOk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:T5e+AAMsmMTlT/u8wDqddxdoyZEZdVXaHKw1Zll2YWQVQFOoA8mfUxCnWoH0Tl0AubqRTUnSp+aYta9XXQS27YuSpkBuNVDfo+xU5CR1HBH4Qnj54QUtDhVamB5jpMOSSE48gPVQ/CtdCwahecyabeQIunoiyn4vNfv8bX8NgiR/E6FFRUXXS9vatu+p8GkfxgXzGS60GMC5pPkReWaX2gXG8xIJqLBDlb71Xq7x3LvVHz6dNmozvt0Enz+biPn7
X-MS-Office365-Filtering-Correlation-Id: 171a441a-eb02-403b-9425-08d5ba4fc7d4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:36:55.8385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171a441a-eb02-403b-9425-08d5ba4fc7d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-15 10:58, Wolfram Sang wrote:
> Hi Peter,
> 
>>>> In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
>>>> transfer i2c messages. The number of actual transferred messages is
>>>> returned and saved to 'status'. If 'status' is negative, that means an
>>>> error occurred during the transfer process. In that case, the value of
>>>> 'status' is an error code to indicate the reason of the transfer failure.
>>>> In most cases, i2c_transfer() can transfer 'num' messages with no error.
>>>> And so 'status' == 'num'. However, due to unexpected errors, it is probable
>>>> that only partial messages are transferred by i2c_transfer(). As a result,
>>>> 'status' != 'num'. This special case is not checked after the invocation of
>>>> i2c_transfer() and can potentially lead to unexpected issues in the
>>>> following execution since it is expected that 'status' == 'num'.
>>>>
>>>> This patch checks the return value of i2c_transfer() and returns an error
>>>> code -EIO if the number of actual transferred messages 'status' is not
>>>> equal to 'num'.
>>>>
>>>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>>>
>>> Applied to for-current, thanks!
>>>
>>
>> I meant to comment here but got side-tracked and never got around to it.
>> But see e.g. [1] and [2] for drivers that will not be happy with this
>> change. Maybe there are more of those? I did a scan of the drivers in
>> algos/ and busses/, but there are drivers all over the tree that
>> implements .master_xfer that I have not audited. Who knows what further
>> problems this patch will reveal? So, maybe we should be a bit
>> conservative and only WARN as a first step?
> 
> I came to the conclusion: yes and no.
> 
> I think this patch is correct, so it is good to have. But true, it will
> expose if other drivers have implemented the return value wrongly. So, I
> removed this patch from for-current and plan to include it in for-next
> instead if we can agree on that being a good way forward. That will
> allow for one full cycle of testing and fixing the issues found. And
> hopefully I have time to write a small coccinelle rule to find if
> constant values are returned in a function declared as master_xfer.

That would be a good thing. Maybe a long term goal is to simply return
zero on success for .master_xfer, because currently the only expected
success value is the number of messages sent, but the caller is in all
likelihood already aware of that count, so it all seems rather like
something that is just pointless and easy to get wrong...

>> PS. Also busses/i2c-rcar.c seems like it might return a short "success"
>> for some sequence of events. But I'm not sure about that one...
> 
> What do you mean with "short success for some sequence" here?

By "short" I mean not all requested messages transferred. By "success"
I mean non-negative.

I.e. when I look at rcar_i2c_master_xfer(), it sets things up for all
messages to be transferred, starts things off and waits for completion
(or timeout). But the driver is too involved for it to be easy to say
that either all messages are transferred or a negative error is
returned. I never managed to see that anyway.

And the function has that "ret = num - priv->msgs_left;" statement
indicating that whomever wrote it thought it perfectly ok to return
such a "short success" (which noone is expecting).

So, I'm simply uncertain about that .master_xfer implementation, that's
all.

Cheers,
Peter
