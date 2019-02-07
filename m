Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1BCC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D5F20818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Cb0q//zQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBGILl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:11:41 -0500
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:22579
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbfBGILk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUqCD1ay5pBxorL+HAf32kV9eIP4tgyk1CHcu7lwPyk=;
 b=Cb0q//zQeutn+yM+BnVBQNM6UoyB73ee5KFyYFpyhLb2P5Giu0+6H1t6fuEd+bgibrKubNtvzDpxQVsjnzj6bpz6GDpnvS0KBW8rI0mLmhDqy2yZC19sBL/82gee/ILcPMwsbcaXV1sYf6QHnzZSuBZ0kzNmNM1s4iWAo1XluKs=
Received: from VI1PR08MB3325.eurprd08.prod.outlook.com (52.134.31.18) by
 VI1PR08MB0879.eurprd08.prod.outlook.com (10.164.93.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Thu, 7 Feb 2019 08:11:35 +0000
Received: from VI1PR08MB3325.eurprd08.prod.outlook.com
 ([fe80::392d:a765:a17f:da3c]) by VI1PR08MB3325.eurprd08.prod.outlook.com
 ([fe80::392d:a765:a17f:da3c%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 08:11:35 +0000
From:   Quentin Perret <Quentin.Perret@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 0/3] Documentation: Explain EAS and EM
Thread-Topic: [PATCH v2 0/3] Documentation: Explain EAS and EM
Thread-Index: AQHUsXroS6fjhCSoFEKDzuzKKILyxqXTlj8AgAB/IcU=
Date:   Thu, 7 Feb 2019 08:11:35 +0000
Message-ID: <VI1PR08MB332543BE1C0D6B27BCD3AA2C9D680@VI1PR08MB3325.eurprd08.prod.outlook.com>
References: <20190121111724.18234-1-quentin.perret@arm.com>,<20190206173228.30e99cf4@lwn.net>
In-Reply-To: <20190206173228.30e99cf4@lwn.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Quentin.Perret@arm.com; 
x-originating-ip: [2a00:23c6:5483:1500:6839:cda7:e31a:4bb0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0879;6:nNEfU/I5SGuuKIMNB4lwkPzxK8YHFBrK+wUuBOE137BMF+S6p2n2uHBpEu+ihYV2l/d6vTvXuvWGu+a+KvEkBBI8Q9p+5Ct8FsXFMn+1x6icP2F4HWoyH1t+fg4EmRYcOPVKooq1HjTpkr6n2r0L0Wft0q/egBGmfyyYLBEW7gyCUZj+JVW/nwhMJL+HWoJFYz2kTDJw/7Ma+C1zIhCPUCzbRL46O5xf+BnTLP7OkoPR2HXhtJHxJ2MqWwYjFFJ8dYjrqsNeIRADx66wcY5S8oZHqGuS5xqeaFxEThZZ43AdClKg0EiUYjJ9dkIyr6iHmNSlQbdWo1Pgy69pWzRG9U3tjxQPkfapFegM6jxcJedU5UEmH+1PZKPiWh17hPQEEhE90bOqfrHHQbEVV8dTJy8JU53ceSC6awV4EG/bmiGOWV+QarHYEf8Vf0ZAR5YcqNGsM5p7z1iL1Knz6PrtYg==;5:ryp9WjJuIJzq7db4XHd+IARcVwR64OCSUkT2TR72gFJRKtKWUtHW7/o+jd+bqnx6alr+ErFFf7t38LOLZS2WW7P3Y5olOYVnm+O8Kjh+vuCFY7sHG3S+kFQZ5M4fINOpme2mC4f3StcJINZ/+L3t66plr+u58p9MIn341G0ZnGufRDaQUo0yFx5TXaFhYYVJf8y0zFqAUY+0+UMiH5Azbg==;7:mimGekSEB1paXCDlDGzxJmGGmfdwoZuRGOiLxzuuJCNxST/b03TCbyoJLGNx1ygyg96RpPtK/o1QhTqVwKCl1Ej6ohWMT3qXsouAbu7tFF5l6qX7FREKJa+AzvH1LgxmUj+Sy/KeAAiYgTpj2kZ0rw==
x-ms-office365-filtering-correlation-id: 50b0c280-ba36-4b23-69f6-08d68cd3e0de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0879;
x-ms-traffictypediagnostic: VI1PR08MB0879:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB0879C34A5BAA58E7EE52C7869D680@VI1PR08MB0879.eurprd08.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(106356001)(105586002)(54906003)(25786009)(6436002)(558084003)(9686003)(55016002)(8676002)(97736004)(7736002)(305945005)(74316002)(478600001)(2906002)(72206003)(81166006)(8936002)(81156014)(14454004)(68736007)(186003)(102836004)(6506007)(33656002)(71200400001)(46003)(446003)(7696005)(76176011)(11346002)(71190400001)(316002)(86362001)(6116002)(6246003)(53936002)(229853002)(4326008)(6916009)(256004)(476003)(99286004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0879;H:VI1PR08MB3325.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D7cFiBogJtvHlz2ImMSU3FksEYRH0Qt3vQR4ex3kgeqLEXaHiSP6WEJILSMZ8Y51JVqepMt64/MA/VLhO15Qg/K3WgG6+tc0GLY8STFJLP6oxEZXv9AVd37KP22Pvshfb4sefZDWqivboDo2ZppFlhN2HznvPxrMFVS4e2W3C+bNRtgAd0u/9QOOnSYzwj0YRElSO4uKmKFHUCr4Uvea+YtQOq8zy1UxLzFqZPilv7nY6yBjY6FS97ujryJv4rspSszPvujimfq6CFtQohe8WVMwg5vFYbMZcFds+IyAw6ZxLvmzkKsF9Pt122aFFFJKKpAgybDHYTqwluhPMROb5BWyps1TFqCPAjWbQlvbYk/yJk/5Zm6T6jTgHCDsie11RbU5TEPtZ1oQgH4qZ8lHSxMR+ZpXlI57pM7t4v2XyGQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b0c280-ba36-4b23-69f6-08d68cd3e0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 08:11:35.6633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

> So these have been sitting in my folder waiting for acks or some other
> sort of discussion, but it's been awfully quiet.=A0 Should I take them, o=
r
> do they need further work or ... ?

These (well, the v1 actually) have been picked recently up by Ingo
in tip/sched/core.

Thanks,
Quentun=
