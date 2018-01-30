Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeA3BOJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:14:09 -0500
Received: from mail-co1nam03on0041.outbound.protection.outlook.com ([104.47.40.41]:38501
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752186AbeA3BOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:14:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
Subject: Re: [PATCH 3/3] i2c: add ACPI support for i2c-piix4
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC"
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1517195327.git.andrew.cooks@opengear.com>
 <f6b7e8e5dc31d294c08d1c218b59e1afce820b37.1517195327.git.andrew.cooks@opengear.com>
 <CAHp75VeZ6fXJsRAj=4ozhLe=X=yL8y3pBVk1c4H7_niQ88Gfhw@mail.gmail.com>
From: Andrew Cooks <andrew.cooks@opengear.com>
Message-ID: <09827d60-7c23-99ea-8d48-8231f4a50ace@opengear.com>
Date: Tue, 30 Jan 2018 11:13:44 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZ6fXJsRAj=4ozhLe=X=yL8y3pBVk1c4H7_niQ88Gfhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: MEAPR01CA0002.ausprd01.prod.outlook.com (52.134.192.142) To
 CY1PR15MB0030.namprd15.prod.outlook.com (10.162.45.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dee9b734-2ad5-404d-600d-08d5677ebfbe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY1PR15MB0030;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0030;3:vlpSpz7AHPJ2eAseFExQi5eot0uT4+OMYxQB996jT+FiPgYn8wQecOKqQ/6fv4VlpNMzDMJ5ZN98+zv+DwkwS9y3X21kn3IDhzdHy6aXwmGEXjP1yLjhf/xJMcAjS21d0o6RDoBzPLaB/S8zKFVjmBtdX060A2RBqxEjaWkRSJTT0eC7GyCulY/CSfRdFu00ZpemIAWTrBMppefenQ2EKXOhjPIU/4eO80cukH8vz7JvWgKA5eO0kxYPf39I6t2E;25:3f7BaBmbAMFIuvL8oykQUNAjSWcQ6SxIRUxkKg0XVvOYfxrZKUV8el+FGAt+UuAI7Nm1Vshe+Doi6xdTu2Epu46zRGlC6tXb4VcMoZvODCz3CoNlxcxs6xumTNKuQV1yXYNlAOOyvw1pnqaDptHOKx+OdEGoeMg+4o0xNrZF+NQagNyZSutk+ao2sDth7t5D8TIaCLemlIvMQ7ebjNi83zbVYs6QktMqIz2IRthQuvCz4z+stlXJ2SC7aUIjUdt06NR7OrHGF80ah+GOq7054TiDsDvVA8+4hOIeBPxZDa8xNdDFO7IN/vBa9XWW3rn1fNo8tVnsN2xt1/DVQAZFWg==;31:j/3B+bUGQpmav7Uo3DdAH+JM3245tdViwL6bI0SnHw/4xBD3N2/LspF7tKbKzAo8f45/dC+uuxPLe515vcS6mm8TANIu8+TTVlSkdRXp+klrMt+qSnlKPz6oaZcJidG8Aiv9W4bo0+D7g+PhVYMT2xoZIFwByaodrtNWVuovmwW2+cHm9xVOvuqQinHXGRQA2Jh4C9XFKEtDQvJak+FY5vZByA5NiZTwPmHjF+z/Q8g=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0030:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0030;20:CcLrFk1ZZG5CTUPx8ZGz5tp5ZKWnyzI2vcOdDTepUYbwNrG2Sfrx/JUQKSK8Pz2Aho6NayeJBSLkhhWgT5wo4dV27I6oG6/Kg756T0flaG7lnMY9KxiPB28yicd3f1qFShsFNEkCVsXaZhtdn6a9TgQcKCY89SesW78vpvrBHC0=;4:TCql2lM3V0hHkETYAjKgx+ZbUqBaxf2ZzByWynFFmRYMFnce3yK1+2ElAXXiUsnLUU0hhPR/5CDEJMaIYvDvuboXOkBMZ81UgRunRNcWAbOTInU2GkCpbc01DRftFRogMEUkkCvcJcc/ajMkHNbF/x52PUJT8rCp78cA8My3+UeYrIHI1nMbH5kZZWJ3zHoHYLSxzNhxIXkE+T1dUaZ9QL93HTzmovqH2YA4R7RU0uSUlZVsT7CAaO7cgMiPXPG9UTdrpRcLP1OYVGagnkOR9Q==
X-Microsoft-Antispam-PRVS: <CY1PR15MB0030EAC46862AE72709F56C3EEE40@CY1PR15MB0030.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR15MB0030;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0030;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39840400004)(366004)(346002)(39380400002)(376002)(396003)(189003)(199004)(51914003)(90366009)(31686004)(4326008)(81166006)(25786009)(105586002)(77096007)(26005)(68736007)(59450400001)(23676004)(39060400002)(52116002)(2486003)(52146003)(76176011)(117156002)(16526019)(53546011)(53936002)(316002)(97736004)(6246003)(106356001)(66066001)(386003)(65956001)(6916009)(8936002)(47776003)(65806001)(8676002)(6116002)(65826007)(3846002)(6666003)(2950100002)(81156014)(305945005)(7736002)(229853002)(6486002)(5660300001)(64126003)(2906002)(31696002)(230700001)(50466002)(83506002)(58126008)(16576012)(54906003)(36756003)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR15MB0030;H:[192.168.254.67];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjE1TUIwMDMwOzIzOjZTNkxINitNWmZZQ3lxaDhMMnljUmF0Ym9S?=
 =?utf-8?B?NVpMa1ppRWQvRHVtVjNValpWUEJkNEhRY3lWb0RCRE1xSUIwK1V0S3JRenkx?=
 =?utf-8?B?dHJZaHpEN3pVeCt5U1JQZ2RLaVdHeWlkREN1VWRLTkpXVjdWNGt3eEEyUGky?=
 =?utf-8?B?RUkrYXJ2c09QZFNNTEdxWk1obHh3UCtieVRZOHp5M3pHcFZGRU5SQkIzSnB3?=
 =?utf-8?B?UTJSYVF6dWErTHJsTTU2UTJVWUVXZUl1Q3poSi8xMVdJMWF3U0VkRE16andP?=
 =?utf-8?B?bVM4VnFaMkVCdk1vZy9LNHFDM2JSSFRIZEYrTkVVeTdFenU3MmwrNW8zWDk4?=
 =?utf-8?B?N2J0a0FzVTM0V2htaDlJL0xjZVhPTElpOUpzNXJaNCtmOEptUkJNcGxhbGRW?=
 =?utf-8?B?RlIySEZQaExFclNUNjN1RFZ3T0ZINmlGbUtsTmdHbEpnU1haT1F3Y3o2Ujhp?=
 =?utf-8?B?UHg1MzJORGpUaEVFSEJTNTBkRlV4K3hmTXRtajQvM0ZseFNuR1J1Q0txTm01?=
 =?utf-8?B?UFU2WUZuMzAxOUdCbHVvYWF0K1VHYjFFVGRsckNPNFo1YlUxcXUxankwd0F1?=
 =?utf-8?B?b2dScnZ4Uk95SUtrRGovZk5qQzhwVVFVOFF3NitQNXYwOGNmWG5QelFmQXNQ?=
 =?utf-8?B?bDZ5RWpqT05tNUkwcjh4aFZ4M2NMT081MUgzUFhwQ1Y2bjRLc0hVVU9PUWRS?=
 =?utf-8?B?NU9WRWJOVnlQRnJ5aWF6TmgzU2s4dTlLTjgzYVUxUkNCcGMyVy9oUThUT000?=
 =?utf-8?B?eU9nMHo4L0g2UXJBbStoRVNQL2dQTHdURXFLWjZyUGtQRmkzblhGNGdvblVC?=
 =?utf-8?B?VDF3MnRUdUNuNzN5VUhZTXBCQ09PWWpuMXhtNlJsa1RYYWtOS3R0MTR1WWxk?=
 =?utf-8?B?ZmFkRHFWMU4reDVUWE5uaWdvME1JTW9qS0FFVzJHY3l0UHQwa3VxMUdsbVk1?=
 =?utf-8?B?ZlZ2UXBUU2lvUnJtazFocndkQWw2SE1XdWNqei9pc0NnYzFOMG14SUJ4bG1v?=
 =?utf-8?B?VVgyREVGdkhiMi9UTWV0NmpFTkoxZjROY2VCNEUzSzhNa08zbzRxUUQ5TmpG?=
 =?utf-8?B?YktCUHgrMGtEWm0vREZBdnZDYzhkZzFRUzJKNElBejNxVktLZnpiTXhOWDdO?=
 =?utf-8?B?M3VJOWdoN2ljZUhPNHFrbTdTeE5sMmVZM1lhVDR4THJzQm1rdjdWVVRtY0NL?=
 =?utf-8?B?YjZ3SEFocXdoQmFna3dla3gxVnQ4MTExU01rQ2RBMGxoZ3RiSXdYaXhBQk1G?=
 =?utf-8?B?SUNVRUp6STJGUnVWWGpPK3pCejJlci83ZUNveVdCNnJEK0VUQzVsNTJTWGVD?=
 =?utf-8?B?aTNyYVBySEhjV0xnTThoN3JNOVBmdmhtMjVnMktIYXcwNmE0MzJPNEIwRHIy?=
 =?utf-8?B?cEdJaVBRa09KS1UxaUdEZ1p2Um9KaDdTcUdkY2UzWVlZek1xZDcyb2tPcWhl?=
 =?utf-8?B?T2M3VHVtbXdhT2dwWGUrUW1OMTV2SjdLMUZmWTh2dm44KzZsdWxjcDhTOGpN?=
 =?utf-8?B?d01idVpvUUNKcnlBN3VGUFI5dDcwYjNWU2t6T3ZyNjRqbENlOFFoL2NCeWF2?=
 =?utf-8?B?Q1hNQzYyZSt1Z25rbmIxZXdTVHVVNXhHZWFsazVwMnRZMWlybGtIa004eFd3?=
 =?utf-8?B?ODBPRlVDU3R4ajlIVFJJNDZFZlJYOEhxWFpmR3p3Z1Q1VGFEYS9WOUthdGRz?=
 =?utf-8?B?MnRPWnFQZmFUN2tHQmdxK2N2aHA1ZFRldW1lZUpieW02UzVRMjU0U3d4L1lX?=
 =?utf-8?B?WWZYVC9tK0NZTHdYK2NqQWZSbDkvNEpaTEJBaTd3ditjSTgzN2FOczFNY0hz?=
 =?utf-8?B?MnhlTjd1RHlFdlpHTGFwK0EzeVpObDhqdnB6bE5EaEtyc1B4allQR2IydWgy?=
 =?utf-8?B?RDhFUnJmYVp1d0VVdlBVMGpoaUgyQ1FuNEVzQ3J3Y0o5VUhGMVV1ajRVMmtT?=
 =?utf-8?B?cnMxdENMaFhiYUEvekdTUklMOURSU1Jha0JNOHJpU2YwMm9NWElIMVBtU1k2?=
 =?utf-8?B?N3JXYlFSdlJWOHdUdC9UM0xCL3ZkMm1BVlNNQT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0030;6:Zc15xxuEJ766rxVFUFf82AdraimsU5UZEHz3Wuio8N3HW068XQSLkraPczrrI4+ESETERs7W3RS8HlyD6Q0L5ZEubTuaEMT8TGXUutn06ing5IHHGTT1uxRPetFfY30r340yPKCRtN8GNb7Dk2n0D5ULb0HdgzyN+fv40oO9H2oYqlmXjCFuMT05fdtb22QGFNpJOo/gHyHBPjE575TfqYb1D7f9ozPTOEKvH1D+KH3ap5tiLntXSdFfTmQB/LK4MujFAGOwdaf5ZEiekVt+01QRro+sUyysNzfY+Es1afo7+vHt03r24tvdnlC13MphPzobrRMW64/Y+2y9gqInAXaadufAzL4v9X3+oe8tlzY=;5:u9gYq6QvM+UVYoEhDSG4iTUcPmcqegMOfsJf1UnnGDPC8TYlCoK67pj/nYnisq66LykbmbZiGv+8BlmjARemKT1FXA8M8BlsAmFpAvQLBv8chfwOjOr+E0uT9mQa43M5707j0PGUyU5VaDtn5t/CgKhOoUi5WnHNK01g2tlExmc=;24:oWtGe19/Ej/g5FZX+TYjvODRqWS9k3fUqabf7KNWzpnwOPvvJimaciLw4iVHGdKg552LgQFlPXvpZtvNxkOJJwQPs1iW5mR8d+SI8ceUgLg=;7:8XtgUji2380ui4HJYCsaxjM/64rmFamzk+ZrpogZR9TiAtTjBFCLP3veqrSZ+18FANJ6LR9D922VawrTH6k/8n/7DcEi2sOdaZ9s3lheB0PX3A+t3COLUXqEyG4TXYD0aHuG8GMFJo0QbnQoV5jGw82CxVYl514uhWxFpLwpumu6K3h4aHVgpWN7VBz56uzEPX5MQzBrp0dCGlZqS9UzszZrxJMD3l/hnK8izN6i98DrAoivvsAKsMK92L9iD5qU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 01:13:59.4508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dee9b734-2ad5-404d-600d-08d5677ebfbe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0030
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

Thanks for the review!

On 29/01/18 23:30, Andy Shevchenko wrote:
> On Mon, Jan 29, 2018 at 5:54 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:
>> This enables the i2c-piix4 SMBus controller driver to enumerate I2C
>> slave devices using ACPI. It builds on the related I2C mux device work
>> in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")
>>
>> In the i2c-piix4 driver the adapters are enumerated as:
>>  Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)
>>
>> However, in the AMD BKDG documentation[1], the implied order of ports is:
>>  Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...
>>
>> This ordering difference is unfortunate, and we assume that ACPI
>> developers will use the Linux ordering.
>>
>> [1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
>> Models 30h-3Fh Processors
> 
>> +       if (has_acpi_companion(&dev->dev)) {
>> +               acpi_preset_companion(&adap->dev,
>> +                                     ACPI_COMPANION(&dev->dev),
>> +                                     piix4_adapter_count++);
>> +       }
> 
> Wouldn't be enough just following:
> 
>      ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&dev->dev));

That seems much cleaner, but it doesn't seem to do what I need (my devices don't show up). I'm still investigating.

> 
> ?
> 
> Or if this increment is needed:
> 
> struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> 
> if (adev) {
>     ACPI_COMPANION_SET(&adap->dev, adev);
>     piix4_adapter_count++);
> }
> 
