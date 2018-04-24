Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/CLf3EgNuNHYFsesx2CG3/SIIUt8UrBSnB1x0EfLSoxaX6s/Q2oQkH6eZ+175jvnINZOMs
ARC-Seal: i=1; a=rsa-sha256; t=1524569946; cv=none;
        d=google.com; s=arc-20160816;
        b=Sd0IMPjfgplyGrMOYaRxeoGCdynvlKA8mcPHoKUbR7L1OPtKJGALNfUlKf0fBM2mvy
         NgJrKeKjRt+VPJtBjA2kxbM2/+RbZ1rlNw8HIGPXf2VXE29oDCZGmovbyLwglsQAmLpo
         tm7GIwyNR5pzBa3NSCGEfk6JlphRCmc28XuFfSA/ENF6S1BXJWUbptppl/7FNYjqxQ50
         RVIvivjHlFrIUZtKzNFHJOWmvvB5fHZr3XWHiu5dtASRDP76NCFxzHzm88nd7uZGzkah
         7KbuaqULn/dvlT1DYYOo+Bz8roYLGXBTKj1faHmeKilWp+HHHx2svu9172gL8J90MpBI
         DKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=BbZeerzq5K3/oAed2DdwcAMxLlhcu+is5gXRFDDBZvA=;
        b=q+zr0EvbzWUkmXKF0Ic1c2hC8QAGuHPC2VUGRbs/iPCrc7hOWe0QVwbf52+8mIBcky
         WpfTd8motm4Pi6+8HWKsvRYotCUak+H+cId0IypbdMO7XMdSH6uU9O8zRu+ADc/8xxgL
         or63tss5rdDInNm/5l0ecSpRfMAxv5a7ri0IWtW39j2N+/stW7yPSYyZc34EtXeSzs3I
         AhKWvzcjDH3WIraumkv1kLSctLtc4XRn0EdgQA6o7L4Gby7PCk4axgvY25hC9A2ZL1LJ
         E5z2zQc2iflfEP7dSujV7CU5kI7bkpBf9OHBiZa8H5S1Simjz4/RBYwu9nuO2DEc5WSq
         ePxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Vk6ibwiT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Vk6ibwiT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
 <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
 <20180424112844.626madzs4cwoz5gh@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7bf5372d-7d9d-abee-27dd-5044da5ec489@virtuozzo.com>
