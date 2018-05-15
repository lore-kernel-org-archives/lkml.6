Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeEOJjj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:39:39 -0400
Received: from mail-cys01nam02on0077.outbound.protection.outlook.com ([104.47.37.77]:38451
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752343AbeEOJjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:39:36 -0400
Subject: Re: [PATCH v5 1/2] clk: x86: Add ST oscout platform clock
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
 <1525859941-23654-2-git-send-email-akshu.agrawal@amd.com>
 <20362702.FCbsg9xPKv@aspire.rjw.lan>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <9f31fc22-b97f-0241-30cd-798ee03b2f1d@amd.com>
Date: Tue, 15 May 2018 15:09:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20362702.FCbsg9xPKv@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::25) To SN1PR12MB2367.namprd12.prod.outlook.com
 (2603:10b6:802:25::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2367;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;3:N3HzHOaD3hXGB4KsYDvSuIkS61kzSB/ibg07odvnfIRDsJOB+Pok4BSoHzeLyyzMCtcI/3Xk0pJFIqX+e7yNjkeXWn/5vYtCRta8VuhSCC1PvX0lwEiPfiAJlUIzEuIWJor09FdZMvoX3Ip0H4bHKaJcr5VIY3/d74u7paYjJPBCrWuNR24+BkhhoHSeeGYBG8DKYpe7cGivPYejKfqEDcmKjsyNc5D6jrdSJwHMnwscs5KUGxmG7pEb7RjHKGBu;25:i95xs8NhHGuQwQZUit3cThvw7MkYyyB49JywlYG3N4y2FrZGbKZ0s5D186SSD7MVDMuReD/N9HfH6VW6rFl/3y0EhkuVtpjnJLGc/I3EMt+b0oxZgqNUfHuYzr3eJGB+E/8H8LaofmT6Z2yys10B2Y0RkK7+wILvurOrvRy9AWY/4yCvbnq6I3p/NQKhYbkfun60U8T0U5CIq7XbmrHZnazPS+F/J90g/eNY9vN1egspBM9Gfi5oFWkvsWQnkmEghgJdVKdYUPPOhn1+q1FoJUEiCaQOJPuR+gZIXbNLeJiRfYxoQ4kJg2fFgJiOBJslcZRsBKxKg+gG3MKPtcAcTg==;31:AtQvnIhQPEDT25S9d19Z1txNXBvcPvXw+DDHGkwRCxFi3Pxrp67GkQMZg566FshguNM++RxWE7RfOQ6bE1DJDlVxkdzKYOn6LDzwjG+wxWdGPTZGo79Zub5+so0WbllKd1JaQD9HewERDZE8stH+cDj5jdJeHRZdgeH14VSASZIHI+qLnGZppYsBrghqXjAqiRoXgDZXQFSQzDduxaRFay51YDd996wmwelK0hIMvVw=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;20:Dx6rraL1lt63kmjjL7YIK8qyilavcv93z2/T+rs8mbR0ma74d1k5EsO1Ne0ycrw4jtmiMSLgWIL9/ojbWZE4kWxcchaTXIMwGdt8qHrvmGHXh9H/0AtR1/U5FVdn4nERImzUUrKBSJOBeZ/Q5JDsWHYt5O5d6c1tCvfPZcHM8gDKgNVAE/+G1ZUQzR/N0SRerzrI7EMYSEd7snuVZMGKjffy4yuUujVSGHRDpeI61mHsEebK3ZS+QBaSl/dsE0vr05dywLGCLnn0va4z/56jU6mzAV4pV/qObbv4ApfQmRx4p5ocFALEXsRljv2qlJaJddfg5cpfTUNF4Mfot3H06p39ClVE+3hfPdchqwdQoHQUVaEZrO9lxJEfhZa+bvMX774EBE0osZDKMDRT4FQhXV3KWDF2CGWYfyduS82jzHR6fnG2cOlUY3LOMvoh17CDjIBceJOxbHrEYPt3JERabL0FW3TeaBbT+ds8hT19u3eJd2zyf6gbbl84gu29Ztkc;4:MYCak8QOaA5uGtjsB/DcwHTxJUgUKuyZz4ojgAZVSU3ykNbUa1krrGrCX1igJfAsBr55csIceGPcyTL/Mqau7Sq7Xry000VklfHDhxewu3EMBk542Tu1Tm7Uo1vwS8Kli/J9IuW/csrmEW7w2IGluJnXXFVkXd92qDjdLTNDzzrKTcMo75zyben5VOe2+qvO40agKArfKbA3c/5KM1rNvZSb+OWwmR5na/3YAmRs2F8LKo5OZhlQPo4F7wX4medxSfx979kOCjiShGAi/LR6DQlsg4llWtOm+s2EtMMk7PEBfey3dXBlTX4P/8llVjOO
X-Microsoft-Antispam-PRVS: <SN1PR12MB236777AA8FDF8BF0AEADEAB4F8930@SN1PR12MB2367.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB2367;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2367;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(39380400002)(346002)(366004)(396003)(199004)(189003)(3260700006)(26005)(25786009)(956004)(2616005)(476003)(386003)(11346002)(77096007)(186003)(5660300001)(16526019)(53936002)(6486002)(446003)(106356001)(4326008)(486006)(53546011)(66066001)(65806001)(47776003)(6246003)(97736004)(65956001)(65826007)(316002)(58126008)(16576012)(68736007)(7736002)(31686004)(64126003)(8936002)(2906002)(105586002)(8676002)(36756003)(81156014)(81166006)(52116002)(6116002)(305945005)(3846002)(52146003)(86362001)(478600001)(76176011)(72206003)(31696002)(23676004)(2486003)(230700001)(6666003)(6916009)(229853002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2367;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIyMzY3OzIzOnJjK3RhSTlQNE8xMzhVOTE1bkh4YlhkNldD?=
 =?utf-8?B?WDJLeXRrcjZmZmg3VXdKQmx3STJEVFZLdyttRU4yWUFnWElGUE5tYWhWK0RD?=
 =?utf-8?B?K0hta2txQjZPN3NGZVNoNllTTCtVS1BTM1VndmhaZGUwaldhODV6dTQyZjBU?=
 =?utf-8?B?b0NtMHViR2lzcmY1a2NHd1kwaFB0NjFLUkV2U2dVMCs2eXFseDZORDRRVHlO?=
 =?utf-8?B?YnBvSkU4NzlHY3NQUWFmUjJxQk9hV1EzU1B3bVkraGlzUGdHaUlrcmQ5SFM2?=
 =?utf-8?B?WnlKWUJxZmlQVlhKUTVsRmpVNSs3WXllQzhMVW1wU29RRDdhc29ZU29DSVJB?=
 =?utf-8?B?QUg3ZkhPcUFzU3hkT0FDMW9ncXl5eXJNWVZsTTduTkxMc2M1dnBvVDE2SGti?=
 =?utf-8?B?b3pvUnBBSDhsb0RjbTFBb2NzZXRzVi93Mk5hTVMyMjJaMnBGaDdxQXRzY2dz?=
 =?utf-8?B?N3FOKzlHZkJtN3JOaGd4Qy9oNlcvRDRISDJqc2lRQXZxd0NURitDRzNsNFVM?=
 =?utf-8?B?ckt2TDlwMDJwVERMeGpnclNEYUJ5dmxPRGpQUlRsdVVoUHlqdDIvMXMyZkxh?=
 =?utf-8?B?Kzg3Zi93c2hRYjBWd0ZMM3ZRTmZVd0k5M2FJb3RBRW4zSjFpd0o5U1FEZ0FB?=
 =?utf-8?B?WlZDd2Y2bzUxK2FUV2NIYnd1TmpKV3c2Z3NreWVPSEFhUENoV1Y0TnFUOUQ1?=
 =?utf-8?B?R2VGMUNQYUVUcGZkc2ZabEg3QmJlT3hPYlNlZUxxS0FhSTYwYW9najQrRGQz?=
 =?utf-8?B?Yk5jL2pnZUZiVFNwWFhmQWhYYW45U0JubGFUS0R0SmtibzdVOUY2a0tpWWJv?=
 =?utf-8?B?bVZUdXFxSG81UVkxQkYwUEUrUlh1WWNhbjNvYkhtTkUweCtubmNwZzJqYzQ1?=
 =?utf-8?B?dVl4YnAzQWc2cnZRR3dGbG52STN4eWVBaVN1dmNwRG1IaXJ2eFAyZnRvTVpS?=
 =?utf-8?B?S0pVVmlQM3lRcjVWaktxSjM5d2ExemlmRVVhNFB5bGxsUE5xZThZTmFyMUQr?=
 =?utf-8?B?TFRxV2pJbzBHQlI3aFM4SVd3WUZUY3RKZ0ovckdKSlhWbEJLdlRmQ1BpU3BX?=
 =?utf-8?B?NmtkV01NU1ErNy9GN1JnVDRyUFd0aUpubmczaXZ1OTczV0Z4YlJ1bXNpbjcy?=
 =?utf-8?B?T1dVbTM5VnQvNlk2b1JsTjUralgxaGRjN1ppN2V3ZUNkekF3WnVLNURSZGxo?=
 =?utf-8?B?dFdQMkk1NlRPVHVvSDJtWThIUnlXdXJ6UmpmUSs1cUx6Y21DdTBkRitEaDlx?=
 =?utf-8?B?b0JVbW1TaTloZTlRSnR1RXFjV0tCWiswMHZ5c21HNzNxVE9jOFU2N1F0R0ta?=
 =?utf-8?B?MzRKcEVaNXAzUlFrU2RQc0UxbU1MUFpFR1pIWkJQK1hpNmZXbnY1S1p0S0Yr?=
 =?utf-8?B?dVVncG1oVk9NZzFxeHFyT0VralVBbFEvRFM1Mk4zdDZhcXQwMUw0ZzhoN2ls?=
 =?utf-8?B?cUdRUnhsYTlQdGpkNHM2KzVobVhTckxJYXE0TFk0M0taVzMxcFRYN3drTzhW?=
 =?utf-8?B?Mk9SME0xaVBWTzcvM2g3SjMrZW1GeHFSTU5qOC9kMVAydnRraDh5YktmR3hI?=
 =?utf-8?B?OVNQUFJ3OUkwaW5ZN3JxMzZzYldaRDQrb1JGWmlyZjVQZnFScGxjdEtqZW15?=
 =?utf-8?B?dDNqN25yVHNKRUFBZkl0dU1rZWlTLyt5MFFiOFhNMXpwZUwreGNNQldHQ1Zh?=
 =?utf-8?B?RlRGRlFINmJuRnArdmlhejEwRS9VTVcrdWdEdk85T1EwNVFnVkg5ajk3NnNn?=
 =?utf-8?B?Um45NGlscGtHT3NqN0h6KzUyMTErV3VmdVJTNVJ6M21GdW1maElSelltQzRL?=
 =?utf-8?B?ZjZab3Y4b1dONnpUSi9pRVMyYlM0R2l6ZlZCdEQ5b2lFSjE0Y0tuS3l4QWVa?=
 =?utf-8?B?SUZ6RnhmckR0NFA2VHYzbkhUNmRyVkhVbzl1WFJUNlR3RTlwNUxydlFpZ2hH?=
 =?utf-8?B?U2RrZ0tjc3kyWHFiZDEwSmprVEd5cXpzc1cxSG5sS09JYmVZOW5FVjlYYVRq?=
 =?utf-8?Q?FP46Ub?=
X-Microsoft-Antispam-Message-Info: 8Au+s5MxVIOSVtH3gQnss4dQ4G5ccVVBB1bLXr9DDuutQZOgxqWi95XlP11B2tcXO+i4HoMBd674jhrecLkhsauRB2TsrkvU3gUSW+v+MGxmiJht/UH2RE3AVUpf8AHSs0THGIbF9eqAg1YeVN05bxwqB9othWSD3itNDCGRgbl9ZvMcV1zj+4jy32rOaAFx
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;6:GBjOGilnJtgzShgru8H2F0ZFFvM60oG4QhiFqA+ZsGiJ0Fw2VTzLXLNiAT9+RabkuOvTxv9HVL/mtVj6zaxPHMYdx7iHNKsDyCZMw52YwxwoIdwzv2RIZoePy71QSoFZtVvSM53Qktqv0YRnc1JDyIu+dHHE5yiBdht8aeZOzlbdVlEumruSWbefPIefO1C+VIqtNTit/JUjS3bRkgbsXhBb0mHI4Nn5mKtfGTiu4BQJ4P6Luwa5hja/YCTbNUX4PvV5Il7hfODiIFysU8049lGiFkBQOw8TGfT1Iki2eDlcO517vDIYPlQjQroDBweZ/+lZWwA6gSRhAz0jj3U9gVQqf1iUxVipEUlE4wHToYeUPxDeYXmAEM26dFXIeZGhgftYdGADIkIzTAbsE7EXf0iaatEhpKOWQIHTMHGTK6974VRZH2LNCvnrfxh8sXQGc+6JN/4ShDDiD3w4aGNRqw==;5:Vv47DTkfam1zs43FXQWapDVSvqdUaufL00cjmDF5O4U3hXhLYo1LUnLTbcEljuzXLe/RH9ikf9+zPpz9bS3V2fHQqVMYrcY+CctuJMlX+xeprn7TFJx7XEMU6BzL3wEOs8AUbPERQ7sDg253VHjMKUKoiUFuIk2gvGB98fQiPbk=;24:5k6sc0NdLMqTxXUEqU0I1GPJhjr/4b9UWN6KWKcfzIJNPYnqDyj+Ad0bcyQaV7LN3P+Y6Hniwfne4WZ0VMyyh4OuXijUrZDNHXYooKkJrLE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;7:Dnk1r4CAc/qoBgjZECN9y0rwDvl9KcETTcS5Q8fbR1nK97/oTNG1ftZMkgznQEIwsk4uFsvAOgLJw3tGWSr+WvqxgQm7fbhavg9vb6A5UphRPaDsro4wo8IdTQBJ8fjgqHgoIQSBPkONnyD5T5VjNlNWBLxL4kTaOcD+rVNjjLHm4Ykl0OrPgQOl4YCt5Zc1xcZxTN0KxMmgQJR86wWJLfN3twOON2qBYUUSeKUg4bIAwaGaBHrx4rqHsiyOBIEC;20:zCXI2hyh0g4aVethpaCPjAljUKuUpDujreD3qfhxpSNW4Kr2ZS2iJOcNopj+ZbUnIc/ZWPIlxfafvBppWkPHn15PirTKYpSjbsBykU1Kc7eSL2+TyOf7ierdDj6/l8J9KIBmlF28ZpzOeQmOlNVIXQgpNlCVcMlqwhQfqJkM+UNxspZj3fbJmc5sbGNAJvY47Xyx/0pWXXQvEc6dRrSnuxyvqGrUnhwJS3aq1Hh/tDhraCCY8AgXfAeIOASuLC6l
X-MS-Office365-Filtering-Correlation-Id: fd026f69-8f1d-4a63-d1f1-08d5ba47c3bc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:39:29.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd026f69-8f1d-4a63-d1f1-08d5ba47c3bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/2018 3:02 PM, Rafael J. Wysocki wrote:
> On Wednesday, May 9, 2018 11:59:00 AM CEST Akshu Agrawal wrote:
>> Stoney SoC provides oscout clock. This clock can support 25Mhz and
>> 48Mhz of frequency.
>> The clock is available for general system use.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> 
> I'm not sure if the Stephen Boyd's comments on one of the previous
> versions of this patch have been addressed.  Have they?
> 
> In any case, if I'm expected to take this, I need an ACK from Stephen on it.
> 
> Thanks,
> Rafael
> 

All comments of Stephen Boyd and Daniel Kurtz have been addressed.

Stephen, if you are Ok with this can you please ACK it.

Thanks,
Akshu
