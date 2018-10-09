Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34157C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF29A2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="GvKMl1Pm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF29A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJIQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:00:56 -0400
Received: from mail-ve1eur01on0109.outbound.protection.outlook.com ([104.47.1.109]:11136
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbeJIQAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj6E9Uf7PbxaNpvcKw8ZgRP/8Hyr2E9qGS8luN89V7k=;
 b=GvKMl1PmbYy/f71NJzKnYfCFM7//SCHBcpaQE2hvnV9eXocbVswsepCyMkOXmi9VNSMshuZZ3iwCRE99NnX54Lvy0SC3zWc6AlAIfHXR6N2SZGKXHCyzbItRsAPLvlB9qHBIRW8+r3h9UiDm1gya3Xjk9G+0UfvkM1jW9syp6T8=
Received: from AM3PR07CA0136.eurprd07.prod.outlook.com (2603:10a6:207:8::22)
 by HE1PR07MB4203.eurprd07.prod.outlook.com (2603:10a6:7:9e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.13; Tue, 9 Oct
 2018 08:44:59 +0000
Received: from AM5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by AM3PR07CA0136.outlook.office365.com
 (2603:10a6:207:8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.10 via Frontend
 Transport; Tue, 9 Oct 2018 08:44:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 AM5EUR03FT023.mail.protection.outlook.com (10.152.16.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1228.17 via Frontend Transport; Tue, 9 Oct 2018 08:44:58 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w998hwlp016348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Oct 2018 11:43:58 +0300
Received: from [10.151.73.229] ([10.151.73.229])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w998huUg016260;
        Tue, 9 Oct 2018 11:43:56 +0300
X-HPESVCS-Source-Ip: 10.151.73.229
Subject: Re: [PATCH 02/12] perf auxtrace: Include missing asm/bitsperlong.h to
 get BITS_PER_LONG
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     Clark Williams <williams@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
References: <20181009005427.6607-1-acme@kernel.org>
 <20181009005427.6607-3-acme@kernel.org>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <a73e3b15-cff3-312a-8345-c5b14dce070f@nokia.com>
Date:   Tue, 9 Oct 2018 10:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009005427.6607-3-acme@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(438002)(189003)(199004)(77096007)(53546011)(2906002)(4326008)(39060400002)(8936002)(58126008)(65956001)(2486003)(305945005)(65806001)(106002)(68736007)(8676002)(81156014)(53936002)(6246003)(81166006)(6346003)(23676004)(86362001)(229853002)(336012)(97736004)(106466001)(110136005)(6306002)(26005)(31696002)(186003)(54906003)(486006)(50466002)(446003)(476003)(2616005)(508600001)(76176011)(65826007)(5660300001)(44832011)(126002)(26826003)(316002)(47776003)(36756003)(7416002)(230700001)(22756006)(356003)(31686004)(966005)(64126003)(11346002)(21356005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB4203;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT023;1:YYFgI+ayhBdryP78b7hortEtdy8oPx/CYumJfUfHRbY29jZKd60ubk5IlG2Vm7x65kC5t0kFjDs/lPSPln+j1EPppjNWX3Bb7pDN48bzU8Buo16/K7Ip+p6xg1F4Bmjj
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a2a453-6376-4745-3b49-08d62dc37f06
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328);SRVR:HE1PR07MB4203;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4203;3:0hPt+eeaVpglEmh139cvUDPWZvAXAsOHOAID+xRo1M+IR3GK2WuYkkM+Y/8IwIY6jfc3uU5xQ+Q+OhDFzGh/M9CfaGpIOpPUdz+J+nP4xmyEMB295LIGRrNqYa3Jr5lqfSuBHYnpFhJxojRtoOkk6iCdGfSdcjEG7AHZ7FVwwCtMn1xmT211ZGd5P8zTPZ7O8zMZmmqxLUBrpG1ycFKE5jcc28PlW22tECjLEzzcMAzVwtkpruZCUIw1/UT6WL06r20f5Gf6NwFGFu3s0c+R0rhOkXKvSuhFCbMgRsm5HX26Zp9VJAb/wT7U+uKvKmPQr/tGY2N3K5e2K33BMvFSKRtUnnQXiX2os7F6zmN2jx0=;25:cuTbVJgpYYUAUd/btyGcBasSzH9gLrfYwc9x3ir7G6bgPc43jXhhL5KHtJDmxwtX6RkU4WmrEPWHMgyWRAH18/23S5Xwy6JQe43DX+/xSYYQli7QnhqWzcC2xD6bLmTcFgM04Q25eZSsitalWcgdqVbEIGd9YouOrfRU7zKUVypUzb7hAMkaF6Ru6op/WlV0JHdLkFocX4BgTRhUZW+t7czGpCaFqkbwOUJJTfBbkJVR4hGkZT7Hua4+Y4chXG5eQXoiMlbLopWpw6CIE7oKEm40MNey8liKF3nGgcRtyyj7dPSyol5Ssxs/ivbQFsgCnNMWGRqvUXlNP3TJnchCSA==
X-MS-TrafficTypeDiagnostic: HE1PR07MB4203:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4203;31:YxsW90+u/89kJKZJdgW/MoLPaIWJDKg7PPC3/Z/+e22SAbspfy9Awk9eqc7fLimB3EMrOnNXR/M5zYic4g/M1uRNhCQygUGYgd3/cgQVjZylFzgWot82UvteM5SAittXUSulB0iN/sxsEzWrjMa+GzP5OB3t1PpVhBqnfEPec2Im5Ni/XXTU9DbtJRl1FdDzgyTduyrAs4JMLDlSy7m7VM2hKvuo8SRaTBr3fJMHiis=;20:nOZKv4a1V7nPEmyuiN0YidDK4YG1ZWwO9+kBnfOBduHXujNnZWBYxBMszcnbmD5aSpcMViItFwFHVhZ0Pt1OzmMXwRBca2uJtMgnUzM6SAtzd1pyAp0BS+oFiWLa2Ovevf3L97XFXua9n/Gho8w4iRBKLzFc/fpjCg4pI5a3DnQ5S8jgyqDk8WPao8UQOcHRohMhXH3Oea72qwC0b6oGfX2ujnSJwVQOyns1BgtzZGd3ouS3WeHL+YFQId7B9lmWQc24vTOwrKFOTCTiL8ObTjpNlkIkT36nUSYOkitdkhNOXhOgqo1Nc0FWPl5aUIFOJzShhxwFeH7mWEFYf1gbRHhtgHwP5YiODgYNtfUR765/rLDXArwzq7/Masw1KvF3+sQSg8AmtjFW79OlnDXnKkOJJBBzJbEPzaL8hdAs8dHGKEzK5KJ/L0A+llS7bxmy2HL3fFsqg5RZrQ1/bGoa1wa9oanag/FmOYw8GMt2zud7UqYfJg9BYB3xBPhiCcvfXQUJAIZ3rRiOU7Gx6i3KrpLGwcQ34/vzS/o7qiwhHNwkjaMm5rDPWXLCPLd/3WIwCXLaFUE49FoBaa1WsKHkKvlhLztwAy+8Ou5+D6+iPxA=
X-Microsoft-Antispam-PRVS: <HE1PR07MB42039BB34AF06065D608C1D288E70@HE1PR07MB4203.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699)(109105607167333)(82608151540597)(195916259791689)(85827821059158)(50582790962513)(42068640409301)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(11241501184)(806099)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:HE1PR07MB4203;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB4203;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4203;4:8bvQs5p/igT98wJ7L3gsiICA4XLDZZ9fSf4M+T5/wKP9iDrEjCeQYJ6JE4Vo7auiS2lcGpVyucWfxHPKf+0Kys1V1lZArPqFYG9FQM0r9X+PFtQH3kWPlP+a9wo3giVG2jpWrofR1q3OsErKe2OX0Iy0RyRV0697agZtsiuSf1T1X9i6D5SJOvEE9O5GOE9dTVhI9bxDLKYKvrlFOeWOwCn9juTDdLHYfYNK9qNXFzdqX1DfgM9BzmcQ2wl6IU0mvYLaXfCydYw2rLN70Yv6ZKVMELw2wcy4JFzm6u887QyTPEAcaK3j5By0n5st7/BOvnO2BDWapPGrhZjDBlNIz1mzNITUiykaltM10mL7hWA4S/CQ+12lqTV7loO6GHpegnWnLmAN9yleSfwBGvqLIH8P4UjEfG4VtOVyME9jq5U7ffkVvX6L/bhISPqDlI/sKrjivWAcOPQlWhWOOx/mOqlm4dj2JNTUcN1tiDqADo7bFP2De70KYuw7NXPR00vFsIm8f8wI7+jKWl8joOUspgupqC6IwZselw0BWZSVD/SMrSMSRf8b1IWus0tWsn+l
X-Forefront-PRVS: 08200063E9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3TUI0MjAzOzIzOkNtSE1mRHhsR1dQTy91aFpwaTh0WWdGOG5I?=
 =?utf-8?B?NUlJWXBpYnVOZTVsRFp0cVFCcHAyZ0o4QWNsd2hIV2xWYzRZQWxDaW85aVFT?=
 =?utf-8?B?anUwd3dIb2hoSWJMVFowWnlaempyWStyMEo2bkZUQU5qaUUxVmRwZzJXT05T?=
 =?utf-8?B?SU5QYndSdVo4WEMwS1pScDN5Tkpkdi9hZWlzbkhwcis3cUgrZm5ReW5zVm1X?=
 =?utf-8?B?YnhXTzhNYVo3VTNLbllUNnJyVXVEZlZpZFczQXR1bnZRamE4MitFMVBmUVg4?=
 =?utf-8?B?VHJrdDlZSC9jd2EwSXVxQlhwTDZEMHZGS1k0WUJvVGNMb3hmOGRONlNEMEVn?=
 =?utf-8?B?MWZwYzlGZVM4Ulh6bHVaWTQ0WDRkM1FjQnVkclk5L1dWSjZZK1V1cnFpVVkr?=
 =?utf-8?B?dGcvN1JSRmxBZEtqRitkVUovN0lLS3lIMkQ0UFc2REROUXl4UTFNQjhqYnds?=
 =?utf-8?B?VmpBdk01SGZ6aHZ6dE9qZUNTVWUwSzhiWmpPU04yRHh1VS83eDRXMkw2ZlQ4?=
 =?utf-8?B?UXp6U2ZGVDVkQXRRYlJvN3FQYjZwU2xvaGNHWmFMcGo0QXpSVWdCZS9tKzVj?=
 =?utf-8?B?ZG1uZE1mc0M2MjZTbVYvdi95dzYxek1GMU5YSkFoTVdjQ3VaQ0VnNGdQMitC?=
 =?utf-8?B?Ym9sbDJoc1A0dHFYUVhqbmZyeWdMQWpySzhyQ0VmdDk4NW1IeXo3enlML0FX?=
 =?utf-8?B?ZEdqRUpkM25VekIwTEVoUDVRbTg1ZG9keDdlQXNvVmJ6UDd0eFhnTTQ0Q0Ny?=
 =?utf-8?B?czdsVUlBL0ZyYkdBOEQ5aFhrTkRVeWdWc2lKeEZlaEFmTDJtS21nZlV5MlJz?=
 =?utf-8?B?OGNyM1JncGlVVzdDSkZ5enQ4STRaQTJMMjVqbXZIK21HRHU0clFFWnI5c1Ay?=
 =?utf-8?B?YkpsVy9raVBCc1Qva0pRbFFzRVZhQ0F4cThVVXhqd1VYNFp1V09FSGJ6U3NJ?=
 =?utf-8?B?RXBlMDFvNWtMc3AzTWV0VDBubmVLYzE1Ylc0dUZVaUkxVXdSLzFsUG0yeEEz?=
 =?utf-8?B?ZGVWWDAvRVU1MThPYlk0QS92aWRvcDZVTEZFTzljUFpGOE53b0VMem5BUzRj?=
 =?utf-8?B?U3Blc0h2bGMwSGdqcmxoYU16dkdsbi9Ea0xrOWZJUHdUVnNNSkZqMDM3MTl0?=
 =?utf-8?B?YnF1dFhkNEkzcDVmcGZPajZTUHZSd291c2EyS3RzaFYrN04rUlE0clRzS2FW?=
 =?utf-8?B?Ukcrc21Vdzhjc3ZNRVE0RkMydm9hbmt6WU9iZmRjYVdVM1ZJYmJpT0F2RVJI?=
 =?utf-8?B?MlV5VjIwN245aGZTT2lOUFFuclYrWWxObG1EZDlNYWZPaHNlUG1ySTRKS0g5?=
 =?utf-8?B?UStJNm0yZytyWjlRczdaNFBjYW1kSGJLNllEcHJxQWNVdVd3VXdaWmJRbVR4?=
 =?utf-8?B?V1AyTnh5T2ZDNDZleVFHTzFHN2N6ak5aeFNTclpBUXhPWDd5cFdlNi8vWUIx?=
 =?utf-8?B?WmhsQVpPeGdXZ1lreXJLbFc5NlNyVWpxaFR2TXE3OUl4M2xBMFl3WWMvUmN1?=
 =?utf-8?B?Z1ZRZENVenVwc29McWE2NDQ1WmY5bFlxcUZKOTJ2T0N6RnNvbUJHYVNESC80?=
 =?utf-8?B?ci9zdXhRbnl2aE1BVm5RNVphQnI1YWh0bFo3SDFDZGVuYVZ1aGF1SVFKaXJl?=
 =?utf-8?B?SW5ST0RsbFZuS3FsVXY3VlpTR1RhQ20zUFpTenVEVWpEMjNPa2tDWjZyb1Zr?=
 =?utf-8?B?TUJPbWZ1RXR0M0FDNWQwREd3MkYwT2FIbU8zbDhRY2RoNEhqMU8xWTV6azRK?=
 =?utf-8?B?d0E2L051UE9rc3U0dnQ5RWJIUkx5SjA2ZjZpZTdra3BJKzV5MzVEMERRSGdv?=
 =?utf-8?B?M1AyWWtpdS9TWnhIS0RXVUliYURWaTFBRzEycG03aUF6WWYra3U3Y3dmZEY5?=
 =?utf-8?Q?fDNEXDL357giKy/yVGThBWD04b9qnYHl?=
X-Microsoft-Antispam-Message-Info: /sQl3NegNLlGk1WOZT4v6hNY+aI3XAmTUondt1jiMa1awFDQr+lWoE1j1TZEHTDoy8aBvnnEajU5wVpF9Gp967L9gl6v/Ln7RcEx0g5dMFqbEe/ONGUUfS6wILqDRBdn0BRlJueYnBz64HfP4X0WSGx3wf2Msmjx0udZvn6oqR7F0oiqfd6WqAiSWHAqPghSk+6zY94iC46sKnjR1Xaa1BFfw8IB8aec1qjT3mCTCh0Zz0er9E2Jz6pSLc5MGfOTSXt/u5bwOFIetMzTXQtMtbdPXyioFLeBTOKR3duxIzxvjZs3dNwBCOSaiRf5Tsp19+u64QcGPzrStPF2dBfa1NL3yjdb3I50yJe6qMx0sSd1ASx5LhNg2Ol6IuYL/TIhpYPlj0Hm5LtCuFrpGLSSBNf57lYp6Zbyjb2ke2quAVHVLBQG8scBvcYImgNEuGKv
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB4203;6:+PP22Z9wXFlNo9nUOV3Olz26KUPRdsJ3bbr6+Gm0T3p4VSoBzd/YvCDxIPQACZANFTERlghoGQ99cdydy9X2d7o+BWs7lW+i43tbeYh6d0O0wTyX8TE5/ghrJw1jq6wVT52vD6fmCHX7Q17UtrgeGc4A1ud6ne+b76oUU6lRl1celEulwyQ+wezuzbVMYuB2Sfp+6hZOADv8a2xJLbo0yKtaB3z/ekDkr4zATbDdvTgsRS7W2UEd6Uvekwrn6mTMTporlQ9xoo/rF55Dpr1R4ytjljvX+49IjwCnqlLqDqSc7jbrMuCl4kVGyxM8uU5NlUBle7RNI0WFY+2DMJpOsRgTKMsZQ1H/1RsQnlaeW8J6EUktmcxphoIp2ESsVF4b3EIweh/WpdmHI6LCvYW3Gvq30obce8+vyUYbhlTlWvEsqwNSwGY9EpmMBV/cfBqHxFUAtJUN+BwiXPpn0wrm4Q==;5:T+RvngPSC3I9Wq4jkwR6VmxAIORlSdeMttz9VnLroi+HQrZOIx3+bgx9hhWreJoLpugx7v/43+k/MXN6dHc+O3cOeiz9o/EpZAVnbnIR8FAQ1kbrWyNmb7RQH94soieMV49LKLLq8wSB0N2ae3g6WEhtMAbF+b81DDHZ2GBaFnM=;7:mlfvPXbwUTBuekPcvnJFcKqSv0eZxMENz7q9bXjD7j1QOOaZ2m3loICPKfwguXEaW1gfKp4z/39KXhDdy1PcKLun4BTM/36VPvAYx13t9G8tVOfajBy0d+8PSiaIu8plJfKTb5GPfik1by8Fswq+gEUCQmBrEgG8EfgFMI5/sLpKe5VpeL7qCYoPYpaL7Kn+xaImgwj72XqXCtfsNd0NYTCC7khSqDt0Q9WSnxvDDsX+Oq+3PjJCTyRm1Ze31NmK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2018 08:44:58.9835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a2a453-6376-4745-3b49-08d62dc37f06
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 09/10/2018 02:54, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The auxtrace.h header references BITS_PER_LONG without including the
> header where it is defined, getting it by luck from some other header,
> fix it.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-v04ydmbh7tvpcctf3zld9j9s@git.kernel.org

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/auxtrace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 0a6ce9c4fc11..d88f6e9eb461 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -23,6 +23,7 @@
>  #include <linux/list.h>
>  #include <linux/perf_event.h>
>  #include <linux/types.h>
> +#include <asm/bitsperlong.h>
>  
>  #include "../perf.h"
>  #include "event.h"
> 

-- 
Best regards,
Alexander Sverdlin.
