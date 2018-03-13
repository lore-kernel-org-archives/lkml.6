Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCMROL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:14:11 -0400
Received: from mail-eopbgr30118.outbound.protection.outlook.com ([40.107.3.118]:45513
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751612AbeCMROJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:14:09 -0400
X-HPESVCS-Source-Ip: 10.151.73.41
Subject: Re: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
Date: Tue, 13 Mar 2018 18:13:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(2980300002)(438002)(199004)(189003)(53546011)(6346003)(2486003)(23676004)(316002)(65826007)(229853002)(64126003)(76176011)(186003)(77096007)(26005)(2950100002)(68736007)(54906003)(58126008)(106002)(305945005)(356003)(4326008)(2906002)(5660300001)(36756003)(50466002)(26826003)(81156014)(81166006)(31686004)(8676002)(336012)(97736004)(8936002)(86362001)(478600001)(6916009)(65956001)(65806001)(230700001)(47776003)(106466001)(22756006)(31696002)(53936002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2393;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT033;1:ZR+UhJOeFiUUXzl1LXjARQBB73S7eaghoq3rQBxvybKnwolijPZWga/YepmfqSXMpC5Zj8gkhkqTP9dlOpx0BY5J9eTCjQrBWQng7hvPOgbiT4QPVovVQb00E5BIzPDM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31380aba-9eba-4fb2-1cbd-08d58905d377
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328);SRVR:HE1PR0701MB2393;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;3:MVtxc5zL3bM1wrzxVz6oF4sUg4eTBHFpk+vOKkWUq6RAy6Lj7DIHi/mn0e3PCR8bGtcfTIKNmfJTX+r68Eh4TzhwSj4EsQ94TEZzBJzxyjUNxfS3IqXOAYLtzZjNrgYYyPOZLJftRVDflLKWvnB5LfcOnRG9MZBEwjIn/MMEMawLhyIrQNNJkbxaEX0mOjDucBRmFe0+lXlUEOBxF0jHZSmAcXQqkH0rZSg2W7LmXDMYZx2OE2Xe7YjfHn3k8vJgml+UdFvevtUGkUVSYpISZ82aei06sSXkGfKSi7CQp8MDxjoQTj5D4cqILJFUX88xRqgUu/hAREbzE9XuERP6gh6KoQiQMdyvg5rSzLSIBi4=;25:g/HZFvvumRdQkmrKlcRFp1oTZUc9bcQ0O53t90GFkN8X57RbN7FLcENkKZKLmRtes1UBSTd/UwHWcUzH4o2JltSxjdQMoyqRhEJyPdkU8BgOfIOnVpzUd0jJPGp57l8olEWo3qqc1jL1MJ/Rlt9foR6YfXhiq801AJVVf2XBQrV9NwvlS7jzOECtOvJaYwZUKbWiFDW5Z3UWjqI7tH48O5xm9xS3N30sbrzlCzlHjDIt73ukFnElPXHT7AHwvzXr6IM1JN6l2sYqKH2K/AMB+2Z0VkwTrkwUN8yMYrygUK3DqwKvVf9/ZK1ZCjWTXdvEPCB9CobE1/hZ4HGmw7K4EA==
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2393:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;31:EwZh78DnWfhRbVzUseEP/7rqfuzGx8PZqHK/9q33auMURwgjSDrfUk8ILxSqv4YTiSR2d7OuCoZMJ7eAvmyAfxNCIN/1RHC/lqhmK1s8/AlsTGpb+LLreHAC0SayCrt2fTMnGk2FJDXo++7E9rWMA6kvJB4AUBFTeYqd3V+I2eNELkcLkVNsYpQACkeod2caIRSYtWZUWj24y9BcL4KYeer4Gz6GGQ5btkvY4HAbfE8=;20:StDQnJJmQdJ4PnM+Kc4AAYHxNICSS8muE/3bJR7nFeQeSrCcMkG1hwEZ6l/9SeV01p8WGQEkVhSceMMEOqJd9F+3Q6OxMyBgEYOK286pYKb6zN0zET1qzE10zkDVwCKVm102ybu1gOrHgbghJRQavh1RevacNivjIubCaJ6ckrvHdwOyXbpUZHbZ6Fx98PE4lsW78WUvMTg4mVWmQqNVI1R+McgiuyqF72v3lpo7qD6IOuaJ3ya2v5DmNwG3Sfm3aXyA6ROieu78XPkk3/fd6IMuOsVWgU52F5aii7q0d8eglSS1UHp7ibkUgeKDsIGReAkX6C2O1QWgrAaW7jsyA/fFdcMGu3bpOP1aFY2pN349HgHPLRdFRJ8oFZF9tcmHn2qT6Q+S3p6Fdlr6VVsf9m3sYnJI4EsyIlocw5A/3aubmCCyumdaH313ZPGZEzfto4aOe0KbSCz3fp7kAfrusNWBTcEs1fq4qhWJy5dzNDuD1hlfjRrKxS3pLJ3Aspgrgm6EH1Zs1QsmBjdKawerSQRHYGvc0cLdBk2FF/4EttjbHAqRrrmw2Y6mThol8icEL3N4XpHDxur6vqntiTWe+N9XtUbODc7aSg4njpjCBns=
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2393D0743F60AE870678903688D20@HE1PR0701MB2393.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231221)(11241501184)(806099)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0701MB2393;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2393;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;4:FKorLOgszbC2qNZM5ayIt3/eLXyEM6Itu0YBU09jdTI94z+oDCgbmeDhN3jO7ranXuhvCX7DCE0OcCFtYyyRbS3bWUXC5MhU68wccJYYG36kLSUejbXEsacixyWQl4v+bmXlCn/mJE67u7EBo3825LrdDFKpRzPX/Dej0r3HtSjM0jmEXUz/lhlPLXQt4WS23xKXOD7/87QBRkFTa3WmVVC1cvqF6q0mt0uiH87283ewSlQDyCqlp7V0J2YjzaCQbKycFBV6EgLvzwgRla9ctA==
X-Forefront-PRVS: 0610D16BBE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3MDFNQjIzOTM7MjM6bVY0TzA2ZnVQL2ozT2w2QXdjZ3lTZm1W?=
 =?utf-8?B?YjU3QXJmeEhoajNaK2l6UzdsYVAxTkcxc1NuQXJ4Y1hCSFYrQVpPWTVUemx2?=
 =?utf-8?B?OFYxQWYwTnVpYXlBaCs2cXhRMlFqR3hXbkpyYm9DdjJCaUxnZjAzUFZyUXda?=
 =?utf-8?B?c2tlLy9UNDZVV3lPRE15ZzJuRm9FL2o5ZmQzMVBrU0hBeHAxM3lLK09wczVE?=
 =?utf-8?B?eW1VVHNsVXh6Kys0emVwYVRUS2g5Ri92U1ZnRkEvTGVqa09jUXBURUdCcnc5?=
 =?utf-8?B?Y1oweTM4RmpBMDhmcTMralkyRVZmaTcrdHJFSFErYmx3OTVhUGNySDVIbWVu?=
 =?utf-8?B?bDI3cERlZndBV2xtc0gvTTBlZ1IyRGEwSVRxRWFYdGJ2c3dBVlZZVWdMRVRW?=
 =?utf-8?B?MTI1MzdxQ1dYc0hNSDlJL2NENnVzMkM2WHFSOHhEMEtUTVE0S3VhOGZOcWo4?=
 =?utf-8?B?bTZXRUMyU3ljUmszK0QwMnBGRm91dFBsVlNsSHFvcVp3Y29hSzc1OFVOWlMv?=
 =?utf-8?B?UFVNSVlDdkFQWng5clpYUVhCUEd1T2p0L3l1cUtDZE1yc1NDTGI3ZjB3ZllS?=
 =?utf-8?B?V2hBZEJsT1BXbFVNYXZBS0haZmRkNHRBLzF4ZFd3R3RJSjVFTkVyd3k2QW9J?=
 =?utf-8?B?RVhCbkNJRnJNblRVeEorRzRQUDhHQ05Gby9SMFluOFo4eHB0N3h1L1dZSldT?=
 =?utf-8?B?Sy9RcDJSWkRDZTcwR0twTG41MXlveUwwRnNRSEdmZTNIOXE3U2Rzb1poeklI?=
 =?utf-8?B?WlEveGZBZzdXWkZNM0J1d1R3S05JamV6RzlqOVprbzA0T3ZQRHhoV2RTZWJ2?=
 =?utf-8?B?SXJ0b1gvZDdWWGMyZEwzL2ROZGlFSXlCKy85dUdXNVFSaVc5RGlZaWtuYlZF?=
 =?utf-8?B?UDUxQllqTjFDWTVidlk1RHFnUG1OYjdFK2MrYnZFS09SS1lwRTZiWHp0bUFP?=
 =?utf-8?B?TWM2UVBHa2hYeElKcHphNy8zbVU5WjRMWWJqaTBWengzNW1IVTBYWUNXeXVr?=
 =?utf-8?B?UGU1WWJnZWRvdzJUUldwWUVEWFdrTkpZZnlpWWVCeC9FQ2Z6RHZ6LzhxbytN?=
 =?utf-8?B?Z0tnYU9aRGZrY1BiYXNRSkFwUnVDeDR5YjRrejJlRXgzalI5K0YzMmx1Umcy?=
 =?utf-8?B?cFp5VmNpaWpTMTZka2VDVmxTaVozT0NGVkZBN0tqVityOFd3NVpocGJha3N2?=
 =?utf-8?B?cnl4U0s5aElvY20yOGNuM3ltRmpHZnBVTHZjbGhaRVdMOTllMzdibUw4UHZu?=
 =?utf-8?B?YlhqNTlPU2g4TUZ5T1ErNlBka0dHakVqazJzTGtRNTIwV2ZFM3NIWFNtVk9G?=
 =?utf-8?B?OWdXUVJwNk1ZM0hrbnIvaDAvNmZyZkFZVG45SFZaRDg0S2hKckNKbFNYQmUw?=
 =?utf-8?B?SXBWYXROeUMySkFYR1BLaklxRlpIMW1Ra3RaZXhqNmxLYnF3ZmhrSlFpaXZu?=
 =?utf-8?B?TzBCcS9TSUl0SGNBMjdJbElWbFA2SE0yQ0pnQ3dVd211ZjZSSXhHSXpWdHVH?=
 =?utf-8?B?R1FrM0dVazdBVHp3RUR5Z1V4eE54VThBWWpmVXFKWVZMR0VDQkM4SlY2SE0x?=
 =?utf-8?B?a1BhbGJvTnBuNE10dU9zNlMzQWJ3L2VTcnJvOWZaMWViODV0WnE4SjFkTnFn?=
 =?utf-8?Q?7j+uwDeFCvbkegVVBZ1d6R?=
