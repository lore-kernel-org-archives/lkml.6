Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeBZVWA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:22:00 -0500
Received: from mail-cys01nam02on0066.outbound.protection.outlook.com ([104.47.37.66]:2624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751608AbeBZVVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:21:54 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
Subject: Re: [RESEND][PATCH v4 1/3] i2c: piix4: Fix port selection for AMD
 Family 16h Model 30h
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC"
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org,
        platypus-sw@opengear.com
References: <cover.1519601860.git.andrew.cooks@opengear.com>
 <be68c29f603153cf047cd893c6b9d6423073632d.1519601860.git.andrew.cooks@opengear.com>
 <20180226085837.GA15131@eros>
From: Andrew Cooks <andrew.cooks@opengear.com>
Message-ID: <8b8638e2-18a2-5865-4e7a-27092b053b1b@opengear.com>
Date: Tue, 27 Feb 2018 07:21:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226085837.GA15131@eros>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: MEAPR01CA0048.ausprd01.prod.outlook.com (52.134.192.36) To
 DM5PR15MB1211.namprd15.prod.outlook.com (10.173.209.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c65eec69-142c-4bf8-5eaf-08d57d5ef456
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1211;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1211;3:ihWHFmnmdYBmWbmzAIEw8H49/GBEps7w0lVtb0Vf5oFbNq6v4J2KIp3ONfd8a5iKqYw4FMK08VOVXQMYSkhxCigEsoaZjOy24dk5MivVygvIeowsjmxvu3rJB+B8ndz7Y0KeIeFjYMRFQxnT4QFapinePUllq1zABlWcFoTbne40wCAjfuwrU/oh9XyXUAdBPafX4k1gBS41d4s1EfQoPqroFreBOHJf0KPoofm4EC0Sl3porNTt83Dq7c7BbJLs;25:3gwbOIC5KGRfEPFqKw1kQKx7zYZTYg2gRQ8NlYt5mcpsgvkpLluAW8FzNCOwp2R915oYhj+vtScpNh5pBng13rW29VmWax6CWR9qMGGqOQfoolTBPRFm+2N92OtfyUkp55qNt1oCKpAlR+x2xA3Bm4UPyPNOs2T+kdbqMmuuJgIJcrfekc1V/035PIqvCB6Z2uJAQxcLOUxfFizXFC75MmB5dQ5th1t6N08XxCoPg34ICuh40gY2jDuX7iLckpbPyYjWZnM2z15pOjz68Z72Yd6gO60zLG+U19kXI02mh7g4/wsVkyunKCPV+7mm9VzqoRLkFdyHR4fbHP7wHo6BbQ==;31:eWkE/5huu80a3COELC7HHnETnTV/BBRqMsk4sZ6bXAROnc3jrskznJVyAxcb92BUZkP9LUE5ykVctiDSR0PhnfTawPVn+DmpLnabVzhrWrunpQ7hCzN/Kimr0MZZ4+cQt0RxTfHQR4BbiW0Mne6+GCNGa+Zibdq0L2F/r0kChh6xCxxFcc8QcfTAUoIXDs5zzw4A1HIFjgoaPDOSHHhI97Vma+9n2P7QsFto/Y4KIeE=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1211:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1211;20:IZcdR2JSVYE0+9AWmVlwYjQbuH3Tf1RC5VYzq5Vk2bIfv3cC/3NDDGAzwfkFZfuqJE2gJdguXHqBasdehnRIEu+yq4OOj9Aq6KsEiR+itlfBfIMy/HyEun8UeKJ3LibEEOoCinqjI+0va39fyGvnlZ0jU82XAaLpLic9bKyfuoI=;4:PB/uyvB6pletbE3jxT9/MiRs1Q2pYCtqoQkA3Mwew/IQ+uBNZ9F6wRskkKgI3AVAJajYRqAIstfF3wH9WQBq1g4kp5Wz0k0Ixj6O87dfIwYqlB9ciIMIWH5a+5YiFpRGgz9nij5xGRtys18LFyIPAurabAhwVuaynKNy13SI4ub9G0oIQAFlkA/WC9MApnhwjcsI2+yNnRBPsBsHdfJF/+aiSbA2VQD3B4GcVFF8vv1icvMDDF9xiz/N8MoH2zjgg9IkdcsKWSZNzunlUoGDaA==
X-Microsoft-Antispam-PRVS: <DM5PR15MB1211617BD69021D3301F15FDEEC10@DM5PR15MB1211.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(3002001)(6041288)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1211;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1211;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39840400004)(366004)(39380400002)(346002)(376002)(396003)(129404003)(199004)(189003)(2906002)(31686004)(478600001)(117156002)(4326008)(64126003)(305945005)(31696002)(107886003)(316002)(50466002)(68736007)(575784001)(7736002)(86362001)(65806001)(77096007)(6246003)(6486002)(65956001)(106356001)(66066001)(47776003)(26005)(76176011)(53936002)(3846002)(90366009)(6116002)(16526019)(36756003)(230700001)(105586002)(52146003)(2486003)(23676004)(97736004)(25786009)(229853002)(16576012)(52116002)(5660300001)(65826007)(81156014)(6666003)(6916009)(8936002)(2950100002)(53546011)(8676002)(81166006)(386003)(58126008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1211;H:[192.168.254.67];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjE1TUIxMjExOzIzOjBkSlY3NkdvMmxXMmVwcDJpNTB4d3ZSVnRs?=
 =?utf-8?B?SUZmVENqUlIwbm10WkZPLzlCZzlRV0JBbnMyU2t2L2JObjVLenU2TzNqcng1?=
 =?utf-8?B?UGlRYzFVL0E5S21pdHBMUVZwS3pDWElKb1NkSUYvRWpUaGwzSDhoaE9DS3JC?=
 =?utf-8?B?U1ZOT1BhTk1CVUZEZXI1dmU2R2xaSnZUWmowUGhOUG9CeC8zREdIYk4vdm14?=
 =?utf-8?B?VlJQd2huRjdOYVRmVmh5UGM0NkVyZjkzbHo5R1ZoUHBab1NhT3VSWkR5WEk5?=
 =?utf-8?B?NGtNRnVvcGttWFhSdGt6OU9wb1ZVekVxNlhpeUlhOFpBZVByb3hxYmpOdW12?=
 =?utf-8?B?eFUyeXBuRGp0ZmU5V1VJSi90R1owTG5PbFAxOFBKaUpHemF2MnJGN2RRbWJz?=
 =?utf-8?B?RnF2OU9xWlYxVVMzZERxelU0c05ReVdwVEVjYlBwTXNJQXAzWDczUmk4U3hr?=
 =?utf-8?B?aThtaDI1UTFWempJMVp2OGp0aVpyRjNKSEk1Wkx1T00vZEhvb2NhUStIOEdQ?=
 =?utf-8?B?ZDRQbXJLSWRqSlFDTTdnOHduV2FDVXA0bm1ZVVBxSCsreDlrd1VCcWp1aEdQ?=
 =?utf-8?B?MDkvQlpERUhVN3ZjeHo0RnJKMjZQNXpNU3RKS1oxTGUwbjVTcjBFU2xqL29D?=
 =?utf-8?B?RDNxVHRId3lGTkcyU2VJcXc4NGpqOGJ0QWdZcUdDL3RtaDNka21TWWptWWc3?=
 =?utf-8?B?ZkRyNnpRK0dtTjFyZHJjUFZWL0k2YmlXWW4vNlhxUlBpSWo0RjRDeGM2MVJv?=
 =?utf-8?B?Ukt4Y1AxdkYwU0hvQ2JxNnV0RWY0YkliV20xVUlJSzBQOGZON090aEJ2L2ZI?=
 =?utf-8?B?QnhuNDczMUhISXlocGRRN1lyUmUvN0hDRjNvSlVQd2xFenphdjhsOWtaRUxo?=
 =?utf-8?B?ejR5YkZqTVVXcytBOU53bmdzSkhHYURTNzVoUndZbktjYWxaTWtremtrc1BT?=
 =?utf-8?B?ek0wMGRtTXZpK3pPZ1BPbWZMRHFaR0VDOEhZRzFVbXBIRy8xRHQ5bjlMajNY?=
 =?utf-8?B?ZVNiU0llbzh2cmxqdllpTjFWcHJXdkJoQXFQeUJGckVaWGo1UE80RlVDN1lN?=
 =?utf-8?B?VGQ1QS9TcS9OZ0dRR0kvaHNpWjJqOUk5RVo2Ly9BaDVrT2EvdWoralVoNlJ3?=
 =?utf-8?B?WExXVnVDOXN5T3YxcmtudnpTK3g1aE5qb1FIWGxoUjdGejhIQnJqbU1YNUcz?=
 =?utf-8?B?ZGw0TCsyUGZSNHVxWUVZMlhhZVFuWUkvVHgxTURGeG82TVM5c0U1SUQrNWly?=
 =?utf-8?B?QUo2U3M3V1NTY25nTzdxMmNEam9RSk5mOGdKYkVqV2lqRURNV0tJM2ZRRFFr?=
 =?utf-8?B?MjVxdDA4UE1lMDhMdElXLzZuQURxV1VHT3d1OVlOWFRvRmk2OC8wL1RWTVJx?=
 =?utf-8?B?NmFsQlNsNWEzV3c1ZEdBRE5GS1h3M2IyUXhtblhOMFk0bnQ2VDRSZGs2OGtG?=
 =?utf-8?B?aVdsVWlYZWhCajU2OVBGLzg1ZFRJb1FRamdobEJzamhaVEU4YkpXUUxXWlgz?=
 =?utf-8?B?TWh6cEdrc3hPV0pWUEw3YlpmUjI3dXdpMG1NS05udVRpMC9WR1B1WFNOckVJ?=
 =?utf-8?B?ZUlJK1Jsb2Raa0pKNFR5VmJzQ2wyeEpqQlFYWUVHOHFHTngzSHlCdm04eksr?=
 =?utf-8?B?M2VBS1d3VjgxU3JQL2JqczlSdFo3TlVxcHppaS82U241V1FkSlEwRnJnZ2Q2?=
 =?utf-8?B?dGpwL2tlU0IyR3VuTktBdi9sc1lRVGZBbG9QS3IzRHZiTjUvUTg1czlwUCtx?=
 =?utf-8?B?NU53cXNMNXVWOEJYNzgvODlVbk52Y0pFWHZ4Ky9uNGhXanFNdFFqOVJNRktE?=
 =?utf-8?B?WWxzUmpGanFybE80cUhzZHBtVGd3UTE3NWpLaUhKQ0NLUFNZcE42MnFpcE43?=
 =?utf-8?B?eHNqOE04NjU5SExDZHFML3JaSGFEbnJuNHlwaGY4VzdzNExra2N5Z09ITWdx?=
 =?utf-8?Q?KqESpFJpzDSRrjfFBDxy2Oj58wDvIU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1211;6:CoslajJoWoGyejlJRV3ycXVnskYkXzPVKdZYjui+zh3NiQ+9XhV9RWVIU4QhoWVuUj2EaTd3Ppbecsxa4EPwNacvk8ZrhUKvHnlPbsG2V9+/1Mk9Q8jrIA0g5ptIMn8t9fbF6tVdHOK7W/VPJDJccEUn6R9W1+Cqfra/WHxugbEio5d+YxCoIArdfr0eVw717WEPVtd4Fu9RQcLIRdoMaSbAYgEzfikw6CFVnriOH3ok0Iyfte+cIRcVgOqN3I872GnGfiWdIM43Pr7cZkn05DfkVJ5USRHePJVqn9qKXy+gP3ZYrbdv5yIDmup318Lfpa2uten/OD920x7cTOY4RW9yDykGxJPOoGPpQAhW4K0=;5:vlMIm3fhbrpkwTg21I08l2/VPswzgjkdObwmfpQPmH0ciEbkurQkVOpE80Ggm2og0PKPvgaEJx0rORFLLYHkXnn/zHU5XaIJzMEcX/ACjjg9OSHo4DhKQPFBtjX8YxJXcrw4DqWB+qSoWyMgzbi1muMJWVNxDZfFZxtSh9AtJbU=;24:50haMu1JfmbTX0/ropBpKa0WTAjoqgCjbL82FqjMZZv+pUhit98v40pNz0yb512XZ638gTomh6FUMchYln4kr9RFVT+nMmdsXXHxzAp+rpg=;7:Z8eDfzi06W0R7z6xXc+9ECKvHZmBm1H2PidupqDO8U2gGJge3omxACv2ZCqv2m6wt8qU/UjSwwDKJuktEnTtu3Tw5TskelegbTXKhbma3WQXDhMOdhEmDFuA4JNSEBZXC1p6G+hC2oQLe+yUYuXB75/nQm77ZG0gIDYTR+t8uJv9eXfa9rYwwfGAMdpC8vyzzAYKN5qyrr2Alzknn25rM/hiBMgXkMy4Rtt4Jk8l/dBvp+y1dBTEAnqNQ0NHIkRF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 21:21:49.7648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65eec69-142c-4bf8-5eaf-08d57d5ef456
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobin

On 26/02/18 18:58, Tobin C. Harding wrote:
> On Mon, Feb 26, 2018 at 10:28:43AM +1000, Andrew Cooks wrote:
>> Family 16h Model 30h SMBus controller needs the same port selection fix
>> as described and fixed in commit 0fe16195f891 ("i2c: piix4: Fix SMBus port
>> selection for AMD Family 17h chips")
>>
>> commit 6befa3fde65f ("i2c: piix4: Support alternative port selection
>> register") also fixed the port selection for Hudson2, but unfortunately
>> this is not the exact same device and the AMD naming and PCI Device IDs
>> aren't particularly helpful here.
>>
>> The SMBus port selection register is common to the following Families
>> and models, as documented in AMD's publicly available BIOS and Kernel
>> Developer Guides:
>>
>>  50742 - Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>>  55072 - Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>>  52740 - Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)
>>
>> The Hudson2 PCI Device ID (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) is shared
>> between Bolton FCH and Family 16h Model 30h, but the location of the
>> SmBus0Sel port selection bits are different:
>>
>>  51192 - Bolton Register Reference Guide
>>
>> We distinguish between Bolton and Family 16h Model 30h using the PCI
>> Revision ID:
>>
>>   Bolton is device 0x780b, revision 0x15
>>   Family 16h Model 30h is device 0x780b, revision 0x1F
>>   Family 15h Model 60h and 70h are both device 0x790b, revision 0x4A.
>>
>> The following additional public AMD BKDG documents were checked and do
>> not share the same port selection register:
>>
>>  42301 - Family 15h Model 00h-0Fh doesn't mention any
>>  42300 - Family 15h Model 10h-1Fh doesn't mention any
>>  49125 - Family 15h Model 30h-3Fh doesn't mention any
>>
>>  48751 - Family 16h Model 00h-0Fh uses the previously supported
>>          index register SB800_PIIX4_PORT_IDX_ALT at 0x2e
>>
>> Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
>> ---
>>  drivers/i2c/busses/i2c-piix4.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
>> index 174579d..5c90a44 100644
>> --- a/drivers/i2c/busses/i2c-piix4.c
>> +++ b/drivers/i2c/busses/i2c-piix4.c
>> @@ -99,7 +99,7 @@
>>  #define SB800_PIIX4_PORT_IDX_MASK	0x06
>>  #define SB800_PIIX4_PORT_IDX_SHIFT	1
>>  
>> -/* On kerncz, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
>> +/* On kerncz and Hudson2, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
>>  #define SB800_PIIX4_PORT_IDX_KERNCZ		0x02
>>  #define SB800_PIIX4_PORT_IDX_MASK_KERNCZ	0x18
>>  #define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ	3
>> @@ -359,18 +359,16 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>>  
>>  	/* Find which register is used for port selection */
>>  	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
>> -		switch (PIIX4_dev->device) {
>> -		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
>> +		if ((PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) ||
> 
> nit:		if (PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS ||
> 
>> +		    (PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
>> +			   PIIX4_dev->revision >= 0x1F)) {
> 
> 
> Hope this helps,

It does, thanks. I'll roll this fix in with whatever other feedback I get before sending the next patch version.

a.
