Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeA3BoI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:44:08 -0500
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:14557
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752131AbeA3BoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:44:05 -0500
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
Message-ID: <56310e2c-eedc-a71a-3247-d418ec10052d@opengear.com>
Date: Tue, 30 Jan 2018 11:43:46 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZ6fXJsRAj=4ozhLe=X=yL8y3pBVk1c4H7_niQ88Gfhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: SY2PR01CA0022.ausprd01.prod.outlook.com (52.134.186.34) To
 BLUPR15MB0019.namprd15.prod.outlook.com (10.161.124.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55af90af-a4d1-487e-d204-08d56782f127
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BLUPR15MB0019;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0019;3:nzraFUOpKGSiYWjs5gbzwWAJiAA0NqrpQaGtyW7TbxOBS6bGrCLAx3i5PVitEPFTsCYmsjDwSOWUwYQKN3vvjAtuKy4QNxg95zLFAWjCnzZaVe/hEBdoE13M3N69FIj8e0Cj2VRB88V0sL436YixD7ymT+CxBV+240udqqUc1opCCS94HaNnNN56mq+8yGVZyuCSKWNZQd/n+jQkOCYjTxB0+/MExVTlXVFhhiXmVmZ2yfuS1Ik6FgI/ZvH8sTiA;25:uCgiRGrB6Xyg8Wexm5Uhjxp3lecyyjA68cb38Y1Nstbrm7CC1TY6+Fi4IWzN9qoB6Uise/WEJCJmqgIe6L+UzdabtDEUzr7V3v1Mf2A+0fSO7sjOUx41J9aEi6e4hy6ACo4qnGzcDGDpF6pqnKCL6cccE23Rp+rk4U+tW6jmckJXRgeB5jUJJ5KO5suWJLz4Tqtbwa7CbQGPT3W2kq1Z+pKIoPG8MpvNm9ElkByXfeAgbQ0V78jycV2ku+3PHtD5DJZx/Z9iaTCsdVUcajIvo88GVfw9TVvV7mcOkp7PIjNYMjsUasgkc7ymw6aWMj0u/SVJ38j4LJL2+uaJfgw2ew==;31:DA9AfAd9n/XExiLMyJBFwg1tp1IkdyD5oMkyE15nYrILVz2oWiWWT2LshoVUBxqhJSn80w4a+6MLobdsZMJ+63niJKlPo3uuaj+XuGT3+JxQgeZFlXq4kPmVPaMGP7+HK7P4AFF3DV4hDN1ozXlIfGfSbZZsvzJmHuZEk2VyVWzC7yN7LRyaK6BO0C2OSIsrH1s+Ur+Y5mB0BL9eaLnkMyGpbz61uqt2WQp9KhHMUmA=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0019:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0019;20:nP3m7AG2znppvNZNY8oTKISIELMfccDFba82Zmnzr7Rvc1940eH95U3NiCECKsZzebS3LuhTPARj1WQ7WDZMCWD4ovg0s0j8b8veagjDJhQZ9gNyxIvXlusjitNm4vJ7nCd9Wv4RqYeY/mTe02GtjTSQo5MlECQ6D4RaJ+htfds=;4:M35n3b0BA7/AF4JLmLuBGXif54B/DFMaWHKFA25H2QJcJiCV9oiCHkbgk0xVA5FXski1KVs0M+BCHLEiEqsQXV4UpegiLZUQQ0jlcl2K1FYxSyl5zyn2ge1uE6UegyA5MSd68Wx4uxqGUGW8ltOoBnKt60QuG26fzpadhwsaIeXhGhL1PvFH+3B7Mrss+qEzxlusKiWu1riC4zP7W5ocLdBK0AB6PPIAlvMnjBmVrEn4CJEKtHx44cfB1AkZbvMKekLuUkL+gS+X9zwq22tyCw==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0019865D24E1E0D4A808F9AAEEE40@BLUPR15MB0019.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR15MB0019;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0019;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(39840400004)(376002)(346002)(366004)(199004)(189003)(4326008)(16576012)(52116002)(2486003)(105586002)(6246003)(117156002)(8676002)(52146003)(76176011)(8936002)(25786009)(23676004)(16526019)(81156014)(81166006)(53936002)(26005)(386003)(68736007)(54906003)(53546011)(58126008)(83506002)(316002)(59450400001)(90366009)(305945005)(2906002)(7736002)(64126003)(5660300001)(2950100002)(6666003)(6916009)(65826007)(39060400002)(230700001)(106356001)(36756003)(229853002)(31696002)(65956001)(97736004)(66066001)(50466002)(47776003)(6116002)(3846002)(65806001)(31686004)(77096007)(6486002)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR15MB0019;H:[192.168.254.67];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjE1TUIwMDE5OzIzOmF4YVBVUkwvdmVZSXZ0YlFFckZnYUcrR3ht?=
 =?utf-8?B?MktiTmwzY2ZXN3lQbmJ1b0FjbFJZUkU0Mm1lKzFReEFTYnZVMUlyMmU0UFpJ?=
 =?utf-8?B?NXFDQ3kyck9Dc3M5ejA5ZVFLU3E1bmdzZE12YjZCNGdVWmFtcnBHYWdnNlRV?=
 =?utf-8?B?dlRlQkdERXc3VW8rTzdmMUVTRWhlOEVZY0p4N0I5UjU3Mi82TThLMXJWb0NX?=
 =?utf-8?B?L3Y3U3NjN3l3cThkZWhOL0Y1Q2psWHl6UUdpZEpuc3ZvNC85Z0tWdlU5dW1v?=
 =?utf-8?B?cEtNUmt0WUJVY2VUc0pVTmVoOVpGK0xHL0ZqdHRXNFVCTTlIajR1ZlRvWWpR?=
 =?utf-8?B?dWdaaksreUxycTJVUm9Xd0pXYlo4NmFReXl6elZvMmdlWEdPWUVFcUNGOTN3?=
 =?utf-8?B?WkFSSUZ2VzFjYi82NEFBZk5QTlNCcnZDQnVQSFRRODUyMVFSdWw5Q1EzamNG?=
 =?utf-8?B?RnVzUTkvRmFpSmxiYU94cEFIcGR0NGtzZU1FSkhXTWphME9SZ1hNWit6TnJR?=
 =?utf-8?B?MmdnTU1zTE5selppNHJiNlZxVHU1YjlwK2RqV1Npcms0NkdzSnB1Yy9ncFp1?=
 =?utf-8?B?dG12eXkyNVBRZlUxY3N4cFY0RFhyaGF3L2M0SWRkYTVJckVUcTkwOG9KczZq?=
 =?utf-8?B?N0lHWjNtbUNyVGt3LzZseDliOURZblN3OVRyWHoySnh3K1VSVURQT0drUTcr?=
 =?utf-8?B?dHAybk5MWlRsOFA3cWlXYmxPR0pFQ3ZMZndMMFRFZGs5aGI2V1ZzS2VhdEhs?=
 =?utf-8?B?WDJKckEzNDJVclo1bU55QlpKWFc4dDZkaHpYYnJHV3U4ckxpVGFvTjdqMGdi?=
 =?utf-8?B?bFYrS0hOOTdQdndoNzZzeFBOTUc1RmRYM2pNZEFXYWQxczBreUIwYVVhOUUr?=
 =?utf-8?B?WjRrbVRlRXZDZUxDaWIvcjltcWM5U01PckpVUitSZHBCSmFCUURUdVF6OWRG?=
 =?utf-8?B?U0RkWkQ4cDFHUzVoaVVONWFzTkkzdjFYcWpveWtuUG51RmlXaHBBamNBR0tK?=
 =?utf-8?B?TkZEQTFDRDlLUERxRHJxSmEyTFppbjBUUVVqajVuTURMcU4yclZubUhka2JC?=
 =?utf-8?B?WEpyRkVzNVFtaUVYZTYrUCtoQnFQWGN4OFFtcktEZFMzOWNXN0NFTnFrQmVY?=
 =?utf-8?B?RkYrR1E5Wk9CNXNEZzdTT0xlNEx0R0tlM0hHRUFBL3hhYWlXQytlbG9OaCtv?=
 =?utf-8?B?Y2o5eHVyeWRQZkFCMklTRm9LczFGaHBJUGpBYVZwTHlUa2Y0dDQrbk4wMk1Y?=
 =?utf-8?B?cmRVL2g3bnJpdUpyazZDUkw4SFJuTkwwV21HYngvODArVHZQSG42TFB6SnQx?=
 =?utf-8?B?SGQwSkw3VkVSRjdxTFVkSHRCTkRJZ2psSndpVlFZdWE4SXJGanVKRjhFUk9O?=
 =?utf-8?B?bW9WdXJlZzNwYnlvVEFMaGN3UEVPVGxVb3hNbEZyNElqNE1wZnBjaEF4bkFN?=
 =?utf-8?B?bzg5V2lDUWkyN3dQVk4rMlp6WDJVZmlzK3NGeFc0anlORVFzOGt1ejBXbmQz?=
 =?utf-8?B?ZUUvNm9zNWhSZVNCTW55SndLSTRGTHpwTzN3OTd4R1NSNm9CZDJ0LzU4MjFI?=
 =?utf-8?B?ZGt3RytzU3VoeldJeUhnVnY5a1VnS1ZNZGNUNXp1SFhRaHFyYUhGZWJTTlNu?=
 =?utf-8?B?TVdHdzUreWNpZlUrWm1EQ2FmTTVUTmFtYmhUTGtnN013aU1ONGc1Y3RyUDRs?=
 =?utf-8?B?MXAzTXRaWklFOS92NTV2OW53Q0pNZldtOWptcERvVm03TVMvUVBlUGxxdThC?=
 =?utf-8?B?VXZJTU5CVjhCWE9sTWJCZUFCUi94NklIczBNMXAzMGllNTNvc2R4VER5Qm5N?=
 =?utf-8?B?MnFhTWZYWEdjM25RRklqdThxMTB6NXpnNUd3c3JqM3NFMVBjdm51QnNuVC9v?=
 =?utf-8?B?Wnk0eWgxU25YNC9ieXNBbUd6aHlYdGpVaFBoQ1FudGpXcFlMblZ6SGF5bXlG?=
 =?utf-8?B?WlNlVENpb21MMWVBV2tQdXpSR0ZIdFJXTzQvQnMrQ3dteUw2VDhldDR0MXNI?=
 =?utf-8?Q?j9MGth?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0019;6:IKB/ikJWrOi6q9hvQIgjUu1UzYK9PdReuSyV3rXj+AxFwRSSHEGVUjxYev+R02h/VWRjBAwwCEUK9eML8iRagWOMgxIrI6Qn8tzpSCyGIlkTFHnpQKZ52qGkxaQWQ+qayAfzU6otaJFj0eE3PmfkQOJj9YVsfEB3aXB6CFpQikYUDV5eHhIIJuCBbCKU6YvcNZqblmKvC8ZWY4eKICDflMY+hrMwgVpb3+w2f9stMJQjkHn8jEnOBvzyrIdKj9p+orfUv2B9xVIilCAVPDl/k44/MOCaBV/SUr2jTWiI1ZK9NP4VnWwYHCkLe+nBkXE/dm+ITDjeBxdgwc0SGSagc/X5fXKeTrwviKrWS5o2++s=;5:eQHkk4yYNqwapz3psWU3nmhVcthR+a2P0Yvb3s6XRtu19SB7Y60E2KsrJuM2d1pMHk/2UTrqD560pM+fw3GE5h4Z6ngVGxViaGiMmhvleAx98cJyQOV0NJtdhqXaDWHaJSsriCzBMlfc/PF/15lQj+N0mEHUU14fFl9U9/9C1ng=;24:wHBYbIYjvMEIIZHSmgIZ3Gahxlo20Diu5LnFbZXJLDD3FefQm5lFIrPnosWQR+ytX0Rc4G/nHQTAqbpnlOFrnPlM78NatxZ/hyuvUCrTMxs=;7:4Vr6NQ9yp2fDYh42bmV/xRe65/edUzVWEaJAK50O70hTe103JZkIlHilazHS3BKwyoxN5oXy47uNdz+XM7czWRcIhZkfaexqo70JyBAPROAfOw6ynS9Upqg1NvWBmJUbf8vgLvmG2z6qu7eK64+asBpoHIByYF9qBqmRJ6ZpgjgXYkfvhL33ZTBMky1mkPUVdakXJ2jnDcambk3loaEncv+l+pJWV4qR8I/sQOopgSxSMjohBRDdFSkGAWEs/jHP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 01:44:01.4933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af90af-a4d1-487e-d204-08d56782f127
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0019
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

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

In the ACPI DSDT, I've modeled the topology as follows:

Device(SBUS) {
        Name(_ADR, 0x00140000)
        Name(_HID, "SMB0001") // SMBus CMI spec uses (invalid hid) "SMBUS01"

        Device(CH00) {
                Name(_ADR, 0) // main SMBus adapter, Port 0
                Name (_STR, Unicode ("Main SMBus adapter, Port 0"))
        }

        Device(CH01) {
                Name(_ADR, 1) // main SMBus Port 2 (Port 1 label is undefined)
                Name (_STR, Unicode ("Main SMBus adapter, Port 2"))
        }

        Device (CH02) {
                Name(_ADR, 2) // ASF adapter (what Linux calls 'aux port')
                Name (_STR, Unicode ("AUX / ASF SMBus adapter"))
        }
}

That is why each piix4 adapter matches a CH0? device that is descendant from the SBUS device in ACPI.

It is similar to the topology shown in commit 8eb5c87a ("i2c: add ACPI support for I2C mux ports")

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

Thanks!

a.
