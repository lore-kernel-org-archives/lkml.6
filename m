Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7KtRDTt/GVsmfAAAmS7hNA
	; Thu, 07 Jun 2018 18:55:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EB15E6089E; Thu,  7 Jun 2018 18:55:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xoy5EWkG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18599601D2;
	Thu,  7 Jun 2018 18:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18599601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbeFGSzK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:55:10 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:27072
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933177AbeFGSzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQu8oWF7RhyxwKrQolQ0yQLtAt/W9lE1tzQqJwCzwnk=;
 b=Xoy5EWkGQHUhAwRARAiQFUThbYaAc3l0nrOb4DcLCy0xBt+LstnNy+09tEDrssH/I/6fRqI0w+g4kyc+b4SGYAQxMkSEmjjpD/dqn+KhMv1hqPJVQJsy2O41bY5CjiPJD21udhtWorAZKWeywwBCh0vG12Jg4VDMVhIg79vWtsU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Received: from [172.16.25.5] (195.214.232.6) by
 VI1PR0801MB1342.eurprd08.prod.outlook.com (2603:10a6:800:3a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.15; Thu, 7 Jun
 2018 18:54:59 +0000
Subject: Re: INFO: task hung in ip6gre_exit_batch_net
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
References: <0000000000006e4595056dd23c16@google.com>
 <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com>
 <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
 <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com>
 <CACT4Y+YBY2yGJBHgqGhAcOguag9JUkGkeOz1acgKd=KR3q+noQ@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <04b6ee08-7919-bf2d-5b77-bd346a0bff48@virtuozzo.com>
Date: Thu, 7 Jun 2018 21:54:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YBY2yGJBHgqGhAcOguag9JUkGkeOz1acgKd=KR3q+noQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR03CA0008.eurprd03.prod.outlook.com (2603:10a6:20b::21)
 To VI1PR0801MB1342.eurprd08.prod.outlook.com (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:Ux3bR9aGSgLI3X5TWni/7EOblGtRtvtRl08WFrsPZHG+iHstdDVb/9tujCUE8sCPxxxv/wkAY0HzNu/OYIMrVzoDj0V8GCwTEoz2uW2JLe+Wm4gkigA3eUHkN2vvq9V+qDzguVFl+Xgk9zT+MlDQn8UqGzX3tbbTNmts9SDb5a4kNCBWvk8ss/+GcjKHTJwsR8827NdczkpZFqDF9kwp+BH7mv98PlY33v5uJnCIui5EOIQcBkrq4JGsGRDTArz3;25:Ed3af2HFaTf/jlvLIEIISekfDqFQ8IAY301M3Cler37WfbE5hB4mc2viDQhTVcopjD0A1xGhSWE1uMK9KuyMSPMhVPIIP1Xmeye1jvorKq8uneMpDE4PnbwwIcW7yDlI0lJuy5zYSCsmgT/CxYaJilFooQZ9/2tZOWeJOr5srPIWKRANSHSpqc1ZZLwXyX+wWZpDxTjkABv16DHJao8eRmV9f1R6K6W6jl5gqzL9AT1JLgMPgkFxIfCxhYzgyJdX4PCZK3gj1YECrMhzsucaYK4JPobvSF5YexGUGHG+QC95MzxTntx6ndMYCTcgmNGVKDalEWfPPD2/62j5BrFpDA==;31:WEt4zIWncHI4kGcso77Iqf4CLkpiwaNodrY5bTUskmX5/BgrAoSKRPaVaFU8zf23NSeIKYyUYnz9SnYmCfcXIVqpJRHxxJm98ChvRalcnUapMTfMIe00Fb2YHQQJWTJKIXRs2SgRatj51gRqh8mEP8jVei3/Hx219dINp8C2HNHvL+Lym08z2WEYH2wlRp+Do6x/mhE9WEnbRiIRXUdKG/QV/OerJs5gj7cEaujRgSQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:+JwZUP+MqzDK1Yz/nyqldqcqJMs0ICY4f8NuEHDf8Qoc1dOTWuJyawq6Am4JTeZ6cBbG8+I+6rEahHbxLxQ+qnZdrS24pDs76aeo0APmt7mvtPqlpYjkm0CScbxKV7UUivqRrpDea9d8Cei3ZDCDl58XK7kInQ7VSVXdtkm0SiyNS51wJJc/EkLQ0Zz053OzdmkIOQrGjoOziUb3Fpg/TTqJ1kpL2NjyuQ+QFUN/Z84Wv90lwH/AfW3Si3h+Kg/f/rCL4+FUsvQPK8xI+xM8+vJE39nWmE0WhXo7DNTSRGSyr1WiY9o/XC4+b5WIVlDylwqGolQhOUPIpze0rP5rhpT7LaaqpIXvNS4b1ajRKTJhIokS8+3GytjBbC7aopsBMAYJjf8zhGG+dhZb5hDq9NA3JC9hGnWDNPb+xAMI2DAmb7TXHiCBZriAKKFvSFE1bnmcVU0II6bGoejKrcKirIUhg5Qmx3s004u66DEpV4gTw2WZ7ZzFX3BYYcRvg29u;4:zEHfJnztcOhkahga3hJJTzTSU3XkJ9xIpXVy63ushAmhPLMiRHJTPVgztpPRL8IPXIAxnfA7CoyZAYOAdbp+8MKcd4FO7jnzn6kdqur7bW+qpXlNvSF0v5rPCVSjuJIUPX3KacMyU866hDfcitCENveujOKYt+oTLGkPGiXQzUt8HJfY1oBZZeUhIauZYgbirwtpYd2Y4Do4B6X/Ko5XTjTmPs4cIXUWLmpuOrsvpZWnNtv02Vr2u/1ybri9HS87FW4mjyR2kmBXWJLDSUptuw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342D28F43FE9F36522C9EFACD640@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39850400004)(376002)(39380400002)(54094003)(189003)(199004)(229853002)(16526019)(6486002)(486006)(68736007)(230700001)(446003)(956004)(2616005)(186003)(7416002)(476003)(23676004)(11346002)(93886005)(52116002)(52146003)(2486003)(6666003)(6916009)(36756003)(58126008)(65826007)(5660300001)(26005)(3846002)(6116002)(2906002)(16576012)(77096007)(54906003)(76176011)(55236004)(316002)(59450400001)(6306002)(47776003)(105586002)(97736004)(25786009)(39060400002)(53546011)(386003)(478600001)(106356001)(65806001)(966005)(66066001)(65956001)(31686004)(6246003)(53936002)(305945005)(31696002)(7736002)(86362001)(64126003)(50466002)(8676002)(81166006)(8936002)(15760500003)(81156014)(4326008)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6ZXpSbWxrVnJiV1VRZ0tCYVpvTEpKbnU1?=
 =?utf-8?B?TXdVdGZrSDJtKzA0K01IQ3JLVkZueGZhWEZjK2VXSERkUmxVRGV6UEhNOUg3?=
 =?utf-8?B?Q3hLcGFXc25uZklZelNyL1NoVko1QUlsRXlyekR4bWlzSlB2dlJPY3NQNUNy?=
 =?utf-8?B?V2FLM2QzU2FRMVdtdHhaV1dmWWZKdlA0eVd3dFVKeFJmd29sVHpaTDdKTSsx?=
 =?utf-8?B?dmtCclAxV3c3eHpoOVhGOUhIREtuRkNFMmFYTk1sZUpzR3I1dnRkYnowbXpN?=
 =?utf-8?B?cnhtRVd3Ujd4U2xQcWFKVjN5bGd6QVN4TmVUVWVQZjdCd0tidkgyRGRDRk5J?=
 =?utf-8?B?Z3pvVWZqNHBSeDFxNlZFQXpnTThEZVlRWS9DU1l6S0RPc3krRWl0aDExVzND?=
 =?utf-8?B?NzVmN0FYMmVYSVAyUEQ3RXJoN1QrQ3Z5TFhJbThqU20zTHMyejFZa0JnQlJD?=
 =?utf-8?B?cTE2eW8xbUNveFQ4R3pVVFdqNWFxelFjdlJQN2p0MTlzcVBXSTQvampidVRo?=
 =?utf-8?B?YU9SajZSaEpMMHliOGlQaVUzS1RpdUMwd2NlOUsxc3ZZR3VTZEV5eDI5NkZ0?=
 =?utf-8?B?UjhwVGo4akFHbFNiNmx2NE5YcFhVY0xKOTMwM0FIZ0hyam4wZmp6ZzVjckdG?=
 =?utf-8?B?aWtSbjRxNW9KS0RPM3Z6RHZkSXdMUnN3NEsrSFBVVmhqZnA1NUp5N1M3eXZS?=
 =?utf-8?B?VmZrRGE2bFFHaDhRNkpTajd5a3cyeGNRL3BPbnIwTVc0TnBRdkl2VWtLQjgz?=
 =?utf-8?B?SDVkaHUveW1RM0xDYzAyZHdUTzhDUVlSWUVTR2tRcVJXMHAxcGdpM2VaL3FJ?=
 =?utf-8?B?aWxTWW5zeEdnWmhMbjVidSthQWdUdzIwekY0TEFYTndRRFFkb3RyUVVCOHdO?=
 =?utf-8?B?L0I1NmdJa3VLd1B1K0ZObVlCa2xvcW1tODIwc1VtdlNuN21YY3RYUWRqNHB3?=
 =?utf-8?B?K2t3UEwrSnpHY09wVG5iNTFGLzlyN0dDcHBDa3B0SFU2Z2hVY0RzZTdaS2Iy?=
 =?utf-8?B?YVNBeWtHM3UwTnhHTTBqUnc5b0RrbkRBZXB1R3o1SHVzN3RHam4raWx2SkVT?=
 =?utf-8?B?Wk9laE1CeU5RVEhiRzZ6MEQzelExUzdzUDlsaFY3RTk2aExSY3haMnJ6SSta?=
 =?utf-8?B?eDFmQkFuZDUwelRXek03UWxJdnpZZmRtcktkUlhxbzM3ZXhnTkJiTlFlQzNE?=
 =?utf-8?B?NEtvdkZvdzRyRzBwN2VCSFZ2SFdYRjh4aVBtVkV5WHdGNWNXeDZJOXpzb25W?=
 =?utf-8?B?V3hhUXI5STN4RUdVL213R0ppdzRDcC9WNDMrcnYxODVoVS9aZWF6YVd6Rmh1?=
 =?utf-8?B?VEliK3B1bGFKa3Z4SCszaGluaEpqajEvQUx0M2dTanYrNDZWOFNjS3VZVDhU?=
 =?utf-8?B?TFFDWHhaQVk4VWJXbGNXM2VvVjlDL2VZS3BNYlE0QWFudzIzM1EvaUVaYTZh?=
 =?utf-8?B?bXlzMnJBd2dCeUF5M29mcEsxbFJpRm5hYUxCckNZcHUvTVVZT09oOTllMUxN?=
 =?utf-8?B?SHpEZVRPcncxbHo4MWdUV2c4L2RtWXU0bXc5QVNzL1p6aWxUb3BpV2lWMmJ2?=
 =?utf-8?B?a2xCcHQ4QlRQcHNlSUJ3Q1cwRkZteFlLdHBIMUNhd3hmdmhYMVRTWTVyeCtC?=
 =?utf-8?B?QnRhUFp1VUx2YnMyc0tjRVRzYW9LYjRKR0RvZ3JsYWx6ZHhSR1I2NG9ZVEw0?=
 =?utf-8?B?WG92TWlhbjlUeENmQUdyRkJrcDFtSDA3YzB5ckY5THVtV0p5OTBSRzF4dS9D?=
 =?utf-8?B?bkZJNExXcE8rOUdpY2pOT1JWNEl3RjBHcG1QNmZFczRuT2kwS1JyNGtqQ0Nx?=
 =?utf-8?B?cVR5QWNLSTdwNno4YUF1VkplaUdzenNXOUFXU1Vmbmh1am9FeHoyK2lJWmU4?=
 =?utf-8?B?ek9jSVhaRHRUTWxOTTk3aW16V24zK2dtQldJcFlGcTl0N1NqUVkzekZoOEtH?=
 =?utf-8?B?YnFYb1UrRDJuZ0s4THlOVGptNTl1U2ozbmxlbGxMdENwbmtIMzdBdnhxcUhw?=
 =?utf-8?B?WVUvKzlORVNZOER2SW0rMTBIblF1UDFDNEk0MlBVSTB4YURJOGcxbDlYbFEw?=
 =?utf-8?B?aWRuY1AzQlQvUWZQVUJpQy9OOW9iVVNIbjBGK1ptdzhtUkQzZHdYT2pCSm5Q?=
 =?utf-8?B?bUR5TW9HSi95ZE5IczBUVURpS05PSmM1NTZVKzlaVXBsUnV4bzZNdEF2THM5?=
 =?utf-8?B?Ni8ydkRRa2RNUFlVTXBKUXBNUmpyalh5V1JNVGFlLzJnNVBqa2N4NXQ5NjBt?=
 =?utf-8?Q?0awjLiq/L3crCRKehcwy?=
X-Microsoft-Antispam-Message-Info: wj43CZ/aO9bsSOfV2JC79Oy0Mq1Qvamn3vrNxClk/hr+vkl2aiMAPtiK7QSu/LRGrDZUKdHrAGI3HZ0nn5+ZTJ7tt4i6a1SOrJPDqkf3++awHwY6suVGxOhmCy76UtXjZtBiE5Okeh/yJAM3KFzQp7GXEoC86JyctV9/961vlIIJiRo6OzzwkzyI+zk3Tj9P
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:Xta2llSw7P3WIqO0A4Cj4OSKP499hKIhBke7kXB43qCjuLea5ib3xhmjPzfFD1bYO7IbqrK5XE8Cbx+E0qeuHKhUWHBfgmIZxhLqVzFhcy/L9OXaJsp+jgD7CcnOvMtxRNBBWPs6rpWzQ97t91hYSQqVYUb01q7oqURah5XHzP3hfvFsoWVKDPAYtls6a8wfHm03JjXekV2GwCZ64e09SV0XXV4hYCnrmypKbXJUAB+ak1le6GvzUSjsWJTFbcZV7fb3RKSHNlD+xTnVbWFZz0fxZnfdwtGSvpnvCrFEPPDuqJg0yYzZcq0w/OVPVcdnu2rCUIYPSjVCvPiNcAq027Bl7HaYoH/M/eGwBQPxUUDUiYLrnN2Fzmzqj+mpymYwMGz+0XWktygCaYied2/DE6Esfcn+ODvK3PaBPQ7Dlth9P/QsxkiVYzt4vikjGxZgOiZESaGvBoCHR+c/o5u3BA==;5:JljtnV+BBWknVMqcJwpU2TDGIGPonPcZdycpYQBwzVm5LdLwjOOInrjmd2yt0BZPYcblgRdcb6Cr+fa5xlWbLysNJ3D681HBa2v9eUPT/T3B+FjOXLE17ZOifTCCvLSFDaGR3qmpnfsFoF4yRftUTB6kfaPNqsBe8V4ZWgY4PpM=;24:syyueNBiECFf/Jsc2wSrOHf4a8aKos1VRtkdlZMh5wSGo9bFkSqxhIt2VwjTkNLyC0dCTb5q2O6/Y8fGaFFfrYR9hJddspqpV2n/4u+6UVg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:eU3OQpfjPRdfK1GgxA7EJ7dU9whFBt/KqVPCoUMCnouzXy7UzaskjWzUxBgnaNBtKb4q4BZLp5FV7b8ZymkBUEkdjAHOdTFxctWeibliUAhkEUDzlf3GniY74e+1Z6bnIw7xDaYdcNBhSywdKUr7zB60yjM+JbA94jrmV/JyTH6QKzBiYmiqhMHWdbu7dt4DvT8x7oqgvfvLCAft9LbQ3Exjth4jQirlZ99TjTmKIt6tTaXFBP6LE6HibZ/HV4PA;20:RSK8BptuwjHwlwTtkbmzkA4TqUOVyeqUprb4heb6/noAyO7NPcXWCTkepwVOU1l7nZhA/7HidxedzJJF08223lvSCeh4vEj9f0e+krC7wcwKldAXUKB9TcT4R9iugUb0IVEntBwiwcfgZOGvZTPlwRlFGkhu8lwgJSbzTA8zQDI=
X-MS-Office365-Filtering-Correlation-Id: a69347be-e50a-4452-f693-08d5cca82bb8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 18:54:59.2148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69347be-e50a-4452-f693-08d5cca82bb8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2018 21:23, Dmitry Vyukov wrote:
> On Tue, Jun 5, 2018 at 3:55 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> On 05.06.2018 12:36, Dmitry Vyukov wrote:
>>> On Tue, Jun 5, 2018 at 11:03 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>> Hi, Dmirty!
>>>>
>>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following crash on:
>>>>>>
>>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>>> git tree:       upstream
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>
>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>
>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>>
>>>>> Another hang on rtnl lock:
>>>>>
>>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>>
>>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>>
>>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>>> be something different.
>>>
>>>
>>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>>
>>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>>
>>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>>> if they appear?
>>>
>>> Yes, everything containing "WARNING:" is detected as bug.
>>
>> OK, then dead task not releasing the lock is excluded.
>>
>> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
>> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
>> There may help a crash dump of the VM.
> 
> I can't find any legend for these +'s and .'s, but {+.+.} is present
> in large amounts in just any task hung report for different mutexes,
> so I would not expect that it means corruption.
> 
> Are dozens of known corruptions that syzkaller can trigger. But
> usually they are reliably caught by KASAN. If any of them would lead
> to silent memory corruption, we would got dozens of assorted crashes
> throughout the kernel. We've seen that at some points, but not
> recently. So I would assume that memory is not corrupted in all these
> cases:
> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545

This BUG clarifies the {+.+.}:

4 locks held by kworker/0:145/381:
 #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] work_static include/linux/workqueue.h:198 [inline]
 #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_data kernel/workqueue.c:619 [inline]
 #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
 #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
 #1:  ((work_completion)(&data->destroy_work)){+.+.}, at: [<00000000bbdd2115>] process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
 #2:  (rtnl_mutex){+.+.}, at: [<000000009c9d14f8>] rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
 #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
 #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0 kernel/rcu/tree_exp.h:596

There we have rtnl_mutex locked and the {..} is like above. It's definitely locked
since there is one more lock after it.

This BUG happen because of there are many rtnl_mutex waiters while owner
is synchronizing RCU. Rather clear for me in comparison to the topic's hung.
 
> I wonder if it can be just that slow, but not actually hanged... net
> namespace destruction is super slow, so perhaps under heavy load it
> all stalls for minutes...

Thanks,
Kirill
