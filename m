Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CLnQNe8+GluKSgAAmS7hNA
	; Fri, 08 Jun 2018 08:31:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5A94A607DC; Fri,  8 Jun 2018 08:31:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jrs3mzA/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DCF88608BA;
	Fri,  8 Jun 2018 08:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCF88608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeFHIbt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:31:49 -0400
Received: from mail-eopbgr40112.outbound.protection.outlook.com ([40.107.4.112]:52199
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752825AbeFHIbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnInbFxa+kVXRm48EKeSmKhVsh0YrPUwPsar1XjIvRs=;
 b=Jrs3mzA/aaR4TugEjKP1EEe5hCg9kGE5RpF8q7fb36U3shoD4Qco7f/mLxpWPEwYvmjaPbapaaOtuDILn3Bn3ZyeUhoE2vABPMz0s9+/VtwTnhxeXAq3K6/AGV/15QT6GoCgiNC7XQmFJ5qUajw2KFJB59KL+J38UU5X6/b75os=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Received: from [172.16.25.5] (195.214.232.6) by
 DB6PR0801MB1333.eurprd08.prod.outlook.com (2603:10a6:4:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Fri, 8 Jun 2018 08:31:39 +0000
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
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d544eb27-339b-a7df-3143-08ac0fc9bc69@virtuozzo.com>
Date: Fri, 8 Jun 2018 11:31:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a57xaVfph_u78Z+kM8xUF=8fVk-VSA+xqok38Zm4bhFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0166.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::14) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:JpbiP16YyiNeDOKEbV1QEnOM/dan6ht5/HVjC5XHX+HRkHQDzoVpSBPBnWI8DP+MNIIaY92lxdW3UMfzMJAVRMoh50qjg08d4O99fFb715epzgJQ8z1KqGJ3+LAmMMFg5ZR7q3YSKJFNugah9yfG1fVduEH5sbR8gWu1XTCNztCu7YZF3TiBtkJ3qKf2755o/ra1bYblXAIYTr6uwjBGnq1nMtAmV5v5b31b2AuUygB9R2Wr99CKz2pNVQoomsQw;25:ixkkteb6fY3GpeOeKv1BjJCEtBc7CZkAlVcUaIPE88KpXjGdRwknjxiqCdpjkANlrultI0QV0nJX3snCi1ezoy+J0EFvG0tY+YVZ4UbMbYDnNnsnh0o6r8glHZZw4JqPvLyOqw7KmBIKhXJ0GZ0gpAkiJfUfknqAsq0fHPBkAdty4E3EpLPmrgRidEYKsqmnJhEj1eUjQwZaKfDZB1V/iRpFOXF3jHeJ79nGHlSn48N7y7e2Bq4vajgpzFVBZWhCpghFiHe5UOOWJufhrgvfGTwoG4cxe57syXrvr8N3N0yfUrn72stbdbrCP7/Xlrqf2lQobUVi3frT/d+BAxTONQ==;31:iX+aRKf4/aoc1XjjAXpPTOT9zeMcjb9azSJNcNU1jjLHfMF38phEVC+g2uVxgAD2uObvQKJ3ceYTBfCEGmKENcURajsv/4WFzwHoFVP3RyGNgc7DG4lACOf4ipeUseloT+klzeJT+62fNMeRJa8z3zy0vEJSpCkI3dKDLJuU4ogjzCQFZF9JaIacolpnP6CkyS9HddL6kidHMznHnE4aIscPGxPDxUvQhe/Cc1yltX0=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:PCu6za2lBwHMLI89DHG6UwZ5m4SQj992GHEezoWo5UklTkqmkaYxiw8UWOS98mWSoMM36Yog1oKgJzV5f8RDD1FExpIrMAh4NwmMKh7FPUGBeMpOzsRS4DQCFs9G339owvJ3KHfU3IFlmb1TMA99B4EFwKlJycpb9JX+ic6Lj8ndzDxxPGHncn24TJlRAHQd/2+LF9CL4vNOQIb9kq2wijBtQC6wZGKN7h3zh5CUn83tozWegzMvxohYZotQD++LtCm3QhkxEkv7QRiZBnNIzTfAxIO53m5r3RBR3bFAGqjfmDoDIz6IykeW36UNPLheBTeUyni2x4EGlw/iMVf/VAI8Ep06M4ivDfMpbUoIutMDTVvDQr7ZViaJSdB1xdagvnzYov/QgzOG3W9i1kKOSprK5F6wJ891DcHyuzpu2LKffdQftq8z7nvo5MnyI/mVvrZUK6JKYZAuUBAXphabIDGz4mZd0+vpY5jeq9HQkVGU59/OMh+2HkzO9GQEpFZR;4:hqqixMrI5iyRidCsOZnjSefKo4rqy2bC4XGuriLP9ym+dB+hqJC7NjPBPDzFo29otJF9f785WyVdC+o7KbpeSkAsIavnec23pzBQny26FASnLhE60wKT+eLRt5l8c8LtPLu2VL1ez0t9x3+UF7gTg6m8MRxp2Rh1qDCzacIXe8Od0bVQ3MEpCVroJp9Bw+JcQWE4QB1Bm5V/mOOcim5CxbLRiKtXFi4uQYO1UxkU/42MjWxdOPhbhdQMxFZmqc/txvQtLlRpjriKa8HkXUU4rSAZK/0qoP09UyrRcXWq66QrK8jNj6zBMXQfWA9pbpQ95aY1JsG2rt8B2HRdJkScMSKuMiR/XhBT1kcvUb+vutg=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13337C20937206D996D77356CD7B0@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(376002)(346002)(39380400002)(396003)(366004)(199004)(189003)(486006)(11346002)(31686004)(446003)(230700001)(6116002)(31696002)(229853002)(64126003)(3846002)(86362001)(6486002)(105586002)(93886005)(52146003)(2616005)(23676004)(2486003)(476003)(15760500003)(52116002)(956004)(68736007)(106356001)(39060400002)(97736004)(7416002)(77096007)(6666003)(81166006)(6916009)(81156014)(8676002)(316002)(6246003)(16576012)(478600001)(8936002)(966005)(65826007)(76176011)(25786009)(36756003)(47776003)(4326008)(16526019)(65956001)(65806001)(26005)(186003)(5660300001)(7736002)(66066001)(305945005)(6306002)(55236004)(386003)(53936002)(2906002)(50466002)(54906003)(53546011)(59450400001)(58126008)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6WGdtbUg4VkFGU0cvbkY4UU9XN01oek11?=
 =?utf-8?B?MjBacWE4WHU0WXpmL0JUYlFQUVN1Wnl3K29TZHI1RVRHamt1S21YZnVUem1M?=
 =?utf-8?B?MlBBRHBTR1lMdjh3SW5BYTkzSm9GYXdPd2ZYMjFEOVFla1loM1NUM1dFbHVr?=
 =?utf-8?B?Qmd0U3hna0NOUS81WWd1d1BjbVdnM0x5M0h0d0swL0hxQWxZTzBTSkhvQmQ3?=
 =?utf-8?B?aHcrbFZ1SVpPYXR3a1JPQ3BFUENtSjFQeGtzNkVpZytrbWlNSmtidmRBaGdr?=
 =?utf-8?B?bGZZOU9SQkFzK0ZDekxCd3ZyZ3JjbnJCc1dXbThGSWRETTZPcm43RTNuSk1h?=
 =?utf-8?B?dkx0Snc1NmRJanNRY0U2N3B0TnZac2hOcGQwODJ4b0lwbDBITEQ4QWpXNjB2?=
 =?utf-8?B?N3IyK3B6bHhOUXFqT2NBVGR2OTJ5M05lbVZ2UHppYXVpem9VcE9NZWMwVElO?=
 =?utf-8?B?L3Vzb0VITTM5UXVZejVWcnFrVS9EVDZpWStNQy8ySU5JODRuTGhtOUwySW9G?=
 =?utf-8?B?SmFjS0tVZWFNeEM5dkE5blJMZ2VwMHBwdWxRQU5EdnpHYkYvR3JxdllHaUMx?=
 =?utf-8?B?STd2S1RGRDduYkZBVC8vdGEyOWVRMW4yOGo5Yk1lWnMvK00xZ1ZITkdVU3Z6?=
 =?utf-8?B?RkFCM1NxWW5JMnExNnhLbXl5cEZUc3M3dmVwcnBxdDdRNERoZCtQMlpxbm02?=
 =?utf-8?B?WEI0QjFVNjhXUkZtd3pqcEJVWlB5dUJlUVp1eGVsbjJBSVJPeGhpKzhZVmx6?=
 =?utf-8?B?eVFGMU11MmRkWHJDKzIraGlTVjlDQVlMRnl4VzlvcklRQ2graGp3djdKR0o0?=
 =?utf-8?B?MG96Qm1NcVJjU3Q1d0M0ZmxZV29nNzRKQlQ5MlJXajNqREhUMmxnNitabXdB?=
 =?utf-8?B?UGJidjBGeDd0bnJFSVI0eVBWQUlSbWp4c283NjVsaTlaa09ySEJobHJLRHpK?=
 =?utf-8?B?ZGY1amdXMUZJcWhHdmJpbEJlQVNtU2M5d0NGbzZKaDAwZnc4ek5qK0JPMHBu?=
 =?utf-8?B?YWFtK1ZhazNLR0RWOTNhcURDUGxPK2tJNkJCQ2l1QVQrWGFLem45UUJvaTMx?=
 =?utf-8?B?aXBRUWV1eGZnR21DWWorOFdVUjViWHNUNGdvMG5maFdIeXRlQlEzbEYzYmZn?=
 =?utf-8?B?VXZHWFBMeUU0QXdKVDZaNGFrZktqeWduZzZFK08xOE9DL1Y5czBrSjNPMUpI?=
 =?utf-8?B?QzZJQVFOSnFMdXdjNjNUSFZqRzVpZnZ2YjhCQmRydjdtWEl2aVQyVU53Ylc2?=
 =?utf-8?B?SG5lQ1pOdHpGOEk3cjZiMWRjRDBxWUtJWktKeU4xNW5NUXZDemttMnVQd1lM?=
 =?utf-8?B?OVQzZmxmUkptYkY3OSswWW91VEt0T2xmUXdtdHhRYmlwcmV0UkE2RUR1bk12?=
 =?utf-8?B?RENhRzRhbjVxNXBVMWU5bVZSWlJlSEtVWjB5aGgxM2pkZExpUVNMeUJ5UFor?=
 =?utf-8?B?d01xR3RoZVk3VGpqYUpiOFY1QmhsODBXaWV3VnZMa3RXUjJLS2FqODMxSXZq?=
 =?utf-8?B?c1dTRyt2QjVhQWxYYzVOUUV2dlNtc1lNTjBVdG5hQXdYM2xxVm9PR1k3WmdN?=
 =?utf-8?B?Z0psb1lyaFFQcmR0dThGYXpiaU5BZXkzdG1ZaGw2Y1dRc2FOWWlZcDYzWGZn?=
 =?utf-8?B?RWhBWUpHdENKVjh0bGE1ZjJJY1VQZHlhenFwbjJUNk5BbDhldmVEY0FUKzl3?=
 =?utf-8?B?ZUgxd3dzV2tDT1VMN1c2YldaWElzUVRnNjJTNlJ3TStaUCs4NjhjN3lUUWhs?=
 =?utf-8?B?S01Yb04yN0xHVlYrcUc0bmVSQWEwM2ZQbk1uc2EvVy9PWFhvbHl0bll3a3NC?=
 =?utf-8?B?bFpOQnZEcVZFU3V5Ty9jUit0LzlGU096cDY4MkwrNVZTdWhsMUJFcXhQZVpv?=
 =?utf-8?B?aWhnUVpJYTZJVDRJalBNay9UT2tKeXNndi9WRG9OT3pWaXl4b0Z1V0dwemhS?=
 =?utf-8?B?SHd5WDRBRUhBK3FOdW5Fb3k3bDJHeUNVQkxnNGxIdWx1YWZRZDQzZUNFUlZw?=
 =?utf-8?B?Q3crV25vKzIyYllMNmU4bHNSU3pKeDkwZmY0czhpT3ZzSGhaZnBTa0F2ajhJ?=
 =?utf-8?B?alNRQjEvZzBZbDVFR0NqcWZVeVNpZ1BCY1JINWRrV3RvUUR1ekk2ZTVBeWd0?=
 =?utf-8?B?OHFKNDBmNnpXcGQ0bml6ZytRblFzUksyRGpWMm9UQmpsRHppZ2M4S3ZWZkJr?=
 =?utf-8?Q?rRInEZbn5reM/jDTCky93NOCRMNfW1XWE6ofPe5HLbk0=3D?=
X-Microsoft-Antispam-Message-Info: qUTJ/3Nvq66HNOSkGLaiFuad49S81EaoebtHNbeZXcG4ysaPP1S1QyFAA3m+7wZzsG1RtZT7rmuKD21NeruBWehTBtpd3V8s8+jWZrFj0oFSK7qJmkQUJAGivcx+NbJsTDrqd02YuLabKLe8J7+JTlE8xjQPH0buMKAAUcCuRrjSZn5xiZ8F1y7Op9w2M1Y8
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:iMmr+KhzGlzvFRQwI8+zCquP6hcsWwRSoeu0Ab2GZFY5eNR4m1WR0yKE3RCq9oOwnuOanq2TpPBESsQPFIlxijVEoplPAPkz0l0a77JbLM4nu43hX2UrB7qSX5twn/a5RPWsYZsHNRUvHJz5r0jDqOyEkaycxL0B4LBpCRFiSJkF/ysb0/RMkv/PdtIXxRjwKWEYFzN07GeIin93bxMDs4rj/hCwAzsFdLqLdvTsITvu5uFWX34qJRuCctFQmxkFbZegThVdhTLc+cDIhplu4a/s6Pny+HQWVDABLPtq0lzh/XalkRLOr3H+CBiaWCEdPuDns7Gs/4KhBwt6t/qwNnAGbqlvn58TrKWErUiJOtpVQ6hJNkgonm22XDbhXi5ut+5BpzfIUETsA1JpcPNu1eRbYcPbIEfXEsyGuTmOKTtR8FyHjsWOMKOVdHqTqObxy4TKX102Clw+nEbG9ys9/g==;5:gr9jILUC0uIJgEqMVlHQrNo02QIvHR8RxLZC16sb7PMixlzAAK591LBP10QPTM7+FUkIWq55f2r/+Cy4sjHeUmC3oCvou4jaIe0xDQe7s8IcnPJ1c2/2Fr9fR9RjeFoYAz/nW/3bCP7B75KH7ELpJMcDpgxGt1ER21SFndyU49I=;24:ce12gmKbGxC+0FqsGIMhMEqw4aW+JRQGp2DcPLMvkLGDoeLTWiXfgfy5uIeyOEtM0l7ipGrofsxcCCDrjnKuBq/MYjGg67slio0rwcp6qc0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:RcYkG5DPHMKFJTYhYMS12ZGiagh6J75BcPWWHBTyoiPNl520bMjvcpU5yW+cQ1fK9vm3vAD6UsJZlykaFpAz0ziJs0G0JnpdBMVDOlHpoARQ6k2WQNydSevyruW/PZask/rvaddwqAlANwvIMmttQS7ERDqT1azr5sz97TsI8qUEnts4OHHE1NX+v7KzoEhKhFWuduS1mLC9lGfCExfFFn5+R0CwkB9ZYiBa8HLD+107aJ8e8Pj//XVvjBK2zFhB;20:rO0gkKvHE6r0YWC/0ApbuEp+vKvQPg9e5OLmfcx9Kpo4UP3I4cv/vXmq/uAiol2zbfGzhHKTVuVnHBKnzxrUnDZZgCwmwpUJ+cX1wboLAINRCZiLNOkrrRt7ZsS2LoxA4HXadXJAEgfwzeandjFt94sDU3YPqawETYfn/C367dc=
X-MS-Office365-Filtering-Correlation-Id: 3fc67da9-75fe-41e5-209e-08d5cd1a41f1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 08:31:39.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc67da9-75fe-41e5-209e-08d5cd1a41f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.2018 11:18, Dmitry Vyukov wrote:
> On Thu, Jun 7, 2018 at 9:59 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> On 07.06.2018 22:03, Dmitry Vyukov wrote:
>>> On Thu, Jun 7, 2018 at 8:54 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>>>>> Hi, Dmirty!
>>>>>>>>
>>>>>>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>>>>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>>>>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> syzbot found the following crash on:
>>>>>>>>>>
>>>>>>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>>>>>>> git tree:       upstream
>>>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>>>>
>>>>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>>>>
>>>>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>>>>>>
>>>>>>>>> Another hang on rtnl lock:
>>>>>>>>>
>>>>>>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>>>>>>
>>>>>>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>>>>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>>>>>>
>>>>>>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>>>>>>> be something different.
>>>>>>>
>>>>>>>
>>>>>>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>>>>>>
>>>>>>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>>>>>>
>>>>>>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>>>>>>> if they appear?
>>>>>>>
>>>>>>> Yes, everything containing "WARNING:" is detected as bug.
>>>>>>
>>>>>> OK, then dead task not releasing the lock is excluded.
>>>>>>
>>>>>> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
>>>>>> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
>>>>>> There may help a crash dump of the VM.
>>>>>
>>>>> I can't find any legend for these +'s and .'s, but {+.+.} is present
>>>>> in large amounts in just any task hung report for different mutexes,
>>>>> so I would not expect that it means corruption.
>>>>>
>>>>> Are dozens of known corruptions that syzkaller can trigger. But
>>>>> usually they are reliably caught by KASAN. If any of them would lead
>>>>> to silent memory corruption, we would got dozens of assorted crashes
>>>>> throughout the kernel. We've seen that at some points, but not
>>>>> recently. So I would assume that memory is not corrupted in all these
>>>>> cases:
>>>>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>>>>
>>>> This BUG clarifies the {+.+.}:
>>>>
>>>> 4 locks held by kworker/0:145/381:
>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] work_static include/linux/workqueue.h:198 [inline]
>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_data kernel/workqueue.c:619 [inline]
>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>>>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>>>>  #1:  ((work_completion)(&data->destroy_work)){+.+.}, at: [<00000000bbdd2115>] process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>>>>  #2:  (rtnl_mutex){+.+.}, at: [<000000009c9d14f8>] rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
>>>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0 kernel/rcu/tree_exp.h:596
>>>>
>>>> There we have rtnl_mutex locked and the {..} is like above. It's definitely locked
>>>> since there is one more lock after it.
>>>>
>>>> This BUG happen because of there are many rtnl_mutex waiters while owner
>>>> is synchronizing RCU. Rather clear for me in comparison to the topic's hung.
>>>
>>>
>>> You mean that it's not hanged, but rather needs more than 2 minutes to
>>> complete, right?
>>
>> Yeah, I think, this is possible. I've seen the situations like that.
>> Let synchronize_rcu_expedited() is executed for X seconds. Then,
>> it's need just 120/x calls of "this function under rtnl_mutex" to make
>> a soft lockup of someone else who wants the mutex too.
>>
>> Also, despite the CFS is fair scheduler, in case of the calls are
>> made from workqueue, every work will cause sleep. So, every work
>> will be executed in separate worker task. Every worker will haved its
>> own time slice. This increases the probability these tasks will
>> take cpu time before the task in the header of the hang.
> 
> 
> OK, let's stick with this theory for now. Looking at the crash frequencies here:
> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
> I can actually believe that this is just flakes due to too slow execution.
> 
> I've noted that we need either reduce load and/or increase timeouts:
> https://github.com/google/syzkaller/issues/516#issuecomment-395685629

Hm, I'm not sure we should hide such the situations from syzbot,
because the load like this may occur in real life on real workload.
They may help us to understand whether rtnl_mutex already needs
a redesign came from this statistics. Also, these hungs may happen
in a place, which can be rewritten without rtnl_mutex, so we focus
attention on it.

> Let's keep duping new such reports onto "INFO: task hung in
> netdev_run_todo" so that they are all collected at a single location.
> 
> Thanks for help

Thanks,
Kirill