X-Microsoft-Antispam-Message-Info: skwweW3Gx6vddUTjcfdEnOPM6b7RR+AiSDeb6HLricw/6grjiBm6YP2IW6Ojh7IyoJnKz9qMsrcEkOdM9GDkhrjIwMSJtK5Dy0ETsCqlcHL1iHbaEwlDxgwJj1mwvnJwomJDWyZthjSdETWlvMF/Ag4mvQWpwykCvWWXapWVJbNGepFcIkzshQ52h9SccBFrR0dSnjwxzGLLu99m9M9DeYkLJDfOx31oZpZ7lvxqVjz8K6NjDyGsdGC2RAvyGEjo4l4BN3enpGx7/8b2VHHyUrh1hBWwJmv4V/JHlMURrCm7cKx6WryB7DeSUKEpbyAxedK+bejE5eH1K2METQcejXv2hwRZTrdujhrBO0TVgge+XJG7X+TKsubVuj9pNQBD
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;6:S5MccLHiUvheJth2owoJZ0BLH7EnDEmvUNiiTcse+ANT7iyR5upRljlqSXPN6lgo3OGSKpGXW1TqQTlszuHB8S+3k9vsSoMHRXLB53ii1N8t0Bl1ecZNETB1YGcrfTqimWBOvvs7xl70t+Vf31fHEDBqALlkgomXWWDhL09X6lg7fw0Q6/vZ1efSAtatyjOe2iwNGVxkvX1sxaKYjiEWw1q2Ysa1OLJWMuFNk4WtV40XU+jp40GtyaR9GE4N7cASvDgrTj+Aprwu+w9sb5RXyIZ+Bh3L0rnK7/+L8rzWQldh9f3zrmb27hhsJa7j+Ba4nWUO+EWcKFAxtEAqof/yJjLhhT1Q3H1ZMP8PPysCDEDTD3RuMSux3xleC7498SolCbWtfc1HYcP8c+/AcXgFzA==;5:PaKxtUysHZzUyyU+b8fF31PLH9NMv44gLm5sdEUwSxZIuK3lavd5d7kEIvrJPlpVNb2Mx7sEHZ7S/tLQPmqP4fbmJD7bT156HeSGq0SL7swsVNC16Yp9f6fvQBSQ2sV9ly4NxsvGdLxScQ7pUVRbLQI/IsqIpdl9AWs84Ah7E/0=;24:DU9KxT2ZI7CiwFikZ1/i0/XoEj7CGpoaZ/J3xvtlVP4tNovETSnJUQYGTP0kpoCUl8Fh81lc+IF2g6f3ldbKCipXpsa4Uvv4PRqApAJrFfs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2393;7:liPii4WhAwXjcyLoBImTUJmtWWMqSOnN89OH+ymfnJC6jZzv3vSLq/bwgOT8wyJ0xcoCsSOPSYePUTb4Uh5yUw2tXi9/6psg1lig1PbJL4PBFeXxDx+BfiBpkCpUK8rkde53ssbbXT6Ft05LzOehA9jU46snYwZFhr4F57T9rT+yyqURBObO8WDKSTFcr2Cqt4iXc5E+6zyXUBRBQooeH8GeedK0u30ywExwnVgIFnr3C0IqOcmniaVRZSOm6UH4
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 17:14:05.6246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31380aba-9eba-4fb2-1cbd-08d58905d377
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2393
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard,

On 13/03/18 17:12, Ard Biesheuvel wrote:
>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>  {
>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>                                                           &mod->arch.init;
>> +       struct plt_entries *plt;
>> +       int idx;
>>
>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
                                                           ^^^^^^^^^^^ (*)

>> -       int idx = 0;
>> +       /* cache the address, ELF header is available only during module load */
>> +       if (!pltsec->plt_ent)
>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>> +       plt = pltsec->plt_ent;
>> +
> Where is plt_ent ever used?

Above is exactly the place it's used.
I need to cache it because after the module load is finished the ELF header is freed,
pltsec->plt pointer (*) is not valid any more.
With the above modification it's possible to call the function during the whole life
time of the module.

>> +       if (!pltsec->plt_count)
>> +               prealloc_fixed(pltsec, plt);

I'll prepare v5 based on your other comments.

-- 
Best regards,
Alexander Sverdlin.
