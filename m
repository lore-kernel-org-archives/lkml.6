Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B07C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FC020869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="QwaveEwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfBAIir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:38:47 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:34306
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbfBAIir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=korChi3Q57c/5YXiLBuhyP9TcTzKQYclN+QIlo96/vk=;
 b=QwaveEwj9nk3PDZ12yEXLRQoxNf4oqlJ3OwbDB+km+wZ5jXAd3HfNpbimbn3FCxZSwfl/GE/vwnVclBqL+ndY+QQGGgy1XTi/5KR8J5MDy9uautLjk7gJt417ftQjtJgPiYKIQCYV5ZUktFTKZAbmFA9frDRx0L/UbrzuWQGgvs=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4357.eurprd03.prod.outlook.com (20.177.33.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 08:38:43 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 08:38:43 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
Subject: Re: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Thread-Topic: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Thread-Index: AQHUuW2awNkJGzJtBUW2HZJ5omKh0aXJ6V2AgACzoQCAAAM5AA==
Date:   Fri, 1 Feb 2019 08:38:43 +0000
Message-ID: <735816a7-897a-61ad-e70b-8d683c94d8ac@epam.com>
References: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
 <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
 <20190201082710.GA7437@infradead.org>
In-Reply-To: <20190201082710.GA7437@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4357;6:7dW4+nKEYKJpr68YpMEPmRSe6sola+2UWf0G2XHXa0ocJqOQpkfqI/VlnT1bIghqeDOyGA39FpRi9NgeDftReqg3UqmFsda8mENlBtR61oLO6gl3cjo5bUz9z48QkxjhJEKAMtMNRbfo+5J/kqcr2IkQ8ImOcC9iiyobb7k0yVfih3lz0l4dv3m9hue2uCU+46Ly3NZEDslwVbuMbk06zCFmZBggL9ACyrzOdctBmSkBdxKe4b/lceANMGIAQzmpB3BTk3LHtYMTJi3OzKI64zTTMhUraN867MRMSco13Bb96sEdw5YBn/e9h/1mtIAS9uJFsV/DrcnUvxv+A1FacC221XHduEpsEcH7YeFqvxcTWB93y6rlAQNQ1uE+rhNkQfgIkAPxrdO6BpY2tpUan7pmLfao3txlmo+WijyjIHi8jWlaL7MHm1iuDzcjYHLPR/7aD6so1MPsHMDPrm1MSg==;5:XUfVeWYptryqS89d7DTHyM2SVrg9tuVKLusayyG1uCcf1lRDoIilBTzUddT8INOOCwHY+PN8tw+3+mbP+GW3TLaAivFxFNKmQHK980/tY2iD/pRavIzI2G0RxIc1UMQpoyhcd5iojPbeULinIrQzsjMBq280R1GE7pZMRYhUvWStRuytHOrCigNuVKPmTEtymLZwR4HhCepgGJFuJ35gMw==;7:Zrl8n5JYPaDsWkzHf/lk4WE0cFKfslmfLN/ltMQxXRIsbScvgYMGkLnYS8tV+/0BMhFGL9dMITZbbqPweHHS9Z+JLPJDq1GXM1DEqG7YFgWum8WlomiBWO3sYdFsvLuvALOAjEUtLOQnYvqmE7SQwA==
x-ms-office365-filtering-correlation-id: fac6e751-3dcc-45bd-441a-08d68820ac71
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4357;
x-ms-traffictypediagnostic: AM6PR03MB4357:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-microsoft-antispam-prvs: <AM6PR03MB435715AB4BD25676F6FF24FDE7920@AM6PR03MB4357.eurprd03.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(39860400002)(396003)(199004)(189003)(6512007)(36756003)(8676002)(80792005)(106356001)(76176011)(81156014)(72206003)(97736004)(4744005)(31686004)(6436002)(86362001)(105586002)(99286004)(31696002)(68736007)(6486002)(71200400001)(71190400001)(110136005)(54906003)(6116002)(3846002)(2906002)(316002)(6246003)(53546011)(478600001)(66066001)(53936002)(186003)(486006)(229853002)(256004)(2616005)(4326008)(25786009)(476003)(8936002)(81166006)(446003)(55236004)(102836004)(7736002)(14454004)(11346002)(6506007)(305945005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4357;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mTMQfsYdyXu6vYbpllM53NxIpHt9UXXvb3ghOK7lNmaV/UtH/+w/UKI5ax6PPHZcNC1tk4pdX079ba7CLGVzgodsZcYGTe8IN0jtHWYHtooZcTdX0EcVasVZFET+j2/w+lq53AVK9tHMi0T8S7Qwpjrhwg9hioVGhkVz8YPknRJlAcGpy9MYVT3rgV9PjTEj5+KR6/tvZOvgrYbiNFmUafTDf33Qf0PfvJrBSRIsaa3f6q2ttGf2hpYJ/roRhZIaHq9mXGyPbqjFcOejNElOtdXiks/o3++3IIrna26EH2wem+ngb2LHk5pXYEcrpD9L4eEpiR6DTaiiWxgsZpwO67a0niUXMY+/Hm2YAxeYGphtzjk4Qj8IUCOQtexVmHN3D2cexpbqqFPWcHlsi0U3blm/+Au8XupfCSPQ6BGt9hw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65757B78EE639742941CBDB31EF8711E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac6e751-3dcc-45bd-441a-08d68820ac71
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 08:38:43.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xLzE5IDEwOjI3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVGh1LCBK
YW4gMzEsIDIwMTkgYXQgMDE6NDQ6MTVQTSAtMDgwMCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3Rl
Og0KPj4gVGhlIGFsdGVybmF0aXZlIHdvdWxkIGJlIHRvIHR1cm4geGVubWVtX3Jlc2VydmF0aW9u
X3NjcnViX3BhZ2UgaW50byBhDQo+PiByZWd1bGFyIGZ1bmN0aW9uIChub3QgYSBzdGF0aWMgaW5s
aW5lKT8NCj4gQWxsIHRoYXQgaXMgYSBtb290IHBvaW50IHVudGlsIHNhaWQgY3VycmVudGx5IG91
dCBvZiB0cmVlIG1vZHVsZSBnZXRzDQo+IHN1Ym1pdHRlZCBmb3IgaW5jbHVzaW9uIGFueXdheS4N
CkluZGVlZCB0aGlzIGlzIGEgbW9vdCBwb2ludCwgc28gSSBjYW4ndCBhcmd1ZSBoZXJlLg0KQnV0
IHRoaXMgaXMgaG93IGl0IGlzIGFuZCB1bmZvcnR1bmF0ZWx5IHdlIGhhdmUgdG8gbGl2ZQ0Kd2l0
aCB0aG9zZSBtb2R1bGVzIGFuZCBkZXBlbmQgb24gM3JkIHBhcnRpZXMgd2lsbGluZyBvciBub3QN
CnRvIGRpc2Nsb3NlIHRoZWlyIHNvdXJjZXMgdG8gcHVibGljLi4u
