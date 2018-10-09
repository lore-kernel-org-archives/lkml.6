Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE03C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09932077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="oojuzrO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09932077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJIQEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:04:22 -0400
Received: from mail-eopbgr60112.outbound.protection.outlook.com ([40.107.6.112]:35823
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeJIQEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR12x2XeY5rzQ0YqmMAaoz2UTGXwzbpwFxuIVNTPTdo=;
 b=oojuzrO9F2h+7cvGaw2cLoGBErVMyWwfjNEkcrTWD7lTh8j3MZqH4jMdMnWfXo5yNvO9TYPLBhbXctjqTpixuTcsqIov4cpX6DUVyaUXEU3euWIMVQkr4vcEWzZDuxzoCHfOBj58FAA7c/B4kn4kAjl2sW86OSo8SdyQsw6P3U8=
Received: from AM0PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:208:ac::22)
 by AM4PR0701MB2100.eurprd07.prod.outlook.com (2603:10a6:200:48::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.10; Tue, 9 Oct
 2018 08:48:22 +0000
Received: from AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by AM0PR07CA0009.outlook.office365.com
 (2603:10a6:208:ac::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.12 via Frontend
 Transport; Tue, 9 Oct 2018 08:48:22 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 AM5EUR03FT006.mail.protection.outlook.com (10.152.16.122) with Microsoft SMTP
 Server id 15.20.1228.17 via Frontend Transport; Tue, 9 Oct 2018 08:48:22
 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w998laOe029040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Oct 2018 11:47:36 +0300
Received: from [10.151.73.229] ([10.151.73.229])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w998laDZ029010;
        Tue, 9 Oct 2018 11:47:36 +0300
X-HPESVCS-Source-Ip: 10.151.73.229
Subject: Re: [PATCH 01/12] tools include: Adopt linux/bits.h
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
 <20181009005427.6607-2-acme@kernel.org>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <f40d9bab-dd39-5a88-6e85-36f4c6069668@nokia.com>
Date:   Tue, 9 Oct 2018 10:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009005427.6607-2-acme@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(438002)(199004)(189003)(39060400002)(53936002)(86362001)(31696002)(966005)(575784001)(50466002)(65826007)(5660300001)(6306002)(64126003)(476003)(81166006)(11346002)(486006)(336012)(77096007)(126002)(31686004)(446003)(26005)(97736004)(229853002)(81156014)(8676002)(36756003)(186003)(106002)(356003)(76176011)(7416002)(53546011)(8936002)(2486003)(22756006)(2616005)(44832011)(106466001)(58126008)(68736007)(110136005)(23676004)(47776003)(6246003)(65956001)(65806001)(54906003)(26826003)(230700001)(4326008)(316002)(14444005)(508600001)(305945005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0701MB2100;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT006;1:Hq5d3AVkQ4Uhr99zfZXjy4p0pF3MpnVwPdHZuL3C0ljynn0ip7K5KWRO6+TYwBFfRdQOMtXGr8gaZZdHksfEZ8b2+jRKKATBVb186t80bubfUmVOOFyiMqMrMCRGKl15
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f0752b9-452e-4488-e98e-08d62dc3f85b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328);SRVR:AM4PR0701MB2100;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2100;3:ZP8ruVuMNfVQTLCrupE+LPr7uQl47KSF4mLX4XRxZHaF40z69bmBQoNqchQHMpXFsdOFtrkeBVgqCd+x9pczGr0OkiVlhrwHYvWoGtRz51krMnhfayMC/QZxkKLjg0wDUUSacDPZgDq78KOL7t5JYwM88WyPXPzFqHHwigVW1nqMqkwAR+YRvfsOvVWHb5SO/C8kPDAx6yrTZhLFIJxNG4/ai/r7oTe0wkTfDRQXa6zhI+r+cY1IQkK4RBH8yiSYMw5jArbkkAR/Tahzu1jsDlQfg4FhYDL5hwLOkOCU6HXcLuu41zFUbDrGA9YVkM2Xs4dyuJOmH41taQsaTX42dFfM572OVoD12pUWDqkhW1Y=;25:/90jTDJ4uEOg5FFjFPub6bA1QA3TfymTguq7XshfymxZq2JLtUhbb/XrXXZvT290YuZA0jr6dQQBgc3ErOVzpWtHD2w6fwAF465BSn0/1WZ+UKIh7HblJGrX2s+w5Xyk8+3/9yJK6oIb0F8EAq5W5QwJAE9iWLaVZiGIsNPMgObEpLW+v0MsfYf7F9cI5YemILxS7WrcV3hcoFRyA958WeCSS8z6NpHqITKLA6obZKxIFscZEYSpBnTVvHoiI+WHdbnL+pFk0ruzo3doookLvl86MfYZAzvgPLFKG0RXvPhtnT14zBMf5JcO4pboDKzXN4czyKEKYovXhhGqzHVjZA==
X-MS-TrafficTypeDiagnostic: AM4PR0701MB2100:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2100;31:qr3cqj59seiSPyTTh+V0sOAQ6TRtihm+1Hw8SuSL4MWqJIExqEDdFHZZngdzTtjsT9+YTBH88KGKLfn+5/4iL9auDe6F84A3lap0ZvoRL2rDZWU8VlvRmmv59eGvTwQzENtvsh6pPYv+rbd+8cgPISq5I3cEI2ffDD+0FLwQ20vAImGFsqWzCX3RCZ0p/p5OTO29rqdHuAaZ2G6j0Sq/r2AtuYUipar7iLf2WWBx+MQ=;20:TyKPB0OwjKGJGzoIlFAg5r+udsK8dph+5fk3okg82nPfjPdz+ixBUyKTTLcnsUYguJyGsSPvfMBKy2X/I94PGOpBIV5tzSxVjSNBXw9S45J8Rb65oJ1CkMfRHQiDh5T1v7Q+s6su7opl0MbXY0WM3f2UfRLvPfJHQ0+h5WioyLOjVwrE35cop/FB0+4dqXtnkb3GvEDv1q6E5ocIOTwyoWdXlgq/llB6OKb5Hw4TOci7IV2z7J3DBw5Y3UFnXuIEw69ngoeWMsMxmPMUp7EPHQo4VmVDYwpNonBwMVgwmG7MPaAZEOmakUJmKGqaAtpzW9nt+YZXoak4kJqb5/OC+En5maMW1KxEv1zKUEXOndYc9h2QQzxV2WlOWmVDlThd9xCwW52UU2RooA0s9jjPwgZpygD+8cSW+fPnrfXIhIqLcHhGTsnopZcUr7ph/BJy8EwW3B9nGtMNnUVf2wdF63q+MdojBsP0Pbhe+GS1JxMJRLcYIhvBbOh2xjbk3usSGaaLbBWSrHk1busj7hnTBarwD7GiAjxfjhRzY9diS9mCCcidncnx2g+UZ7s+OAjCkwYcIprnPi+97TL1ROmyZRfapmbHZZ5Jaoezra1xnzE=
X-Microsoft-Antispam-PRVS: <AM4PR0701MB2100F773AB5956D35FA701C388E70@AM4PR0701MB2100.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699)(82608151540597)(195916259791689)(109105607167333)(85827821059158)(50582790962513)(42068640409301)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(806099)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM4PR0701MB2100;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0701MB2100;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2100;4:iRGzZF9L1AwXa9ev5hk0PtZji1zFE34wrQh9i5azH93Y/gsQCLfYYdRa25lm4o/UCnHzO0genBf2CXxHBRoWT/2X0XF2PAjYCqCPyBLekos8lmE8j1V8PK5HaSVKIZHUE7G80MyQJdmzes46ZcGfNMQ1PGpIPRZZ1f0/oOWI37bnvwnqdkfHb38SSQJ2eRXKKGyfFag7xVBa4ZUGFzB37hpRquPHD4vEiwadfS58eyfTBFu/HB4rnM8Gc7/WZFC1Mlu45YdV6pGyudg1Ysgjn6vTHEfBZcUjCB9qZY/xVYLggbQKgqby0L18T15gLAEgnuAUGr3byZaBC5mW17LLown/Eq5NIuj/8JUA+fTOLbkD64EsYbGb2HRLtpC1dnJIpxCV3mbczRNNAcCweFHOuK2oFhYLKUxCjU1v4S6xfBTBy7TUJg48jQw0wczI9D0ZE7JwqYYnBgLdb1I7VrwY3qvgOOwF2hQNJseNqPSVBbsMl+LDoCFHOxbTUnu4971oEZBvjRxEWo7NyzEwNhw0F8vzsp+vATSujfVjzTVOwD8=
X-Forefront-PRVS: 08200063E9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3MDFNQjIxMDA7MjM6dmxZc3Q0UDZ5NUFTUW05YkVMWHMwV3ln?=
 =?utf-8?B?QkZ4VnAyR0JBcUozQzdEVzZhcGM1NUZsczFjZHJlUzhDMlhzQi8yemM2RXBx?=
 =?utf-8?B?cnJuTFFMTVRQQmY4eU9KaTJtMUMwYS9udFBEeXJ0VU53VjkrcVJaVy9waWRC?=
 =?utf-8?B?MGJYZVdlcmZQeU83OUUyR1VjU3AwdytXTnM2bjBmOUhqbjRtcmRlSGNGbTVa?=
 =?utf-8?B?aEJmWEJLT0lncU5NS2dwR2lwcStBbHBmUzQrbm1kb1JkRW5IRnNqOFNjVk4z?=
 =?utf-8?B?blcyUS9haW9TT1MxL0xCWEpoai9qOUVDamVkWmRSS2RDeUY3SkNIQmhVNVk0?=
 =?utf-8?B?UHV2KzhWNzJTQ0JIUVMzaThla0gvVHFvVU8yS2FWVEpDeDhid0tlb3MyWGll?=
 =?utf-8?B?ZVp3MzZERTZoUDk5Zm1remR3ckRucXZZWVF4WjFKOWdBSXAzS0hUNU9Tb2Vm?=
 =?utf-8?B?aThieEhTelptcDdFU3JUUklOYW5xUitxV3JQM3BBc2Y2S0dJb2xtZGtvelNQ?=
 =?utf-8?B?ZUhxTEVZWXNGWHZ0SnVDUHd6aVk4OC9HUmlsLzBkTGFzNUdnRWlYU0tJVjVq?=
 =?utf-8?B?aTJDbzFIZVpQT01LU2ZnaXJtWWRGdk00U3N1SXBCSWtrSDdXNXdFSS80aG85?=
 =?utf-8?B?TTlzYTVLK2J5OU1CS0NCc1N4Q2ZkTDl5VFZBbzdTQWFqVjEyNkFRNHhlV2J5?=
 =?utf-8?B?VmhEK3QyYldGUFZGakN1SElMMy9nS1ExN0YyZ0FQeDhSZ1QvSnM1d2F3cTZu?=
 =?utf-8?B?b2N3RmMrcFdLei9wNXBVRk5WdTZWMnZEOWFzQjI0eEhrQldSNnRwb1lxSzMw?=
 =?utf-8?B?UzJDYUpSYUpMYmRiQVV1UDdXdThoQnZDK3dvMi9MVG53TWdLNC9LNk9ma0FR?=
 =?utf-8?B?U20rbTBHWmF1R1lEak02SDhMWnhZUUNxOU1mWm0rbEtFR2xJUFFjd0FJNnln?=
 =?utf-8?B?ckFFYkFZRHJ2bkhCRndGNmVGSDN1czJER1h6ZThxYjRNQ2Foc0pscTUwSlVZ?=
 =?utf-8?B?UUp0Zzkxam54dDJCeExKd1JtVzhzSmJBTVFJcDhIV21jb1NNZGV4Mjg0cm1n?=
 =?utf-8?B?MlB3TmpMNlgwS0xudTNxNHZiaTdJWHRkclFKWW5JL2RpdEZmd1hVMTdYVGJu?=
 =?utf-8?B?dTdJL3FEdGkwZHRib09qM2o3QWhpWTRING4rZlphYnU1c3I1UTM3S3hUMitN?=
 =?utf-8?B?bUlSNXdLRGFTdTRLd084TkRGZXcwc0gwYWdvN1NjVTR4Wk9OV2hKTVplVXVP?=
 =?utf-8?B?VFhmQk4xUE9qQlIwRHpDNWtGR3llbS9CS0hNOU1yZGFoVGF1WmFiVUYyeDBH?=
 =?utf-8?B?Sk5Tdk1tVTZPbnQzeEtSU1I1c2F2RzRoUDhyWDc3elVPdGVKWlVsNG1pNHNv?=
 =?utf-8?B?NW83cHo3ODg1UWllVVVPRjRCL2FyQk9reVpFYVR4Y2RyZVVmWGpIcG0yeEMr?=
 =?utf-8?B?TEEzZEorQ3RMbE8rbEpVYUFEMU5DUm1pbTBPVXZZY25zMUVGZG9FM2FOVDJI?=
 =?utf-8?B?RkZZcUJOWTZjNmRuQzc3UHVkQThmbGR4amZRaG9RbHU2NGJXeUo1ZDdNeXhW?=
 =?utf-8?B?UEhzdTFNMUtJQmpsblVLdWlQU3hMNURuK255QmVKZ1pXVzhjMHNaOUpKQ2t1?=
 =?utf-8?B?cE9xZk5CdWZiT2UvRVVKeENzc2R6Ukk4M1U3UW5zVzU0NGpnbFVlR2h6MWl6?=
 =?utf-8?B?aGdHVzcvZlBiUXVET0NLYS84ZDlnOUhnc2tsT3Y0YVBZNXdadDA4ZFMySUJS?=
 =?utf-8?B?YzVKQ1BVR01LVVhtZEp5dXQzbHgyaHVTZ3RJRVJOc1ZJak9rMGkwaHlZcXI2?=
 =?utf-8?B?ei9LWEJpN1Jpd3FRd3lmd1RDTEF4NVFZZU0vR1BDZEswNTdNK29WMmNCZUMy?=
 =?utf-8?B?MnJqeURwSXBleFVDQ2MwQmFpSDFtbE5PMjhTWFdVampLMk00QmM1SDdCQjQ3?=
 =?utf-8?B?ZUhmNzJWMXFTdEE9PQ==?=
X-Microsoft-Antispam-Message-Info: 4RB9Wrtq/hRt0IAN4pkWCksVm7nwemdFApEZjCk6PvuKbPqs5mrFEjZ7yl3Ux7RQ2J8jp4M6aeBish2q4vUT0ed3G5+CCE4WtXbDzGFtFt7S62Z1qimIWxBXiXKJtHruLzB5XXC6GB20R0oEv4utf2pUpKwqtZWkoOocRsoN+uhbfp6E817kWocBW+31ucBqpFhllioPPxEH3gusoqdPDDivYKlswg71nmrtIV5HhUWO2cnRTYgSd8RDVPTTvNkKBA0deI23pkjfMjt50BaaB+0yCTFMp5AykNmmvDXZ0/sHYwgVCwF1gmstwOCWM5s0kxabTZZYE+d57pegailq9L3mffAcj9cPhrOuNgFBTeQkIeLQIlavfaLxOWmrbn54b4+x7u2jsO8Ox0d8dd8gV2sdLflapOgfC7is9zSGjjR82slavgJq1EMX/sSccnLX
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2100;6:a9wmUi3lC59PQXHrWbqSXn2KBDB5Ox0HZe4u077qM42FZlEUxJ0ISep+8lQKA3utLB96zrn6wkRDcSpkFM7eMEd9gAB0FvK0s/0Av8JKnyKWxqa60CKKwL0GGd/1R4sV8/FmkOLVRVlOnQpqeWM8MxPpyge0ejEiwBuoQbGs6J/eSNPNR4wzcL1Vv0L4Zeu/ifCCO+8keBdAozqYfCsQR8+QYZQZyFdOEqfAWqX+aqzMXWv8Fk7N7vD4mU5Dyo0k0q84hYyVVDd7ywt9CQ47zaYRxT1CmFEajNBhAGEqqoS02vwDXC2u11IyjPBKu6kITPQJf2BzibsnoVY397v/G8kQ6EXGSgoSY4mRDzbr3nAaobcD3t9ACR+MmZkJtRhWlYEVL3hZt/zY9JMiWWr8HIWodOHAVMWFYCtibtEVRI9HBUpFCndmZBhe0/iO+BGHDlSQHOtWydMmFHlPfaUwRg==;5:zMEh9wTeJNe6hZcoMzDh1cbDtYgoZ+Q94dDJJZ/HbPnQEAefKj8OS8VNWVVaIYFm3IzQtRmXiARjBBGd4srbLypTFm2AZMpSpvM52uc/qv0SBfmx2EiwBuGOJ/Esqi6vLO7Mi8A37C+ajyJaBGB43PazFmwfvVUAfGW7aCmkCog=;7:Ks9cA3hIzUOfxEu+x6dHGXpSvR9ywO078xO6cH4u1RObg2wGOv4XvkxooXnQnX3fZhGmciU1L314ZrkWsRgeEDdHyznG77VhNiGjD4YTM+HPbTBT/4eD2OfA3MOshlnem48ZsHQg0WpvAMBAZ93mTO5Cum7/5gSCty6II6uiKpIHPjnvKLkEOdu6TWJkTJL8YZbUPRhRjgOyCgh/M+gnqtp7G/Yajx2cbxLRWBgXIQNFIijoc4cHayVJ2/ayJL1u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2018 08:48:22.5493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0752b9-452e-4488-e98e-08d62dc3f85b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB2100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo,

On 09/10/2018 02:54, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> So that we reduce the difference of tools/include/linux/bitops.h to the
> original kernel file, include/linux/bitops.h, trying to remove the need
> to define BITS_PER_LONG, to avoid clashes with asm/bitsperlong.h.

thanks for looking into this, but I don't quite get your plan here,
you neither remove redefinition of BITS_PER_LONG in this patch, nor
in any following patch in the series.
Have you forgot to include another patch or shall I try to come up with
a patch removing BITS_PER_LONG from bitops.h? 

> And the things removed from tools/include/linux/bitops.h are really in
> linux/bits.h, so that we can have a copy and then
> tools/perf/check_headers.sh will tell us when new stuff gets added to
> linux/bits.h so that we can check if it is useful and if any adjustment
> needs to be done to the tools/{include,arch}/ copies.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-y1sqyydvfzo0bjjoj4zsl562@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/include/linux/bitops.h |  7 ++-----
>  tools/include/linux/bits.h   | 26 ++++++++++++++++++++++++++
>  tools/perf/check-headers.sh  |  1 +
>  3 files changed, 29 insertions(+), 5 deletions(-)
>  create mode 100644 tools/include/linux/bits.h
> 
> diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
> index acc704bd3998..0b0ef3abc966 100644
> --- a/tools/include/linux/bitops.h
> +++ b/tools/include/linux/bitops.h
> @@ -3,8 +3,6 @@
>  #define _TOOLS_LINUX_BITOPS_H_
>  
>  #include <asm/types.h>
> -#include <linux/compiler.h>
> -
>  #ifndef __WORDSIZE
>  #define __WORDSIZE (__SIZEOF_LONG__ * 8)
>  #endif
> @@ -12,10 +10,9 @@
>  #ifndef BITS_PER_LONG
>  # define BITS_PER_LONG __WORDSIZE
>  #endif
> +#include <linux/bits.h>
> +#include <linux/compiler.h>
>  
> -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> -#define BITS_PER_BYTE		8
>  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
>  #define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
>  #define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
> diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> new file mode 100644
> index 000000000000..2b7b532c1d51
> --- /dev/null
> +++ b/tools/include/linux/bits.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_BITS_H
> +#define __LINUX_BITS_H
> +#include <asm/bitsperlong.h>
> +
> +#define BIT(nr)			(1UL << (nr))
> +#define BIT_ULL(nr)		(1ULL << (nr))
> +#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> +#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> +#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> +#define BITS_PER_BYTE		8
> +
> +/*
> + * Create a contiguous bitmask starting at bit position @l and ending at
> + * position @h. For example
> + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> + */
> +#define GENMASK(h, l) \
> +	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> +
> +#define GENMASK_ULL(h, l) \
> +	(((~0ULL) - (1ULL << (l)) + 1) & \
> +	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
> +
> +#endif	/* __LINUX_BITS_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 466540ee8ea7..c72cc73a6b09 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -14,6 +14,7 @@ include/uapi/linux/sched.h
>  include/uapi/linux/stat.h
>  include/uapi/linux/vhost.h
>  include/uapi/sound/asound.h
> +include/linux/bits.h
>  include/linux/hash.h
>  include/uapi/linux/hw_breakpoint.h
>  arch/x86/include/asm/disabled-features.h
> 

-- 
Best regards,
Alexander Sverdlin.
