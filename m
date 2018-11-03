Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176D0C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8D72082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kL0tdiyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8D72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeKDBB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 21:01:29 -0400
Received: from mail-ve1eur01on0049.outbound.protection.outlook.com ([104.47.1.49]:49814
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726888AbeKDBB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 21:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKlm0mIIswFkq9FONamvawZ4NI9wcUSBNsT/TzswILQ=;
 b=kL0tdiyrifRek7lyC8ULsJSTm08HERw5/m7DHGklLBmXpYhZfPx3G51vhT0JccSWWOgOFl6yh4qvM1l1we2zwrIw3dOexZ7K1o1RPkHYrTGTrJhH9ikfu9b1rZ0h3jj8mhmK4qDglm/Myf+KKBHS+BfVBg7eUhULqIIAIDRr3o0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4898.eurprd04.prod.outlook.com (20.176.215.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Sat, 3 Nov 2018 15:49:43 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.028; Sat, 3 Nov 2018
 15:49:43 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     kernel test robot <rong.a.chen@intel.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@01.org" <lkp@01.org>
Subject: Re: [LKP] [sunrpc] 6a7da2a288: kernel_BUG_at_lib/iov_iter.c
Thread-Topic: [LKP] [sunrpc] 6a7da2a288: kernel_BUG_at_lib/iov_iter.c
Thread-Index: AQHUckFKrYSkCoZzUEKg3reiNwAAdQ==
Date:   Sat, 3 Nov 2018 15:49:43 +0000
Message-ID: <AM0PR04MB42907C7E4A7E1B09ED7B6BBEEEC80@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <20181102001633.GD24195@shao2-debian>
 <7958.1541119812@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4898;6:ZODTG3rwbgcqWt/6mEcT3xY0MoQL5kbMXDINFR0l/lpYeqX/ahOJ9tSh1Ki4DxAaghzUoaMQ1WMJvqnYDmqBi9JMPP9bPCFJ/ZTY9KY8k5iTPYZOwnQCmPJXempYS/e4T75SEKhw6tgOU4wK4vgyVn7ggGuqnAzhH31gVvM3SF05m4bgyoDIbzwvzMD2p+zY1mXQYDrgubm/nN7b5dwsqG/a/iJ0tgFb+JdAEp0SHXc4pmg48Hqc6Wu049cnANAs4haxDPBh3iYyuqK49639JB7W6DjbcsEjJwA9Xzs6ip5isjuFtF5vUxXaWtrOOASbJtanF5a5meLBppVsg9M91CxZZpiCXPYoe2PoQVWYXwH6iZmnjuswSvb0vCQ29Q5wT8IIgvyqBufC48vgY3Bbwc4C+knuYqCyNTqQo9KVUrppgjmVB4GT2o20sdHopPY1pJXh56w22gs1SsG772Attg==;5:gagZgxfTC8xcHiKWZjRjDb5d3gswWvxlTc7zz0BN5RADNsOXLvhI9XJNhRz0GixBnxKDJwS1nDWdCMbODJikNvpRyWqOjOqu2uy1+q51q0NhBVxHu+nWyBwzBuJ032BJlNgfrcqCKcnprIB61EfTvHpIWWYfiPAuu672Rq9Yt4c=;7:hh0NaWhTpERf8V10fHto15V0++yg05elFun5TrqAUlk1tM6g+QHsFk0+DKMtU5TQCGxLMw9pCGkHdYo9s/9v7yVI1ytmZA1o/aOHfe7xq3AA8IJBft+Dd4UR/Iv4ZtpBb/AhVlhcNA3LeMwruqV5jQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e2f86fb5-47ff-4254-96e4-08d641a3f939
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4898;
x-ms-traffictypediagnostic: AM0PR04MB4898:
x-microsoft-antispam-prvs: <AM0PR04MB48983F4D9E4DA5EB9ACD0E31EEC80@AM0PR04MB4898.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(45079756050767)(189930954265078)(5213294742642)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4898;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4898;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(69234005)(316002)(4326008)(575784001)(86362001)(68736007)(2906002)(6436002)(26005)(33656002)(6506007)(53546011)(25786009)(5024004)(102836004)(2900100001)(105586002)(256004)(106356001)(71200400001)(71190400001)(186003)(446003)(44832011)(486006)(476003)(55016002)(966005)(6116002)(3846002)(66066001)(14454004)(99286004)(7696005)(81166006)(81156014)(478600001)(74316002)(229853002)(8676002)(7736002)(305945005)(45080400002)(53936002)(6306002)(110136005)(97736004)(54906003)(8936002)(9686003)(7416002)(6246003)(76176011)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4898;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZFn9SVtUmC7hPm/rGq2xKzSsgbeFzFPc8dE1tsfeVofZ++WI7M/h9UmS1QDXuCInsOyceymOfrAnIjhlN8boJwsfWLAwRHM32QDJdj6u007aYVmXbrijxIFeV1QzREO4QSUYZC5JBkJTHyjhVTn6tmxYHgBKD/PuKIaEhvW/uLE1JnvrAu+SQHUVGLAtohW3IuW25bkoCVPlMzFw9goVMoqbO+qrprWdEVC43WDaT2GZcZ5lJoaqg9KCUhWJItqT58ovKVamjxiKN5KG0Ai+iS1g7+Km+oVOJo6TsIrCLdmOvcmUiLcrOC79V8Ni2UA8WwwH6jBsFh8BF60Q8k3BXvvjFdP0Ew5e+QJWOO2SIjg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f86fb5-47ff-4254-96e4-08d641a3f939
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 15:49:43.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/2018 2:50 AM, David Howells wrote:=0A=
> kernel test robot <rong.a.chen@intel.com> wrote:=0A=
> =0A=
>> FYI, we noticed the following commit (built with gcc-7):=0A=
>>=0A=
>> commit: 6a7da2a288ce412d7ac117a2912a7b0d9104ee6d ("[RFC] sunrpc: Fix flo=
od of warnings from iov_iter_kvec in linux-next")=0A=
>> url: https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fgithub.com%2F0day-ci%2Flinux%2Fcommits%2FLeonard-Crestez%2Fsunrpc-Fix-flo=
od-of-warnings-from-iov_iter_kvec-in-linux-next%2F20181101-070713&amp;data=
=3D02%7C01%7Cleonard.crestez%40nxp.com%7C0b22a6d58a5242277ca008d6405d28b3%7=
C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636767166190134069&amp;sdata=3D=
335WGS8H6GRfqp%2BDmocDQ8mowhe7a0RxKbfM6rSgJ3g%3D&amp;reserved=3D0=0A=
>> base: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next=
=0A=
>>=0A=
>> in testcase: boot=0A=
>>=0A=
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu kvm64,+ssse3 -smp 2=
 -m 8G=0A=
>>=0A=
>> caused below changes (please refer to attached dmesg/kmsg for entire log=
/backtrace):=0A=
> =0A=
> Ummm...  You can't just apply that commit to Trond's linux-next branch un=
less=0A=
> that branch also includes the iov_iter changes from my afs-next branch.=
=0A=
> =0A=
> Before those changes, ITER_KVEC is required:=0A=
> =0A=
> 	BUG_ON(!(direction & ITER_KVEC));=0A=
> =0A=
> and after, it will be prohibited:=0A=
> =0A=
> 	WARN_ON(direction & ~(READ | WRITE));=0A=
> =0A=
> The reason for this is that have yet more patches that split the directio=
n=0A=
> from the iov_iter::type member into their own member and turn the types i=
nto a=0A=
> simple integer sequence instead of a bit mask.=0A=
=0A=
It's not clear how such conflicts should be handled. Maybe patches from =0A=
one tree should be pulled into the other earlier so that merging "just =0A=
works"?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
