Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-325945-1517516687-2-1639955356771398040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517516687; b=CCcsNxQDqud/CzGdFWMOofGrDy1j+eJJlsiAadI55tdjghg
    KKOmpbwSkqnAE3rN9QgzYgehwq/8wCHLgAoDnPnJ8V3SBp8jBOIxFhX5BeOgldGw
    B2ELfodCZJscIR0AwPKoMM/xGj8jI3FB0u50D+qhsYbwZuMixtUV4Qxs2gTcz68G
    o0YNxWl2aOivXNFHa/SUS51GUd14vhmUDyMFTI+wSlVtbKs2SuuOrs9PNrWitBY2
    0R7tl9LivAdKlceUvVBDXLpRibSbvCLppOIpqXQhWwCdh1XO/8hR7cS6yM+SUt45
    gU4LZzZEH1Osp/jJnUhZPr4Rr8wUQRZHUisRtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517516687; bh=0bKHjYCO5GPO5PhUp7KFShkSoXlK1ECj35GCcQvVz/g=; b=u
    rSNs/N7950TmhP3lTiq/hNtmzpXThozeBG8H1RAs7S7rXM8JRw0e+17vAq81j4LS
    Zeo7DjDORpd1KdvMqxXGjD71w+KIYQZ332Yu0B99S/0a/sUSvlMKvzwIP2dxhoJ2
    wkXY2Q350gJAb+9g/2yog0qG/AWD1u2/9ulLkoy1ParE6j9Ct4ngzMfOTpVVX30S
    Ze/VJJGK/RupD23793758zVJJaG49Tpm/31oc+m3k8adjSRfWnixzEcTotePHvus
    divbf93QE1pM5xlU9GbZbYUV2SgQ2rRTA0GvHd4Wd0rd8PcirnWgs7Cvu+GFcby1
    DwbeG5NV3n1w7bNXAmm1Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=DoimfVwC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=DoimfVwC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbeBAUXi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 15:23:38 -0500
