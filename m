Return-Path: <Michael.Hennerich@analog.com>
X-Google-Smtp-Source: AB8JxZqmkCH8Dlk7SE6Xf8Yhq5yRQxSeCQOkxY+P6xQFnNZdRAudNSWxwZpMZxCrXZlGpkNZfCil
ARC-Seal: i=1; a=rsa-sha256; t=1524129094; cv=none;
        d=google.com; s=arc-20160816;
        b=NgkhnsZB6bNE7+8rl2e7t3EJ07L0lTO1/eBVtSzBGtMXIKbhyhLCTG3ukBhQIaB4YW
         6Vu+GIJBqH5pvHjufcMseNdyuIRqO+JUdmeaKTuJPBjqwOqp0TU4XSH18LVv09oAn56V
         3Wh3oe6HkTlI7xxm3ZOqdnaby4KbzHZV7xWxE0Zc4MMXGV3wav/D//TI0e9DGoxh9wm0
         q2hdpKGaQm4AwjLgSYr2SHublpS9G5WR4tNpIAYOqxZbJ27W40CO/SEaQYAtxy6sM7FX
         vL3MU95L2rf+PgNh0vk59wnUCXlSkQ1ujWxoPrxxF5A7ReyyIQXmIifRnvUZOzp7n+oB
         CukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:reply-to:dkim-signature:arc-authentication-results;
        bh=13IAEnkbJSqQ/lGKIk0UJYeo6qtygEvsrvy/+FSqxNY=;
        b=Ov1icMh5hthD8z9tcIBVZ3DHdGAeBxBFzVTMwSVQn/lLBooT8yb1yWskaZsiYuB0wY
         h/z/OxOsknoKCScE2ofcQQodlcAqd5LL8MW9gEgAXLcwgNHejdw/q8339InLmETZSDaT
         SigHdij8K7tyMjM3Ge/i0sZxE1dTXf24tWzwzDJPvZcN0IEgsx1ZeMLJknYLYQskAq+5
         qv3hUU/q4NscNpTUhBnZV5PelhVaeFs757Kq3831zsH5iuxnO/RzSU8kyeM+XtuCRnEY
         mYitssdXOVO7HjdZ1Nut2T5oQSz3CW+aOzHzf7y8QK9+HX5Wz4q5TgX/pFCZX+C4fxhQ
         j20A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=p2fMPswE;
       spf=pass (google.com: domain of michael.hennerich@analog.com designates 104.47.33.70 as permitted sender) smtp.mailfrom=Michael.Hennerich@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=p2fMPswE;
       spf=pass (google.com: domain of michael.hennerich@analog.com designates 104.47.33.70 as permitted sender) smtp.mailfrom=Michael.Hennerich@analog.com
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 09/14] staging: iio: ad7746: Add remove()
To: =?UTF-8?Q?Hern=c3=a1n_Gonzalez?= <hernan@vanguardiasur.com.ar>, "Jonathan
 Cameron" <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
 <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
 <20180415163101.6ab15cbc@archlinux>
 <CALfa3vGd0SG60mi4MBhfAUJkpD8h1e6odgbJ750C31vNO90Zig@mail.gmail.com>