Date: Tue, 24 Apr 2018 14:38:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424112844.626madzs4cwoz5gh@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.15]
X-ClientProxiedBy: AM5PR0102CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::45) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:uDsbLFFeHvGyy7D4T0zrqMvIEIldDR7Y+cIL25QnxvGeKcr97bz0qAAnhWZHY8TP1DOeVGlGSMmjU81DBzITX3VxF0Ssv/JZEDy9T5tico2nE40vN/h3/Isnc+T5KMiAhuFfnzo7LqJNk1JeE0384JRutMUuto3ddAYbO67HJsw+Toc5Ppl+mJ0N5c7o9qJ5Gc6O1TtgPz7+UxeEA7VnK6AMHkf3Es8eqBkrB/IueMJLqusyTB6dtIW86rIoiGlq;25:hjnOXTzWea5J/SFTGa/GoWci/LA/4t8/GTG2uR143kUmUpxm4R8Af8bsAKVdtCx0HtX4kRG77r+SE+DDE1u+3J79RTkkxySEpa2VYtXoecN8Spr9PGd5/o6Vbe37VaS4pzcBWCEiyaog3sB0ahXsRGKFWDE0XbiiZkRDmeNxg8hhB6TJUUx6KxONf09nQyV9SUFBVRZ8iVZ7TFS3RzVgFCfyDjNjkLxhLpUb1FA1X8+QSfMaYorGKkoi8mgm8D+Q5tzwc8CHgxGpTDfaVEa0/rARHi5szjQ4LuyW+EOpGcooKMHuTr4/XXJfQF9JM+DEV0AwwG5dYnPaFHctmM3Mpg==;31:O0GUTH1LVY1jxVD7GAKC5DKdwVRpSwAgxo8wewlbefKuy2+IhNAybZaWETv/l7hbag04WYMI4m6BLBCnC9yxF8fmdlhnWu1KWWxcdG1m0/jU7sCp/jkBIu+UbFOD+gTwj1dqzOVctB/YRBKIUh0GndcRKcRuC7IfBgMiBEqz862Riy0QYliCnobAV2Urx7ln2XtVIBTX8x40mfveZnLdJRDS/A4Wh0vyXcfHd+iHR8s=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:gW+tIlsVzN3vU4iVRT41iQ5O7h8EdgEuQyC8fij4wu1cRykiY48N04DTRLUWaKS4NWTceTct04ey+wE17Uz+ZzLSCXr/gZvPGVLPuMqK6SZHHTYVTRNUqn/IXcV0uGqmvJe2GAUo+ivWMEaz9sebPDST/CdJjSbXYCojNPdGSTjFZ4Ae6epkvQtfuqT0Az5M3MZEjG/MM7iNcbYJs3e0GHkQ2NzEfqYxpWNxUn5HoZ03cSoQluMjlpTGShrRBy72zLdBZ0PJjraEzrzw/B3Hr8RdgPBWrHgNmJ55dc3XPKySFRAl3SM5CZ3NKZxSggM6btDgHckbblwuWjKaF09NLpxBiWtq5+IEH+Wy1X2yGLj535+kdJik/JeQaMiyQAW6ShC34HoGax4SVjnpQwXe+Ebi/YzvBI5uPCMptwsUH5P9epOy6Rb9/MMW1mIHSBB7Xz/gz14TCPSIQv/VZAR62WitkfMvK8CCauDitF6FKGOuG1njps2q7SOSje9Qo9qr;4:wdS2XhC9X4sJP0xdZct9et/20hZw+NdKvTBv2bwQzXIibb76aNF2pwFIdz26xxthuogRZ8a2deWng6RtSh6iUDZ3mkOVieksZehxdbPQ6YlvQZsEzh3NyZ4IvxukRlODwxhTLDL6apjJ4detPblUgIW7VH/LnJplDgq0QmPhvzKvDQ/le2SjSSA4TwQDKUJfXLFNkqMCVpaIhtekRd4nNNFcATSrDUZ7OnMMMl9QuiuK+ZMWLL5ZG45/WkllmniqJbCfRiCiS5gB6py7NAAEEw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344F98C8F02120BB67AE5B4CD880@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(39380400002)(346002)(39850400004)(366004)(199004)(189003)(64126003)(16576012)(8936002)(16526019)(106356001)(316002)(59450400001)(6916009)(6666003)(7416002)(68736007)(7736002)(3846002)(6486002)(25786009)(486006)(2486003)(58126008)(229853002)(386003)(6116002)(53546011)(47776003)(97736004)(65826007)(476003)(230700001)(23676004)(52116002)(26005)(77096007)(956004)(52146003)(446003)(11346002)(39060400002)(31686004)(93886005)(36756003)(50466002)(305945005)(478600001)(53936002)(2906002)(86362001)(81166006)(65806001)(65956001)(66066001)(5660300001)(31696002)(6246003)(4326008)(107886003)(8676002)(76176011)(105586002)(81156014)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6bDVDV09lcWhITmZ2N3NObzVzd1BHVHM3?=
 =?utf-8?B?ejZrV0hDbDc5SWhwYWViYWNWd3paZmpZWXFqMUxjbXFsb1lJMm5RTFprVHBG?=
 =?utf-8?B?QnlXeUVOVGV1ZStWeThhNmFUTkFqZytYYlBOUnNIcklINVIwbjMrNDJyTVpx?=
 =?utf-8?B?Und2VkNIVzZxMW1DSDVKL3cyc0RYcmJmTGtYdHdLS3JtNFhFbCtZd3llMVdn?=
 =?utf-8?B?L0NkakF3d2Jpcmx2SnhUTmNXVHhrMVMyQWc1c1VRdHRsYmp0NjUzMUlnWnhQ?=
 =?utf-8?B?Zjdna3g5NUkyWW5zcWNzRnc5ckRPQkdQSWZ0d1U2KzQrM0F1YjcvQVY2eXFF?=
 =?utf-8?B?cXpXOEp1czlNZUhuVGJXNmpsQndOaG1SekNUUGlXK2t3amxTS21RdUZzMUl4?=
 =?utf-8?B?Zk4rZWQ0dGdmYk8xYndKblNiU2pncTM4L2dsV3Aya3M1MnFXL1AwL3J3M1VI?=
 =?utf-8?B?NDFEVm13RkowRHAvY2NiYmRPbEUwWWJMUHhrcWFoZUN2OFNGTFBHbWdnUmkr?=
 =?utf-8?B?S1Z6RVJuMTliV1VaMWhsemx5aC94MEljRmVBUlZlWE4zbkNIYVRaakZCZGZh?=
 =?utf-8?B?Sm9sbnlCY1l0bXlab0tlenFld3FQbEtZL01TQk1JRHY3ZHQ1cmFmbFBQazJX?=
 =?utf-8?B?SUtidTBNbTBMUXpoZkNTa09uWHdvbDZlRnZ2alNKeksvZzhucmhMOURiMzB1?=
 =?utf-8?B?OWwvZHB4bXNRbFc1dUR4RE1ERGdoVmJ3T2dWdW4wNlNWYU1ZdzJYamYwL1pw?=
 =?utf-8?B?MDFLSW9pcUJDRU9IYUt4TFhBS1JCWWJyTm1FeisxMHFqSlUvQVlWQWxuLzcv?=
 =?utf-8?B?bm02T1UyVndYQkFiM2ZxRHppbGlqNUVVRkVva29XcXJzc1VNZnFhZTNsZUtn?=
 =?utf-8?B?MTZYUTl6WWlZcnhnTjVHeFh6NXFKY0ROYW9HQXFxWWRCVjljZlRTWDAxcXlj?=
 =?utf-8?B?c0xOV2hLa3BXb0QvSUFyaXcvRlBZM3A5OUdTYzVMajZLUGRhNXB2cHFnUEQw?=
 =?utf-8?B?ekVaUm1oNzhzV2U3MmpzTU5tQmNsdHUwK05BalhjQXZRL3BNQmswYXBXTmZE?=
 =?utf-8?B?TkZxS3AwU3huU3VTeGRqTGhwQis3cjhMMVY2MWVVSjJGVlEvMms1VXpwT05q?=
 =?utf-8?B?ckpuNC9CQnp5WVo3clNDTlNnZlRKMEZ6d1poandSM1NJdUhWUXhLazl5OHp1?=
 =?utf-8?B?WjZMZWNua052SFJZTVlHaHg1aGNPR2x1Tjl4SVc1RVA5cEhQKzU2NGorckxj?=
 =?utf-8?B?RjQ3b3JHTkw3N2lqVFM5OEZxazN2SEpHL1R1YnFzak1DS3lGT3VBN0JOUGJK?=
 =?utf-8?B?NG9DSFZ1SEZXYjBWR1g4b2tjK0NVUWRqaUl0clhYVjZydjNYTkNCa1VZemkr?=
 =?utf-8?B?N2lFb3hJYmthcTg4cldsanlYckNVNGlTZnZ6TURjTHNSUHlJeFFGckdGc0Ev?=
 =?utf-8?B?akJMRkh6NHJkWENtMkdqUEwyeTZ3bFV0RU0xTjYySFFxRFZpTHZid2xRa3Zw?=
 =?utf-8?B?SGZLYTYycHpMUU1rdFJ3bUxwWFFSeHFnRERNZlE2L0dubEt5U2R3NjNxT2hJ?=
 =?utf-8?B?ekEyb0VUMGdjbkhNOFJJQ0NUMzVYbVNoZGF5Y2tqYUk2UDcwQ05XT1VBR2w5?=
 =?utf-8?B?eDU1aVJQS0x5UW01cjRWeUFBc2VBTWZDemZSMmVSTklOWVMyMHJ4UUhpTkxD?=
 =?utf-8?B?OTdqRVhsSHpRalFCSUxqRC9ha0JLTmg4SEtPb1ExNStWbUdXWmc3bmc5RlY5?=
 =?utf-8?B?dWJ6RWdRU1M5dG5IUitEQXlsbDd4d3p5Y3p5ZHpqdUVOY1FNNVc1NHNVa2k0?=
 =?utf-8?B?S2FITWRtdzk1Mlhrem8rdkRQSVlCM0twM2dXV1FSVWp4QTRscHFrSjhSakRU?=
 =?utf-8?B?YVhHN2FvdXc0WUt5anc1R3dBb2xCY1JDY0RXeHg1NFpYeTBDcmkvNWNTZm12?=
 =?utf-8?B?ZVZtZ29ueVY5SWtHYjFGbVZrOEF2UlZ4azRleHNMTndSWXd0blVxZUhYRmlQ?=
 =?utf-8?B?RjdBZlRjckZEQzFsVk5mVko4VU5FMUUwcmhXMFFGMnFQWGJoYlYxTjBrYUZm?=
 =?utf-8?Q?PBRgsc=3D?=
