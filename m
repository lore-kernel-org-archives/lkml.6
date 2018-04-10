Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeDJSds (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:33:48 -0400
Received: from mail-he1eur01on0040.outbound.protection.outlook.com ([104.47.0.40]:7007
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752340AbeDJSda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:33:30 -0400
Subject: Re: [REGRESSION][BISECTED] i.MX6 pinctrl hogs stopped working
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <8b07e30a-7dd1-7923-dc50-b84f0e43e9e9@nextfour.com>
 <1d3c6099-3b33-d5dd-e12b-903586dc79f3@opensource.cirrus.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <950ec4db-4121-2faf-b6fd-5fcabef91e90@nextfour.com>
Date: Tue, 10 Apr 2018 21:33:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1d3c6099-3b33-d5dd-e12b-903586dc79f3@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [88.193.232.20]
X-ClientProxiedBy: DB6PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b7::17) To AM4PR07MB3331.eurprd07.prod.outlook.com
 (2603:10a6:205:a::12)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR07MB3331;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;3:V4IOororFHu+digfmXFy16HMhRgh0n+N6ffg/av5o4M/5mwoRtylTSFQAdOGptHeA+qJyGnrj4gjXF431WUL00U7uA35ipkFOcaqUEZ1wBz5ek1jsrO5D6dEe7B3IRktzh9gvx4pUzYvDQo6GJ6xAeSdxP3UvSW7H2eLwL+7HCzK6GgOh6jgoKqxxmd9O+GvWAAUfCpEXL5Vl8imyh9QddjPIk8wkf2EUBHRGefd8/DmcxslUj4yY5wDZBdlTMI5;25:h+afl2EP6ffF+nqRy4TDvfAEyuP6RrZKfu7NwbPZYP1keHEAUCvvfDDlvrDzSapQNMXPL9I6UyYtfMVX+ccLHTV/+PFxKRmQGrhUuXbgLHC7CqUazUgE+1VcqkvlaKFHnhbig1LaJmgCDSelS8kckoPxL3GJZ2VycSg1X/JTwM0CYVP/Fgq34SJxJE8Zzr0GxIwJXcsEQczSvMtzQ34Y5Us3gnRWl9ydrTPYeo+zYmobhIEcns6nWzLc3NRIhl82p5ZcPxqxq0z8wsQ7Zl8rhPtTwXY3/LXcCIV6/5oL7CjONbeuucF9/Ol+O5vA7zmgSz+okhkg4K8gA4+QsEbeJg==;31:eqOy8H1DRVz5St0+wIkp2UNZmDNUEeAqml90ykqAFOgWaTSTS172etjLwW8S6Fkt99IWlV9m/fdJWfHKYQZqaCaN2xaEdL0drR3HQdqZq4jPtjpD4BOcjJTduF1GTMtYUXXh6Sz4pZglsHinXbANiOma0XlVAN5nehGi8k0JTmd6xR+UC8f58JtzPL7E9g/ZBP6GetZNhewymMEtUC3NpbkDTlyywmemEM+9/Iy9aL4=
X-MS-TrafficTypeDiagnostic: AM4PR07MB3331:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
X-Microsoft-Antispam-PRVS: <AM4PR07MB3331877EAA2E524663D9957E83BE0@AM4PR07MB3331.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR07MB3331;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB3331;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;4:TUCm53QoAWEz1MCxApfQYbwAV+DqI4FBu2ZHsxsvOXu6QThLv8wlFNhsQ/16Voo4SuhKz7EfjYBY+zZ52XFDbOmo/1ScMc+dfWeYijFryQZIvKBWS3JL2xpWTfz34lEIwdsjI3mo8h93YgHQr9fMTcOgX13jbKbU5hcZjRlhK446Gh81nkS5/+GzMErJF2jVQ/GjWPWy5hTYDGXgihZD6bJYPnli+C7oIeciXLdc6RPUbVNMCcMtpM2y0i6f3saGtDuB5CLCHHtPBLUfFuEu1Q==
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(366004)(346002)(376002)(396003)(39840400004)(199004)(189003)(64126003)(68736007)(53936002)(16576012)(58126008)(110136005)(316002)(50466002)(31686004)(476003)(3846002)(6116002)(11346002)(386003)(65826007)(956004)(2616005)(36756003)(105586002)(446003)(53546011)(2906002)(106356001)(8676002)(2870700001)(81156014)(81166006)(6666003)(8936002)(6246003)(2486003)(52116002)(76176011)(52146003)(23676004)(478600001)(97736004)(86362001)(66066001)(229853002)(65806001)(6486002)(65956001)(16526019)(7736002)(31696002)(305945005)(25786009)(26005)(77096007)(117156002)(186003)(47776003)(5660300001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR07MB3331;H:[192.168.1.71];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3TUIzMzMxOzIzOjdJdHZVR200RXlNdHhIaTVSQVRiM3dYVTVY?=
 =?utf-8?B?Zk1UNXI3WDA0UW52c1pOUGZwNzJBUk5hbVdwY3V1eW94VjBLNDY2Z3NxMnkr?=
 =?utf-8?B?N081MmI0VHlldHVFcFNzaG9KN2l1VnZEanY5bHp6L0RSSWNsVFJ1Vk1qUHBx?=
 =?utf-8?B?ZWZtMml0d3NRLzJMTHhNUmV1TDZuZDBKOTMzYlBsYmkrUXA5M1VOV3krU1Qw?=
 =?utf-8?B?SERSMEFrNk0zOWdlWlRKeUdjNHhxRFhNSzFBbllOanFyaFZDWjAyc3NmZTJh?=
 =?utf-8?B?MmZEa05JV2xwV0RiandRQWtZdUFGdHA3U2JaWkdaTEFPM3hsd013T1RnMjg1?=
 =?utf-8?B?Y3NONkhmL3Y3WjFzVHhYMmtFeUVUWjBiaWsyT0NoL20waHpXb2lwcEZrQkYx?=
 =?utf-8?B?dmFTdkZsZmhJVmlaVXlkenpDaXg4Um1sbDUxYlVrT0NhNFFzQWFDZzhicU9I?=
 =?utf-8?B?VlgxS1o1Qisvc2U1dlhSV1gzeXBHeHFqNDFEZ3I4NkMweWdpNUhkazFDQ1J4?=
 =?utf-8?B?OXh2bElNQTlYVEdYTFBibmpZVXFiZzg0aXAwUzRYeWJacXRYdkZzbWlVUTcz?=
 =?utf-8?B?cktEWnFtNW12R0VVdUVNRm85Y3VYUnJmNFlxTDgrVW03K1VlV3ZWY0p1cVZM?=
 =?utf-8?B?Tm9Wb0xpbVBYdVAySkFpNTdvQmpBaWIyNkdRc3N0Sk9rZmZwb2c2UjRlWEls?=
 =?utf-8?B?VTJncmpzU0thWERiMW1sOEZmeGdjTytEMDdyTjNsM0JQcVlxTEV4VTdyQ05j?=
 =?utf-8?B?RDBJeTNxdVU3TTkzN3RIQnRpM2h5K2JLRFNhemNqM0VTSTgxWUd3bTl4NEZt?=
 =?utf-8?B?NlI0K3NEK29uOFZrNW51dUZYSUIwYlh0K3ViTWY3OEJrbzM3azh5cG11TUFN?=
 =?utf-8?B?eGpTZ3ZiNU9mQnF5Q2kvM0hTWkV2UEpOazFvb1dYZm5adkZkdUVSaHBnMWhO?=
 =?utf-8?B?dVBBQ0RnUktlQldzcm0rMzl1Y2NYVEp4eUpXM29hdDcyT0V5MXpxeGZsbzFn?=
 =?utf-8?B?RkhWUFBFNzhSSHVVb3RLYUQwb2MwWDJrR2g1QkxOWWpWQ2pBc0hYajJXcnlr?=
 =?utf-8?B?UytBYVBHUHNjMTZtWjFOM0orYW43Y05EdGZZNDZoR2lPcE9QMzdoYkpKOXA4?=
 =?utf-8?B?MkduemZPSHllOUZpekMyOERMMm1xRm03YldIaUI4YmFKZGh4VHZYajdtemQ4?=
 =?utf-8?B?RlU5aWk2Y0NIS2FLaEp1Z3ZVZG5CSXdSWU9wN3RtUVlhMjhnbGswTHBHTU5K?=
 =?utf-8?B?UDJUMHhIUHp1UmVsdUVQQjBUMHlLWG9OV3dKdUI2QUpvRFU2UFM0NWNrbm1r?=
 =?utf-8?B?NTY4RE5RZGFwbXNCQjdkYXFrZzlKT2FxaElOYXhSQ3drSHhmcW5OSWlrcFFy?=
 =?utf-8?B?RUtydUdUZkVvYzlsaUN5M0lhY0ZGQWtVc3hHSXZPaCtuWURBcTNnWEt5eld4?=
 =?utf-8?B?TFBxYkIxZGhaNGpwSVB3UGVRZmU3TDY4Umk5NGFJaTQ4UFZESUVmWFVtaW1C?=
 =?utf-8?B?RkZoK3d1Q0hYYTczTko0bXZsNERObGVGODZkS0tQVVowTmtQaWRjTDZENWlo?=
 =?utf-8?B?Z3hGZlRJZXR2WGpkV1FCMUJnYldvbnl6MGN0anVnODN3bmVqSitFZ2xrWGZM?=
 =?utf-8?B?Tk4va2RaZEd4NldQVlJmUFk4eDh5eHJHVEhXa1BTTjFrTDN2UG9vdE93QUVH?=
 =?utf-8?B?LzEvWTlxc1pnMlFmUktuUitIcGZiVDc4NklaU0lzV1J2U3c4OGd6QUhBbi9n?=
 =?utf-8?B?K2hZeTlIdEFKR0RPcGMyTHZSQXFQK05FeitIR0g1RlVsZkcrMnRseEpjSWpQ?=
 =?utf-8?B?Uks2K2o3NVdoSDhrZXZ2TWNmMGkzTTF1UDE3ZVhTcnF4cEdWSklmTWV6MlVz?=
 =?utf-8?B?SGdhU3BwczZEa3ZiUFd3WFhYUTQzZFdwVVVxWGtvNDJQblpkaDRhN0ZOVDZ2?=
 =?utf-8?B?L2lYR1ZKZFF3PT0=?=
X-Microsoft-Antispam-Message-Info: 3idgHkC0EVeNyMZIdTwNkBPySZRc4T0zQDM2HTtTm0Oe7EQ9WbT8lZltjrW9lBKqShm6zu6hP7g2BbLAkd73dW5MT6ugZIesm+eHApues6rbM3rW+pWFw9UmNnpVAjtez0rkZVFmETPG2JsD5JQTR9qVivFaqqSHxpc/qDuq3oWFgkMolwBaV3hplWhQ3/iu
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;6:2M7k4mEtFD98twrJrb1G4XNAiiJNnJykaSyNGVkTuVEEWxVxB/fb5xLCXtf12HNFR7ECjUcyfaCnCuR36Yj4FqQYBzi+BTjLdjkPFHB1L+V6RwfM/nKvtnoj3kza1t2jYqjxbimS3c/3IVJSCG8EMwv6iv1IL4U4qjYfm9j8l5wO94vOQHUa/anDBFHeYzOpYNgtVf6XFH+OlGyhod/L8/PyE5LkmWCSvc6vVPZN0hk+y8AGIqNlYegy6Uk/O+oB5kss2OiDeI4rZ3sZA0vWSzJF9g//H5sNy1uMAO5S2YlRhlh1lr8RsreHnGMt6pKOHrYmunknSU2MuwlZ8p3tlKwrXVW1n9MoWfToP5++ApadJ4ojCZgAN+ykel4rGJwXpLlTbcHel/v55HrsrSUaDXvdimitYrGn+h0DTPh6gh+tKvie3eb1ylspvJBpODU44a5ll24A9/Y4R602TYf2Bg==;5:7CoalbSkgOQoTpN6DOsdk8AiAbm5JhWtpu0UxZHIYTz+ueNuzTgPpxRisD29mPjnRrA1RAG+QunAfzRxalmc5XiF5J8GNdzCRm2QeoS3EGSByOvze1I146C6Q7KolSUXJEcu3iNITg6OBz9AIFesru1r9/rD/oHYxfnDzURBWso=;24:q7QlE0ebPd9d/VGQUV/6CEyIxYHiy0mnytziMWACSiyu9jBCpztR4JtuxTUlg/QgEOFu7ENgJlX0b/5C4NAvmP3QZhPZ6c92zeCtUrEfn8g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3331;7:g2vhgz0Q0kI29gBt+CE6rIpK17pVOvGgDobVuxHfCB3FUb1bl2/LlUcIhTslcI8z+zJuxZCYEhxb4Uap3XH7FpE1BTEsetxd20SjWOxQTZcpvAOPRZDfsLJRiEyZGplJ4axtHZ+bK6yQPqBTGyxJEpLgqS4t7VLyuiFa3kPcpiyqnE8uhtadxQU3wetYILchU/2V8aprWkTXZreRET2l5E+dSugIAAcbWjApnJHKOFfAcN/qYS1lI8ch7LUOw/gP
X-MS-Office365-Filtering-Correlation-Id: c384168d-a442-421a-2da4-08d59f118d3c
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 18:33:27.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c384168d-a442-421a-2da4-08d59f118d3c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.04.2018 13:21, Richard Fitzgerald wrote:
> On 04/04/18 06:33, Mika Penttilä wrote:
>> Hi!
>>
>> Reverting this made the hogs on a i.MX6 board work again. :
>>
>>
>> commit b89405b6102fcc3746f43697b826028caa94c823
>> Author: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Date:   Wed Feb 28 15:53:06 2018 +0000
>>
>>      pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs
>>
>>
>>
>> --Mika
>>
>
> I think you should check whether the bug is with the i.MX6 driver
> relying on the previous buggy behaviour of pinctrl. I haven't got
> i.MX6 hardware to test myself.
>
> The bug I fixed in that patch was that when pinctrl is probing a
> pinctrl driver it would try to apply all the pinctrl settings
> listed in a dt node to the pinctrl driver it is probing instead
> of the pinctrl drivers they actually refer to. This was a bug
> introduced by an earlier patch (which unfortunately I forgot to
> include a fixes line reference to)
>
>   pinctrl: core: Use delayed work for hogs
>
> So if a pinctrl driver "A" had a dependency on another pinctrl
> driver "B" those dependencies wouldn't be properly created because
> all the "B" pinctrl DT entries would be attempted against "A"
> instead of "B". This caused failures if a pinctrl driver had a
> dependency on another pinctrl driver, of if creating a pinctrl
> driver that is a child of an MFD and that MFD has dependencies
> on another pinctrl driver.
>

Hard to say, but the kernel/dts has worked ok for 3+ years, from 3.17 until 4.17-rc. Nothing fancy, just normal hogs, in two groups.
Can send you relevant pieces of DT if interested.

--Mika