From: Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <636ebba6-8597-eb84-6321-11a01cc2862b@analog.com>
Date: Thu, 19 Apr 2018 11:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALfa3vGd0SG60mi4MBhfAUJkpD8h1e6odgbJ750C31vNO90Zig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(2980300002)(438002)(189003)(199004)(43066004)(53546011)(4326008)(6246003)(2486003)(36916002)(2870700001)(76176011)(106002)(8666007)(59450400001)(23676004)(2906002)(3450700001)(31686004)(47776003)(65806001)(65956001)(6346003)(77096007)(26005)(186003)(72206003)(478600001)(11346002)(2616005)(476003)(126002)(446003)(486006)(7636002)(106466001)(426003)(5660300001)(44832011)(65826007)(64126003)(8676002)(6666003)(356003)(336012)(110136005)(8936002)(229853002)(36756003)(54906003)(58126008)(67846002)(316002)(305945005)(86362001)(31696002)(93886005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3050;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:nwd2mail10.analog.com;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD023;1:6HOrdNyNQpQ1Vb+dARi98AIhEepBObphfNd67SftF+BV5osmNyWxmbereQAA1FqsKNj+N5Vm4cewIwcocSdcaatZ2MNVExVRLqYKGPwL3Igbqe9TuEZ6g7hX3mxwqYer
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:DM5PR03MB3050;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;3:FNQZRcsYfo+SjK4fawokRA2gotCQTd6fxKCWez3Om+q7fMCJIAONO+Glujx5HZfhGtkStpCQuwSnFsgu+ct20AW5gRAsd4AHiN1dG8Hwz2iX7CKhwT6RffSK6Nt9+ot0rPvlcPwMLs7HvJk2+9Wkh3p1fEA6augBlXrhiRY/6qbvBLUPGUIqZHVojtOkWW4Ff++wD3WQV8LaW+PxVuzY6MfWqKt0CBw0j9Gle71dEjfR224fQS54iVxQ7szANTlARYNq5uo4HWMKQKAs1A0D7PY8UsXQ3EvkEOEhAHO1wiSOe3f7sG/BJRAKNS1X5piQ3D80V7/2TH1D2LIvsoMsoYyEPd76+xsrKn8wNlt4Fqk=;25:U4lc94WFQA5+rvTXUSmSIyQL9tzex71gNw2JBi4VYJgoY6jBqIp//L4q201GjNHCgZvvuymPSn2boAAoJZPuglYRjOLsXViJyQNmtwNx/P9iSTDhEosZjGEDw07GKo2lV92fguzkWItyIO0f8kJpxczwZzFp8lknucUosado13kUuRzeaMmcEFmIdbYxi5Y//l1w1WzqP3wDTh/ywuS87QqfVsvWIFVci79wz6B6segTUNjnHQbkhcnFaJ7dZQuq17NApPp37aLPqN4ZkKfJ3h5oB4rLt4a5K3onxzpdS2y9VLrgV6vagrjVrmYRpGriCOEUP7/hH3TmiavsDELE1A==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3050:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;31:6KTW3arLt1b6irTRChcm6pOTW1ZY8K8GkKN9t8oiVumCxPzW6vLFUTErREsUNKKL9Abzc74Ct1nGwRhvYhW8GV0fqytZ1AEN0S191iW8KzdLxnAp9WWtHb0ozgsKZWhCm5lV0sfjw0nD+N3EWblcmXdQ8ko3H8U1aeBcuS//FhRyJQMHPucNnQ+jhk+JXDly0T0QXcxO2wlAUwYsHV+h3pEyNJtBqL4GyVET+5HoJRE=;20:ATEIf63iSFmTUxIlwhk2/3/yxlKjlWcZluUoSD6icOteLVDwckeFAdlqCMEmMRoWAK+kDFA2GK4mEwAQIqznAEKLgDyVtVVV+ARp2/X+uqhGHsLkU4th0iK1YLJhQY+plhXIO4YgpEetn837SDyRw2AH5CAng0EI0QhmQYs/IrlvWFLhVKAVqZktHRfpiM1Ca/ZJSuJETrlWKeuNexvwzw1gueeZh+/KXp7eiiynhS2qwRahhia5W06BsA8tVgNme2gPKHp8qTSJv3uGRb0o+0Qi2lRTy9sz8xCP10lDj8bL8veixlmPMDTLD0HTuN8nTdWo+jRKhoXkt731ETps/70NreE95uVpKaT9c4zDUfUQciQYdcPvVZMNR8DXf7c7gvDNqyNzQhToUFMG7EDu1p6mMrQzD6+f4qejiD2P4dcPQSNirr1+8WmElVciwRbG78+NLANC2jJ6I1qQJt72kMb3sBwP7C8PFtQmXyUazIr7jqyAyUKMZktEcT6JM08Q
X-Microsoft-Antispam-PRVS: <DM5PR03MB305047265A68D6671E34C9DD8EB50@DM5PR03MB3050.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231232)(944501382)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR03MB3050;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3050;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;4:y62aulDM7dDXK3bBps2k28n8qEhsBS7dItuCOIWm2w2Uaee+HF/hKGlS5BkH+FI0uyIw+vPhcH87GFoZgwkGNIQFwe/V3DjtlOrq1poK7RLAHiazM7Sh48tL9Xax5xF98gRbVzMQGhM77IBEjdTd/LX7JWkN2jw/iKfRtQWXQ+p44VT3kJpYu1MP3kWqYfngNWBeZxOPgulyVLRQVsIcVYI6BtGS1kIliQZB9b9Uih3TDJlOt7+08wfA1nl+C4kAGfJYNBbWdFZ68pSSHaZSOQ==
X-Forefront-PRVS: 0647963F84
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIzMDUwOzIzOkJuaWhjOXh0VFRHWElUMHRxeS9BQlAwNGVT?=
 =?utf-8?B?eEdRa25Pb3I5ZWIwYklzZGZHWndBdHAyYXpxRnFuMTdJSGExU1RGWmRpcy9u?=
 =?utf-8?B?RzN1VXp5ZkJzbmlDbGhCMmplV21TdGZCMEd5SFhhQ1o1eVplMkl5VWdnbVVV?=
 =?utf-8?B?enRJSjRXb1AzaThwUlB3ZWdCMm5rSmdCeTNJL3BXOG9KbzhsSDBvZXd2TEZi?=
 =?utf-8?B?NXpwbUZneEdvdmppeUhTeEpsNzA2RFlMME1vL242WFV6UTQwSUVVSDIwVkRq?=
 =?utf-8?B?WFNTMFBQMVdpcU01US80TzhEcHRLdDRiMjkrQmxwK3hYT3E4aW5RaDdQb253?=
 =?utf-8?B?OU1Mb2pUaWZyWFFzVjVQZ2JVZWx2OElNbzBVQXRKZ1BwaWZGVDBqc092ZExE?=
 =?utf-8?B?T3EyMUdjWUN4T0pSamJaaTkyenJob0VMbDJRN281NzQwdE9ZWC9lN2YxOGli?=
 =?utf-8?B?M3UxMHhNN1ZxM0tReVFFdDZFKzhOZDg5cXFJNG4xd1NjMHNxMDZUcFNxTVJu?=
 =?utf-8?B?VXpGa0ZnUW9vdG9EemhBb1Y1VTZIK0VISzRrU3hIRUpySVhuelAxaEwyL2ps?=
 =?utf-8?B?V3RvMXJpVURiQndpdHhCNFpJMWg1cWRDcUNpdVFHd0I2eVVYdzZxWDArb3Rp?=
 =?utf-8?B?ZE1BL1ZRc2tvWkhCS1MrWXRwZ2JHOXI5RWtyVXNwMS8vTGMxOXZQV25TU3cz?=
 =?utf-8?B?c2RWSkIydGJXU2VLenpmb0h3Z0NLSjlXR1FuUFRPc0x0K0xGOEVTRWQ3YU1V?=
 =?utf-8?B?WnFlaHU0MWJPbnU2UEF6bFlJTVZRMlVuL2dtUVFLZHVVWU1LdVJlSHNqcGtE?=
 =?utf-8?B?Z2EwbUJvWUc3bXF3L1RMVXIwS0xsSHhiVDBJUDhZZWVGZDB4ZVJJSlozY0xR?=
 =?utf-8?B?REk3c0lnNGgwc25tQUdrL0pQQThJdjUxcG1ML2lsR3J3RU1rMGV2amRIRzZt?=
 =?utf-8?B?d0p4Wkc1eUJ3N1poK1RMZEduZUprRk1RMEdvVkpMUGVVekprOEo3c21MQWRT?=
 =?utf-8?B?YzRqUGVTc1ZjZ2haQmRrYnVWS1hEd0lDWVg3anFSZU5hNm9nYTIwdkFFK2t3?=
 =?utf-8?B?UkxPdExlekVIODE5cXVCWjZFZFpsdExHeXkrUmtpRVl3SGRoZTlNVm1hT0Q3?=
 =?utf-8?B?bDZRelh6ZnNFcmp1TGVzRzFlQWl3aVA2SEhUT1RWdzE4L3BnOG92dEJIYSt5?=
 =?utf-8?B?YWhFZGM1ekl5RUpQZytVS1owbmVKTGZnNEVORTQ4aFZIZXNmMlZLSDEwdXZU?=
 =?utf-8?B?eG1iRERtY2lGM2tka3FtVnQ0ZVk3VHdHRVAwL0RzS1MvWHdMUUJlOVRRcENn?=
 =?utf-8?B?S20wbDUwMTNrSlBtOHhaS1pjVmJ3dW1Bd3hkL1FaazlUR2FQQTBGZjN3VHgw?=
 =?utf-8?B?MUU3QnFXUFdmZVZVaE1lQmE2ZjU2S1dkeDNlN1VZTU15V2RwOVk0N1lFeWRw?=
 =?utf-8?B?QnN0cUZkQ3ZaR0IxcXdUMHZWRjVFNzcxR3JzM0pPNzQrbDdENE9naXNKcmRX?=
 =?utf-8?B?K3pTWHpzbFVGUldmK0srTEd5N20xQ1JsK29BcitQU0M0bEtvT2ZlQmdTMDVa?=
 =?utf-8?B?MjBueitkQ1liUVhOVlF3UG1qWHJKNWFCRXlLVHB6ZFIxdmpBK09KT3ZTazh0?=
 =?utf-8?B?NGgrdVlRbFNsZGFUenF2MFFjZUV1TURtQ1psUWZoR2MyV1ZaYkwrZHZPSDFK?=
 =?utf-8?B?R2MycUV6MXFTalFwUlFEVVZoY0JMd1pDRWZUQlhKMjNTQUhlUTR3cmZ4ZldC?=
 =?utf-8?B?YTdPVy9URm1QQ2NBSjhxcUVGZVRKWUVaS3dlQmh6Nm8xczN1NFFFZTExWGlm?=
 =?utf-8?B?Y0pNSjdDVGg2ckZKSWFBQi9zb3VwcE1UWWZNVHZOYlJoYmUzUkZma3QycEdC?=
 =?utf-8?Q?mULCxZGdCACHXMRQtldPd2SFwqGRjQ/n?=