Received: from mail-ve1eur01on0125.outbound.protection.outlook.com ([104.47.1.125]:18354
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755038AbeBAUXg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 15:23:36 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
 <20180201163349.8700-1-aryabinin@virtuozzo.com>
 <20180201195757.GC20742@bombadil.infradead.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e1cf8e8e-4cc4-ff4f-92e1-f6fcf373c67f@virtuozzo.com>
Date: Thu, 1 Feb 2018 23:22:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201195757.GC20742@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.47.128.244]
X-ClientProxiedBy: AM6PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::16) To AM4PR08MB2817.eurprd08.prod.outlook.com
 (2603:10a6:205:d::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5af3904b-9e56-41af-c5c5-08d569b1a9a1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR08MB2817;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2817;3:GGW0CBdiF5aOBMqtW8etsen6XrDfJqo+MznpggwwzHqEfFXz3/wDG6dvKLSDLkz0ydqPH6u6SqmnghpbmtL13Ayce+jUJkKCud1QMZScDrRXxa/I0sL28WSe35I6/m1VHvf1M6IJTyVUL4vBGCxyDkPiTn3SLJRHUBtBqu16aBjmRhAMYviXzOfjT1YZjOvibZISWQNDkgnW+rkuv32RNgux72Nc3A7RUQUCGzo+o/TNHsEpY/9Ipgesw7c5XOUb;25:JaekxeTkyTOvsb/N5FqBdpRMA3kEnvURpnNm+eke0stU62E1iDyGa2sRgf91ssBFeFxvxo9dRlumfXzseo3R8EySGQstvg9T7laM7nCF/oBF+9ByxYvHQnEbGytRDx2euGgr4RAaCec0HMqx3WueNcaxUS/h/rrptfNBSYhI5eTsjqYmyGBL8uNoiyKnDu22DXV7fSGSemavb4rtEwSBPOWgRTj8G4QHTPM+zr2U7R4x/6F+mI/Ce1+jmXwFSWkCTMfIOCyylJn3NBOILLrFZEAlpoGG9AnrcpXHwrsKksrhnT2s/rVcJerb+BOgGY6Fbo/vl5IcDtWt3TEZFHCgwg==;31:HAuS9EB2sCJdsjW66N0XTki8pRWBkokmC+1WiG13kTOoclkXXNMHMAD4i3LRPW8L48um3DuuyeJuNdtV3gS1lwcsykUaVPRAYl1biNKOYMnEXkWSaXD2fTUN8K+hOlZWdD0TyEbNNYpwRrEJGTGOnmsJGhS3x29OXNIvwOetSA5pS67qY3K/dmKrTapMaNot0Yk66iCHlmn2Sa1VOcWLZYNR6bsoQuoOF9VWZqBvaxE=
X-MS-TrafficTypeDiagnostic: AM4PR08MB2817:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2817;20:nT5EKOQhbRAU+yk2Q4XQ62BOu0iQWSCamaVqoEmbDgD8V6KzoyFVb6Ds5ggaKMXRhbuF8pDOfzb1c3Ot/qbJo4zBCmvq9GSCo3nxQOxDVhEyOT8WjNK6N6ZygnhuAtI6pbaG92KdOyKoKiunb5aQNocvOHZiU6irKvhKkwS09S4S1W8h5TnNhAn4WVjoAeEGdCYJwmPLnTY0oqJXvioMBFNiJtZwaloAG27MIM8FSTolE/PK5fbD+3ZYnAU2TKVUTCy+X6F5Dv2V1aPn421ilqq8/NRIjyW9GRr4UOBgDSJ2EfShqjU7OgoI7Y1ZIqRpLvAzwQXRUAoEeqdEfZz3yWVX0/i2zV00j0gma9guE1berILMuIeD20PWpXZFe7SMbtDULadKBtWCjPSjdtvFA7UugzzKp70sht+4LqIX1Jw=;4:7/Ko+ySMGqY7VafKN3yhoSH9tHKIOME5CrHaIhVubUqWOMsJsV6PEcldwFdCZViueAChVVlRnbRQooMNg+C2uqtpsxLaFcNEtbSoszXe0vjqUlK51siEo1dLTlrI6A0bZL7DSCO2qQBLtJ4H8zP+j3sIbkT0uQ5lPyNqv+uCdxsUVbyl/wUBYbt1Q34jidrD9mdNe+OsOICwssE6Jh52kQq7DrlupD70oE57tO0G85K+44LJvpNi1VsrQtgMrdR4lM7+txMEbN/CHVjCVZZAyQ==
X-Microsoft-Antispam-PRVS: <AM4PR08MB2817E8BA1144D278F6EC05A2B0FA0@AM4PR08MB2817.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR08MB2817;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2817;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39850400004)(376002)(396003)(366004)(39380400002)(189003)(199004)(52146003)(6116002)(23676004)(36756003)(52116002)(3846002)(2906002)(7736002)(53546011)(65956001)(66066001)(68736007)(97736004)(76176011)(64126003)(31696002)(305945005)(5660300001)(6916009)(229853002)(50466002)(47776003)(478600001)(65806001)(65826007)(2950100002)(6486002)(81156014)(106356001)(230700001)(31686004)(86362001)(54906003)(4326008)(8936002)(53936002)(8676002)(6666003)(6246003)(105586002)(83506002)(16526019)(316002)(2486003)(26005)(58126008)(386003)(77096007)(81166006)(16576012)(25786009)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB2817;H:[10.52.82.104];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:3;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA4TUIyODE3OzIzOjROaFk2VUpHQlQ4WS9JM25Oak9kTVIxWUx4?=
 =?utf-8?B?VnRlNnUwR2IwUko1dllMaC9va3h3b2JnTUdpZnQ2WjRmT2Z5NGJ0aWlNVE5M?=
 =?utf-8?B?SnorTXFYRjkwNTZiY1Y2ZVF0R2hvdzJrT1Z1OG5qbm5TbnIybi9Memdvd3pL?=
 =?utf-8?B?RkJNSjA0S1NCQ3lqSEc1am9zUU9wajJPUkx0ektIR1lxRmpBU3Rwd1MzRHMx?=
 =?utf-8?B?elBBeXA1ZytZR0xSUWFrNHpDeXMwSVNqK0llR3c4U210VmRodEg1RTgxNlNZ?=
 =?utf-8?B?cEhRa0lneVFmT0loem5aYkpXL05UL1BVUVozQ1dsMTZwMkJTZEpVVUFSSFZ0?=
 =?utf-8?B?U2VZZGNuZGpzQ3hCZGVlUlpFckp3ZFN5dWErbm5YcVVybHIzRmtUSWlxQmZi?=
 =?utf-8?B?dlhmNE50TTJmQWlqYjVCRklKaDU5RUJnUUVhVDZlS2dlMkRFK1B4NlgyL1Zm?=
 =?utf-8?B?MDl6Qi9Zd2piUVczUlFZblo2S1R3U1Y2ektHWDlpNFBsYiszNVpvZVhDUW8x?=
 =?utf-8?B?L1ZLZzA0LzRzNDFGNXVtdWVKUjhVcXVuN0VUdGhoa1p0bmRlL0VBc2lPc3A5?=
 =?utf-8?B?S1ZuZ0p0T1Q1dEhJT0lHckRWV1g2YTZJSkJKUnVNdStxSWtEVWdNTE9Ubi81?=
 =?utf-8?B?Z3V3Y0drNHZ0T3VhZ3I5aTAwWEJmVm5lMW9PRXNDWVE3UXZxTEU1Q2pQTGho?=
 =?utf-8?B?SjlxU3Bkbi9BNU9YRG90Mnd5VzM1blJFNnVDaFNSN0xaUStWVjZ4dS90SWtS?=
 =?utf-8?B?NTJuTjJaSmVyZjdWU1J3THpkaEtSeFJSeHltSlU5K1c2WE85UEFWQnA4SEdX?=
 =?utf-8?B?TXByN2IzSzN5OVFWUkF6SGNCT1dabk5hSThNV2FBMitoRjRFamdaemtIejlH?=
 =?utf-8?B?cDZjdWZxVE4wcStrWnkwcG9VYmxyWUxFS3MxczdmSjVMWTJFZ1p0TWJXRlYz?=
 =?utf-8?B?K1B1REljY3RFTlZ4RnlrRW0zc21keFFaQ1Y0N0Jrdzk2RnF0T0dxTENPZ1Zz?=
 =?utf-8?B?ZjJUL1ZvN3MwS2puSzRFOUR1M05HSExwZW5qNk5BWmpPSExsL1Q5NDlkdTQw?=
 =?utf-8?B?VnFpM0gyU1NhREF4aThhcHVLOXJXRS8wa1BhTTZmdko5UDNqT3pDZm1SR2Jm?=
 =?utf-8?B?MDRsQ1ZWK2ducXJvM0tnNGtxMk9Xc2lOUWlSR2kwR29BNXphQnViR3RXcDJU?=
 =?utf-8?B?cDVVWXhEMGc4c056NFhLVXRQOGc0cERwdUlMVHZqaC9aSXJpd2VWVUQ0aWd2?=
 =?utf-8?B?dUdxYUtIWDRqa0s4c2VNd1l2SENrVEZlMGxkdFdMK2RPZC9EYnhEVmxGZkRS?=
 =?utf-8?B?emRDamplRHJLQU43NDJQK0haOU5oRGovME9FZlNTY0NWTWJmSFJvOEtOcm1Q?=
 =?utf-8?B?YTIrTWpnN043eGJSYTBHWFRieXdjcHY4c2lncHluR0hoM3pnZWpTNTVqZG9K?=
 =?utf-8?B?c1U5ZGtReDlmb2owc1pCeTVJZjRyVEZmRVhOVkxXcFJ0d1RudHE4MnpQbitE?=
 =?utf-8?B?Z05Qdm5oZEY1SDQ5YWdFa2NTb1dMWVY5RnBYcTFXeHdpL05pUmZwRldNM3Rk?=
 =?utf-8?B?Zk5tQ2FWVVNoY0JmUm12VHBsbjhzandUZkxINW1WWDUyQ084bXpRNXRxNHVx?=
 =?utf-8?B?K0VGQXVYclRpS2VDcGtOMkU5RTZZNS96S1paK3R2eCtXWEdlS3BoQnNHRHBN?=
 =?utf-8?B?L2JaU2JFSmh0REJUNHNPRnBCalBVN0ZZUENzbnpIQWtqbWlzQ1hmUU1adVJz?=
 =?utf-8?B?Q3JWbkJyTWg3MFg3OFkrNUZzVktTb2FabHE1aXNxdHA0NGpQSUtHSjM1YStq?=
 =?utf-8?B?VG9QSXVicE5IWndpTU9wTG5pdmdCVm9kRi91VXNaVTJlUVliWWtNWlcyOWc1?=
 =?utf-8?Q?IpBSB+bzeDA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2817;6:lvjUSYWRwJZGHxDBFesP/o4o1u2+EK/scbk7ZqQ9offFMQTSl4OZuQtAlM2ksSnK9lfxqOHdYcp0FRdWKGtE4nDV+stmz/7Fvu+BPbJ6n0PkraHtE66QRH8faMJDCaTYZ89TLn2J5rqGkIvKjHMAL1l1N8I0qe+lqaT+aO9/UaQsFPnQeSxkG5OC1Rcl2nA96Jo63KEP7K13JUEz4HWZLXBUToG+DBKo9Up6Io0f2syYjnDieCUnN3TWqKQyYJ9joJtI8PdcrgO4mePuG4xfHHwlS2LD2CatPIiVzpmHGewXZDzGEwsqPGUFmB4HfrCpC5OH62AJoB6O959cMJxmClokMBHHhpTKX/bpPmmt3BQ=;5:1DbwiMwpl1DlL7e6gSDGNAG7h4fjBcPHV2pICiKKOs9aW4bfmf1iEAmSD5uE+ArQKxJY7wpOTUBxaKAw2ksx6nxdPYlyHiq/srp/SQI76oEJTdiqfSMo1NJa58zlzkR6NzVRqVHyig4/G4IZhPOtgjgMvWnMaLikDanenRjT4qk=;24:VzscBw2RGkc/Kpi6x4yjdArIipsjGOpZknTuoM01UfhXZnpfxUF0gIwQ0MlDcHdiVxdttQVAizyjHAoxXoLQAE2zeqgt+jjI4r6YQCpSk0E=;7:n0de+MCeUlIFqvEsTX0epNKQvCOtyrY15lRFto/hfyj1fN9AZxwZutY8E7HYdPmwh6xsA+TKyvUMBq2lrGCaUxMfdeumDK+RKouQ1NMmEhNUj3sE20HAevk50OrQLIwHGEWmwVPLwW/Khd7XQwTlGfmY2fjg9602ROBLQL0zNrxcwcQpSfm3YAS0WUyxjpB7mWwb0Q8smu13aKFKaFs8pn1tEXQh9pK8UIt2ByVPX8RP3RB4gZF0jPSInO+H7bad
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2817;20:L0LTyVi+crAnoFKzzWK+KyLKauICR+L/eANoDOyI31CxvB3ovLZ7n7BFaaTF33+vCVz3jCfTAC5cDGmBVAd9U67zkF+WpJ9NSx/zVRNKp5XrnkTbX9OeOCRqObMnLDzmhqqpS1wogOg/Wr08m09noUrvZtQnGXxb/zWMNs9MA0I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 20:23:31.1528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3904b-9e56-41af-c5c5-08d569b1a9a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2817
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/01/2018 10:57 PM, Matthew Wilcox wrote:
> On Thu, Feb 01, 2018 at 07:33:49PM +0300, Andrey Ryabinin wrote:
>> +	case MEM_OFFLINE: {
>> +		struct vm_struct *vm;
>> +
>> +		/*
>> +		 * Only hot-added memory have vm_area. Freeing shadow
>> +		 * mapped during boot would be tricky, so we'll just
>> +		 * have to keep it.
>> +		 */
>> +		vm = find_vm_area((void *)shadow_start);
>> +		if (vm)
>> +			vfree((void *)shadow_start);
>> +	}
> 
> This looks like a complicated way to spell 'is_vmalloc_addr' ...
> 

It's not. shadow_start is never vmalloc address.
