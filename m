Return-Path: <aryabinin@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpse7RSRwVpOuvy2e3PVzwkfk4L0RmRInRkbRUhxAuEA7DXWGvDKTJ2/Fj60Mb0kCt7NdZ/
ARC-Seal: i=1; a=rsa-sha256; t=1524146075; cv=none;
        d=google.com; s=arc-20160816;
        b=sX58dbYP7GIRTOf/US/HrgpNE2S6uXAAK9m1+O06xLvi0iyJP46H979pPTWr4W7gal
         4v8NoUIm1LxbzVo5VJ+dqzoT4b4iMsovGhOSPzyY5L5xIVdfL/7lQu5y5JecuqOVX0Mp
         XAvFK8bgVAJYFz1sZj/mfWEELhMRVzqDv0ZhAC5z8SMAG3p9X6DR2Q6Ct4YplZnJVx99
         ecJb4aVSb8utfW9Lpod2UT6K5JfNiHpj42SnaGak5y4ex2EYavwIo0SQlrCtHudcbNIX
         LKE1eeFKDrhs2+4AJYcW+7UazvBvXHMxUDf+JJHzI+CZahHnIPL16XPp0BY04Gjjrsc2
         +p3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=McbiJNRyjUQcf8G54aANqsKTWD29fdPTaHflwCmjiSo=;
        b=Clrauj6SAQk1YPiqsK8605Ori7H0nZ4rH06ulcWb5CDIKQsDGp3RO7LL/en0TJJEbG
         2chi5SAvIbIgh2+CZFfAmpedB3jy2Jf9lQK/wqxJPiyM7bbSzaAVjfS6YiLkQPMeLlD2
         qchR7sJTeaYVamPb9qH61LrhCaw/O0QQtCFniO2T8AWSF8N9kzLQUA4/wp0O9tWRzrH/
         SZsoaerhsAFUtfk+xq60IRUKmuZRleAwG1EtG34e9C0X2H53178nUuIu3tZAI9fx250P
         AekBCTTbuhS29EbNj41tbJlJRxR4lFVdxevogafK8t6VddGEakC5WkK61ZDDu1NYQq90
         3fAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ZJhzx9ZZ;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.2.130 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ZJhzx9ZZ;
       spf=pass (google.com: domain of aryabinin@virtuozzo.com designates 40.107.2.130 as permitted sender) smtp.mailfrom=aryabinin@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: 01.org; dkim=none (message not signed)
 header.d=none;01.org; dmarc=none action=none header.from=virtuozzo.com;
Subject: Re: [cfs_trace_lock_tcd] BUG: KASAN: null-ptr-deref in
 cfs_trace_lock_tcd+0x25/0xeb
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>, NeilBrown <neilb@suse.com>
Cc: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Denis Petrovic <denis.petrovic@edu.ece.fr>, lustre-devel@lists.lustre.org,
 Staging subsystem List <devel@driverdev.osuosl.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
References: <20180418133831.uef7d77ejdyjtxgh@wfg-t540p.sh.intel.com>
 <20180418134058.l3orjjxcpv7cxjfw@wfg-t540p.sh.intel.com>
 <CA+55aFz=VCq6w=kH5aYavOM0-h130HgzVhVc94JxeYSdbMWbxg@mail.gmail.com>
 <b66f6034-7631-7fbf-56aa-e8e136e8b636@virtuozzo.com>
