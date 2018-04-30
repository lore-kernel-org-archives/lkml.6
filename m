Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZq5+COpAFOl5Cc1ktlTKDfEpGVpeCihCl+nRrT1EXd9WoWjo5L0qSskhlpFxrg9Q/pkMrDB
ARC-Seal: i=1; a=rsa-sha256; t=1525072925; cv=none;
        d=google.com; s=arc-20160816;
        b=Z3ri25RJFePe+DtjHdNnzkaGVNvGG0wp901h8MvPUA8k3DfZ1/pGx12D1Lewd3HtjX
         4HzWpYqB0Jw2QyUBTXbIX4/bg5HvZxMO2adBoQW426F8rgjR2uwPhHtHrJ6KrOQ2xgpX
         EsGmSarBuAQ1+F4ORVBfLWO78lzmt0XVhxxGIcGyJnksgx2Tae6TFhHslChqHggbFue/
         k20PpyRJet4Us18XKrNpE9GT7yRTKtnjFlkShYqiHEWFZh5xc0t+kQ1mN+ZN5JwHz1G+
         giUwL8Rb0UFcbS/7PogHeubu2D6bHCTwaV58KdnujEzaxt5sh1mSv8A8PRZ0YCaR4Pg9
         6xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=gqN33ztAgtnHZ7siPDdyLemtyyBM+F7tA45yuPz7FAk=;
        b=z+CSrNE8CXNE6RniGlUjNhTsDLRlDngZEjrD3+Otx3HfTCxvNqa53Whia6UYjuBpsO
         Q1x5BDU5w3yGjolLYf9X+6lHSTkurborGahbMnvwNwlDR0k8O3AjTF3+DcCetbJmTI5L
         nrSIKpR9aAloSImaFT5C84cq04g3K1GXW+4//l85sINGiV681liCBXRXbmxB/YzZtRM2
         Mh2Jg1CyVBdtXR6vwzTXPGhKyU7TPyJhQ9iFthkGYlrU82rGS+fpbo2a67cqDR0qjl9z
         gxNZxIDlS2xwPK6/kkbeL7OxenuoNgiem8CmROan8PfqoqiDOH0lzM1TkqAfzhzMf6Ai
         /1Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=ICUMLRN0;
       spf=neutral (google.com: 104.47.38.53 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=ICUMLRN0;
       spf=neutral (google.com: 104.47.38.53 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH 03/11] ASoC: amd: added byte count register offset
 variables to rtd
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
 jclinton@chromium.org, Akshu Agrawal <akshu.agrawal@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, kstewart@linuxfoundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-3-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omCN5Xk71FQMJztzi6orNLShr9E4g61atYpbqtcOtcHLjg@mail.gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <fbc27437-769a-2340-a348-1c21977ab158@amd.com>
Date: Mon, 30 Apr 2018 12:54:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omCN5Xk71FQMJztzi6orNLShr9E4g61atYpbqtcOtcHLjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::18) To CY1PR12MB0309.namprd12.prod.outlook.com
 (2a01:111:e400:50f8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0309;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;3:F9Vc4FKlSqDsF/SEykM3xmXAyoflCx7IX7vc25nYrv6JDDc65YeqdDf1iUQ6IWjGvMlvJa5A+rDNhdj33NoNJvMCbtT+03tGSa7VwXcRhjuFGAVsEJcZ8tpE0XKGVk/VbqNCv6qrV968hxr9gO2kEFaHMqtGPkBuh+7r7tsSc3r1XJuspYlmz0Mh9atWazyRPNerFEq8rvfO1D2JrAu3vnjpaWjqRifPujwyWGkSNQ5u6co+kztktjg1Jp02ORKA;25:lU7ULbr4c9clxxhIGF01KrzQUTUGvD0gSuvZQoirNwSN2xX180LMONY2g1eOmC50yhp9vzRjVWENotKppI/UL4CS+XGZzWtoepTbpsUjN0eU/B/X+S8pLDd6ki7HF4uSg/UnT5C6Ldvu3C1svL7mz9S90tP1L0Dv9ckMlxIfv25zQBZ5aRzCtl/mzoMNUngHqWufFXLq86HlPqflZibmgQ9cmVdvQOJnev95LEvBtiEyRFuLyx+E3W9b+WCVv+DCA7nHpmax7P/HQbO9yrv/SkT7ltXanpp7fhnICYXuIhTCAaAJMH7taUYHyl5NGFkfHVNWoCuyTF9D1Xp6RlSP5Q==;31:0qtReTIytpc50rEN5Kih48xMDfveMcUT2oo3FRXHLjsfpUFo3Ns/4bq5YUYa8naZb+AYLYwDkhMPdBwz3IETmT6/XuQIdVtQqeFlDOdNF+tsGnTZji3SD7WDrCwb4t5WrTlgWqsw7EB1piQiPPaaqo68txonaEGmQCvqMTy6rlLhNEzmNFYwlc3MGIGzvPK0W4ZlBMgWDTVYG+RHVMGnk1eZ2VxWxTkk4Id+BvCGCoE=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0309:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;20:l9avBjj7PKXOrhGAVEQz1HlDNNjw+Kuy5eOFtfWHdopUa9mpY+GRZtCX66/RSq76N+PEXLb85vIKRVtsQ+INx3lPzmzBY0+8j1DEBQaNSzt9ylLgSqCPKtoreCt8wKcAOImGt+1T4sLJ/sZqfxD6sIPsxmTgdcdJCT9Ezdh3ZxOiK5z1xkBrSmVtLRA4QvqebL8GdnBP5zstgxGzjP5lG1m3xMLF+rKFsaw4hJVMClG6h7wpUTK6mwJqy8GqOUBisRR5wXvTLLvWX9sOQKD/c2nwfZtXcjk30cvL+c7lXcURpsbSFyNox1lEX+MLgJ1iloYCuU6Ohzw6aUxH1fjWS8ZYq68jGEnhWUY7teFu3Jf3/NKBeWLNp14JPITqy3wOAV9T2pn2oIgbNhS0mnjoSxZhNdRzUwwLzYBbeJZnAPilAxUs68qBldkiLPvSAC6vE+hLnRASIpgkQz7PV6zFleKkH7QTytuRAkN5sE2hxr92eo3z9g3BujS9i5+yt8Yu;4:LLM7KdsoDFYwPWCaI7s8mQfdDPhnkeDOZepf0xHbWO/86EquAnODknYdPvmST0uYgZeCO0iPkcfCS8f31TYR7vIkR0MW8mV5Rq9MFfRZ2qFHowzFuXbjZQinjJqFF9PgriemabVAhtkW8r6ghQbLVwmc4MRordCq6xRd0AGwTwwU6GJOdcAZ5PV5RrKGeVo4l4Dnl5GtkAJo5jJcTlt7x3eAmKb0T4v+4w3PiDX6ZkgLU4ztI59YtXj0DamjDvYy0J34n+pUyuOisF2Nvu+fRwdMin7PVBVBMiTiN2xhyEWgqqR9TCUy0TzaWoa3bL2b
X-Microsoft-Antispam-PRVS: <CY1PR12MB03095FCD826BF26D82E2BF2397820@CY1PR12MB0309.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0309;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0309;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(396003)(376002)(39860400002)(39380400002)(189003)(199004)(52116002)(478600001)(6246003)(23676004)(39060400002)(86362001)(52146003)(2906002)(72206003)(305945005)(2486003)(7416002)(5660300001)(76176011)(65826007)(7736002)(97736004)(3846002)(6116002)(67846002)(47776003)(66066001)(65806001)(230700001)(65956001)(36756003)(8936002)(31696002)(81166006)(8676002)(81156014)(4326008)(25786009)(105586002)(106356001)(31686004)(53546011)(956004)(11346002)(446003)(53936002)(186003)(16526019)(486006)(476003)(386003)(229853002)(26005)(316002)(54906003)(16576012)(58126008)(77096007)(6916009)(68736007)(6666003)(6486002)(64126003)(2616005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0309;H:[10.129.12.246];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMzA5OzIzOmdoWGx3Y2NMOWRjLzhTTkxXV3J0NExTcEZo?=
 =?utf-8?B?SzdNV0RGSkM5MksydVFMZk00YVRZdXZGR08zREF6MkxRVGRzRDY2YWZNT2tK?=
 =?utf-8?B?UHlpRmJ2RkxoT0pXVFFkbzkxQmkrVUl1TkpzYjJEOEhmb2JyMjBTVXlNQXB5?=
 =?utf-8?B?RGRVU3pnbFc2WkNEamFqVVR2clNsSE9TM1hGV0tnTWZxTXh3SUVORFY5ODRM?=
 =?utf-8?B?SGRwcG00azd1VUNUdWpWQ0FtVkpFM3BUZDBubmM4SDlUdEdCTnpYSXN3R1Zs?=
 =?utf-8?B?cU83SkxjOWxpWkpDcU9aN3h2cHV0YkZ3N1pBeUlucEdpcWFjOUI0b0lLeFUx?=
 =?utf-8?B?Q1lmNExxT1lqbnQrUmVuQXdaL1Zjbks2MUM2bkRyUElLL1ZlMjdtZktBeCtt?=
 =?utf-8?B?NitsWHdjVHN3QytSVnRoT0MxeXVzTjFWeEZ6OURXcnJTUUp3UE9Wd2NxSnhS?=
 =?utf-8?B?cE5PWUw0eUl4SzFDcE9HU25XM0h4RGFXWmhBZmtMSmw5M2JMV09uVDFXcFlE?=
 =?utf-8?B?K210bmdwcEZ1VVVCcWlZZFo2a1NraWx2enRnZlAyem5RNEtuNDEvaUZ4b0RZ?=
 =?utf-8?B?UzRsMTg1RVNkNUNBelpCM2g4Q09ZMGFkYVc5YktiQkp2VEJiRC9WZkZ4MURI?=
 =?utf-8?B?V1BvZmVhbjkyZFdwNlFFYmFmeFV0d3Zucm1NTzhEVFNuNmI1WVNLVjlYUFpC?=
 =?utf-8?B?eFVGb2p4cjZDUlYzcmdmVTJCcWo5TVlERWpvcE5Ic09MRkZnL1hYK1JjTzFV?=
 =?utf-8?B?WmFIT1Y4aGFETnE0enlueXZ3TXVkZnp3bFBqeks3eldXaFZDYmxOcDkzK0lO?=
 =?utf-8?B?bWVHQm1DTHhGQWtRdFZBMlFXVWxYaDdYTDlENDg5b09TVUVCSEJteUVGZ2ti?=
 =?utf-8?B?bDFKVFZudEtGRHNPa3dGQTBFWDJCcnk2M0VncTA1Q2VLNlFlaUJrQ2prdmJo?=
 =?utf-8?B?b0M3bkVkbS9QWi94QVF6MkpYMUpJTDU0UHR6THo2bTFZUGxRVHY2eGp3blFy?=
 =?utf-8?B?ZEcrSWJMOTltR2IzUyt5eHk2OUtyaWhpRlNaeGJUbmQ4V2t6L0UrR3FPaHpw?=
 =?utf-8?B?NlVaYXJ2YXhuMWEwV2c3WEN3cEpSYko1WnZmUjY5aWNjRGFYZTFTaVMrKzRD?=
 =?utf-8?B?a0J4ZUhPMEU4R3ZvQTdtck0wQnZqTFgwNFB4ajFURm1KQjM0cy8xVDRNRzFT?=
 =?utf-8?B?ckMyenFUOVpIbHNmbW1vdUJYN2xmaTJ3YlhnSFhidGwwbFRtWGNwejNBODZH?=
 =?utf-8?B?eUMyWjFPRG5pU1d5K0FMY1NkS0R0OFo5d3NLRFdYNkVMY0FpeHJyVUJEa2I1?=
 =?utf-8?B?cG9DdGh3SFYrSWVBQ1NNeUtvMVNscHBuZFMzY2s4eDVHUTEwNVZMdTdxSmxK?=
 =?utf-8?B?RTBWSFkrNDc0aWxVbHR3dGVEbUNOUjFMdDJjbVNDYTVsYXZnSENhbVI0UDFF?=
 =?utf-8?B?NFdIUnFjU0tEL2o2dkRyR0RQZWdFWmNEeEJ0REhBaHpsLzdpdjNsdXBjNUZm?=
 =?utf-8?B?am85TkFmNDJDYmVRQzhIQmJRQmZ4VnZaTjhvZnNiUmZnZ3JWbDFMZG5WcndM?=
 =?utf-8?B?eEpSamFURk5ISEZqaHVpa2ZBcG1hOVRXTzN3bDVCVFVsQmx3SUx0OTNqc3Fs?=
 =?utf-8?B?dEoxSFE3cC85ZVlLZXRablMxVGxLME1HVUZqSFQzU2Y2UURmVjFsMXNxUUE1?=
 =?utf-8?B?elVKTTVEWXZSUmxKVmNTRWlOWmpTYlBXeUdiNFM3STl1L3VVdVpiYUI5RURv?=
 =?utf-8?B?QWZvRmloWlVtWlVjdzlOQ2h4ejFxZUMrajdEUWlSWUJTRHBpZGhuQXcwTWU1?=
 =?utf-8?B?NmpiT1N1RWwvVENCayt6Q1Q2NXpoS0diaGpnYThOb2p6VnJvMnkzRUpaZ0Fk?=
 =?utf-8?B?Vy96QnJhT0d3YzZ3bzBra2lUQU9aL0FkNko5c2x4dHppd1ZwMW5MR2NMSk81?=
 =?utf-8?B?UmVsTE5ub09idHo3NXJQK1l1NHhzZVNmOVNxWmpKK0FqcmNvMXBqYzZyamp3?=
 =?utf-8?B?ODVNcFlUckNBT0ljTVFEQ2xDQ1kwWmZ6dVVPOXJLMjVPR3JHZHZmUyt3cHhp?=
 =?utf-8?Q?ChIpImfEOcHZ3zy56Z22gVz1q?=
X-Microsoft-Antispam-Message-Info: wp8mTctzoe8rMKBiVJLFBJVUV1UAccqxB4QXqzgOqT2vqd1ElcJY+hbTevUYd9bByOY6LlvL7pkTduOUDZtadNibKtKmqEV61/FDQMHBsor24mdWO/JW6T3GBj8wa3/O6mgHJC9qZNBU2NO65d2cssDpcj9sO7ZcHTd3Ce1CFsMegc24Rg0/1H0wltnG5xf2
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;6:/VifNml47sSy5Um+08FOB0xKimcUHjBKeNeEpCjv/oz96tLscZmpqo3j7XOBVagsAJPJAUPY1Vh2o92HTXx18NRseRluvxLGMNnXrrOCgDufueRhkeYLOVyvgnGl4s3Ro07Az3gr8ShnqVryU2D0btc1IQlsOES80RPK83fXcCcBYxgh6H9oMicQzz5rJBRrQcfQLztJe72IOKscBGwZ3JxF8UN24woqJ/uWwe7To7Bp+OcJVmyMJyYD0fxBG7hq7EmVc7XKSNx6RH5vcDnhn9NAiTnKg43G+bQqsjb817VEJOZBVJBJ5KIZZGFtLbmh4ZU/G9tqHa4RY+U/LHeu5lw5rexXNhgGV+Xbyw+PpkMav30hFmed+AI7817sdw68VZK9BjFRfm+BAwxItDsKRTk65pgwnIrpVurE/i2DxePJS+gylOtiOmtUmXRlryz8B8tTY99hwsZa44TkkeDcIg==;5:swZmEjpBtkHURyODpjG5IS8LsTjLnYAftEswRGZBZFGBo2uE8jm0BnsSzgrG0VzjlCv6Vgqx96flN0+kvElUKIIgY3LnIE6aaTA0yMJ+yBn/5ceHK/NQsUhl90R6SWBWL5NACTSJVYZK9kEFQv2W9/rCOgWpo69LdXEbBfEptLc=;24:W60oC73XzHRm7DaN2lpE8Tmm6lJIuQ5BPzptkxK/vethFAN4rmvV/gUep5xLjZxxkX3ODTzoV7YNM90Rih+o1hc/MMqBf/aCZ8ZUtM0rYik=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0309;7:lU5FRS/P+mrAF5yOXhEFpRlIY1TT447d8D/5fXXKEbCuSoFJKoLfM0um1a3ZTc2g1K5pV1jLG7prDzIs/lQEdh2Ui2+N/pP6JfHzw+rwYTIDguHKt/cO20KmGpn2oY2zUHmVXtB9KwttVxtbzYTQAy+zBXKjsDqQjyT55kd1KVj23kA8OwZxndL+svU9pvvfhYMSi6G0JS2FcGp1nUwDrqN8fupsp68sGKaQZxw3sdU5UzYEbxEj0NOLqr/lZlyc;20:FvT909R/IOxzjCUECzDkQkPpSVKsDxvQQq4eYMOt989mDtkkwAimOWlET/Nt5xv23kg5KWZf4NF1pySd/jdFKnCKZNqcy6Q88blibHjMlgxhg3z4yvME2TXk1MeofKbq9Yu9A2rDC0M/v1BB8RVX68dfywMe/C+aNEbhVT7rr48X1gb2lEhgYTEK47uzCd4xL540W4hIpOMiRxl6VJbBheGLNpo9y2W7e/oaz+ZxNILOlFLzGp8x71hGTv08hc5M
X-MS-Office365-Filtering-Correlation-Id: 1deffb2a-294e-4a94-ef59-08d5ae6b107e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 07:21:56.8030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deffb2a-294e-4a94-ef59-08d5ae6b107e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0309
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807124963001399?=
X-GMAIL-MSGID: =?utf-8?q?1599154868021547916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Monday 30 April 2018 03:09 AM, Daniel Kurtz wrote:
> Hi Vijendar,
> 
> 
> On Thu, Apr 26, 2018 at 5:14 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Added byte count register offset variables to audio_substream_data
>> structure. Modified dma pointer callback.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> 
> Please fix the small indentation nits, otherwise this one is:
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
>> ---
>>    sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++---------------------
>>    sound/soc/amd/acp.h         |  2 ++
>>    2 files changed, 17 insertions(+), 21 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index f18ed9a..019f696 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -793,12 +793,18 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>                   rtd->destination = TO_ACP_I2S_1;
>>                   rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>>                   rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
>> +               rtd->byte_cnt_high_reg_offset =
>> +               mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
> 
> Indent relative to line above with 2 tabs.

we will fix it and will post fresh patch.
> 
>> +               rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>>           } else {
>>                   rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>>                   rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>>                   rtd->destination = FROM_ACP_I2S_1;
>>                   rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
>>                   rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
>> +               rtd->byte_cnt_high_reg_offset =
>> +               mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
> 
> here too.

we will fix it and will post fresh patch.
> 
>> +               rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
>>           }
> 
>>           size = params_buffer_bytes(params);
>> @@ -834,26 +840,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream
> *substream)
>>           return snd_pcm_lib_free_pages(substream);
>>    }
> 
>> -static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
>> +static u64 acp_get_byte_count(struct audio_substream_data *rtd)
>>    {
>> -       union acp_dma_count playback_dma_count;
>> -       union acp_dma_count capture_dma_count;
>> -       u64 bytescount = 0;
>> +       union acp_dma_count byte_count;
> 
>> -       if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
>> -               playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
>> -               bytescount = playback_dma_count.bytescount;
>> -       } else {
>> -               capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
>> -               capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
>> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
>> -               bytescount = capture_dma_count.bytescount;
>> -       }
>> -       return bytescount;
>> +       byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
>> +
> rtd->byte_cnt_high_reg_offset);
>> +       byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
>> +
> rtd->byte_cnt_low_reg_offset);
>> +       return byte_count.bytescount;
>>    }
> 
>>    static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream
> *substream)
>> @@ -869,7 +864,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
> snd_pcm_substream *substream)
>>                   return -EINVAL;
> 
>>           buffersize = frames_to_bytes(runtime, runtime->buffer_size);
>> -       bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
>> +       bytescount = acp_get_byte_count(rtd);
> 
>>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>                   if (bytescount > rtd->i2ssp_renderbytescount)
>> @@ -925,8 +920,7 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>           case SNDRV_PCM_TRIGGER_START:
>>           case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>           case SNDRV_PCM_TRIGGER_RESUME:
>> -               bytescount = acp_get_byte_count(rtd->acp_mmio,
>> -                                               substream->stream);
>> +               bytescount = acp_get_byte_count(rtd);
>>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>                           if (rtd->i2ssp_renderbytescount == 0)
>>                                   rtd->i2ssp_renderbytescount = bytescount;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 5e25428..3b076c6 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -90,6 +90,8 @@ struct audio_substream_data {
>>           u16 destination;
>>           u16 dma_dscr_idx_1;
>>           u16 dma_dscr_idx_2;
>> +       u32 byte_cnt_high_reg_offset;
>> +       u32 byte_cnt_low_reg_offset;
>>           uint64_t size;
>>           u64 i2ssp_renderbytescount;
>>           u64 i2ssp_capturebytescount;
>> --
>> 2.7.4