X-Microsoft-Antispam-Message-Info: EuhFJ1nkkZz2tlAS1fJX0Gzl94BSCCQtEpgh/5e1p7rPHNi2MVUOD3ld/wmbbNmfnmovuCt48hTAlR+tPP1NSFpAMnnTpAgJxDs/2hQj5dhko++OBYkRCp/gCDSd4NLFH0qZTqxrqFI7eA3mtLxAH7+PfbuPYTlgDSdctC1J9tlzNMKULYkrNIU5OCOf5wnW
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:gzycXGQlKgX1bhjoTQ69P+FC4oPH/nKPyo8lFjcyeWUy5jKEK9b5Bv9mGGjeAJ+UdlHmOU6QU38A7zn2aiS4Wqkkomqrvct8fuGfWGSYcJh9PnE/tf7p67TPvZGcdQkGQ5Xsu8pMPxgNPDh55vKHZOh8tAxakogvUK2J4XhdLtJeAd/FZacCUM9XbOjIuzbCOl9hPDlEPpqxv7fU0zxkbc2+HvMGEB+FtSPz2iehNpQyeQJrErDTUxpRdR3NkRpJLhDlYWJmRKNw/7H55fIoa2oIonfrZrtDlsjKb3Vl7wdlrv/FAHC+xdFkLKfRIhqTVZhgQVxDD/Ocd4xAnL/PV6EPuA089GuY+0BVMZgYUaxID2J7Nd1duEY3rRk1qe8WnfS3H2CQF8pJb8aJkyZUn7HP4eYHtFKm5LpdKdDyW9YyhZTz0os6AJpetKEpjuc24+okU7aqu1S5R8PHfjl6WQ==;5:JiSHQIn4UBmm0K2+VnUfPm8Jr4OcI58HJZsZIqYBKXHdiZ2hQaKK4g9BBuW/WgApntj8fLIdDpocmeg7n02rtxF7VOTJeAQ+aRd2XIE0hWU5/Zsm5k4St1XSLYVoxYQV0L7ZGcCE9cDAyonGszuBuCmWj2U8B5icE9PQixfQ3+8=;24:v+q4md5K6ADkiC8v1Gu0bW5vBOI3zLesItHu6KBf7NxaX97Qz0rpmIp2xR7q/EP34cgEjOIhHThtuEtUqJLNDzZ/XYn/FnsDIKZOD7kfbe4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:6BbsfunXlE8pqAh3Wrxe178HaF9jYjduqpK/4pdAjHCBTU391eMx6ZKLrSRj2mdZr0a63S+fhg+AIou2ViSe+J4deHyYalSvGlAT1pe07BqCY4Fd+AMCf7n7GovjSJYHRDyPeX5XksFaEkEyvGfHt3nfHLE85MjNnMa7q2VHpZg0JCqt35rntaQfIgFqRPP986Wc6Td+Da5W2OclYhmN++fUYVLx7ljE/HDK8o+Qt/LRnhW7222GWUkCMxxAuoTD;20:CfRSD8cFGzdu89mm+D6IukoyEqG0YWl7jv4pTLEVaQupmSsz6Fa+JI8m8LDRqj9DEjZW/RWqoSLEAyYSiFE0r2bv+LkPs6JXapiltfKFI3vi7V+ixU0gsM/CxezAwyYKoodvlg4wAaQ5xK/z/PBRURS8Fcf3Ry7XwdeglgRP38Q=
X-MS-Office365-Filtering-Correlation-Id: d44435ce-e700-4ea9-f311-08d5a9d7f90a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 11:38:58.1755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44435ce-e700-4ea9-f311-08d5a9d7f90a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598627456568581681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.04.2018 14:28, Vladimir Davydov wrote:
> On Mon, Apr 23, 2018 at 01:54:50PM +0300, Kirill Tkhai wrote:
>>>> @@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
>>>>  void memcg_get_cache_ids(void);
>>>>  void memcg_put_cache_ids(void);
>>>>  
>>>> +extern int shrinkers_max_nr;
>>>> +
>>>
>>> memcg_shrinker_id_max?
>>
>> memcg_shrinker_id_max sounds like an includive value, doesn't it?
>> While shrinker->id < shrinker_max_nr.
>>
>> Let's better use memcg_shrinker_nr_max.
> 
> or memcg_nr_shrinker_ids (to match memcg_nr_cache_ids), not sure...
> 
> Come to think of it, this variable is kinda awkward: it is defined in
> vmscan.c but declared in memcontrol.h; it is used by vmscan.c for max
> shrinker id and by memcontrol.c for shrinker map capacity. Just a raw
> idea: what about splitting it in two: one is private to vmscan.c, used
> as max id, say we call it shrinker_id_max; the other is defined in
> memcontrol.c and is used for shrinker map capacity, say we call it
> memcg_shrinker_map_capacity. What do you think?