Message-ID: <dfa02f34-5ada-70fe-0fd7-c494d632f8e1@virtuozzo.com>
Date: Thu, 19 Apr 2018 16:55:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b66f6034-7631-7fbf-56aa-e8e136e8b636@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::33) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:fCrcknngYuOroPvC8lXtxfVJyayVg7jNB3+e+KoSEIc86XBrk191hzssYELskRGHhmiRSptTDNlMIASBYFOm/vJTHjh0/5pbmxOSKzo5AO1BefEge9fVfwx6xcTp7aj3geV+VVC5BNVV1Rq9usLlhb9chqkXFtNR4wbw9V2ebZa0z3+64M1K1+J1MrcsPLhsf0Yfko1be9aR/6NCwy8iexDgjE67fMexZdYbaezuxeXfOJPLtLscvOhqDmtoM1Na;25:Y9SfLpM4uop7FL+8r28jZDcNz6DfrCh4ltmjryUWYUpjL0HidexBa6siITJkmNkVYAqxDkHnx46HuC42QuKtTdXQPHPn6Ge7cchdPRX/cRZBiP74D/CYvss31Jsi1BAsDb096JVWqMhXo+M+Eol8knMu7Seg758nrT6pnetZcDWBNHE5R+kHmh3f37ie69ajCYdMty443SWrVitsx+3AV5JtxjZG6ZYQIQ67dXX0cNNP3Kb9xGn65x4+prr1E7CTlbt7cwj+sIRT7hN5RrmpgEw+OBCAK2G3bqQVcjm7HLy5aHdSlpRwTGrP+FIFX5iRZlfSkSHJdA6cWJt/8QZFUg==;31:e4NkCxCMHj2k4pDs/7ncjABuDu7lh7kal0wPJRyL1kxIO6FCkJsNVhYSbECJamlTiW8dfKWdQ3/mX+1h0u5hq4JThu9X13pe4ApdRZtBglyJJL1KOjz02SoBFUJgZZOXwQaeiayu1lEM9szDTj+JakZyHZ34AdZ7yH9aoN0R10WHyxGiz8jezpxlGr2RZ2gae/aDoo9p42DHKN+Ll1Pan8edWzLCTuHyL7fiNuoYzfE=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:EGVH6vmrq+fe1jGfzonukRjgetCykeXYW51J92tkO583niRv82lhjNnzjoMJB9ILGUhk/EsGiH0ilgyfJX7HhPatntH5lvUWEStiOhLTL1QbDC5V3a+fV22ChxO+fcCxVA2fyA67w1EVFc69A/AWstxdVk6jtiTGT1wbSD98Wp517uz9+7GGxbJWehp/BRRkuopu/q25bXQiFzJp4LN5j+6H0eks591Hji0EvEaE2awAuErMF2iGP6DCMKygW0Iqb009+ibD6G010In4EHPi54HFptSZK7RvcuxzwWXWB7MIuxafz8uV50ixkO5Wl4uDNTxL+NJFoOYyN+4DwOjhX4aduas3F/saBIWU05QQxFNffXJBTj/Yozf6acoSlE2WBbGx73I2+uJ09fOHbX3TPdqBWOr6eDxhIbLkqbyhICXVwLYqF3jermsh6tZr9NL1/Gm0j/jpWAUDOqWw9jwyZdHphfEt+TOkAypgB6EMHRNann23abamN5HCCFRYGW53;4:8ACrVFHppwb/QYnj3BXaINBaHgsiCTiH8OxYs84CYnTPXpUP2NOZgdz3KkiAwcwWAjy8NKO5h/qmorXQ6D1iYB9pdcjx9prkPNRZNxXiGv8sNRZLPyTygEupu3GmL8fkp+5YK9gwMXoN+YT/zEJmNm2OQx/GhzVNp5FP44dWqO+16tWyik81xpXMHJqtOW3Lvt7ZR8xHylXKBUn/Yzso05Yh0y7m6dinOC/Ypg9lcE5uEtx1vXl9K5SbwU4FSG4CqcCpL1RTC/rQ0WYc7we4WNBZ6+hl6XEDUmPaDAoGmLhatMG9nJGPVTQC/BN4KcD2UytJzXZFJumyWOcZZo4zt5rKcCGT2CwDBHThfBIhkUI=
X-Microsoft-Antispam-PRVS: <AM0PR08MB3251031F0C7602551FEEE4A9B0B50@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(39850400004)(366004)(346002)(52314003)(478600001)(2486003)(6486002)(4326008)(76176011)(7736002)(52146003)(52116002)(305945005)(53546011)(6306002)(53936002)(6246003)(23676004)(386003)(55236004)(25786009)(77096007)(26005)(8936002)(31686004)(186003)(81166006)(16526019)(8676002)(3846002)(2616005)(956004)(446003)(11346002)(6116002)(476003)(966005)(5660300001)(6666003)(230700001)(575784001)(86362001)(7416002)(93886005)(316002)(36756003)(229853002)(66066001)(65826007)(50466002)(31696002)(16576012)(110136005)(54906003)(2906002)(47776003)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:[172.16.25.12];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUxOzIzOnMxb25IN0hHc2lYd29rUlRibXY0NmdTQzhI?=
 =?utf-8?B?WHRRdzlaTWJuL1FJTnhvMVhQcmUwcjBybFhzWHBJV29Nb25tQU04ZSs2blI3?=
 =?utf-8?B?U1ZTNGdLWlhEbGZ4QmRsMStJL3JwMW8vTThSTlNIM3N3VWV0NGNkZDhNTjlk?=
 =?utf-8?B?bWs0Sk1tVkxYODlDQnFUb0xsQklDMXhhVVRBSHB6RFd5ay9wb2wzTmIwWG9O?=
 =?utf-8?B?RWtOc29USEtkVFZtR2pCanRIK1dIUkVvSllTM2N1ZFhJRDJmczM3SXhSTktO?=
 =?utf-8?B?NW5sK3VLVC9Eam9JWkZXSHkrT29QNFBRZnIvdVpuZjJsODhrdUlwMGUvc3N5?=
 =?utf-8?B?bVVsWEdTMEJZd0FuUkpOQnpRWkY2LzN4SStSSDNaM2JxRDZJbXg4MDBGdHFJ?=
 =?utf-8?B?bzdOZTBsWVJXRC83alJQSGpvdmN4QWdMWCttWlI1L2R5MWs1WDBzdkkyQTBp?=
 =?utf-8?B?ZzNwbkc1ME9sQnMwQ0pMSFdON2R1N0NMelBhV3dEZ3hUVWdpMEdSWENQa0pC?=
 =?utf-8?B?dzdiMmo2aDFHbW55aVIwbjlyQzFaWkY0L08xUDVsUlhDWlVaUkxyUktMN3Mx?=
 =?utf-8?B?M3AyLzZlUXRLQ0FUcEZLSzIzVG1BdE5HTjQwYzFOUm52RHNsQnltZHBWTWlB?=
 =?utf-8?B?VVdDTFF4RGJLZXpQbmZIK2JkN2tmSWRwOXdIMkhtVkxuYUp0NHRjOWJNRjMx?=
 =?utf-8?B?WEE5UWhlYjJrMnpUbmxtZnpWY2ViYnh3aGFoaWZwdWEwUzlRRXdIU3JKOU5W?=
 =?utf-8?B?cGZEbjdyOVVQNWVaWjllV2ZNVFJ1OTZSa0gyNUdVNG1UZXdIUTR4V2lRcEtK?=
 =?utf-8?B?SkVVTklpRWxreVdiWmswWkxFb1BNeklRZGtYL0RzSzZBbmRFT2tEZ3R3QVA1?=
 =?utf-8?B?YTBXbnNBK2pobnc4VDBPZHA4N1ZqY2hBOXg5QkNKZFBSeFhIOFljd1N5Nm5L?=
 =?utf-8?B?YmJoa0Y2cVJ1elQ2Ti9McldVQTVZdkljNWZRRWNteHpPazkyOHA5dEFkU0pD?=
 =?utf-8?B?THI1YXBSSVV3N1Zlb2FaQXE4RGg1Rks2ZW1ZUmtCajNFOEcwTktmMVZRa1dB?=
 =?utf-8?B?aTBKcGFZSHlyTHlnQUlITjJodTBuMjR2dXNwNmtQYzI5R0tQd3pBMVlpWVV4?=
 =?utf-8?B?YVF5M1Jzb01tUGZDTkpTSFkzeWs2TmQ0ZFo0YmxtMldGWlpPQjROa2lJNFhZ?=
 =?utf-8?B?UmtsZ2NOTzZ6dkFBUkdtaVZ3MlN6L1ZIbUQyTXd5eWdjSmpEa01ITktpbGRG?=
 =?utf-8?B?MlNBdlZWVGNEMUtLYlJiSXNidXhUOU0wVXV6R2JEL1Y2aGJ1aStja243NlRn?=
 =?utf-8?B?RkdRRnpMOEFPV29LRXdVa2hrVWhmaEZXOFdnZGpJK3VXRTEvakUrNFNUUVNY?=
 =?utf-8?B?QnJJMWk4d0pqZXdzNDRveG0rZ0lWUDlnYlI2TEpOOXNFdkRuaDBXVmJEZWVn?=
 =?utf-8?B?OGhNNzJEMFlYYXhKeDBGZHNhQ21lV0dRdGRSek56RDlQVVBVcTQ2TzFtWFF4?=
 =?utf-8?B?Z0hSZG1BYlBZd0h2Y0NhR1o4SXMyU090ZU5KL0N2c2Zsb21wSnkxV2tVQkVD?=
 =?utf-8?B?cnNHakNzdWdJVGc2UnE0UjFhS2gzRGVweWdwdmN6RXcxQXB1bGdTeC9mRGpq?=
 =?utf-8?B?Qjhqako5MzIyYm40eHczcWMzcTBUamY3NDNLV0UyUWUvY1VyanI3TDdwbzY4?=
 =?utf-8?B?SllGcWxoWkxIbWlVUW1COFh5dnNLMFc3dHFEcTBHT3NyM01TUC83MGVvVEFa?=
 =?utf-8?B?d0JvV1dnRStnUnhoNEZkU2NpMXhaUG9mV1ZpbUp2ZlJ1bUEyY2k0blNNT3dj?=
 =?utf-8?B?VTZDS3FFY3BiR01DVzVBWklRR2t5S2E3STZPckptNnNGRkE9PQ==?=
