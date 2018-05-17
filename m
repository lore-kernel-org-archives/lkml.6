Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeEQPrY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:47:24 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:41046 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeEQPrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:47:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mike.travis@hpe.com;
Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Do not adapt the size of the
 direct mapping section for SGI UV system
To: "Ramsay, Frank" <frank.ramsay@hpe.com>, Baoquan He <bhe@redhat.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
CC: Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "thgarnie@google.com" <thgarnie@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>
References: <1504770150-25456-1-git-send-email-bhe@redhat.com>
 <1504770150-25456-3-git-send-email-bhe@redhat.com>
 <20170928075605.g74zm5xeglosmvct@gmail.com> <20170928083112.GN16025@x1>
 <20170928090143.m6sog2am2ccz5dm4@gmail.com>
 <25fc5345-3273-447e-de6a-2ac7c56d0f00@hpe.com>
 <20180517031802.GK24627@MiWiFi-R3L-srv>
 <AT5PR8401MB0370A3560532C224307B4B9383910@AT5PR8401MB0370.NAMPRD84.PROD.OUTLOOK.COM>
From: Mike Travis <mike.travis@hpe.com>
Message-ID: <b2f1aa4b-8230-02ca-e35c-66df913b6acc@hpe.com>
Date: Thu, 17 May 2018 08:47:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB0370A3560532C224307B4B9383910@AT5PR8401MB0370.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.48.179.6]
X-ClientProxiedBy: SN4PR0601CA0021.namprd06.prod.outlook.com
 (2603:10b6:803:2f::31) To AT5PR8401MB0804.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7424::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0804;
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0804;3:UxkwICYlrfgcxP/JkRWvUBaeHEJQ8n50iOdZyCmnGWgkpqPoCvRY9QCv0zkCZCZT0RQtVQ2RuaInw9VuDwT8ZMTranMwC7zyEtyftiS9pHm0tZMohESE7ytUImtVJAdAYJ2O2qvTvZyyIY3AZANCcFBGXJPBXEI32blSm+LcJ+3tK0qShrG18miWFkyDozVNDLOaVvrCGcDXijULL7JL7z00A5llMoG4peLkJ1/teS5wT2+xtXinq60Z17CnQy+C2Mralg5GN0N0uJptNBlPwtAvwifTjbi2TTQQcBhP6Pg=;25:/Smbf294KjnB6UvcAgYLi8ctP9dlog/EwxSpPw0nRRY2XP/erMlU7XC9cPrLQnx1GRv0li9oMYa1KVN4i8xTowCg9hmJYRUJAEGqDXVQffoatRuKZTT5Ys8PT/1NeVWIGmIkt2FBhhbMFQiwioOZmqXm+M2oVvJ2tSIkMhBLqm2m7lyw/xsl5WhJ4oQx46L3XSL8M2YJ/MHCTL5/e38cZfZgDZdCiLVlMvfC07RsMFAd6o6moVMktwhN76t5xZRIQ9oFi1raZ7zC+7EGNr7wpBJ7yDMCJjjHnvJytviCYx1JCRjOJukDiyX3D0nurxcfv79YJP6wwneiwnQK1mIikw==;31:Aad6h94QZGQrHtXo3HoTAXnFR9O5614cwuhkBURWqK7+gAvAzkQjhJC046nGdpRIlCXNJ8vGtQiWIkV4kM6gTXVHym4tbUxlAcKEwtL7sm+FksJMcMtSw913p2HcPSQGh+0tHiZuFl0pTG93lUDiMgrDpCd6JMpi757zqu8IicznJwiHBr4+WM/6xiCgZ1sk38TD9EyozDS3NIUenkQx+QxdCGtw7ET6MsaPwDpGBhc=
X-MS-TrafficTypeDiagnostic: AT5PR8401MB0804:
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0804;20:1sqUkBW2xPJywoTEQMlHDuEPWFl861IEIWl/d5IkZ+ts2KYX95wcAZM40orcimGjdWjV+zF2nKqFH03roz84RF0QhaPsU+gmctwhfXNPdV5PtoUUWIq220sVnZybWJH1t5sKFkNPrJXG1DQ2J0RtEgsFh0eDORSaORIPdjuHK0FWX+ZpSwzszFwWSNJKvhpPULPPwSut0bC6mnZkXcG9xVKNdC5q3AyGU39SvPk2krF6p2Rn2EBwjUfA+WC7uUVnmEcYOQOFkPurPEAmM9cgPaKIh6M43du6W+Ck6Xga+nYyolgKRBDIOP3OUhX+VTLEZpZhPFvz9teUFGuuy4Z5I92aC3IUBEj0injwG+XYe7eMaV+FhWL1QazHF1+JWhtA2SG67UEtqVDVoKKh88EmW+kMiVycic1l1zjSXvrouZZgQuW7bdJ5fp5MJYch/aoLbV2jk+c8ZGjcitf7EWQQZ80rJ57Jg4Tv8Ui3b+HjsehwYPe62VGihSRUX7EWEwdp
X-Microsoft-Antispam-PRVS: <AT5PR8401MB0804C6706750B7C27FFF224CE7910@AT5PR8401MB0804.NAMPRD84.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(227479698468861)(9452136761055)(211936372134217)(222181515654134)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0804;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0804;
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0804;4:M4HIq6Oazr5+c9yskAnuzYyFYxYRFpdxFziwYGkEjUcUmxhqEQcyExpXS14CmyrD6lkgjvTTxiAhRqVpBOLzepVUGSQxh+UDM+jz7osgcwMEXZaFVSZvwSUQfnKltYjdNHT/2IbUZzryPwI20qgQMCxD+rN3Ag5DWfKsikxjxEaJYY8EZDu1GJoEmcFx4XDa8II6RjyrZjMScg0yPIBTWAAYrboJ2T6rSXWMAkDccjNMJ+krP8wq27MgTMQXNxes0YDPbHV2wjl8c+XuuOPYifc3v1AiYGIJpMnjAGVAq577XnJPnoJ7/dLrlXRuDDB8ARwXqF2nWclJ4IfD+ShdNBrM7GOP8BqKGSnxrPYKdZoEBX7fHIu8qBS+FLQL1c+c3Nltdqeq9PAI1J6MxVuNej3fEjyoJiyz/DIRKjLp06JXHzfYTDW/4zql2FBZg0Re
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(13464003)(7416002)(2906002)(7736002)(2616005)(6666003)(64126003)(16526019)(50466002)(956004)(68736007)(11346002)(486006)(476003)(4326008)(81156014)(446003)(53936002)(8936002)(8676002)(230700001)(81166006)(6486002)(65826007)(305945005)(36756003)(66066001)(31696002)(65956001)(97736004)(229853002)(5660300001)(47776003)(65806001)(6636002)(86362001)(106356001)(105586002)(478600001)(316002)(59450400001)(76176011)(31686004)(16576012)(54906003)(67846002)(23746002)(386003)(6246003)(6116002)(3846002)(110136005)(53546011)(25786009)(44832011)(52116002)(58126008)(49976009)(93886005)(26005)(3260700006)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0804;H:[134.15.1.253];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;AT5PR8401MB0804;23:nU87cWAdGFqvRiqzhsbb+yK6zo2ZVyhwyyn?=
 =?Windows-1252?Q?NFl0uZPQxkIuUNc5F4j1S5wgNGxUj5uxAlaRuEiwECgnCPRuiuImtuD/?=
 =?Windows-1252?Q?/sxYEPTQhgOlnvDPNCH3uQcGRvdn8+RQatHAOhFjwQ07CPZl5JZyWe7i?=
 =?Windows-1252?Q?TGsCLNwmle8RYQAK3LGoXEur9T8C/AAZK7F+afdb5o4tCpJu17oKz0sE?=
 =?Windows-1252?Q?FIz02NetDsyOzazTzfEUD9EIrcASqmi7+jS7geKU0tPkPfcJMcO4R8lh?=
 =?Windows-1252?Q?bfe/vzCiePyJIsOez+zrAs7gx8MMHKorgAIb2YrQXrwt1HUmYNgUCeJz?=
 =?Windows-1252?Q?WeiY/Sm29jYemhsVSrItieYMfA2Is4/8bkLST6VwEO0UpPMWs6DJFTkk?=
 =?Windows-1252?Q?oG19GTKvbehPMRr8kRIV7KIJ9rx/+6bkoQtTcal3t10LwBKam05zoloL?=
 =?Windows-1252?Q?AyvVu/+HZ6EsJmpdcwAej433RdsWcMRWTstg3Jsrveur2TIuUXm5s0Wn?=
 =?Windows-1252?Q?sFC0OZcDKTIKhI5HaGO5XJYxK9Dqinm4PmVWpOkzwAK7+w2k4naYOyvD?=
 =?Windows-1252?Q?qElav8+pIdJAUjHKwP1tcMtx6FH8qrM9GStQVe/L7MlC4ZxTFdGUZlUH?=
 =?Windows-1252?Q?XyJsJkdR0hIIUGtSl1pjgD5+7qyRTTNIx0l0DKmOw9FX6Y9C75TZGfSN?=
 =?Windows-1252?Q?nQhSP8iL3i2ZtEIcihKmrcADXTNbiEUG99rlpCxS7LmUvUACaqwWBoaW?=
 =?Windows-1252?Q?ZJ8p6gEQCizHwYOsLr4+YcRl5jmHcYORItxkzQ2JAKyI2zQBn8ypSnnB?=
 =?Windows-1252?Q?nu8a9KqCuOdeOhIFsg+PlaISkd7cw+Bcb8BWtXH3BACEPWIK3agN61tR?=
 =?Windows-1252?Q?1vF8ZyBRwoCSnGKUOZvbYgDyk/psLJrgnaJVg5pqxW1zEM9OwvcBJQac?=
 =?Windows-1252?Q?8iFKiTRGHfkf8yo7NRC1HF6INx4aGQAfN2yxXCjeCAPJCcZfmOp3XdFf?=
 =?Windows-1252?Q?CqiHnEp6O/yXthKjpjtwubfE/wQNn6KUmzA/LBNX60tU4bauqVUBMcMa?=
 =?Windows-1252?Q?wdLGSk0LCzCs0GUhKgXIO/REGr24fUK32EYkxJRpMFc3WWKKX+ePFLKb?=
 =?Windows-1252?Q?HUgIq9pAvBnAEjkXRfrE7Jx8bCQajaaaslzbOsRhcVAGWmEEIjIdoup1?=
 =?Windows-1252?Q?mO6uuwLwTRElnNLyT5hPn0UeajmTbvzz/4IL2qmit0rhx3aFKWvolEP5?=
 =?Windows-1252?Q?Bb0gwT5xri+7fEO5fKybwYJCeMUU7w4iKaSp+LkcRoITVsbd65ZX/ctT?=
 =?Windows-1252?Q?Yj1uPhdqTVotigfQdn5PB589FDSOm5wBBUWhbhPr96VGjUUWtWFtmkro?=
 =?Windows-1252?Q?+pKCEa7EDwAobU1tYUgCyD+o4kWzoBoDRZ6fxMmgx6sIEMMH5pCpZu2r?=
 =?Windows-1252?Q?6d1PnT4LfIHaTn4WGZt+CyCr3a0Wn9xnhdHhxDv6cQt8mIiQ4rQbdeSK?=
 =?Windows-1252?Q?e9M8V1KAMCKmUyTwGwlQlrKoLk7e3dH+k7y/+YWfPLM5qzx3UZd9x4cg?=
 =?Windows-1252?Q?/PSWaXVFAjPKI8UPQa16Tl9FAobZlqAR1i82daUkDUSv3KFPhy0A31Su?=
 =?Windows-1252?Q?ZMy1pRJIREPAm5rUpfQRwfaBqb3nU16Wmb7pQVeKwgmo5F8yL8fccjlP?=
 =?Windows-1252?Q?swH2B0LmckkXDYO6WN4ce1AtHRtJSJXI=3D?=
