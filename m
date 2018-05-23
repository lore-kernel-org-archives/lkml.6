Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754281AbeEWHQf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:16:35 -0400
Received: from mail-db5eur01on0077.outbound.protection.outlook.com ([104.47.2.77]:62528
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754124AbeEWHQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:16:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
Date: Wed, 23 May 2018 10:16:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::36) To HE1PR05MB3259.eurprd05.prod.outlook.com
 (2603:10a6:7:35::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3259;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;3:RI6ue+k/q4kaZVLznq5zLcLu1OrjlNyMM5H8ssIjVw/3tU4U+GgDIgXjT18PaArUlcXiCcztT7NfhyhkT1JvY0w3WYjIzkoGe8sPoPNE+3JeR4q67vGzuwkkPEOydphaRM/ugBp9ZCIJyzVmzT3N5D84qw3OoF9ewFw33vRicmxWkkG/XEGNsrpAgXCb5dNLP6SoJwAuaIJ31m4l1bF0FU0LKKsBnGrw36Er9fcMVwdxsEhKksTa9Tzjiq5f0Bjq;25:Efu0lOO0tGPPt7s1Oxy8ghNqH1UbPghHlcqmvDwPWHpAMco/zPdX07NeDA69uegDpCpY6sV+rtmBBufLmHOZF3CE5mT5tZsgX1g6jboOSqPDUcE6NTTut89ekPFIoadyhwA37VV74A80STjLh0LcTvGDXOMrMBdJqvry/iz186S5aJD4OYGPBePKfd3kTB70SynVO/xZrvEiaj8aXrWEwHbQj5ubVUbUP9u7HB2LWkoqLV1/9hBJILiTZelsYPtkuG3LRNrtUvjQbrbWuYBj8djBTgi57yvbEt46BAcQBff2yUBVoHZiG3qQWLh2OZ9WHtx4Eb3RteVikcyK/8r79g==;31:kaxkms3ytyhAtiiXvnbd1EYyAamnJuNMbTxT5hMgG/mHdZCbcS009gvXjQEcNKNv8+uLCtjhOSJPDfrCn0sxiXiGVsKweDaavE8jZNxzaSrYzAJ0PvbYkOvTNF5KGfHnLDAF+4xTRPFW7Rey2rOVTkarg7QBr7zufUNdFnUa8OHEwcqoGTeubl5hrI8APNNcGvAxVBacIMyO1CNKVlda7C8X80jaYpVp/gkg77YQWko=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3259:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;20:BNMpDyBb6ush2OwHiGOy73eWQ/2wACoKgkp4Xs3xtMYnvK3Fvisn6YFx5GgXWi9eWiGfLDcYKiMR1HTTkTjmvi30AykRYP+kKceS0e6Z5/oeY3CWIacvARArCCShb/64ZJ0HhsrV449FoSgry+Xc0lrkuCSRsaLbI9oD+JAGvglREraAMCVxvMNjGPmluYnSlixH6l2+t3bZor5M/6dxKQQWA5/WCdyb3KCCzTAMu/HAsjKsupMHO94AC1fEaigWDjRnj6I5q6kGcLyulTh/FG6wf60IglpQIjqQponoISH4w87WrUCDfceleTnl5f+1a4yD0/bcBytFogH9Q0+lX/v7pNmAzXL44HNDUS06Q2zCbyT/1yUep45bItc1/qerGU9EUUrK+/qHkwGFe9k63HH/FCmrBQPwQo3/TuQaDq10bhw5JLH0aQO6j1yplvId83oDzMzzpfkXCW5Txd6/7hqyT42O5yUoBu6QpXptgL5hKgMmfDXnXJYp3tzzk7lX;4:4L8lXLPEsH4U2ldpYBSy5ufT1VZTartFB0IbIqgIy1gigXeFv4WPjxZSaW1BWzc72TmA0AnJLGQ5pJdoA0n3J7ASdz4LTqpxeZ+wBlntxS2CfyyH/yPm0ixVy+B+sHR236wxSnZGX4sMdVHyojXozacfMwmF4RAtKuGUN7ArUN5ovXfP0k5OfwZC3GRvF9udh5R3zxURS9mGrIiG2Icc9mUQRjQmaB5E/HoX7MMdIFiOAHprd5MVzwiw+BhSWz1U8vVO9BPPS5sYVYRXUDo59Q==
X-Microsoft-Antispam-PRVS: <HE1PR05MB3259A6BB77D47184F57F7B24AE6B0@HE1PR05MB3259.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3259;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3259;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(396003)(346002)(39380400002)(39860400002)(199004)(189003)(4326008)(86362001)(386003)(26005)(76176011)(65956001)(66066001)(36756003)(6666003)(65806001)(6116002)(6246003)(52146003)(52116002)(107886003)(2486003)(31696002)(53936002)(305945005)(97736004)(23676004)(65826007)(39060400002)(5660300001)(77096007)(7736002)(53546011)(2906002)(67846002)(105586002)(229853002)(16526019)(81166006)(478600001)(50466002)(58126008)(47776003)(54906003)(68736007)(8676002)(3846002)(81156014)(64126003)(16576012)(6486002)(230700001)(93886005)(106356001)(476003)(11346002)(2616005)(8936002)(31686004)(110136005)(316002)(25786009)(486006)(956004)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3259;H:[10.8.18.17];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU5OzIzOmhBOVBRaFlWQkFPbnNXY3RIakxUZ2RlQmJ2?=
 =?utf-8?B?bnFtQTJiZ05STXRodTdJRWNsZjBvUmNnUEplVDBIK2dleEtCMVpoa3pMcDZ2?=
 =?utf-8?B?RXRSZWtyZHVLUlRGQ0k1OUFRcm5uZElCUHFMSmM0L05qQXJBMXEvUHdXN1pi?=
 =?utf-8?B?M2laVnhsVkVIQ0FGcXNxWjZCeHN2V3ZCb2dUZHpoUURmZlg5aDVaV2N4TUlS?=
 =?utf-8?B?WVFvV0hlZXlkbkJWUnVjeURMS2d6SXExQW04MjRWT0x4ZlIwaTZCS0ZNcWRp?=
 =?utf-8?B?V0huYmtpLzhFdmpWTUxsNSt4TitNWGVJQnRhejlibEdqM1VQN3ZvdW5Kem1t?=
 =?utf-8?B?QXRaWkhCMWJQc2lTaUkrbWJheXRqaHc4UEttclJOWkxOSXdtaWFoZ0pyYVJn?=
 =?utf-8?B?dEZIa2FzZDlwVXV2RUMvWkpOUjVRZ2VXWXRZSGhmV1NCMm54VXlsWXRjWHNq?=
 =?utf-8?B?SEdIREt5RHZoTHNvblBuS1VOQ2JFZ3ZmUDlxelZRMHd0S3NzNHN6cXl1WFJO?=
 =?utf-8?B?VktoaUIzR2RiSk9CeDBXKzRHMnJHa2UyN1I1THVMK1YrS2IyMmFzVGtCMi9T?=
 =?utf-8?B?U0FVN1hnUVZYYy85b2Y5NUV5S2YwZElQTHp6ZFEyd2liR2F2cnJoVlU5Zkkv?=
 =?utf-8?B?MWFFRjVtbFltclZHRHU3U0JtUXEzZkVPMFd3SHVjeWFhVkpFQzdldVZHOEdt?=
 =?utf-8?B?cUpvOEw1Z3NXZ05VV2FOMU5CREY0Nm9WdVl6d21TdndicXEvTDRHUW1FTXhl?=
 =?utf-8?B?NVgwNEV4M3dOZnUzMmlBZ0tPN0pVb3EwaHJaMmh3dWJVRkM2R2xmT1I2RFdN?=
 =?utf-8?B?RmF3Z1RFUjliMmNjYjNlbEZOd1BrSm5yS1FUeHV2eStUYW5UKzBENy9QSEZq?=
 =?utf-8?B?LzF3OGRNN0phbXlkanQ5eEpTMXdJUEQ0ZVkwSXlIL00zcnQ2UG5Rd0E0NVJw?=
 =?utf-8?B?VkNYd0tFbmR5OCsya0c3Q3ZlMmcrTkxGQjJVVm9ZSExYMWhEbWtnTlhwajNs?=
 =?utf-8?B?elNjZm9pQzlweWVzOWFPdmNuSHQ1UExEYzNPYUkyNW9NeUluZy9MT1ZOMENk?=
 =?utf-8?B?UHJtK01lZkxyeGN6cUN2bWdZOVRMNUdNck02T1c3ejd0L0syOTllb2VXcXZn?=
 =?utf-8?B?NExBYXRJbmVEN2tYZE10OWFxZWhwcUxKSTNOclc2RFIveWFQYnkxTW9yT1NE?=
 =?utf-8?B?TVZrR0Vibmh6Wi9Ib0ZRL0xNeWhXdHdlY3ZpUlFiTUZWb3l5eVdWTVl6U1Rv?=
 =?utf-8?B?dWtVcUhxQXZrNnNvbDZxbDZLV2NPYmI5R3Q4Mm8rUUlSeWZ3eEM1dExuc1lM?=
 =?utf-8?B?UVZya21ubHJlbU1ZRWdUUHdPTmJ0TyttTjU4c0ptb3QycG1tKzladDdXM1JE?=
 =?utf-8?B?STNHZjViNDNzTk1HM0EvcFVram9LaHhOMTZWNVBFUEUvdUhSZjlGa3YrM2tS?=
 =?utf-8?B?WEY5VWIyZDIrVjBaOUM0azVBQzIzb1dBZTFMZll4MldlMDdKMXVPZjBibE9k?=
 =?utf-8?B?RXRjWTJtdkJKRjcraFJBVTFJZ2ZzUHFLLzN2WDhPMW95bWJ5K3BWSE1jc1Rw?=
 =?utf-8?B?QTdTY3FIUTkyaVkvRDJVRUJOU2hZOHlvclEyd3I1YkJOR2dZbGp3LzZQNnhY?=
 =?utf-8?B?N1N5Mk1nTFlDV0o4MHdKSS9jNDNqT2c3M010OWZTbGNnTmJlTG9WcVNzbFd6?=
 =?utf-8?B?SEdVdE5tUGNJSUtYLzRtTGtIek96bXI5TTN0VkQweUlta2VuTDlscUtWRlVk?=
 =?utf-8?B?OVVVeDNPREhpQlZDWG1MUXNIclNOZFUwS0FoWlgzNVlicXpWMEt1K2FpVGRO?=
 =?utf-8?B?eW0xVkIyV0Jrek5VZkFrUmVOazJINlAxS0ZiRkc4cHpERWk0dVhHN21CUW1w?=
 =?utf-8?B?dS82WEtBS0I4MUdEcjA3L0dEOHN4MWxzb1NMd1ZSS2dLUVJHQ0l2Ykh6dVVj?=
 =?utf-8?B?S2xFUUlWL05SS0FKNThZY1BkcFRQYWVhSzRVR1RqYWdWUHVpN0o4dXFuWCtZ?=
 =?utf-8?B?RFR6Qk5JWHFMNVZVU21ycGxwL1NLaXBTMFkvWVdQbW1OZkRyQjFFVis3ZDZZ?=
 =?utf-8?Q?/Oyc=3D?=
X-Microsoft-Antispam-Message-Info: Y/qMLRcgNcNcKX/J9NeQApVd9eyYWkJdyBcHshTGyIzt13Se4K5LdLaMKcP9ZpT5kE8HwHIYpI4OYIxSocby0RmlbZs0yWkZtj9um+e/qmqUayymB7WildaM9ZZ8Em2W8BFCJmVDsBsiklqgf2HEjHBE+Mzz50bKGp9hl8O2jql7tMzbS4atiZWYnj23fla0
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;6:SuBX9iqCL1EbciSy2siDQmtVS/2IdQPotKjQcDc2KOMpZCWB7eGcAT4fEnvOcrpLRPyp1t2wmyA+gdcYZdkyqaCs5BgNTiBGFLH+gJzMOAuPYalxwJCm52Cuivy+H+stp0hH3rUCpfS07oBQvC+vrxWpiUb/HxnrHQpNK/aOmhQjm4zlZiK9vLVqRXwtve3p1nV0eRzZLsfPDHYCGsLX9jjkHCMCp2Vhs6Wz9ydBne90d5Hlp3WFEXDLg84Vq4Or7kidy7RXfurTqaFARRh0fAChHWAdv/VIk67k288ChxSpaTE8Xhm6b0Uskkf4Yt8DV+e6PisQKL8ZT3Xooki3vz7kp3aCsBzeLBbmN2hHTvlLm/SoeVFGDBwgDUe4hID46qo2ymx4pO8hI4rttqnNv6xo6tAGs49K6yyLSZlMsiImZWAMWe4bslvDR3nKpu1qSZpVSbOfFB2IVRfEO0WS8g==;5:AEzozZGHTKlidMSIh9ENb9LKNixvx7H2cYX7fW8g/ntr7ViSGJAoW7vYSE7WyzNlSsca7GZPxL3jN5mQ9DDRjqqxFDM1BUxDhitKvmOoL4iwoA80uuACwJCfQYPhaDoTDGGxu0WPL0s4qsba6h6IQeGYsy4qK7dadKodZhmP5Iw=;24:HstilTuhR/1tgY7AO7ZUgwP78Inpb3j3t7v7/h2alV/1d7oGw4jK9Eu7ygsViEtXChW7tHpItNJ+KHB26OlsZM5g/l1alpOE0EbXm5iuiSE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;7:6Po3HX9sJIA1qtcFEGk4aml5lpzQ8Czv7wr4LNX3kuYxeOtkPD0eytQoyKBOGKAjbCm+46i8wmH5pCtOLHrfF34t+ohxR6rMji03DkiQUnvHhgcWuUJg91/w4JXzKtz2KclhYPBKR1/VyxiN8pqW4r3p4O/VT+NR8rwbw5l9xoFYgTB8je00VLCkqzpjXJJy0RjYSFAdg2LPBXUyhCbdnEedK0QbY7+6Qfa3WucJbdMDM1IXiKkMI1iw1bJgAeKn
X-MS-Office365-Filtering-Correlation-Id: 439557d8-4621-4e0a-fbc5-08d5c07d1b5c
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 07:16:29.8129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439557d8-4621-4e0a-fbc5-08d5c07d1b5c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/05/2018 2:20 PM, Thomas Gleixner wrote:
> On Fri, 18 May 2018, Dmitry Safonov wrote:
>> I'm not entirely sure that it's the same fault, but at least backtrace
>> looks resembling.
> 
> Yes, it's similar, but not the same issue. I'll stare are the code ...
> 
> Thanks,
> 
> 	tglx
> 

We still see the issue in our daily regression runs.
I have your patch merged into my internal branch, it prints the following:

[ 4898.226258] Trying to clear prev_vector: 0
[ 4898.226439] Trying to clear prev_vector: 0

i.e. vector(0) is lower than FIRST_EXTERNAL_VECTOR.