X-Microsoft-Antispam-Message-Info: rekwKe2V8jwTSdnezpvrGWl8iTrwxbp+TZy6BYCD/CLi3QyC+byp2CC+DMFXYT4fm+z4SbTzteboGp095+J/bgjp5Wiq67JKzVCcNujMFdPHfMHfakVexhLKAvG+0MYmw4UFobZVR85+gAwJUhRMMHoaqdL/dgah3KwvJRWNn3RVVdHeHQAYH5p30lW8fWJM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;6:CgcdRg59DsAdumh5uzm80v5gMrbPPmWwbKMkej7rK8Img18qhWtAb2q/55ZP9Lgya6D5I6qZvL2PxMHwbxj9YibVZFlAw0QDPwFoc6M3N1908ejDipkqh5NIhsjTXQ8CzFUP8JQsDSNBvyMg1NdqXBo3IXN7hPslsUn+6vSfVkMf4tai5jMfqHAi4Gdb6qlIkIHTYb1d5UqRZgTfHMw14K/2WsLcVBx3DvgYyFmnb3LuxpqLwsKwt8p8Q/qGwICLWa25LydAiSDve2HkW54tWnZ8Zubdkd1n5HJsnWNnB5navfm+9yG+4P5RK3vzDwAGxDGGaBEwnUBpJDYhTfDqcA+HjdlzoEgfkl2BvsLqDeQhBGmdZG19OWEALsY0L3RoJwlm/J004M1+BUfnFH7n6TmzNCDi0p8Th54wyg72bdT8dYGcuk9aFOTx4S75mBp/F02/72VU/hs/kOLNDqBseg==;5:mKHOx+whUIvEBcFmYf/gEMss4B/ZWehaTo7+wLyBAr/u+8lQ410MRhuH24p1jjccMQhgZwQzOx3RvGN6dO9QREcOq9E9cs7Kf3gSCmAd8VhRc/mRht+QnxBylOfAyFfjWYErHdr5SQngIQI8LHyRL/21naV/l/WT8EI2L1XrQwQ=;24:ArE2J74OktHMDwIQ5KidCwsGlaQWShMUS3Dd3/A198eCKZtMb/zvwBx5Jirru+LERlEYUtdCT4tSjHma9RNf4ynNbvxfnzOXQd4zg4mtntQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3050;7:E9YZhycRrUHdIXCAbYw5Smqc60+pNuU+8TeDhhviyNhgRx6oDc3Al3zydabxT8gW9uC8HdAWVZSpgm33Y33WP2kMmcyDh1zfT/taBRLuE2zV3p6hS/zQbkZ7XIhlnL+2shWukoAuDx202UEp7XDEN7grZRfaXVDOMKkiEY3dYqitwLPDO9dlPNPvRCArPLMFINXCEDqvm8eaCoy8R0uxzYrysQVLFDsQkN1Ux3Zsed5Alfv0YWHmXfpV+La7mByS
X-MS-Office365-Filtering-Correlation-Id: 998afc44-b348-4b8d-981b-08d5a5d58b74
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 09:11:32.8148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998afc44-b348-4b8d-981b-08d5a5d58b74
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3050
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649731441296741?=
X-GMAIL-MSGID: =?utf-8?q?1598165189566931879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.04.2018 21:25, Hernán Gonzalez wrote:
> On Sun, Apr 15, 2018 at 12:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On Fri, 13 Apr 2018 13:36:46 -0300
>> Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
>>
>>> This allows the driver to be probed and removed as a module powering it
>>> down on remove().
>>>
>>> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
>>> ---
>>>   drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
>>> index c29a221..05506bf9 100644
>>> --- a/drivers/staging/iio/cdc/ad7746.c
>>> +++ b/drivers/staging/iio/cdc/ad7746.c
>>> @@ -775,6 +775,31 @@ static int ad7746_probe(struct i2c_client *client,
>>>        return 0;
>>>   }
>>>
>>> +static int ad7746_remove(struct i2c_client *client)
>>> +{
>>> +     struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> +     struct ad7746_chip_info *chip = iio_priv(indio_dev);
>>> +     unsigned char regval;
>>> +     int ret;
>>> +
>>> +     mutex_lock(&chip->lock);
>>> +
>>> +     regval = chip->config | AD7746_CONF_MODE_PWRDN;
>>> +     ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
>> As this is a one off operation, perhaps it would be better to factor
>> it out to a utility function then use devm_add_action_or_reset in
>> the probe?
>>
>> Also, I am nervous about this change as there doesn't seem to be
>> path in probe by which this is deliberately reversed?
>> It seems to be 'accidentally' handled by the read_raw write to the
>> CFG register.
>>
>> The data sheet doesn't really mention much about this register
>> at all.  It may have special requirements to exit from power down - I have
>> no idea, but if it is costless, why do we bother with idle mode?
>>
>> Perhaps Michael can confirm if this is safe to do or not.
>>
>>
> 
> I guess it'll be better to just drop this until Michael answers. I've
> been trying to get a hold of the hw but with no success (or I have to
> pay 3 times its cost in shipping), will keep searching though.


It's some time since I last worked with the device. I think it would be 
safe to restore the power on default in the configuration register upon 
probe. Which would be idle state. Besides a unspecified delay, I don't 
think there is anything else to handle here. Due to fact it's not 
specified it might not be required at all.
If your planning to do further cleanup on this driver, I ship you an 
eval board free of charge. Feel free to contact me off-list.


> 
>>> +
>>> +     mutex_unlock(&chip->lock);
>>> +
>>> +     if (ret < 0) {
>>> +             dev_warn(&client->dev, "Could NOT Power Down!\n");
>>> +             goto out;
>>> +     }
>>> +
>>> +     iio_device_unregister(indio_dev);
>> You can't safely do this against the devm_iio_device_register.
>>
>>> +
>>> +out:
>>> +     return ret;
>>> +}
>>> +
>>>   static const struct i2c_device_id ad7746_id[] = {
>>>        { "ad7745", 7745 },
>>>        { "ad7746", 7746 },
>>> @@ -799,6 +824,7 @@ static struct i2c_driver ad7746_driver = {
>>>                .of_match_table = of_match_ptr(ad7746_of_match),
>>>        },
>>>        .probe = ad7746_probe,
>>> +     .remove = ad7746_remove,
>>>        .id_table = ad7746_id,
>>>   };
>>>   module_i2c_driver(ad7746_driver);
>>
> 


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