X-Microsoft-Antispam-Message-Info: 3UTkQuXkMj0hsVhDbzeOfqxpQQSkLg/CRVKh/8cFVrCdkvskrXEbYI1dk3X4hNMcYRaIkBHl8MUeCH8IloIhsrcM7IqY8gmTRHxAFDFlLIQQ4vGsCcTq936jlyOBAWSX3Gfbe/PT2GUZ/t6mFzx3Z80pIqX1qH4/WAVVFX3do2xN4MSlH/7Q01Wr5CCpy9TG
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0804;6:jJN1pkQUZFisUgp+Esghsjma60dmERPEDdd5XM3PF6scC/GNrSc6qErBADi8O9i6+UxNxblU0nlRBgDN+y3lBnbQAzE+eri4PEqjaVg6m/LRCceT/HXpkyU6d2jK2hPRtNSIrYzUduFxW0LXbS8Oanp0NQHFOB50p173eDmYQPnnX3whMDsUNpiErie2NjPOnleRWCYGS+n0bRG0n61jSZfIp5vfcmPGIwm0lCOm9G6HmHCJ9s4QRNbsT1mCi3rkuC9pUt+ZFR+FxCgcGbARsLFJHqQD321GJBonCDUCAufOX9l2h6ralLkaXeWgWNSB9nNOJEXY1xFBOW60PFIBi4+r8UP9f2Z9rDmik2fQ80XnBoD3OQWmmk5MPoKCy2JmJaL3gCrLiyccgEtG90sobHvfF4diT4/aNnePc3pp7Wh+UpfYii53WiuBLzDFMzKbPcE/QMM4aLBr5a+3t4YcrA==;5:RpQp2Rdj60R4A0js2ZKSuRtzW2sR4dfh9IU6EB0pHCHL1TnxFqALxENhZTWGf0ICOb+Qgo5i/IK5hvkB7KOhLrVs3Qz7HZ/wlYIM3aIMHzKcZ5KHIDp3bY0ZEPj1JBQxHDa9ejESidtmxWggDjcTQNdtXL9dW8IKtZBPSy2jWOE=;24:9hBfVdTQGKl7Vj2mdEvnSyZkdi75W4Nm0jfTq58oB4DqgGtV4zP5X7I0iUAPIEzYmI27dp/88oJQofQiWkLwhkWti0WURxcSHGv6b4eWYWc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AT5PR8401MB0804;7:eyg6d4kHjsBD1/eqD5ATbTNJh61pAPtrzEbihZVg4FLtm7TmfwjYHaWmjTAulWlq6Ws/FRk3ojJs0aW4n1wKIuc2o4Fq5EPtFYJyYTSUBN+dVbPpGeugjRqQ1aY9yo5qYNu+wD0awqgrFiRs4usKnJWfHud/0+61/vm5fk5DOsEeE88oq8lZNEvhqiZN2+FFeqoFHTJPGnzM3i5uNdu7OvJaoMvqjVgcW69R2zIsCbgcSKJqsy5uHx8VDiEHNHKy
X-MS-Office365-Filtering-Correlation-Id: 694cf099-69f8-4dba-3e18-08d5bc0d772b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 15:47:13.6580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694cf099-69f8-4dba-3e18-08d5bc0d772b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0804
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2018 8:06 AM, Ramsay, Frank wrote:
> 
> 
>> -----Original Message-----
>> From: Baoquan He [mailto:bhe@redhat.com]
>> Sent: Wednesday, May 16, 2018 11:18 PM
>> To: Travis, Mike <mike.travis@hpe.com>; Anderson, Russ
>> <russ.anderson@hpe.com>; Ramsay, Frank <frank.ramsay@hpe.com>
>> Cc: Ingo Molnar <mingo@kernel.org>; linux-kernel@vger.kernel.org;
>> x86@kernel.org; mingo@redhat.com; tglx@linutronix.de; hpa@zytor.com;
>> thgarnie@google.com; keescook@chromium.org; akpm@linux-
>> foundation.org; yamada.masahiro@socionext.com; Sivanich, Dimitri
>> <dimitri.sivanich@hpe.com>; dyoung@redhat.com
>> Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Do not adapt the size of
>> the direct mapping section for SGI UV system
>>
>> Hi Mike, Russ and Frank,
>>
>> On 09/28/17 at 07:10am, Mike Travis wrote:
>>>
>>>
>>> On 9/28/2017 2:01 AM, Ingo Molnar wrote:
>>>>
>>>> * Baoquan He <bhe@redhat.com> wrote:
>>>>
>>>>>>> @@ -123,7 +124,7 @@ void __init
>> kernel_randomize_memory(void)
>>>>>>>
>> 	CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>>>>>>>    	/* Adapt phyiscal memory region size based on available
>> memory */
>>>>>>> -	if (memory_tb < kaslr_regions[0].size_tb)
>>>>>>> +	if (memory_tb < kaslr_regions[0].size_tb &&
>>>>>>> +!is_early_uv_system())
>>>>>>>    		kaslr_regions[0].size_tb = memory_tb;
>>>>>> This is really an ugly hack. Is kaslr_regions[] incorrect? If so
>>>>>> then it should be corrected instead of uglifying the code that uses it...
>>>>>
>>>>> Thanks for looking into this!
>>>>>
>>>>> If on SGI UV system, the kaslr_regions[0].size_tb, namely the size
>>>>> of the direct mapping section, is incorrect.
>>>>>
>>>>> Its direct mapping size includes two parts:
>>>>> #1 RAM size of system
>>>>> #2 MMIOH region size which only SGI UV system has.
>>>>>
>>>>> However, the #2 can only be got till uv_system_init() is called in
>>>>> native_smp_prepare_cpus(). That is too late for mm KASLR calculation.
>>>>> That's why I made this hack.
>>>>>
>>>>> I checked uv_system_init() code, seems not easy to know the size
>>>>> of MMIOH region before or inside kernel_randomize_memory(). I have
>>>>> CCed UV devel experts, not sure if they have any idea about this.
>>>>> Otherwise, this patch could be the only way I can think of.
>>>>>
>>>>> Hi Mike and Russ,
>>>>>
>>>>> Is there any chance we can get the size of MMIOH region before mm
>>>>> KASLR code, namely before we call kernel_randomize_memory()?
>>>
>>> The sizes of the MMIOL and MMIOH areas are tied into the HUB design
>>> and how it is communicated to BIOS and the kernel.  This is via some
>>> of the config MMR's found in the HUB and it would be impossible to
>>> provide any access to these registers as they change with each new UV
>> architecture.
>>>
>>> The kernel does reserve the memory in the EFI memmap.  I can send you
>>> a console log of the full startup that includes the MMIOH
>>> reservations. Note that it is dependent on what I/O devices are
>>> actually present as UV does not map empty slots unless forced (because
>>> we'd quickly run out of resources.) Also, the EFI memmap entries do
>>> not specify the exact usage of the contained areas.
>>
>> This one is still a regression bug in our newer rhel since I just fixed them with
>> rhel-only patch. Now I still need the console log which includes the MMIOH
>> reservations.
>>
> 
> Does the system need to have an external IO device for this?  If not you should just be able to boot one of the SGI UV systems in the beaker lab (possibly also the HPE Superdome Flex that is in beaker; hpe-flex-01.rhts.eng.bos.redhat.com)

If you have a hawks2 (UV4), you would have 4 10G ethernet devices on the 
base I/O.  But these would only have smaller MMIOH0 regions.  This would 
not cause MMIOH1 regions to be allocated and assigned.  (MC990X/UV3 only 
has a single sized MMIOH regions where they are all big enough for the 
largest MMIOH region found on any I/O device.)

> 
>> Could you help provide a console log with MMIOH info, or I need request
>> one from redhat's lab?
>>
>> Or expert from HPE UV team can make a patch based on the finding and
>> analysis?
>>
>> Thanks
>> Baoquan
>>>
>>>>
>>>> I don't mind system specific quirks to hardware enumeration details,
>>>> as long as they don't pollute generic code with such special hacks.
>>>>
>>>> I.e. in this case it's wrong to allow kaslr_regions[0].size_tb to be
>>>> wrong. Any other code that relies on it in the future will be wrong as well
>> on UV systems.
>>>
>>> Which may come into play on other arches with the new upcoming
>> memory
>>> technologies.
>>>>
>>>> The right quirk would be to fix that up where it gets introduced, or
>>>> something like that.
>>>
>>> Yes, does make sense.
>>>>
>>>> Thanks,
>>>>
>>>> 	Ingo
>>>>
