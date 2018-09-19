Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A26ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCEC20877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="JdlI3WW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCEC20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeISVEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:04:36 -0400
Received: from mail-eopbgr00133.outbound.protection.outlook.com ([40.107.0.133]:6213
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732353AbeISVEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmPG1eTYs9IUCGgN30lvDlFFFNPpgyTmACp/cm6M/0w=;
 b=JdlI3WW35/GeatZoUAH98tWxuEro3iwDX+/MRdyOJ9sRVJ2yvG42rPJ+9lsg5Zz2LeiRaBNfmGzzsU1QMKm2LW9AH4s095jY2YTTWExn0s4FPDJY5+lk6uxN0xo3DLld0IwbLTb3vzNR1jAFcdFolTJZIBF8s/YlXpkYnzbVS3w=
Received: from AM5PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:203:2::29)
 by DB6PR07MB4198.eurprd07.prod.outlook.com (2603:10a6:6:50::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.10; Wed, 19 Sep
 2018 15:26:05 +0000
Received: from AM5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by AM5PR0701CA0067.outlook.office365.com
 (2603:10a6:203:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.11 via Frontend
 Transport; Wed, 19 Sep 2018 15:26:05 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.240) by
 AM5EUR03FT060.mail.protection.outlook.com (10.152.16.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1164.13 via Frontend Transport; Wed, 19 Sep 2018 15:26:04 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8JFPCpZ028994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Sep 2018 18:25:12 +0300
Received: from [10.151.72.173] ([10.151.72.173])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8JFPCOm028931;
        Wed, 19 Sep 2018 18:25:12 +0300
X-HPESVCS-Source-Ip: 10.151.72.173
Subject: Re: [PATCH] tools: Remove conflicting BITS_PER_LONG define
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
 <20180912190107.GA5502@redhat.com> <20180912192129.GB13738@kernel.org>
 <562288b4-aac6-182a-6f75-23d32dbdcad5@nokia.com>
 <20180919130318.GB3717@redhat.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <e6be3495-42c8-5da6-520d-1dccefb17406@nokia.com>
Date:   Wed, 19 Sep 2018 17:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180919130318.GB3717@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(438002)(174874002)(199004)(189003)(2906002)(65826007)(53546011)(2486003)(23676004)(5660300001)(229853002)(68736007)(478600001)(81166006)(81156014)(316002)(8936002)(26826003)(6916009)(22756006)(106466001)(305945005)(58126008)(54906003)(476003)(126002)(76176011)(31686004)(106002)(4326008)(186003)(11346002)(2616005)(50466002)(446003)(486006)(47776003)(6246003)(356003)(44832011)(8676002)(77096007)(65956001)(65806001)(230700001)(93886005)(336012)(26005)(36756003)(14444005)(31696002)(97736004)(64126003)(86362001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB4198;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT060;1:1QQ3636dLsFA58hJckvVVHXv1Ja10WtohgzrqtlpT2EN+LUCHT7Fr4ioaNoxzDPCsSxlvIbBLMPCAImBWLavcfOXda6VS+zPQIMjaXzxa10hgTw0g/rTPPB1uUG3jd6x
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c9441c8-fc80-4011-5ada-08d61e4436fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328);SRVR:DB6PR07MB4198;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4198;3:Bx/fVmOF7VneFD+nCm6DW81UBsELSbqbGdPTgC4f8rSf/2yOAX+ptqAn4Tg+Hr/q07g05qiQUNfvaJOH9r0jgbtA+YhlaY5PkDKA3K8S9sV07FJjnbFt2jsEnkHdBpJZUWwYgOatNt+0qPAyUaEf9lIDINe+aMGJRJyff6N4MopjK1n0aCQZV+98QcoUayD+3rsAr0/cR4qubGTRp7zhMr6Q09l4L9Ph3QSV3hMrcJ6fHNn1y+xS1Qnq3yu19yRe4u3xWSdhHjCgHsOObhhukEv7FbGHwmpnVYVib21HYSQgP0fbNabXESOzFj9WVmgJyQsi5fY8+mj5+20w09ogD5d87CMsnJzzFjgrYStGv7o=;25:MmaQncCMrS7Yr7xCcWGbjcrHmHavEYgcJbsnQoVgh4ptBM3O2fGW9P4/979ZOsApTS/tSDPVRoGLfhpr904qU3MRRq7pmr3pC+M2ukmhWLIHUE7BtAfjbVYOJrxcl/2l/85K/X4Wfnk/BEm4JGUjqPdJv7LXogqOrIxvIQ86XtqOaz5UDFW/JlKuExcsG9AomeH5IWoIz7eUjcV36GXN7a0Dh84nBBSz/FtMJ83aVrc8BgmhyPzG2TpHLQYlWjNLILptMCx9nfld81GvyTaT32a+BF+FvKpxkSx1PCr/RHfIZq9yM1l9qV/N//YW/PpxUD54tlwYYW8MUS27AzomzA==
X-MS-TrafficTypeDiagnostic: DB6PR07MB4198:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4198;31:njHjO6EDC0bCUPya6y7ZNxln0qyWI0gMpRV5jUpf11NH+SjdOdhKG7opf6NC5n87EBZgSu+OeoUJqx1mnOLeqss0DvErawqdAE0jf/e0YqlrTVbFcscKWlR2p3XScctIoHEbe1fsiZunSTuG4VpgppRGtE/pIbZtPqKSZXmtA1DiSBEqm+2yjLeSODOy5SXYfEYF/8hAk+RWBWZmu9eFXNPSD7vvzgPUDv3X8Act0a0=;20:gMSQ6+NVn8f1dM1C6XkY/MfPGPZI2NzMxnjrHLKyZ78NQ9mWQuvBI05q03qRBKYKO4ycn2VjP5MElITgjrL2g8/oT39pJaBBpGoTG9AnRqYu/WN24+A3K1fdhpw6lk6obDfcyfcMej6jVlE/5Ar+gQSoiF//ZHZvErssCuVRJ6SixTmFB1GBU/GeAnB2PnX4sGGccimcfNfIZyH5uZQks3yUYQ8SstJuzH2GfY/lWnpnkS6h5bvvjUH3UZV5CfMg47fTDBTZC4sS1C4xANlRr5KFOYB37YispEn5ia936izdkgcQHYzqK5rati9f0zx2caOAc5vmc7Wj3IyF2MRH9s2OSpV0hReiRDCfMTEGAlp7o1SG5MpM3SR21Zrm1tSgUy3DOSMliLvYyxG5X/EiDI/ofuU1k0+WnBPXNySM5Z/uEMkDd94gB3jXVD3+ymBiqjzUi1cy5du31xtH36d8Q1DVboTKf5iga+xHmqcr4xrkwIkl0ofS2Q6nPc7V3ANxYRrNUaq+IuSUlujc5gOGwDlkIaIn+7e70mS8aDG4bYZAzFlsYObwvliqki+4i/BXtH6HKLsHyaUFCSC2YAiKrKZvksuX/PiLzl+DeAzYAok=
X-Microsoft-Antispam-PRVS: <DB6PR07MB41986889D26A3C1B36F46370881C0@DB6PR07MB4198.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(11241501184)(806099)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DB6PR07MB4198;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB4198;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4198;4:+lddRmlgy+YBjmh9qQVGufIrAeoeHQaCjz02GfGiE6NV8er8aIUPeRYzc47ca7zfinUIhhSeq2oWTmvv0qe5XY3Qx2S52g5jdK0QbQpbxKUlDGKqjoZcxXophmtr/iMMmlsmsCNSfiCb8Sgwr9O1cdecf4bYi00SxE3llV2ssg6j3WTe2DFgrdzZ9gZEP2NNc4ckiL70UWFDgZYWxaaR6D08n5Wk0VFHB6mP20jhw06SBYuqHCwqjlRumcre0g4Y8V621sxSOE8TZtFZgA1SZA==
X-Forefront-PRVS: 0800C0C167
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUI0MTk4OzIzOmg4K05DcFJCZlJCeVdLWjhrNE0weTNMZEtM?=
 =?utf-8?B?WFNCYVA4eXNWeGdVbUhuQldHdTcxSlR1cU9BUWZLT3gwMWplb0NrYyt0WXFZ?=
 =?utf-8?B?N0c4WEdqWE9nVmVWT0tBeEN1SVN0TDd6SnRVR0RkN0N5VXNiQnFWWmNFSHd6?=
 =?utf-8?B?TWhPQlpwSHVCNSt2TU9LSUJzaVpRSENveTdzZmpBOHV1MmVTZHJxY1JhblpZ?=
 =?utf-8?B?YlN4ZzlJQ0lkS3gveVhiY2dQVWp4OTE0d2g1STZZMGxqZ1BJNWdQN255Vy9G?=
 =?utf-8?B?ODlHMjRqeHdKdm1qS0NKNFpQQ1VTRytrSnhWWk44V0xVeHcyR2VKemVBMjRE?=
 =?utf-8?B?SDBuM2pPcWxLRngvTEFOYnhvZkozY3RqR25KR1E5cUxYWG9XZm80Y2ZzYWtm?=
 =?utf-8?B?bXRHK3czZTdqeklYOFl6WElmQjBRV2xvZkN0bE5DYXNVN1p5akZ6bE42U2NR?=
 =?utf-8?B?RXdKeDRYc2Y1bG1hekh2NXFzamk4WGRoSGRtelZJcTJMOWtWOTRxYThBS0F2?=
 =?utf-8?B?Q2dmYXovRWduMkYweDNwRks2alR2WHFzVFlxRXVFZ0JncEY1am12WCtKRGZ3?=
 =?utf-8?B?RnBTQUp4N2M2QnBYVE1Qck9xcklnbGV3R3Q0UWtqSU1VampvaTVUTU5VNG5i?=
 =?utf-8?B?NmM2NTZhNjcrdTR2QzhlazhDL1lCdHNIcE93bWp0SE9DUk95S2pJVVgrR2ln?=
 =?utf-8?B?TW4wZXppTkZhQVNRQ21ZMU0wOWV2SjZrckRLeEZ5MG42Wkl6YTFZMTd0cnBS?=
 =?utf-8?B?WWhrQkd6cmlNY1pYYmlEUUNUZE9PUHhkdVh4b0xSUGJVc2Jlc0JHeitKYldw?=
 =?utf-8?B?QjJ2UWRJUUNkTHE0Qkl2M3hOM1R6TjdsZnQybStYWCtnaUZhWW9lWkNPMjIv?=
 =?utf-8?B?Y0UvVXh5RmI2UGpVZ1JBWVE4VGRlQ3cyVWJjbldXSksrUEk4ZEREQ1NWQ3ZK?=
 =?utf-8?B?bTlLU3R0K3ZqeWNpZVZxVU53MktRQ1Q1aUpublBlR3Y1VEhuWEVSMXh1M2JY?=
 =?utf-8?B?cFlDem1kRWNsNjM1V3JDMVU1Z1U1eituR0NOUFptSnc5NkdvRjJtKzNtNUE1?=
 =?utf-8?B?Ti9wRzI2UFB6NmhUNDN6SzR6NTVqeXo4WDBGdy8rQVBENUtJVTIwcERPNDA2?=
 =?utf-8?B?WnNKdTlxK3Uzb09kakRIVVlYdy9JdHM5alF0eUVsZ1NMMy91dHVrSXBmTlZt?=
 =?utf-8?B?V0Z3anJxYWVBZy9CWVhvMHVsVnNKTUpvZXM3SVNlVm1KRVMzNXJqbis0ak5H?=
 =?utf-8?B?UDdIcGxxelQ0NFBCRkhKeTFQamFWQWxYYlZWZGRwVzg0RUQ2bEkvS0JVQTlw?=
 =?utf-8?B?NDBsa24xaEhlaWovd1ZLS1ZUUzArTzVVaWZRSUxKR2x1aEwxeVlaYyt2ZlJa?=
 =?utf-8?B?M1dQZ1F5dExUTEZBSDR2dGhHSHlLYWovb0c0eTc3MnZsRUdYR0ZQOXZTQVRh?=
 =?utf-8?B?QnBUdjJpcmRueFUrNFhaL1RGZ1dzd2tKTjZTczlCdTZlUXdyRldFRWhNcHFU?=
 =?utf-8?B?UnFqamE1T0RpUXhZVHovMzh6NDQ5REVUN1czKzM4TFVqZCtweFJzSVJlWmFr?=
 =?utf-8?B?d2dSaVlDdmJ4TURLdmpXTzhVT2VqbDl4RUxxRm4xaG1RN0NNOUZFL3JZV0pi?=
 =?utf-8?B?MDFkZHp3WmliRkVENFJLMkNmNU53dExodjdORFV6cm9JWXJCbmNpenpRV1Nz?=
 =?utf-8?B?MmdyTFNHQUZETktLcG9WZ1h3cFJUelBBdE1pRnpHcGhJOENLSGdRRFRxcXVy?=
 =?utf-8?B?YWNSRzIvWlh5V3pZUGlubzZsbjlZbys5d1ViSm5JbHNubXE4UWZ2ZEhvbnFM?=
 =?utf-8?B?ZGhxRE1YVDg5VnoweG92dmQ4Z1ROeUtWN05odjNuYXphT3c9PQ==?=
X-Microsoft-Antispam-Message-Info: ejBdYOjBOkk2E/fvmUj7Hxyja6Lln1hS2j3kNTzH8hXyrHh6wK7EErh8SZz/yin6GvlaqYmGGjVTa4vNWW/ZzD18oR8lKSkF4Lzsdkb6mUyjOC2Rbe4BaENuIJBSZaoypRNBmOHaK4OYnFJ5bHyc/gg4t7vVskWRHAHonAlcx/PnXJuJDMPX4EHVWVHZGtfaI2eor/cYW60Iabc80C+LtVnmMdvTAS0OxT3X916Rqi0atQ9yAQPk9oL96CorI55iFwhw6geEgI0TRVV8aClrp7HE4n2uSpyPu5IpIrvPBaum94OCx9h4Tbd6MPQHCtwaSBBHEnt2S0bxwUAbVxAc5ewaTc8ZOy6vaKtt3FAzIFrrKkxq3GfUz+t8bCwRmhc9/lybgMU3TJN1a1UVJ95VVr1N00+jQHm/ECA1faW9hHaUoPKYe46bFN/VitniL0Co
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4198;6:EvFJvKhSoZkTngyTe83qgcE8ARHHjek6AHkLMnRo+cVrXfICV5jLPMqu6yBmjxdlBRQ8xEgGQKq5fDhZ9BnPvX6sYEgBxz8ZWL2Ef1LpaaxXeezWgSgclNGo7tPld81ujIzKmwsJTc9aMtg+fC5qCoocfRq/xPUCNCiKqNat/cryVrRYco7InUl9wECbJeM3oavgxBpuhFPSXSREl7feJkZzTUnuZ9/WUr7e7OeRY+DrePDX9cIJ8jiidXeW8UqYuqJp4yz5g9fZxeFXluXvaDS6nIQ+a9dTLxWeKD58DV1Tnpfxe9eU9w9mq1cirqDbYN+sH5nrWMWuuGrzR/LZ+P49d6TmUkEhxPYj2PBNhGjxPoaJ93dsZfo9dtJmCjlOvlPnD/TRX6dfv7f9g/qB1V5+3fe6Cpu5apphbQrhUpgVX2Oh4Qp1hRyPgZlYpi8+Ddo/KZqGN0Wf4L2nt2oysg==;5:7UaOTEdTMixMoFM9Oql+gznxQXXCKB44uqhUZmK3xeKIb3bUvNlLPsIclIuQrzXD8T2R0npE/+haRLMZ8Zgl/2Trj6pyd3ADDSIZZ348jPudkYuCUj92FPx38cLydfLhZSLWdEXr758aCwO6BrcbWb6xZg6nfbi0Z9c9FMiEMtE=;7:i9MZXLXyuU4B6nXO95k/k3avcOFn30l/IlQWjoAglDZpqLGFQ2NYjsZxK5u28bpTfKqAr5nMaK9n6MfX9F5wENjzgi38BYeIQWntME3SrunWXxjqqNvhDu2QBgSJe5kbGGVEJOETxH1L/QfCcFQEOXFNeTc9p7ar796Da5rjFrDVCErvw8oMIXbBhNQiz0VF3pZqL4sJW2JJADWaFrrJzGK5j8dr8Q5FynOzZEtU5Y/vzkexWw9J0wwD8x67J1aA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 15:26:04.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9441c8-fc80-4011-5ada-08d61e4436fd
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 19/09/2018 15:03, Arnaldo Carvalho de Melo wrote:
> That is indeed a cross build environment I'm not regularly testing, I'm
> trying these cross builds:

Probably my assumption was wrong about cross compiler.
HOST tool fails (objtool) and it's being build by separate i686->i686 compiler.

>    9 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-4) 8.2.0
>   20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
>   21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.1.0-12) 8.1.0
>   22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
>   28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
>   46 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
>   48 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   49 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   50 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   51 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   52 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   53 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   57 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
>   58 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-16ubuntu3) 7.3.0
>   59 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   60 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   61 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   62 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   63 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   64 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   65 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
>   66 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

I think the big list is mostly irrelevant. I was wondering why only x86 fails from my list of
different targets (ARM, ARM64, MIPS64, x86, x86_64, PPC), but it turns out that objtool is only
built for HAVE_STACK_VALIDATION targets (means, x86 only?).

I've tried to build it for MIPS64 with make tools/objtool and it fails in the same way.

One special thing about my compiler is really old glibc it's being built against
(hello RHEL :) maybe this causes reverse order of includes.

Nevertheless two conflicting defines of BITS_PER_LONG will only work with one particular
order of includes but not opposite. 

> I'll try and get one for building a x86_64 tools/perf,
> tools/lib/{api,bpf,traceevent} to see if I manage to reproduce the
> problem you're reporting.

-- 
Best regards,
Alexander Sverdlin.
