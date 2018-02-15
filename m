Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946353AbeBOTBV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:01:21 -0500
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:42276
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161315AbeBOTBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:01:15 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
Subject: Re: [PATCH v2] rtc: isl12026: Add driver.
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180214005536.22739-1-david.daney@cavium.com>
 <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <4047b1de-40c6-813e-c410-543954190413@caviumnetworks.com>
Date: Thu, 15 Feb 2018 11:01:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0070.namprd07.prod.outlook.com (2603:10b6:100::38)
 To DM5PR07MB3180.namprd07.prod.outlook.com (2603:10b6:3:df::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b78dee40-e9d6-4af7-7d9e-08d574a67bdf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:IW3BNV1r+Wp1dPzazJPn1jaatp8zfMbcjJbSR0LJeVdIQmVh38cEIkTtSMawlGmJJBnDOxk7s8a1ggfeR/kiqOYaxNm1zXNBOQf5BS5/6mPDzibq6+ULu0tfD2cD7t80iNwwvThctWHGEGOEeovtkgj+MdpdbEqmfMN4P7XfZ5F5wjr1oEkoYAp1Ipt8cQZBNMcN5ZqU1ObOOMcKGN+6JsOmnHMnLTE4FeKxZ4BHvkqTevZUFMtCIyCNJRZzajTm;25:Cd4FiRJQBD7wn0EDLZtx4rZP4xPwxSUC2PhS90iA5XpOMeFDSB71R1iOPgOkiigZLEOf4+xl0bhQNc0T99dU5jIkG+LmpwYJXAIWBXoe9EgCMww01ziYjAQg8c7mKvYqacGUSOslTMolZwRuR4FWpPLN/HiB24hjYccSSQg2HeByyP9yoh1zpNVCUgZQ42Usj1rsKaP+TBj8WemVea9NbI3vVw1qz1bm4Q/TejIUBS81nk+VbK+D01kEGAOrw12jhetH8JxWsP11Ze8yyB5r5su2CE0Qq9h+085Is14lwe9IEWseDkjTdudIZxue38kCbUrAcjQsJYd5uMnyAFnRMw==;31:v7Gyt/gmgoSUUjnwtiiIRRmO9fkYNvGq78+d1KmhsTV07uXHXV+PqJrVsPcYFBAOrQW1s+qu62MgWGpWXwCuIV4VDOK55CA3BIOIexKU4OrthSmo5BLJ4Psht8KJvnBXjB2cAzyGS4F3bGOyEKDsDAn4gxzLw6pTNqvAAy2pBQkmFMAiQ1mzpXD/4FX4jRN6oCrdmn0ad6CRC+c1TrOyCUFuCRaJIVJBh59zuxUYdFw=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:RrtoJM/4q5TsMUNOaiPEMg63X6PEFSZQHmiFNWg1AdJ2pqEqoHpQc/J97JicLMwD0rdxsFVKBOE0sk4x4VEAK4FCD6tSrgXZ/BPAnRoeaQS3bhT3IW75vM5aLN7k79ne4DCTXtfzYIQCr0+LTiUdv0PQzM1QiTPr5yHVBUx2JWPQGXk1fGk20glxYQUMbptzDBDTSHRakknVdlIRissH3cDDQFblIr1IwAyJh8fRq0+41Ijv8SWf5kzeaJlwVMM0s+nvO3X5+JlCANAjITaE3kdgq1e3wfMPBMBmnm1AtGLFmJOQj1kyk0UdrlPnrYoREobL6q5Jt58cGp2kJTXklB+LcHeHr0MapyNyrtXhXNesu8UC2lERBNhsO5hg8qey5TNisWC+dlAEe3rTCfww1eGhI8jPa3/t1+KQH//v1DQUzJ0HMDKf1bsPnXcVySWSUpf7Os3RjXdvLbhibfy1UKvvZP1enRefYwnTMqHT6XyVrbHhvEKNFMNIh8UQFm0lwSQ03KJ+fSNfR2QLsm95rjiZJpRQKDtOdE19GyWHLHV6hA41WM11tvdVhqJGoQLTdc73noell2FsLcPRVLS+YckEtcGgpglamR4u3zNhs30=;4:9wGvGNQrIjR6G8vc6zBHF+Ko2R9CNA1BN/Xig9wO51bYKOH1Jd3iiL/h2CwBm5owQg/qjUzX27u5p6qd8gLgPj25WWmL/Ag6GQKHnmvB0srmPtL7K/miGMp2dIEN4LIlLYI7YJ3bTUOErgQr3UUw8mCAszO44X3xq7eyhfFx11Xnia10K/h71qebQ9TOmx7SXNmuLztORcgcrJdXa8l3dSygZzBr18X2EhCh50h/1PHlyu7w3lq/qD24YCYXixIz0LpSWdZwv4CEkRuE/196LA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3180115E61B5114E0F95ED7F97F40@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(2486003)(53546011)(72206003)(52116002)(23676004)(6486002)(52146003)(2950100002)(65956001)(42882006)(65806001)(305945005)(69596002)(66066001)(47776003)(7736002)(65826007)(3846002)(97736004)(6246003)(68736007)(36756003)(53936002)(6512007)(50466002)(478600001)(6116002)(105586002)(64126003)(110136005)(4326008)(76176011)(53416004)(81166006)(81156014)(31696002)(229853002)(8676002)(39060400002)(5660300001)(58126008)(54906003)(8936002)(25786009)(59450400001)(230700001)(67846002)(2906002)(106356001)(6506007)(316002)(186003)(386003)(26005)(83506002)(16526019)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzMTgwOzIzOjR1bCtGT2tubzZja3dVQlFJQ2xiNGUwNi9N?=
 =?utf-8?B?TkNBZnM1SVJ6VGFPTUlDSzFGYVJzNEFsK1B1NmppVFh2YmlvNTF3T2ZOZWVK?=
 =?utf-8?B?UFNxSWtWWmpZT0lRZk1TckhhM29HeTNXRlJoNEtRK1FtdTBhMUFDQmRSV0xB?=
 =?utf-8?B?Q1lmd0YyRndoMlJHcDZ0ZW1UWGdZc2I3UzdKU0JLN1h1dGlXbGNxaXk0VDcr?=
 =?utf-8?B?MDFVTkt1TU5zUjZwNGlwODBDdTVOMUZXY29KY1JNTWxtMlhDZ1IzcVNCQWIz?=
 =?utf-8?B?RVVFRVh6TmU0ckdLNmlwclpmN2Rab3psOHF2bGU0bWJGZEZyWDk5NEtXTjlV?=
 =?utf-8?B?S2JTa2VrS3U2YjhwWVgxOXhSSnQ3VVg4V2JYQVd3RDVQOFRFNnZkUzM5VTFx?=
 =?utf-8?B?cEZSOHV6RWVMemR0N2ZrNUx0Y0lobytSNnJuUWwzQXJGWkFTR2U4LzVkZFU0?=
 =?utf-8?B?eUJFUnVyd0dadk5jZncwN0FBcGZYZFpKd1Z5c3l2UCtzZWxaOURVZElZVzRm?=
 =?utf-8?B?QWJIWmgraGtjc2NuRHdUSXBJNUtmaHhUYjgxVWdvNm5rOC9lZmt3TDBqRTZ6?=
 =?utf-8?B?WnlCbW1Wc01KaGFsSEduN3A5VWVrKzEzQ1RpYm9TN2YwMmRrRVc3aWV2RXZL?=
 =?utf-8?B?MVY5TW9ZRytSeEZkWmNwdis2OEM2a20rc1Nvb0tqTnhyVVYyc0ZFdVphamFr?=
 =?utf-8?B?ZFFoNTBTVUorMEVZd3JlbGdqdmZrK1lxbnZjaFpOQmJySDc5dVdQWnJlb1Ax?=
 =?utf-8?B?OUNud2VBUUdPd2YxaDg2VGM3eGh6V0N2UzU5RzBvZ3dwTDVwSURUV2NtM001?=
 =?utf-8?B?MXVncmhBNTFsQTlGZ1AvVmJMaFhETlV3T2hOSUZrZk43eDZSRkZMbTVXd3RM?=
 =?utf-8?B?V1NsVE5HaEIzSjBHZTI1aytxVm5UQUJVangwWDJnanpZeWttQWNkQUMxSzBB?=
 =?utf-8?B?NHFaVUhud3pTUTdPREdwSkt1c2pyaGFXb3FON0I3SDhMZ3hDVUxNRmFCalIw?=
 =?utf-8?B?S09pTGRUaEpRM0lCOXpwQm8xMjdBSTBFTTZmNzkxZEttZXBCSFFORWV5YlE3?=
 =?utf-8?B?a1BYYmVEN1VOMHBrclZ5MHFSaThrVU9GTUE0aVJDUXhUK0pNU2gwMmJNWVVp?=
 =?utf-8?B?ZWJQRHFEUTR5V283YlYrM1YzbkhIdEtLVVR4bHNyeUcrZlZJT1pKc0UzelND?=
 =?utf-8?B?VlRjQ0FnVllYM2tTUFFidzRuSmdVS0FUc1ZZL2tseXg5NlNLdy84MlJ1SUtC?=
 =?utf-8?B?VmlRUjYxcWMxOEhkcmpOZkRvazlTZmZXZDhGNG52bndTeTBZU1RZTjYwa0RY?=
 =?utf-8?B?bDJHLzFtSjd2OUVLWXRZNkxEblF3ZEMrdmVhc25rMm56RlFMdWtvSVdsbVI5?=
 =?utf-8?B?SDhWdnYxVXFBOHMxR1BTU1lhUzlxN0l2dzR5QjlRdFhjdktQZFlaUi9iKzZU?=
 =?utf-8?B?dDUxNE14UTIvWE83dllwblRSYTRNRXlKZEQwblBSVUg3VTdrOHV5bDA4Sll1?=
 =?utf-8?B?TG93MUZIMVVSM1lkMkFYRXhDUlk1b2VtSGEwU3gzOVNYa0pGWHFjRmx3OFNl?=
 =?utf-8?B?V1hXdzRpM0ZVZkhGUjJVWFFlc1l1NjhUeE1pakkvTzFmdVN5enRkSW1vU05m?=
 =?utf-8?B?RE04MEZEWVVZZGJIb3ZIbklXM0YwNE9EcHpHUlJ4WkNpdFB5MFE2MHVycDds?=
 =?utf-8?B?RGJCSzB6ejFiVldwTVQ2RlFDaGgzc1ZJblF5d3dwYmVSN1hWc2xVY0draE5V?=
 =?utf-8?B?SENodHcvM3lWWmVjdzNNVlRtbVRnQ3BzeE1iakNRL2V3MmNkek1uTFVHcDFX?=
 =?utf-8?B?cGIzdnE1dnkxTWc4aStrdC9QdExudnJIbFlJcldocExhVi9JK0dXZHBqdGI4?=
 =?utf-8?B?Zmc5RVVvaWt2QTJ2Y1lOSEM5akMvUGxldHpHSXY3c1dwbnRCUkw2NUNIQ0pl?=
 =?utf-8?B?eXhheTROQ0t4M28wNGs2bFRYQUQxVUZhUkI1bW13TWMxQzdLQmNIZG1WT1Zw?=
 =?utf-8?B?Vk8rclJnUVErbGMrM0dFZ1VwcDlEUlpNQ09SQT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:UpWLi9EjsM5YmP9xy+28mtjLkLz/WdNkcEo6xZkni4YfQdOJSoum6SsRPAVlFyrShJK6KcC9GEVQR9gmbz+jZccoGX4oWEm7vwVF7y3yibDw8tQD2o7N+RD/PA0Zn01aCqTIi/e0Nr036xwE9p2YB58a/FkzLSJ7ORO49EcBq9kh75XrkKQsAUMIqn4hwXPyGateE/HdL3T+jrD4D4vLlOzT5/wDwe02ZgvyRY22gz38d2espSYUxoGdA7Pph/35UBO3iFoUUZC5konWfFi/8vdC8gl+CHjD7cgQHqdFyrnaogZ8jr7et+FPNaheAqvzWEEFSgV0K0aGOg0qcFRG1br1UL4ytjZfTEIrj85J5no=;5:tQRxBnyPPAgeSw0MQTMIBiFAmgHLCKqH1plb/3mewWBRat4N0eXaX4KnxFYGwW48OpPFnr0MxUmx9hes7xeDm+3C/umVcvcNLCtTTqoUlZ53dFqqTtd09bFXgRkflwVgDSyNqMuixqEzQbH152fvYmgGxg/EPbCsLcGeuIVUH38=;24:Vn1IcF37XwREl8bZ25daQ1osqXngw2g+aCodUtH1NSG+k/cxZ6lNu3ez0bMiP08UqdKUbDw0UhBIzcVV1NUh9k7oVqaDsiP1VgP2l/VoyCE=;7:6zr6kysyR+eQRIWahkkzssm2ONc/HNvtKj3HijQZ32bN1HlPnzXGeAPPbTAh58bvRbk4Bfr6BKmBY4VKvrg796vp6E2Aj2zNBjdVX6V2HD1HnmWUd6gzaPsIEszffHBybi6Go2/9m3/yvskkb8zi7FCeRk4JqViksD7U4YwHaf/jxYsFhRfcBRw3Bdug8FGf0MZcA+4B8qYS5kKCV0Ku70kJSoDcMHEnMyU1sLfTEqrIFqCSW4TVox6oOcKfxvKI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 19:01:12.7399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78dee40-e9d6-4af7-7d9e-08d574a67bdf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 04:45 AM, Andy Shevchenko wrote:
> On Wed, Feb 14, 2018 at 2:55 AM, David Daney <david.daney@cavium.com> wrote:
>> The ISL12026 is a combination RTC and EEPROM device with I2C
>> interface.  The standard RTC driver interface is provided.  The EEPROM
>> is accessed via the NVMEM interface via the "eeprom0" directory in the
>> sysfs entry for the device.
> 
> Thanks for an update, my comments below.
> 
>> +struct isl12026 {
>> +       struct rtc_device *rtc;
>> +       struct i2c_client *nvm_client;
>> +       struct nvmem_config nvm_cfg;
>> +       /*
>> +        * RTC write operations require that multiple messages be
>> +        * transmitted, we hold the lock for all accesses to the
>> +        * device so that these sequences cannot be disrupted.  Also,
> 
>> +        * the write cycle to the nvmem takes many mS during which the
> 
> What mS means? milliseconds? The standard abbreviation for it 'ms'.

Yes, milliseconds.   OK.

> 
>> +        * device does not respond to commands, so holding the lock
>> +        * also prevents access during these times.
>> +        */
>> +       struct mutex lock;
>> +};
> 
>> +static int isl12026_read_reg(struct i2c_client *client, int reg)
>> +{
> 
>> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +       if (ret != ARRAY_SIZE(msgs)) {
>> +               dev_err(&client->dev, "read reg error, ret=%d\n", ret);
>> +               ret = ret < 0 ? ret : -EIO;
>> +       } else {
>> +               ret = val;
>> +       }
> 
>> +       return val;
> 
> Something wrong. ret is not used after all.
> 
>> +}
> 
> Check entire code for such.

OK.

> 
>> +       /* 2 bytes of address, most significant first */
>> +       addr[0] = (offset >> 8) & 0xff;
>> +       addr[1] = offset & 0xff;
> 
> Consider to drop '& 0xff', they are pointless (you have u8 type).

Generated code is the same, but the intent of the code is less clear 
when the explicit masking is removed.  Never the less, since this seems 
to be impeding progress, I will remove it.


> 
>> +               payload[0] = (offset >> 8) & 0xff;
>> +               payload[1] = offset & 0xff;
> 
> Ditto.
> 
>> +static void isl12026_force_power_modes(struct i2c_client *client)
>> +{
>> +       int ret;
>> +       int pwr, requested_pwr;
>> +       u32 bsw_val, sbib_val;
> 
>> +       bool set_bsw, set_sbib;
>> +
> 
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-bsw", &bsw_val);
>> +       set_bsw = (ret == 0);
> 
> Which is not fully correct. Better to do

I think it is correct.  The properties are optional, so it it perfectly 
fine for of_property_read_u32() to fail.  If it fails, we simply keep 
the current value.  I will add comments to document the intended logic.

> 
> set_bsw = of_property_present();

There are no occurrences of "of_property_present" in my source tree.


> 
> ret = of_property_read...();
> if (ret)
>    return ret;
> 
>> +
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-sbib", &sbib_val);
>> +       set_sbib = (ret == 0);
> 
> Ditto.
> 
>> +
>> +       /* Check if PWR.BSW and/or PWR.SBIB need specified values */
>> +
> 
>> +       if (set_bsw || set_sbib) {
> 
> if (!x && !y)
>   return;

OK.

> 
>> +               pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
>> +               if (pwr < 0) {
>> +                       dev_err(&client->dev,
>> +                               "Error: Failed to read PWR %d\n", pwr);
>> +                       return;
>> +               }
>> +
>> +               requested_pwr = pwr;
>> +
>> +               if (set_bsw) {
>> +                       if (bsw_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_BSW;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_BSW;
>> +               }
> 
> Undefined state if no value?

It is defined.  See above.


> 
>> +               if (set_sbib) {
>> +                       if (sbib_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_SBIB;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_SBIB;
>> +               }
> 
> Ditto.
> 
>> +
>> +               if (pwr >= 0 && pwr != requested_pwr) {
> 
>> +                       dev_info(&client->dev, "PWR: %02x\n", (u8)pwr);
>> +                       dev_info(&client->dev,
>> +                                "Updating PWR to: %02x\n", (u8)requested_pwr);
>> +                       isl12026_write_reg(client,
>> +                                          ISL12026_REG_PWR, requested_pwr);
> 
> If you do explicit casting in printf() parameters you are doing
> something wrong in 99.9% cases.

OK.
> 
>> +               }
>> +       }
>> +}
> 
>> +static int isl12026_probe_new(struct i2c_client *client)
>> +{
>> +       struct isl12026 *priv;
>> +       int ret;
> 
> 
>> +       /* The NVMem array responds at i2c address 0x57 */
>> +       priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
> 
> Magic. Make it #define and put comment there.
> 
>> +       if (!priv->nvm_client)
>> +               return -ENOMEM;
> 
>> +}
> 
>> +#ifdef CONFIG_OF
> 
> Remove this ugly #ifdef. Your driver OF only one.

The driver doesn't require OF.  By removing the #if (which I will do), 
the size of the module may be bloated in the non-OF case.  If anybody 
cares about this, they can add back the #if.


> 
>> +static const struct of_device_id isl12026_dt_match[] = {
>> +       { .compatible = "isil,isl12026" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);
> 
>> +#endif
> 
>> +               .of_match_table = of_match_ptr(isl12026_dt_match),
> 
> Drop of_match_ptr().

Best to keep it so that the non-OF case is correctly handled.

> 