X-Microsoft-Antispam-Message-Info: jrLzvpmjASmfV/KKsb6amgwBSa6iKW5mWv/JGPkxcfe0He6NTuK4zD7/0ynkhS4vLbPOKCaCwRtT0BFbcmrlknwSMm4WPO4S8UQNuMB6f/k0nLUPLa0I02RK3+Q7Hkj/HbEeUFrydFMbPoLsGFCU3rH2lOR/+xJXVw2zXV+BXHjkkMs2hqO+Ztm8ArA3vZVu
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:4eH31QeqnxyBC0s28K+bVYwXQAoyI1NlOWpzA37O0diH+BDWuNe6z8F5axHJhw/KAdXxggxK+vVU7Of0WbrS4z6k/VDl7xUwppKjyOwlYBwW9jJme4ahuIciDFwxdMBvCBw/0cPOgeJxnwHKFz8U+vtPxOimPnAr57bAqT5sGbUFs91MIBuCc5pFtVoCdLEghlKUnWg8HY0PP1nr66iqMDbNLqYUKryc2EWloeC0OwnBb+Fj2XIvuQSgjVR7ptPmvHHViFFYuJYMRD0+bgSTACJeyogc7+MUjiXLpp2Uawm3bmyTOVTKMolronW2I6WjzZOfPTNJBBR4Jz7C+m0G1J8uwDY3geP57hT4bJmXkDRJoP5HqmnJApeiKXSIYscTZ6LAPfVp7L1qC5FbZzmEIKZ9xehhyREzHI/S9pOdPJPMrq6djXY1gqxIX+mCkbnre3oqcR03PPDQ1FGolCTY7w==;5:X7bZM8WHpvrCZDfPW3kGr1tar7DB8HR+Q7YvuUePyFcSNMGu5QHdn+vlHzXbtTkesz0kmtMuVRuWhOy6kaooVovFRf71QFu83I2fB7xKgb9et5cBJtnQ2csYW7JG0NIy3VBA4bWbMup4GNDnOFdXCeFQumwRkPnATM98rvshTv8=;24:fcRhGDPbG0Zbds116EVGZjLdYkGz4I1DoCpe0gp0Uv1RLBCovfxJYdqKxlrIh0Airkz81OTI4ZefwpQr20WgoFxt7Dux1v7rdZoecWwGouI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;7:q3aXqfOxwIRmzcHpQousuRnDyay8t5RSFMD4SbgJ0bP5gbD/2Z+HmHbm9c2r6QdnJxLyC7rExaCp9ybA8okox+rQgcUC6zFj8uqj5aOL4t8flgVIiOwwVOGpbx4fBL5MoTNSiwSs95/CPjineoZkI1shZaXmu9isj9Xy01iPpy6+Y/ie6rL5X1hdzUBn4hxk0rjNp8f8TrnsyimbXfu7X/LEU6WLG7DsGHkQcfab1b1iC7XS6mi7TcpZkVI3vP7L;20:inTyiDPIV+dUIi445jDMhjrh4HHfFVn2RcvpHGJLahZMZm1dIqyV1n2W0eYSekKFEwYWfYJupSdD/B86KRMcDAK+ol0zbDoCv36E3nSRCKdZ5BscozEICJwoWAb7VsOCYfu2UbCWX+OWnxL/Rx1tpYAzmbnpZqMtuGGilBI60G0=
X-MS-Office365-Filtering-Correlation-Id: a1ec3a73-bf49-49b5-3ed0-08d5a5fd13bc
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 13:54:31.1081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ec3a73-bf49-49b5-3ed0-08d5a5fd13bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598091550256531205?=
X-GMAIL-MSGID: =?utf-8?q?1598182994386098200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/19/2018 04:35 PM, Andrey Ryabinin wrote:
> 
> 
> On 04/18/2018 09:37 PM, Linus Torvalds wrote:
>> Ugh, that lustre code is disgusting.
>>
>> I thought we were getting rid of it.
>>
>> Anyway, I started looking at why the stack trace is such an incredible
>> mess, with lots of stale entries.
>>
>> The reason (well, _one_ reason) seems to be "ksocknal_startup". It has
>> a 500-byte stack frame for some incomprehensible reason. I assume due
>> to excessive inlining, because the function itself doesn't seem to be
>> that bad.
>>
>> Similarly, LNetNIInit has a 300-byte stack frame. So it gets pretty deep.
>>
>> I'm getting the feeling that KASAN is making things worse because
>> probably it's disabling all the sane stack frame stuff (ie no merging
>> of stack slot entries, perhaps?).
>>
> 
> AFAIR no merging of stack slots policy enabled only if -fsanitize-address-use-after-scope 
> is on (which is CONFIG_KASAN_EXTRA). This feature does cause sometimes significant stack bloat,
> but hasn't been proven to be very useful, so I wouldn't mind disabling it completely.
> 
> So far I know only about a single BUG - https://lkml.kernel.org/r/<151238865557.4852.10258661301122491354@mail.alporthouse.com>
> it has found.

Actually, there is one more - https://syzkaller.appspot.com/bug?id=6a929b72a32ca0b1a6985126fa1bc77c03c12304
so two bugs.

> There are also a lot of other 

I didn't finish this sentence:

There are also a lot of other reports about use-after-scope, but seem all of them are false positives
caused by STRUCTLEAK plugin.
