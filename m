Return-Path: <Akshu.Agrawal@amd.com>
X-Google-Smtp-Source: AIpwx4+nzvHZf37H0lgz0L6l7JPR4h98BA1dhRYNDI9Dg/fLi/z0AtZQCE/EnI0QbuZa1yAmqbPF
ARC-Seal: i=1; a=rsa-sha256; t=1523961769; cv=none;
        d=google.com; s=arc-20160816;
        b=jAFWs85e3mEBWpO/2lJlVd26kLqQhObNEx+8TGSCUXgfuor8FKIAs/p2BmCfXJmWx+
         Zc4uNwwBwSymSW3WX1n087k/K1EkfzKbC6i04YVdIdruwiA4aDHXh1cXsR35P3O98xBi
         TJNyCgSopleeAO8Mu2G/hnKnGqpAaFGozL1RknMjukWspqpfDII+Mt5ruOqwaopf5ho4
         kUEC0jJBlDucOL1+wYhcvJcBq/B2fHsaoRCC067lYPkz4u8Y5i3kpl/wV6/BRbLXqSgZ
         qrzAYMcIJzclcQaroKXXChu8nmNSV8lavLmiQl9WqfRlmxpX24PBnv2ghF9vuayUNeEr
         zz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=4hNELI7SPgSmkBfOcBjX1H+NjMQVyG4lblFw1yex6kg=;
        b=na2OdrNtWBwxtorQHPa4GGSRWaEyoFqHRlcABeIUIF2Z85p1cm3DhSaMGfX9Lfqnog
         9sG63l/pC2AiwzvH+ZnZWAr2+xIvyW//cLZOC5L9XDLs2ghzokjbaYjaYyd5NXjiIwd4
         a5Hs4UrvvcLQ37KurJHPKhYeCvJB+tP7bxDB1RWpL5WFd5HMwifaZOR139TPF1jaKYd5
         vDmd0DmMl4vrO+xcAHAG5OZFANUX5J9O6UzcUvLC1af67j9+DTbUGfOMmDO9BbVOUrBq
         997vqKkDiGlwI3as9Q3qFLMHbyDOrWhegUYq0NmLdcDgnQCd0gLKBvLPNt7tU2tVGOY4
         uEzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=vuRWazwX;
       spf=neutral (google.com: 104.47.34.42 is neither permitted nor denied by best guess record for domain of akshu.agrawal@amd.com) smtp.mailfrom=Akshu.Agrawal@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=vuRWazwX;
       spf=neutral (google.com: 104.47.34.42 is neither permitted nor denied by best guess record for domain of akshu.agrawal@amd.com) smtp.mailfrom=Akshu.Agrawal@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH 4/4] ASoC: amd: enabling bt i2s config after acp reset
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Alex Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>,
 Jason Clinton <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <b2bad607-9744-b1c4-c9fc-a76a9b3e90e1@amd.com>
