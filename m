Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZr8L0Iu6pGmPKSCRPlhRPbeiDEBKtuCeqs/IRNK/eNWLyZt/dN/K53PfST21lyrnGyAN2CN
ARC-Seal: i=1; a=rsa-sha256; t=1525812910; cv=none;
        d=google.com; s=arc-20160816;
        b=zYu/fgvCLDCikZwrjeHzM0fIJQQSlwFh7L73vKIOBSgh8q7Jzo3T+VolveKpIorEYq
         0/kD3e9KZhKHyFcXyhilv4t/nUSG0Ixxz1lRWZQMsPKQCog8uiZeG+rF4f3YngxI7ZwD
         DmLVBaTQ55SiQMus/+xhfQJ24jfdpEPxWZl6569ZnLUAW12VBkj9fo/Ksjim3Uqzzzrk
         Kgm4iWCdO1ymQxuqp9qIMSrZUK0hsAIySVNhvOOM0jbur/VoP8D/FKxnqocjRCC68zui
         KUlB4QehMIFQfuatgxQ3KVA+puC0ERD3LIHhXTRcbVf1+Bdp4GW72yoVeFllq1kf1RQT
         Vg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=3as7Ni38PVyxKmxTqOUr1UNRDBNol/ZOTNY+Zmeikdg=;
        b=kht6eFtIpjl0UcC180jZwPnWMmCfGYaHXYusgeuW8apIFVmGe0igkAUUVWjBbS0ED/
         rspJVzgnIcJlwO3O+ZQ0xoG0JE+Faye434pjqam5vUFDRX1PZTxXZeD8zIASHH16vd8H
         eJFRIW4ZN3I0yiu3n3emjIcjZWXYD+p5U5DYEv9LVlgObrxF6U7J6z/PNcqs9e0eXm0n
         /Qcdp+NKieqmF08EOu35BUEFDF4bzzwbi0bJ09RNtb2uZf2prJwNlL7AtmF3TXY/TgKC
         YQptl/gVmWlXuTXn4HRAjWYSF202iq2MOpmg0w6ih0nbzuwynoKJsbWvGhTdzE6a6Ai/
         Dj3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Pg0ZrAEM;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Pg0ZrAEM;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Matthew Wilcox <willy6545@gmail.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, Tony Lindgren <tony@atomide.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAAHfYCABoLCgIAAFJYAgAEXpACAAAMHAIAABDSA
Date: Tue, 8 May 2018 20:55:07 +0000
Message-ID: <20180508205505.GD8514@sasha-vm>
References: <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk> <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
 <20180508202912.GC8514@sasha-vm>
 <CAFhKne-aDcMKD8FjfROGZ-=ffmq3Xa+7n0dm8uvzKJ_7WO-qCQ@mail.gmail.com>
In-Reply-To: <CAFhKne-aDcMKD8FjfROGZ-=ffmq3Xa+7n0dm8uvzKJ_7WO-qCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:riUJ08LSEAcIodpDHEgSomvg+XasBZvEYDahCmLcjJheLksgeJR8A2Nnnr7nPTdfvS7BQfvSr5vdBaTpl/shA3zpg5I+sR79NCTT/0s1x6GyRGKkdlGq+1GVlrMfWvRmpdd29Kqh3CRNI+qxpwev/AGKA7LYfyQWbMA7mzXF+JfIDAPDPva/uTuXoRxVUxTR9TpFzWZApJ2C5emnyaxPf7ybTp058vjQop4FpVLIsEwDkowAZq/7kglnDYvMlmqH;20:WoZRBduPa4shs4k1Eqn5dv8048jIyPXa4lovLBYsjgLU8bpLw21ETVhoV+waZFs9XV+ny7DcmK3T+7RCxjV2TKKw+xwqWH3jCwnmC3hHAYHUepjjcEHXo/QDfYltZUT6yDQuYtnbqyWXIcclJqTgE8OHA/NXCrwohYkG3IX4mO8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
x-microsoft-antispam-prvs: <MW2PR2101MB1034C9C9E14FBFEBAD9B4062FB9A0@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39860400002)(376002)(346002)(396003)(39380400002)(189003)(199004)(186003)(11346002)(97736004)(6486002)(10290500003)(3660700001)(316002)(5250100002)(4326008)(6436002)(25786009)(72206003)(2900100001)(6346003)(33716001)(6916009)(86612001)(478600001)(6506007)(86362001)(76176011)(1411001)(3846002)(14454004)(26005)(1076002)(6116002)(966005)(3280700002)(446003)(486006)(33896004)(54906003)(68736007)(22452003)(10090500001)(305945005)(102836004)(8936002)(105586002)(39060400002)(81166006)(7736002)(93886005)(6246003)(476003)(33656002)(5660300001)(106356001)(53936002)(6512007)(99286004)(229853002)(9686003)(66066001)(6306002)(8676002)(2906002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 7M1kfyP7f0Ufp4wsw3TMVSxtG/6qpTpR5TQ7KYWGEdz7D75qxdn7TesAKy/x3vyLHqIHdWU58F1E9X9D4/DAndJLMnH3+0XkSaf+lRGduzjOyHJVSw7S7osQJIgYyy63e1M31AK8lUmsNMH09VnjmNueZCvT0NEIXywh+UGPQIlg7YZxGdmP4usbYvbjstXZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B7B7557FD94704A99CFF4FA978E097F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b0fea9d7-d313-4759-43c9-08d5b525fb5a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fea9d7-d313-4759-43c9-08d5b525fb5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 20:55:07.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599930797780475484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 08:40:02PM +0000, Matthew Wilcox wrote:
>I think your sample size omits some people. I run Debian Testing on my
>laptop. That gets something akin to a Linus release pretty soon after he
>releases it, and while it gets some amount of -stable patches, it
>progresses to the next release fairly rapidly.

Debian testing is pretty much a -stable tree, see the git log history:

https://salsa.debian.org/kernel-team/linux/commits/sid

It follows a current stable tree, and moves on to the next one once it's
available (about a week after Linus releases a new kernel).

>Added Ben to the cc for more updates.
>
>I think Fedora does something similar.

Fedora's rawhide is just (daily?) builds of Linus's tree, they don't
care what stage the tree is in at any point.


My point is that no one picks a release and sticks with it more than a
week. If someone plans to use a release for longer term they use a
-stable tree, and if they are interested in testing, they move on to the
next release once it's available.

There's no one, for example, who picked up vanilla v4.16 and plans to
keep using it for a year.

This leads to my point about rushing fixes: -stable releases for v4.16 are
done weekly, there's no need to rush them in during v4.16-rc8 just to
make some imaginary release no one will pick up.=
