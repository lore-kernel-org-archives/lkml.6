Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GYL7DGhBGluJXwAAmS7hNA
	; Fri, 08 Jun 2018 08:44:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D71F86074D; Fri,  8 Jun 2018 08:44:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LqCiJqPY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6E0CB60925;
	Fri,  8 Jun 2018 08:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E0CB60925
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeFHIn4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:43:56 -0400
Received: from mail-eopbgr00101.outbound.protection.outlook.com ([40.107.0.101]:55748
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752999AbeFHInt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGkhs7/unDtKaKyWhCIIheslI1YumE8Z5GwxUH2UrQM=;
 b=LqCiJqPYTYvK70CbNtSilxRuy+dwjQBEK6jpM8fK8bjylk0qSD5fsSXsXXt4ysSON4efA6gp6hcVEkfBwIPZVP/xVywIVU9K7jGny1eq4/ftXr5fBzlr0qSi1+HanjwhtAJroasIUWMJmeJjWKeh5Bt/shatFr4zJmoZpqje054=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Received: from [172.16.25.5] (195.214.232.6) by
 HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Fri, 8 Jun 2018 08:43:43 +0000
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
 <04b6ee08-7919-bf2d-5b77-bd346a0bff48@virtuozzo.com>
 <CACT4Y+b8FkwFe1PCEVDZcTufB4HKVy+ekk=1_YcFH6-RoBGY-w@mail.gmail.com>
 <6b14e8b9-c335-dd46-98a6-7f58a624fcea@virtuozzo.com>
 <CACT4Y+a57xaVfph_u78Z+kM8xUF=8fVk-VSA+xqok38Zm4bhFw@mail.gmail.com>
 <d544eb27-339b-a7df-3143-08ac0fc9bc69@virtuozzo.com>
 <CACT4Y+Zo1e3VFEtXRUToM6Gk_pD7egdi6c-VbAhCOc-=cdfJWA@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6beeea79-92eb-462c-c5a3-009a38e1ae4f@virtuozzo.com>
Date: Fri, 8 Jun 2018 11:43:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zo1e3VFEtXRUToM6Gk_pD7egdi6c-VbAhCOc-=cdfJWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::29)
 To HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:XARX38fwrmVoKJwzrN+2sjstJ73kvueBJ5JmU/OceHBpNpLYzwxd5WtL6MJoqAg9DZZ8wLJnT05qN6EB4iJn3G+E6fUW7m5SREVD1w5MSgj3/ISsDzr9Gfh2Cl75cd6wN31H50JJ+zfGutraRsJ4X/naQGF3jHPKzLAe2LMxqAa5lrrw81iRKSJnJF82imhP5yOOoou2YxaGoe2dFjMOfTc8SlV2jmSYyPJ5yazX15cZkmvFsowDMetrkwdCkbiA;25:osfaTT6zJGPikgarmPQD2at0MuglH5jfX+ZnkPEar3TA1lrnqaGFDUmo5qcJChaj6Zyuq33oE3/DJS432rhok0J4UzIHCrGyWBYr6bIXii2XaA6b4lUYB7pqZLkYudTRfuc0WHT/R3OwxFnekibvy5Tf1JbDzxymAKJ1//y+R19/8fYe3UN2QXEZpPHdIaAeQ+NdtNiVZOxoK4qiXRcEc9qyI6RCuGONMSRxBB+kW8j+9bRmByt+kbLzHdLr+kcK+FGJ3gBhjt4bUUq2exrvkMkswIJCXkQLzLe6t8DKpMGysLtd5c7OeW4cZmpnNDG6ACYoSBIicnK22XZWpTxuBQ==;31:+aMe2NgoaJsyvPOgtqq6sDUxrpzsoxX2gJX2eVWq9tg/FPQb2HuV9hJgPEywi1exgNGj4AQJCSl2ep1vWIFWzwRje8sn0CgIzEJHEnPoU5k50nja3plXO2kNXguSoDKOLkuQB/lpRPkJHbpMaWCLE29GZAVBQJ4VZFvW6IACurxH8bqcyu0EQyXxEY5ZfDVFqoUAvaSFZBdSR+8YJ/Sj6w67Dk7R7NOGOVBw3z2W/9c=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:/YPD47RTjsZaBuob5y4H/NeLABHCTF6/kEOp4U3UDn9TUdi6cDHsQTh6j1L4OdEo0rBVjygojvgxhLswmdIHgQkEUhhdIzwsmwVVIWTfMVXvfF2B6t+INkUUQBxgW4p8TT9j1/j1IVtX3NWH/jk7Ty/fAsMBoIxRlZSrvCqYKCjYVcxd06dQEIzllbmUMe/gLNR9CEMcf8OvxteClSaN/F9VdbSjnv7lE8GgySp7M83xRgVYl0gBOuRMS8Cwhnyc16xHPJsQXmCVC3Uh5lp2aJISBRk9dMhKRsQOLvXl4gLJS5f1Elb/XjD935WxHz1PaGhwCD05tQkfVeTEBEn5nsz3PPZeP5/kRqYx4W3rlVLmEC5NXswoTX+bms800G0Qkj+rh6DTpdv6ScYiCqGQ6s/5dPEzpLGrl7vGBYvLAOJKsvgJi8cjvW3fsCBw91ubP7G/EX3KxACrdCfmxjxto3ssrVWqM5H5fYSauF640fWgicz4Q7QZtoEzNvuTRJbk;4:MgROikhOM44arbD0Wr0Y2WKCGHWYyAhhMqxXhNaOw/HUxhBdn79Vq2h4tFqF7DUekntmhA9rfYIiipnV6DxZpMbsBklnKQ7YkjgPwyQgna7m75+0gtqTgvx81LhavQDTXHmszI0UBZ/+vXv+OPTdAsMpOpHIUnP5k3T2BT71K4OMpttujy/TirsLGrao8L+wxIGWfvS1TrcJJQ0z1McwvSS4lRoV8xCtmPo6mQiPgJZ/QHqje8wwyMyWm4tCepS3YnetdgmRg250MQn+g2Padnb/tvS0x6zlVqrq/W9NU7J5l2wNWS/NdazoNQkM9a4dYQHs+Qzj6kscdHruQ6TQsCsCkAAajm23R+lojk5mThY=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337B7C57AE61EAA94ECCA6BCD7B0@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(366004)(376002)(39380400002)(396003)(346002)(189003)(199004)(16526019)(66066001)(15760500003)(31686004)(53936002)(966005)(25786009)(39060400002)(478600001)(6246003)(105586002)(4326008)(7416002)(106356001)(316002)(6666003)(6916009)(305945005)(7736002)(3846002)(6486002)(229853002)(230700001)(64126003)(81166006)(81156014)(6306002)(8676002)(8936002)(76176011)(59450400001)(2486003)(386003)(486006)(53546011)(23676004)(52116002)(52146003)(186003)(50466002)(65826007)(11346002)(956004)(446003)(97736004)(476003)(2616005)(47776003)(36756003)(65806001)(58126008)(16576012)(2906002)(86362001)(55236004)(93886005)(5660300001)(65956001)(6116002)(68736007)(54906003)(31696002)(26005)(77096007)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6MTlMdGZVLy84a2N6QmM2dzMrVlZNYlZx?=
 =?utf-8?B?RkFJRnpaUlZSL043OU9BN2dqazc5TGo3cDVETUhvK0RmU3FYY2E5ZzE1UFhW?=
 =?utf-8?B?TXhKTkZFTEpaSVRucHM2VVEySmRpZVVkRUpWWitCMGRmT0pUclhEaUg3RmJq?=
 =?utf-8?B?akZ5ZTB4ZHlmMVlESmJjVHF6THkvUEhteUlIRyt1RUdoOWs5NkJaU3g3MU1w?=
 =?utf-8?B?bWtCVUdXbUYxek96TWVFb2MrTFhtZ1hYWVQwa1hNeW95SXlMbERUZndIMHpE?=
 =?utf-8?B?bkJUcm9JTExUd1pmazhFdlUrbEYzTGZhc1A2QnRWYW5xc0l1YlFHYmVRSzVa?=
 =?utf-8?B?V0NZNExCaEVjeHBIU0FzTVgrTnZGbWExU1lJZFJqZ2dKOEdrck5FUkNmbGlL?=
 =?utf-8?B?UjNNY2o2N1RFUFUxNVlNalF3NlpIUVQ4WjFSRHVLdXFzdlFGMWpwNzl1dGM2?=
 =?utf-8?B?MGhmSG95V3E3bzVXZU9VVHgxdlpCYmkyR0owVDBkNnc1V0hTZlFQcVNzQnFo?=
 =?utf-8?B?MlNiSjZ3di9rUHI3WEpYUyt1T1RoRmNVQ1lGbWtsc3ZzZWptbWJaWFNKN0x5?=
 =?utf-8?B?ak9DQTJ1bmUzbHVLVVFpWTQ4SWlsZElOVFpSSEVQZi9NT0pKQmtOdXhSZmU0?=
 =?utf-8?B?MXZZSXdieTdFYXI5OVRnVzg1aEdnMVBZdE1JcnJBeUhhV1dXUmZrdUF0T0pa?=
 =?utf-8?B?SXM0Q09IS3J6czlac2wwZENxYVBEY1JHdDlvQk9aV2pCaHpFaXZVRmEyamJY?=
 =?utf-8?B?RW5UVHhJczRYL0ZKZllRc3R2U1RUY2R0UkZJZzVzcWdndWFhdnAyS1hEVDg4?=
 =?utf-8?B?eXRlSmQwekcvbnVWb1VsYk5ISzdVNERoVkRGS204K1BKbHpSbWg3d2pUd3FK?=
 =?utf-8?B?MmNGL1N4a3ZnaXN4V3pBWGhXODlIY1RpVmNDdm1PZGx2c0lGajBxWm9YWDMr?=
 =?utf-8?B?QWhPd3I4NFhodVJaQ2t2clREUzNCSnFyNGp4Y3JxSVppVmFIWGVFYmduWDV1?=
 =?utf-8?B?UCtkNlpTVDBSK1NENWdCM0lqcUNieTU5WGhUaXVWbDhyQkNieHhRL2Y2b3lG?=
 =?utf-8?B?MGc1UGFidVRuRnpZV1hHanhXbFdDOVN3enZMOWRYTmxFZThEb0lyMXdTaWdC?=
 =?utf-8?B?dkZ3Q1hKejZiTDNwNG9PdllicWRja1UxWEpQUVZ5bGV3bHlkK0tjamNncG1i?=
 =?utf-8?B?VC9BRXdXemhad3hzSnNJQ3hBaFlUVWRVMW1Cb2ZySDdoVkZUMlVKU0VYMFYr?=
 =?utf-8?B?UGx1b0ZjQXFFR3VxaytZMC9lRTNveTVka0hDMVU5SExDblJoK0JlcFJjVXBY?=
 =?utf-8?B?RGNVNWNlaEV2Z2lFdTltT3hGKy9JMnByaVZvMEtXRDNaUUNaRGo0b0lrODBC?=
 =?utf-8?B?RWkxME9qOWYrSmtyOVhteWZFWmtIUXZIVUVhaDJGTFBxbWYvcUxKZEQ5M2Yw?=
 =?utf-8?B?NEVrb1YxancvUWlDNDBPdWg3YWJBYlp1Qjd1TWROVEVWS2xZS3R1TytVRkJ2?=
 =?utf-8?B?RFlzNUM0eXdFbmt5b0VRRlVEaEJZZ3B0Z0lnUTdJY3ZGa1ovUU5NcnEya3E5?=
 =?utf-8?B?ZkNoUmVKVXVRZUlCc1RkVEl2WVVjSHdBaHRwU2tYU0Myb3hFNHdSMzRhUGg3?=
 =?utf-8?B?NTVqS0RaL2lZWVI2cXRVQzV2TGEwVHZTS0hBMkYrZTNnR2hLcEtpcHg3OFNr?=
 =?utf-8?B?eEpXU2cvZ2ViOUEzR0YzZmxmWVBLWUxoTjU1ai91Tjh5clVha09WSFJmVC9k?=
 =?utf-8?B?bjh0WWY3QTZnbWVsZUN0RDIxRVB1T2E3SE4zMk0vaEZlZW10dVVUc3dZaWdU?=
 =?utf-8?B?djVacThHZWlWMWZnYlFMZGh0a2gwWlhQM2J5Z2tZc1QvVjd4QlMxK25ScklE?=
 =?utf-8?B?MVZYK0lwcDE1N0pOUDJVczB4VTNuU253YlltLzZNbms3RXJBNVRmdGhEY0Ur?=
 =?utf-8?B?RDVudjlNa3RWTXozaTgrcHliTHZmWGRuQ21DODE1ZFliMG1BWnQyRWs3WDZD?=
 =?utf-8?B?NFZTN05wL2kxS3V5M0RQYlZrcmlCcjM2TXRzbWs2MkVCbmw0TDNORjhDQ1JY?=
 =?utf-8?B?bHRJN29idWhSeitmUGxUKzBVYTNmYTJGTGtxdXFuWkpSOWoxclh2YWxsQUVj?=
 =?utf-8?B?d3V4aE1yWVYrVkJic1YxdEVheGdjYjIvNGdwTFNYNzRkekJlNWdObU94Q3Q5?=
 =?utf-8?Q?HfNV2V2LK0J8pipJ4rRgC1Dc9DKulRMXmb2zt2FYNAU0=3D?=