Date: Tue, 17 Apr 2018 16:12:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::34) To CY4PR1201MB0182.namprd12.prod.outlook.com
 (2603:10b6:910:1d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0182;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0182;3:c7oKv5efW3jhLqE7Zty+ytPw+iBRjQyOb4aXft/uiefV02H4Pbc7dWANGrW3/10Bg7dX1qf1VR7tYggGw++wCbVZ8tjTIjOH37xT/2L+7PQ0FAOLWzwD6H78y5nRNj2C4Iz4AWOfwynhhYD7G0LHy0M4S9DYdBEzndGef1uMyVVNtI9g8A+9Z1vG1LeZDp5vTwVCco/F0UF5DvbnwJ+J4k7Q7+8oyUK/x4KBaRWbNZgM+SlO2Dsbx+ax9T6pLd0+;25:Wopmg5xPIkuL9uiGl2K1/5bCpbcjVnRoaKPZeAWqPkz02Pb7z7+qi2/B9Np6WHDylEPwrAzObnPt9UFteiD3sPuPlyASjDHAh/ps6SBGdeh9Vx1XcwTmJ6siWSVsm8JztQa0R3f3ewequoBSzMCYAtQdILH9aJvbPs6n6wVQ+iWE7NnSpN7z16KEaD7s16EVig5Pwun7GXmSp0I48rr0qZmaDgJtNQEMIpOH9aE8x9BC8dq+rBmBWjRYuqLY8xlq90ROc9GDYEVv/PAGixeBulxpjIIDyZ/cqDF9s+QcVbga6z+uoi2s27b2W1CiaVjZCNuAJgG+O68GHd8pmJv+rA==;31:qL6MBkxXYn2IqzHcLNNy8XMfShhX2M7JX+yFOlpE0JxbVvbX3Q/mUvIYc28O7fVLTQq6a0lmkWYxaj8RCZSZwT0e+MVD8TTjKqunvpi7zFxDlqSmcSlG5YgapfL53Om5XnUsWEniWdv2/YlCnODWQzmEWlMNgdfa+HaNVPR3WHyd4aTlFZJ1QeHGV77WG6GMczzavBTLl9EGL4Z7n+1Gu9kDbIc5eLlZy+O8TqdujDg=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0182:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0182;20:n31zwBA8cHwiAnWWdqSJYxnbt4YsdYfRCy5+3FMhLS1EJhVYv9Aw1iDn/SHiAs4r7HK3TRTvXUS0Ukff/Wp448QxGlzT+Dcfj+yk7/6w/adAFfoZJcW7gI7AYBo8GAs4kMy49VMchYbJWgVp1N1dyEJf80U2nSDEGoDpvXLTWC+1TTH2JQ9a1wwhXn483beV23CKFf8VCslRZfePOaggD+rf+6tt51OETH4kcRSNpa6bdd9DS2W8P2br2JaxqKnXuB09sHy963hhmSavt1epdA9gnCRyu+Pi6WKH55HkEnXP0+4x0iQPRZhpMRX1yIs74D6eRFfWcJuD6DODxIsFCjIRsKh+nWdrYx8AwpZk66cM/8UahDZA6KtYs3kMqeZbek6mZfZMWLUqvNpoFj2KPLthOnAf1v9oqwXaB+ik1jsgEtUBYrqHQAmrvXVtqdtX3tijnu2yvBOQQMEhkOtXwX2BQNrd4omtzvrURgv8e4DH6UQC5Y94sxwsKgZGpQ7/;4:FvTXwSehkqihEsqe6a0bek9XLHROMMjWkOHOUSzcCB8E9JsFHKvOTC19HNfhShdu5hzNNNgDHaVjinxKrtCGKEqs2P48IrOXKDYhhXbZA71kO99Z+FSl8PR8y94xeHSvmrr2a2t69GpZU8jMwsYOFcfUHr1sI220PqDy0oNY1BAXzC+mvTUuahqU3wnjnlUfIEn/DYrFI+JI/ptpJsnGQ9vwYMvZO2fGDBNiIb3GitmHGFeyYFb1MPlaIImXyqafl0GhKHCifDp3KPtdxXlJOhbQCXo05D0iI/xTjrInghXX83rvb8oucBKKgRRFgfvP
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0182EA996F8895A9FA367684F8B70@CY4PR1201MB0182.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR1201MB0182;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0182;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(346002)(366004)(396003)(39380400002)(199004)(189003)(36756003)(23676004)(68736007)(76176011)(52116002)(52146003)(16576012)(6862004)(54906003)(58126008)(39060400002)(67846002)(6486002)(65956001)(65806001)(66066001)(53936002)(72206003)(386003)(47776003)(6246003)(229853002)(478600001)(37006003)(25786009)(7416002)(106356001)(2906002)(230700001)(6116002)(3260700006)(8936002)(53546011)(2486003)(3846002)(65826007)(5660300001)(7736002)(105586002)(81166006)(31686004)(305945005)(50466002)(575784001)(31696002)(6666003)(8676002)(81156014)(476003)(6636002)(11346002)(446003)(77096007)(86362001)(486006)(64126003)(2616005)(26005)(4326008)(186003)(16526019)(956004)(316002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0182;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjAxODI7MjM6UDlCVHl6d3pyclF6RmcrNEJRckVNZUUz?=
 =?utf-8?B?KzIwTGpveVZMdC94em03cWJXRjVCd2ZTSDZiaEVjL0tnWWRxMG4zQnFOdkF4?=
 =?utf-8?B?YkdWQTF2bWs2WjJKTTFZR09qc05vY2Z5RERUejAzWTI0WmFZYTFhRXJHLzdt?=
 =?utf-8?B?V2ZBYlhXdXRNMnh4cHp2YzFFZHlaSk1pZXQ1cUNWWGFwTXh4NWJPdkw2MVAr?=
 =?utf-8?B?VGI3dm9VNFJqb0hlckl0b2Fnd3I2dkpPaFp6TWNrMEMzN0UyN1A1RFl0aUkw?=
 =?utf-8?B?cGFUcWxuei9pY29NSUZGL0NiYXhjSkRuM1E2STRhblF2QVF6dTNDSzlxYkZC?=
 =?utf-8?B?Wlg1OWd3YjViRFlmL2kwb1NVWkw3bU8zcDVZOVk3YStpZFRTZGZrNFhZb1RZ?=
 =?utf-8?B?ZEMrVWhMOTNuVlR3NmIyUk5mNmZJUHlUVXk1N3ZnODdsTVBJZG42M0xUWU5w?=
 =?utf-8?B?MGs2WmJBNzlsRVJlUlpuMUNISTZ4RXdlZjlLSnF0WDltR0lxTTE5aWFjZXRI?=
 =?utf-8?B?RGpZM2UxRTlQVUxTaktKZlRzMmhNMGUvc1g4UWJuTlkvNDJXU3grZWdnZDQ4?=
 =?utf-8?B?OFBrR0hkVHFqcHNZMUFUSXZnTmduMFFEY0FHblFsQmhod0NnM1RpSkpXRGZj?=
 =?utf-8?B?K1NtUDdKbk9URm1nSXZFdlV4SnRWWFVNY0JOd2w1WXNINFZCd1BrV1lOYnRP?=
 =?utf-8?B?QVNHVTUxQUNSa0FuK3psdkh3WkRPNWtBSXo1NWNtcFI5SXdTTXZBcUxpeEFF?=
 =?utf-8?B?U09DeHRjNkJJMGVBM0JIdXhsOXVlYnhUdXRPdWVicEhUQ2paZmhocCsvVmxO?=
 =?utf-8?B?RmM0Sy9YcXoyR3E4OWF4L2RDVnRUK25GOFNqWHM5M0V3THN5bkcxRDV4NlZa?=
 =?utf-8?B?c09tS09VYXRPN3M3MUlUdUNEaHE2aHZ4U1hMeTZoUTg3Y3JEL1FsbXo3L0Fr?=
 =?utf-8?B?VFA2UEpYNWVUVkg5TmhYdkVLV1JYbXVHekFqWkNYRWc5MUhkeWZOK3RGRzcw?=
 =?utf-8?B?Z3Q3djZmc295cDJVZ1NPNjhjNEF6NjcwY1pGb01nN3NDeW12c1pMT09nbjYz?=
 =?utf-8?B?RTV4Ynh2QkhxTFdtTm5odjNkRG50OEtncGxZN3h1UW5oMUhYVjFPNkJhdzZ5?=
 =?utf-8?B?am9xWHphcUF6Uzc4KzVOWVBDbm9zUGJGeE9hRHM3NFQ0azVOblZRNzdWaVRZ?=
 =?utf-8?B?NzV2ZzU5c3JhQVg2dHhMUkE5WGxzeDdIRjhEdVZNWThRNkRWRk1UenhvV0d4?=
 =?utf-8?B?cXg4aXRrdVZ6dGt6eTAwMjQzQjFzS3Q0ZU02UXRqRm5uRTlrWHk2QStjTUF0?=
 =?utf-8?B?OTQxZHdSWUlhWHVBcUVOTGdaTWt3SWs0TEoxMzIxZXJnYkNwZTVGb2FJVkxD?=
 =?utf-8?B?bjJkQVRMN2NSUlZZYTVMOWJQSzM5cTZtUHlpaExLM2NRa0RSdEFaM0NpNVht?=
 =?utf-8?B?Q1RkcHJZbExSbVpYZ200ZXExcE1zUndNNXdtUS93SkErMTFnN0JYZ2kzOWFt?=
 =?utf-8?B?SkI0T0dZUFBLcWJBd0M0OWZtaXFOT3I1NFJHMGRGbWxjN0lKWmpUc25ZcnQ5?=
 =?utf-8?B?dVhZeHFzRWVORGE4R0R5QnJPcisva1F3QUw1RkNwSmZsKzd4bDdIRWloc3Ju?=
 =?utf-8?B?TVdkL0p6dVdrTjNUUkU0eWNKd3l3MFUwRnV2azhKcnhKclJFayt1TWsvOENU?=
 =?utf-8?B?Y1pZMERDLzd4VHZpSU9ueDhnWHg2SGFQRWdXZ2N4SzFtUHhSZzVtQ2lmODZZ?=
 =?utf-8?B?dTVNVG83ZnZGQVVOZi9iWGFzd3dPS21HZDlsYUxsSk9pZkpVKzV3Q3h4dmRz?=
 =?utf-8?B?aU9KOGZkWHJ1TjR1dHl5Ym5LODk3dldvWjkvbjNJLzRWNS9vMnJITFVpSTF3?=
 =?utf-8?B?b254UU9XMkxjcEJzNkF4U2Z0dnNFcG1uZjUva2toQnVJaUQ3N0YxVWxDSEpV?=
 =?utf-8?B?U2hCZ1hpRHp2MkhFZ0JjVU5Qb3g0dUtkUkMvR2ZBUC95UngwdkoxWVU3RUlQ?=
 =?utf-8?B?N0JFUmJMTFpTVVpzSHFkT0Y5S01zZE82SmlmVDhHendHR3NHWDduazVyTkZn?=
 =?utf-8?B?QXdQZEFLdHVsUUN2WEVHNzcrRGxDSzluUGY4Z1VOV01KbkZpL25QeEJ3ekJY?=
 =?utf-8?B?aHl2Wlk5K0h3bzE2V2JkYWcwelN5d1h3bGZybUN4UWRuRi9kbWVXN1JzZERr?=
 =?utf-8?B?Vk81dzgrQzlCR29TV3pTTGNBY05tSWc9PQ==?=
X-Microsoft-Antispam-Message-Info: 0xV8TNjOUWzd/lsvFxrT+pGGbLCs+OlXvsT44dj/YyFSA08+GScKDu9Oj2XvC/1JEX5uLQKEaM3PZcyxvONufxRWbBplh5cdX7DIgkDH9k8voOKNR4xc8FLPGKYUPfTS+sY6NYT9hKEAM2qt5buf4+XnhA0VDiY7yiFigIAgSUADzkQ4LV91pb55Wzwe+00d
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0182;6:gxIIxnqsUeJuFjrI0n35doO7ZQyggakYvUrg4BjzBWdD9TgShXfc9cBK6yDpdmilpxm4I7LCJhMKVfMw9mXAGW7D7t5Ig8u+pT1rMjPtY71oSQ4iLtLGfrfVvWs5sZXffyqvmR8yjdNGOCoh2FiUJMzUx1wbGyvhJ1/SPlbWi7k4AeaEv7J98o+MhfUAZFLdC3zoQa4ani7c00q54INZpWJZO466A/mR33csuUSgDMRe9GeNco+4y8dmqd1FkliQsWYuxMRGNwL+TAzRL5LgYjTf0+C7/gt2/X53rCrtMXOHbS1AmdDpPYOpQ/FxqXZP/TuB0nCZtP3VxRv1jfq0LRcEgYIMsxz+2mZNrwoQnSr+Jf78er5Ek0A8BJdk5Rbj5ONf6Mo2k5kk3/6W7wqafpXJK9IhZRn8AZ6LSexegZebceZIyp3M+8qiGxEGs6PPrs3Sz/eWOduOGoaI0XNA8w==;5:pWa/FanrJUXRVCMt18Q3/0q/eKWKlP7dDwJJH86/iG3QLv/9piKANtz3iDEc9H8fYoa0RM8qYDUvHmouIWuMci4nLVOJdNL+1RDHaLDNQRHBZClpfg4iefA3N9sIf4HvltvpQjsu8Yb7PZOib+H2L6KHNn7/Ke5WIEDRWtcsDZc=;24:iWbeuTwPK64lKcIlsyvKpxNJdKn0GgZpTGDClILEQMcN76lpoDKoNcdLrgSkGjfGpu/nESOunckaYWcWWS3KTHyOpzkZP5Jo3uHpe4mzJH0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0182;7:oboYX2n6EqbRxHJWMS8gk+l8dTZc8tw/bFyOq/+H3B8PiNHUgFlR4WluwDCHZdx0N4vXJ5oG/5kA2/wD1wO2/W3sw6CxEQkgJarlC/Q1nvF9dk3M5ca6YCAXZN1B2Jo9wTB5N9n5NLU6IRNtRgtEh22U99m0E/eusSziarb03PGuTnLW+ZKUASvw9mVCtdqBNajWMgunZNrGkuqUS+gVrllEXSZ+5t0mzewvaIouNR4wxaTgQPEQO95lZiwBO81e;20:mtCy9wtBFe1MqD88LF/kBebmwI1d36lT5/VITbeAdY9opUMAByFEs6mU+6W/31agyVLn2a7GoJgW43xvm1894/nPQwXZTPSgDMkH+23W1ALnxUiI2cxn3MX3a2c1mBJ2E4AG4sFAxMjMBjtzU6oTze8o+YMtEUhxlrPJCW25oenrSIXDizw8UDo74acArncT0DweypND6ELs+vj4p2/W0un/uyYAcaXiSXEhQJ+Nwb56GF9ffSxgjXrq5PELE+Aa
X-MS-Office365-Filtering-Correlation-Id: 360259ef-80be-4073-9ad5-08d5a44ff560
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:42:42.3445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360259ef-80be-4073-9ad5-08d5a44ff560
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0182
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968144319777100?=
X-GMAIL-MSGID: =?utf-8?q?1597989735894723205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/17/2018 10:29 AM, Vijendar Mukunda wrote:
> On ST/CZ based platforms, for specific platform bt uart
> mux to be defined for bt i2s.
> By default, these pins will be used for uart.
> After acp reset , it requires to reprogram bt i2s config
> mux pins to enable bt i2s instance.
> added bt i2s enablement sequence during acp init.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>   sound/soc/amd/acp-da7219-max98357a.c | 2 ++
>   sound/soc/amd/acp-pcm-dma.c          | 9 +++++++++
>   sound/soc/amd/acp.h                  | 1 +
>   3 files changed, 12 insertions(+)
> 
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index b205c78..6dad0cb 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -44,6 +44,7 @@
>   
>   static struct snd_soc_jack cz_jack;
>   struct clk *da7219_dai_clk;
> +extern int bt_pad_enable;
>   
>   static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>   {
> @@ -81,6 +82,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>   	}
>   
>   	da7219_aad_jack_det(component, &cz_jack);
> +	bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");

This is to be done in probe.

>   
>   	return 0;
>   }
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 7c392fe..b52c660 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -46,6 +46,8 @@
>   
>   #define DRV_NAME "acp_audio_dma"
>   
> +bool bt_pad_enable = false;
> +EXPORT_SYMBOL(bt_pad_enable);
>   
>   static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
>   	.info = SNDRV_PCM_INFO_INTERLEAVED |
> @@ -525,6 +527,13 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
>   	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
>   	acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);
>   
> +	/* For BT instance change pins from UART to BT */
> +	if (bt_pad_enable) {
> +		val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
> +		val |= ACP_BT_UART_PAD_SELECT_MASK;
> +		acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
> +	}
> +
>   	/* initiailize Onion control DAGB register */
>   	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
>   		      mmACP_AXI2DAGB_ONION_CNTL);
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 460365c..6b43144 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -107,6 +107,7 @@
>   #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
>   #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
>   #define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
> +#define ACP_BT_UART_PAD_SELECT_MASK	0x1
>   
>   enum acp_dma_priority_level {
>   	/* 0x0 Specifies the DMA channel is given normal priority */
> 