I don't much like a duplication of the single variable... Are there real
problems, if it defined in memcontrol.{c,h} and use in both of the places?
 
>>>> +int expand_shrinker_maps(int old_nr, int nr)
>>>> +{
>>>> +	int id, size, old_size, node, ret;
>>>> +	struct mem_cgroup *memcg;
>>>> +
>>>> +	old_size = old_nr / BITS_PER_BYTE;
>>>> +	size = nr / BITS_PER_BYTE;
>>>> +
>>>> +	down_write(&shrinkers_max_nr_rwsem);
>>>> +	for_each_node(node) {
>>>
>>> Iterating over cgroups first, numa nodes second seems like a better idea
>>> to me. I think you should fold for_each_node in memcg_expand_maps.
>>>
>>>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
>>>
>>> Iterating over mem_cgroup_idr looks strange. Why don't you use
>>> for_each_mem_cgroup?
>>
>> We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
>> mem_cgroup_css_online() mustn't fail (it's a requirement of currently
>> existing design of memcg_cgroup::id).
>>
>> A new memcg is added to parent's list between two of these calls:
>>
>> css_create()
>>   ss->css_alloc()
>>   list_add_tail_rcu(&css->sibling, &parent_css->children)
>>   ss->css_online()
>>
>> for_each_mem_cgroup() does not see allocated, but not linked children.
> 
> Why don't we move shrinker map allocation to css_online then?

Because the design of memcg_cgroup::id prohibits mem_cgroup_css_online() to fail.
This function can't fail.

I don't think it will be good to dive into reworking of this stuff for this patchset,
which is really already big. Also, it will be assymmetric to allocate one part of
data in css_alloc(), while another data in css_free(). This breaks cgroup design,
which specially introduces this two function to differ allocation and onlining.
Also, I've just move the allocation to alloc_mem_cgroup_per_node_info() like it was
suggested in comments to v1...

>>  
>>>> +			if (id == 1)
>>>> +				memcg = NULL;
>>>> +			ret = memcg_expand_maps(memcg, node, size, old_size);
>>>> +			if (ret)
>>>> +				goto unlock;
>>>> +		}
>>>> +
>>>> +		/* root_mem_cgroup is not initialized yet */
>>>> +		if (id == 0)
>>>> +			ret = memcg_expand_maps(NULL, node, size, old_size);
>>>> +	}
>>>> +unlock:
>>>> +	up_write(&shrinkers_max_nr_rwsem);
>>>> +	return ret;
>>>> +}

Kirill