X-Microsoft-Antispam-Message-Info: d3eEoUpj7xuUMplnZhGwR6O2npI+eOEO2O6PFUHBqrMxQpRGHE6F28jyb3jwiCNfHp/1XCfILXjbvpUF0OIB9bGxLGGXZ8N9NbiGKyoU77t1e2MktbG84xC3SWOmx/a2lbJ31IuxPr8UQmlo3gYipZ+sOzzhAxGUVZvAO7XZlfzyXZnuLfN6/saz0Zp671YZ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:4Dy58BeK3V/BT1PPWPrGJRDLcETO5axp9rfxtK0WvZfRAGfEEyAjiWFQVLo5vbvHORLf3q+nnzSEGnOnpk8sk+d2pBOnK8L1vWK8UTZJztWErA0h287Nl+DTYl6V1FufyOOMfoGKv2/o28ZkHSOIsx+iKuw1gp6QsfE3uZiIIGLXWyWg+4/5Zaan7nmM0wmWi4BRlk4HHD6JMxoUCqtwHBrhhT9vwvbAO0FEcwSWQOpnBF1BsYgVx02TkVaERt1OVgfngFtfPubqRncCl4Ef59sw/Rgml+PDqV8ooboKgcn1alCS41u4nQz5Sw7SmGl7x+ffJi+XhomBx1iSgRPHtDnNswG5eRpkDRikupT5CZBl8XzY7qaNXLVUrIOrQ0aIMJUJ8JMxTc04dwl9K4k8lA18wnKqztiB4nHIhuq6mIvhVrY131nVZ2LwgmuKv4X/IXdAigqT9DIvdtIEcgXxIQ==;5:vCotUG6a1VbKuLqt+tQJJrjCk+79tDgVAcUmkyiHa/B+NAZkI5seATZCQKy4g7PcPvM24Cthl0+AgCUDejbOND7yWRlOGYm3/qHXb+XI7wE4SE3rH2Ge2GD40NBdW+YD5Quz9hmpbzhnRzIyUlB76ECVEjmeQNbHr1TdOALQALw=;24:+n9UJHXKOlkL4R7wGqegiRqHzwNCwbW5tfvlrTqQZPCWfDOZM+U8yltjHtHTnfKZHCFhko99r09HiTw8mQTfW8OUuQu07yu4hYUIVdFY3j0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:CT37vj45laEupFzuu4GWij5jTBzw3uWrufFkWSlngW81U405ZwAonqvMjcUZClppOaKZqy8F55HjsC4/GxWrlD0Z0CO2V6U/KKQzDjQ7ccYtCoLpe005+PnbVpf0zquphoBNyxUysbsvJmp0FTTueieIZEEInwTNvDwrJIJMtNp5vuo8ujTLPH6l0zuC4ahWukgMBdsCTSl3YytxRTSOQD0S+FvHWOvA9y86htdmxVoSaoe37Q9t9gTrIYinY0+J;20:n4DyG5NjfJX21fvfHBziQ07ltSMUnf50zCGTlqIZn+nZkNUtv+UXtXJwwqvVDKu+obPlYtE+pJpJR9LUgkO5Jen1nCRB4QHBqjwX0PILqYFNM+1BerqtoFHTzDwXGSq0A5l6L0LIpcQSP3f9PNueZGADDWvrfly5EtDXTyJiKl0=
X-MS-Office365-Filtering-Correlation-Id: 268e6d48-2117-4aba-6425-08d5cd1bf155
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 08:43:43.4821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268e6d48-2117-4aba-6425-08d5cd1bf155
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.2018 11:38, Dmitry Vyukov wrote:
> On Fri, Jun 8, 2018 at 10:31 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>>>>>>> Hi, Dmirty!
>>>>>>>>>>
>>>>>>>>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>>>>>>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>>>>>>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>>>>>>>>> Hello,
>>>>>>>>>>>>
>>>>>>>>>>>> syzbot found the following crash on:
>>>>>>>>>>>>
>>>>>>>>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>>>>>>>>> git tree:       upstream
>>>>>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>>>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>>>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>>>>>>
>>>>>>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>>>>>>
>>>>>>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>>>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>>>>>>>>
>>>>>>>>>>> Another hang on rtnl lock:
>>>>>>>>>>>
>>>>>>>>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>>>>>>>>
>>>>>>>>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>>>>>>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>>>>>>>>
>>>>>>>>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>>>>>>>>> be something different.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>>>>>>>>
>>>>>>>>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>>>>>>>>
>>>>>>>>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>>>>>>>>> if they appear?
>>>>>>>>>
>>>>>>>>> Yes, everything containing "WARNING:" is detected as bug.
>>>>>>>>
>>>>>>>> OK, then dead task not releasing the lock is excluded.
>>>>>>>>
>>>>>>>> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
>>>>>>>> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
>>>>>>>> There may help a crash dump of the VM.
>>>>>>>
>>>>>>> I can't find any legend for these +'s and .'s, but {+.+.} is present
>>>>>>> in large amounts in just any task hung report for different mutexes,
>>>>>>> so I would not expect that it means corruption.
>>>>>>>
>>>>>>> Are dozens of known corruptions that syzkaller can trigger. But
>>>>>>> usually they are reliably caught by KASAN. If any of them would lead
>>>>>>> to silent memory corruption, we would got dozens of assorted crashes
>>>>>>> throughout the kernel. We've seen that at some points, but not
>>>>>>> recently. So I would assume that memory is not corrupted in all these
>>>>>>> cases:
>>>>>>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>>>>>>
>>>>>> This BUG clarifies the {+.+.}:
>>>>>>
>>>>>> 4 locks held by kworker/0:145/381:
>>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] work_static include/linux/workqueue.h:198 [inline]
>>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_data kernel/workqueue.c:619 [inline]
>>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>>>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>>>>>>  #1:  ((work_completion)(&data->destroy_work)){+.+.}, at: [<00000000bbdd2115>] process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>>>>>>  #2:  (rtnl_mutex){+.+.}, at: [<000000009c9d14f8>] rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>>>>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
>>>>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0 kernel/rcu/tree_exp.h:596
>>>>>>
>>>>>> There we have rtnl_mutex locked and the {..} is like above. It's definitely locked
>>>>>> since there is one more lock after it.
>>>>>>
>>>>>> This BUG happen because of there are many rtnl_mutex waiters while owner
>>>>>> is synchronizing RCU. Rather clear for me in comparison to the topic's hung.
>>>>>
>>>>>
>>>>> You mean that it's not hanged, but rather needs more than 2 minutes to
>>>>> complete, right?
>>>>
>>>> Yeah, I think, this is possible. I've seen the situations like that.
>>>> Let synchronize_rcu_expedited() is executed for X seconds. Then,
>>>> it's need just 120/x calls of "this function under rtnl_mutex" to make
>>>> a soft lockup of someone else who wants the mutex too.
>>>>
>>>> Also, despite the CFS is fair scheduler, in case of the calls are
>>>> made from workqueue, every work will cause sleep. So, every work
>>>> will be executed in separate worker task. Every worker will haved its
>>>> own time slice. This increases the probability these tasks will
>>>> take cpu time before the task in the header of the hang.
>>>
>>>
>>> OK, let's stick with this theory for now. Looking at the crash frequencies here:
>>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>>> I can actually believe that this is just flakes due to too slow execution.
>>>
>>> I've noted that we need either reduce load and/or increase timeouts:
>>> https://github.com/google/syzkaller/issues/516#issuecomment-395685629
>>
>> Hm, I'm not sure we should hide such the situations from syzbot,
>> because the load like this may occur in real life on real workload.
>> They may help us to understand whether rtnl_mutex already needs
>> a redesign came from this statistics. Also, these hungs may happen
>> in a place, which can be rewritten without rtnl_mutex, so we focus
>> attention on it.
> 
> If somebody wants to act on these reports:
> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
> it's even better. The point is that testing must not have false
> positives, one way or another. If we do nothing then syzbot will
> slowly discover all 250 usages of rtnl_lock and produce unique bugs
> for them. Each and every of these bug reports will need to handled by
> somebody.
> 
> Does somebody want to act on these and improve rtnl performance in
> foreseeable future?

I just analyzed this question a little bit, and it looks like only
the preparations for improving the performance will take much much time.
And the performance won't change till preparations are finished.
So, this looks like "not a foreseeable future".

Kirill
