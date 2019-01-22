Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B35C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855B720844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pZadHolP";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NAsmUn7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfAVKnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:43:02 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:38874 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727798AbfAVKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:43:00 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MAgBLt008645;
        Tue, 22 Jan 2019 02:42:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ETDIrzDPI3nfSVAmaataAg0eoRdvCyS0UCenUTGwE6Y=;
 b=pZadHolP+m/q4fwzDEFHpIFH2xop8V7f89BtjRH7Mq9vbeCvYht468VkpqoEydFH8HTr
 8TKFMMzsXYFB5tJ2GS6DgXcG4n64mo+KRY21Qlo5vvCyA/YDrmnMgx7VnZXnN0K1ivlV
 d+d2cgbLDUWNDyJdwewaDO07jojQFCdiyTiTPMxd1SI0CKmXfQl+apFl6HuCIwWrUxGh
 XsU12wRDz3Hi5gIi0UNhGxsvQG3HsEgVOI6hYu7To3LMLcwpTXDdfjXgV9mNjFAmcvHX
 41DVxELEbPp6Ykx9RdTgujzU1c5g32xNOwSUxDDOuCAbLcBDOGFcEqDsf/nvmwPFr/0E Dw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2054.outbound.protection.outlook.com [104.47.38.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2q41awbb0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 02:42:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETDIrzDPI3nfSVAmaataAg0eoRdvCyS0UCenUTGwE6Y=;
 b=NAsmUn7H7XfCqCmj9x//r7YfFqCT+Nq71UdjPhk9H+7bKS0COY5AxzD5WGA1hELMmhjkyHmGQBIJdknv5euXQ4RNO1BeFA7bMr+DJjJ9YV1kHA5HhO+sqeKFw6riPDvjN25KH7YBd2da77CjTQT7Tq1cP5K6uTErx/0X+bx6FcE=
Received: from DM6PR07CA0051.namprd07.prod.outlook.com (2603:10b6:5:74::28) by
 DM3PR07MB2169.namprd07.prod.outlook.com (2a01:111:e400:5980::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29; Tue, 22 Jan
 2019 10:42:27 +0000
Received: from DM3NAM05FT060.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by DM6PR07CA0051.outlook.office365.com
 (2603:10b6:5:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.26 via Frontend
 Transport; Tue, 22 Jan 2019 10:42:27 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT060.mail.protection.outlook.com (10.152.98.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Tue, 22 Jan 2019 10:42:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0MAgKxK031105
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 22 Jan 2019 05:42:25 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 22 Jan 2019 11:42:21 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 22 Jan 2019 11:42:20 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0MAgKZ7012275;
        Tue, 22 Jan 2019 10:42:20 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0MAgKIi012274;
        Tue, 22 Jan 2019 10:42:20 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v3 2/2] rtc: Add Cadence RTC driver
Date:   Tue, 22 Jan 2019 10:42:16 +0000
Message-ID: <20190122104216.12077-3-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190122104216.12077-1-jank@cadence.com>
References: <20190122104216.12077-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(36092001)(189003)(199004)(336012)(14444005)(50226002)(97736004)(81156014)(446003)(86362001)(51416003)(76176011)(50466002)(478600001)(26826003)(87636003)(476003)(2616005)(126002)(426003)(186003)(11346002)(26005)(81166006)(2906002)(42186006)(8676002)(8936002)(69596002)(36756003)(16586007)(110136005)(54906003)(316002)(48376002)(47776003)(356004)(6666004)(1076003)(30864003)(68736007)(305945005)(107886003)(105596002)(53936002)(486006)(4326008)(106466001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2169;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT060;1:Y3W5POna1SeRmICZ8/Bz7QbsYwgZPKvkmGf8H7xftxD+upiuBL3nAxPYVLv/LmAlIFlnE15rPzddBFDxMupQZi8G6w3vweggvt5NqACjI8su+/ABUiFLa7aUN4j0jHJjjEfkr/Km5IM0HxTGLhBxLCdWEsKZlVDd3ZMGccYisWY=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afbd1742-7e1a-42f0-ad7c-08d680564d4a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM3PR07MB2169;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2169;3:SnHZGBHS5EJXmLkPyddTKJGsGG7T10rol2O2vmgxPN61u6TuUI6nyZ/ho74SZ29P3Cx+b0nojXhWYCyXC2NwgDqBODAhuL9ZG+/Cc6c3ZLbapDZUFjO2DNMkV0/ZmdnYoEJq9MReXeYvniDFdXs07uonWxbXFrZQka/nuCjYM6nbMyUi1Spu5WpurFmsRme1p3hrMuUUTP1g1B71q+AvgdZ3cYHw7KDa9kLjLiKNppsywAXNV1YoUjV+TMTgcshr2l67Nniu83FuXdNju/6N5YKwS9ckJHu2oSHpdQZMg5oICOvzpwZGkK8IjaffFaLnbtRJa1WUt6gpJG7dPbYMHXGObPc5Rn04Ao+BXU/WRZDH+DDgWZSoTz/Hsz0Hd5tH;25:ba4Xyuv/pFDJBwT7Glr9I6mkS3+nwh2N5QnvzF2LemS2bvJokIuzsZ2hVYJG9QDhcCvNGrkP3a3S6fKURLIumb6JZpzZvYtiDHP3ktF54mR0i2XPteLxWLHpZQjBxqbC1JV8IjQ1AQ8csm5LJV6koaInfxFTp6kdok2D1PvKK5zm6RhNz9zxJFd8y0a45bcFo4QSMNYy4G89L13yOw3Kh8AaYx7dDSAOX3eDf8ZRSeRxTKPVX/Koh+icWLt/b/M6wv92uNEMLWSsuqOlSU6h5kWklwvE9eeFdClhFVOCX8gIfVOJ76bess4iliVzK6Usa6IDlj1VWzmjGCtTQ7Ez2CGT720Ksqg9/LWWOj1Ugx4=
X-MS-TrafficTypeDiagnostic: DM3PR07MB2169:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2169;31:IChKqxOzl+dR5c+piRrvY6GKLBjYfiZyyG0qf5neE2JFFIR5hiff6+Vnnaku3i5HPeIJ1G4L4jwOmxPEfZFZAKD5Fnn2zn4ve0f2AzFfza672eav8+gTCOEBYj+uc5rBxA9z5ukJJ6CU4wZCSqMWYa7S0jrLIWNpg6ttPUI8GkeOUl4Dtf6zEyO02UDsGgW1LfgNvYNXq8ugXNLyGcFajO6MuHPSBT+Ziv9UDSIBNaI=;20:+Cvy+ufa1NyyHPGKeGkYuH8vMqgcFUSzla4c80S05LQMe6RSljxB5xVz6pdhY+X5ce0vE8A5d/inmsRltM1fAuw7u9ZAPAYu2gQGKTekyLg4fxDnmW5aCaZfRcYQdWqNHd7Sw89bDHTWEBXyRxHvQReLHLyx9odAKICHlm1Zs4rVFp52uaFQLfahWVEeNpe+Us0zXeN+31cbQVVZGdnXQy51gWgi9n6OFa1OpdWQY/+3t5R1fEN36kZmnNz9bZ6i94IrV2FWNUvMwPMOqReXb3GfsoFK+5vV4/20t1fION7PoxnCdEuVz5RxKx5Ab0DgEJVQ9MwNGYgPGwMYM8tzSIwaIXbqWYJH6WKssAUs5d8Ez6nHAb89btlbwCW87XASoQ0oEBsYpkyVAdvRXy9/NT/KgyelPmg2Lji0SjGh6di9iQDag1tmRubZSBcyaxtCM5jVWKjViceBjJFofdFe+rPbUlSwcn9VyLkttbeCmeYX3+feCqV8DYw+e+MPK6th
X-Microsoft-Antispam-PRVS: <DM3PR07MB21691FF5BC8E274F73F6BE26D0980@DM3PR07MB2169.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2169;4:UyTRYdhktv7nJpEorlzkF1wdmov3ra0T7P9m5cRaxkOTZE1amTdFl3kpArfJiXd3dZkMgZE2u29Wp3gztK3Kee4it0N5FVUaMdxtLn7OI9rZ8SpJ+3FMfMc7j8kXQghddpC8rwlPnpUOis3rgV0lYdr40luz5Nivsou/82aOBhZ3Ohk4emAE85FnwzAn+P/gOFiOSYZ8qZwJuXLURXZJBaUHhVslgSyF96Kz1JcHkQpJkVDOuA5uVKFxnQX5pyQEeNS/jM1wHK9z4cjoW3jK2rdbaPMnhH8A+Azc1Ii7Ud9QY95a3NGX9dU2A676zFoB
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR07MB2169;23:pVaAN33JGH4QyhYeTLVXo2fSTZ3G7zIihaJv8fP4F?=
 =?us-ascii?Q?HRGkN1gnRbRB0fAJ946U5yb8kWiBAozN5Ftwy1hSyWAeAktgr18XLm0Hm6vN?=
 =?us-ascii?Q?asE/MtFbe9T+jVFct2Bydkc+lO4TcEm0zJGKIkjCyEyy17RNXzctUSMpFppl?=
 =?us-ascii?Q?s9aoLaKjnKdzMP3cLb4ZxcdaPpADk6xl70ozLpvXSg9PRhJofgrdIrcuYE3F?=
 =?us-ascii?Q?fAsOPNhtqVtpXWLpdLB4Pxexf4tgAZfuwBtchy+WfxW586ANCKtUvQj4n2oJ?=
 =?us-ascii?Q?lH1lUa56+vor6LmyUXV+XVlwcG8om48Wj594AtI6j0M4bTI4xJ3cueO7sZ1k?=
 =?us-ascii?Q?+EOKhn95VUzuBrJBzKlWsliJoPGQq14jxf/IXbYeSl0lKivkRMqJNzlsugzp?=
 =?us-ascii?Q?MkiIX3qQv4O6zg1DORsRa0mrHCr/S+h9tMYrqsYzcOLBQzrkj4hnP8kVvzxT?=
 =?us-ascii?Q?AJImPrksUP0ig3+ZHrANvDfMJKH016auTXsWXnS9+oWTp8tv4L5OWT3KnVb/?=
 =?us-ascii?Q?EnULai/nOrXtG7HXQbvUAPKKBx7IU/3xjm8MqUgNwxLAtYv1ghw+3FnWLe1u?=
 =?us-ascii?Q?UY1QXWZg89EtJD4lWTCOiGo6CekB10x7k0l8bfokqcQWW5kfsbLAdiVV8dSp?=
 =?us-ascii?Q?Y3l5La7PJb1Z/Av6x2SQgnyxbLA3dkSTodT7zyeQuBVJY2/L90ZZXZrTbY5I?=
 =?us-ascii?Q?egvTk8Kx08CXfjma2+Wojf3jnt5mXUcL0yOe0wFC6atgF8HOu1iHV1Dks3XR?=
 =?us-ascii?Q?GZmzRXozyUnrishmzHaK1aXvDHt9LjIWcJdA59WqQFHBLjdW8bOOYtbcbhhY?=
 =?us-ascii?Q?QIf8GsskMXxPUJxHrL5XXX8CrPpByhv/G5AFoGNWI936naib1/mmYFCWASip?=
 =?us-ascii?Q?7nJxOLmolsBgT0E1j1HpviK6XLMz82YGVfLvzCc7dMiEDs/hBjd0Z2dDhfok?=
 =?us-ascii?Q?EanVOYtwUeir0tu/ZXSmt+EVQ0NWl60fjmrIYRX9K0B+mJCOpRWQMWC4/fj2?=
 =?us-ascii?Q?pLtsaZEF7S6yBQy4D+wUZNQwU//1i2vTYTKGXASSNQ8MYERskdaQsOqCHYeW?=
 =?us-ascii?Q?MCG8FOTfMJLKyM0uVO1Rv4toZaUqjaqYyZWfcE59foXobJK1GUzjMScJLRRv?=
 =?us-ascii?Q?V0mz9bKtPpFF2mDZ/Trcwp68lxZfhU0Lj8lhev+rE8qPBClqaWNNYd2L6Wjx?=
 =?us-ascii?Q?255xynPyuWNJ3qQ6dEbycdTHZ36fap6NPa1ws/yMnDMXMA6ry1KzDputA=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8p8E+URl1WomyPjTS1vSL67MmIwi/oKrAtuEq+WbYb6SIhisTzGtNlQgn4ojKN+nBV98DJTbqNVM9cuWWvAeMAf6uKIwBQ4U/W3nJ8EfWmppXHKj/fEM/N36JdLvaY5aUcbWfXzy6bS+3QcjOmcmYsgRNHZmlKOwhR64YwgHsixpq9e765F0hpEKlJQ/ihBahlu67m+qvhJg2Av+zJGyLf1ZXy6rC5XBH0s8LH+xU1arCepXkbK7KhbdC1SyA+DVBV+2vm30xRwrZNaRLjBcxvbOUNGyqrjnS3Mxlh+U/+Q1+X+z2gL4Nxgzv7EKv1kx3dhw9f6fHWdgTwWnzmbQ9t4sHWH5fzFU6clHd4rZixaI2Pu3cfgqnp2rFXhQqquahBiuCy1Cs0yp2j9DrzzKEm/4H6z1eD9bdNp7fKPdTAY=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2169;6:rvZISVpL2P61U4zYfXx2dr9x8UmMKSh+LKTccVM8eVAKd9BKJAy+b1k3cVruE65djjQr6azIPtEdnDJB+b/YbzSY9E+m3+N7JbXQNZsF0Bqo6YHIC5+mNV9Qqdyn2CCoJLVaii95MkbuBrDHSMjVGDuiiTtctlEmOmZULdx0NPLhkVlrPkhrss6uF3xjAw52ekiEodSCzpvug2py0A5dYKovlS+Xa9Qp5YqK5XnVZedCi+Zn7BLT5VSbNKnReCNiPVraIGtsdB1n+X9OUdeckA4iYjqsBOI6psxAm0OhSlXMWosmrUT5uVSbJl3XTjrQBfZKDX8mlycQU79QtMFd9F9UmNq+X43n/rF1097nlbf0WHOylh5YxRUqzJeYtsA8vpUZfYdRQwtDoxoBZLZcciApDVpIQqnmdLm85ESMmXMqqwMQK0m/h/QGKZqMUDUf8KLdk4C1FqYv71FP6akqPw==;5:U1v5niw1qN+Xl7Wj8eQb3ADAlP1S10FMmcQqHj01jgD5pwfMEajAIBIvROo6KXZVALDkkBCdFndjHQGT73BKrz+qJ3rVL2rDdjpilIWASWn76jAvJG1wWoVknQw26MLUha5lm1/OU95DvZ/xoszzMqUk9V85rpGv+as//nX+ygSdm/jNRUXMILoirrdJ0XQKu8/oUIM/i1Mvw8JnjdNDFQ==;7:cRKM5JYEZSqhR4e2P/ROGEswTQlYF7lSNoAbXSDXw72S04bbYwW/GBF6xa2TgEt9xsNc9Bk1DrjJfxIXkpbBNCYchKmz3pn6/onZ6DshigV9GmGmyqsxX16SQp4kNyxfo9gWd7jFKukCkzoL1T5/kA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2169;20:PdiV0JwHGQyVqqVt1n89NsvChaECVKCDHs8foOcxyEIelsI2yScV/PVLefk5pXF7y6QR/kqGpTTaE6X7JlgMhL4BwfNCGYB+DUkXB85qXpQ89Ui8NTTKgjNkSBojocOLs3PeuThDackEiRoZggYQY0ViV0qTY0sQcBkRokY35MPMNqJkCaqI19kSB+snqr4rzYPg0ch4U3AK9J7ZWpV5q7H8U4gMF4OpdSEupw4TVp950eeSK9uujO8kEyGBp0LP
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 10:42:26.7502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbd1742-7e1a-42f0-ad7c-08d680564d4a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2169
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for Cadence RTC controller.

It can be enabled with RTC_DRV_CADENCE Kconfig option.
It supports waking system from sleep modes.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/rtc/Kconfig       |  10 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-cadence.c | 423 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+)
 create mode 100644 drivers/rtc/rtc-cadence.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 225b0b851..0aba341ad 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1508,6 +1508,16 @@ config RTC_DRV_ARMADA38X
 	  This driver can also be built as a module. If so, the module
 	  will be called armada38x-rtc.
 
+config RTC_DRV_CADENCE
+	tristate "Cadence RTC driver"
+	depends on OF && HAS_IOMEM
+	help
+	  If you say Y here you will get access to Cadence RTC IP
+	  found on certain SOCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-cadence.
+
 config RTC_DRV_FTRTC010
 	tristate "Faraday Technology FTRTC010 RTC"
 	depends on HAS_IOMEM
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index df022d820..5adb41b45 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
+obj-$(CONFIG_RTC_DRV_CADENCE)	+= rtc-cadence.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_COH901331)	+= rtc-coh901331.o
 obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
diff --git a/drivers/rtc/rtc-cadence.c b/drivers/rtc/rtc-cadence.c
new file mode 100644
index 000000000..3b7d643c8
--- /dev/null
+++ b/drivers/rtc/rtc-cadence.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Cadence
+ *
+ * Authors:
+ *  Jan Kotas <jank@cadence.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/rtc.h>
+#include <linux/clk.h>
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/pm_wakeirq.h>
+
+/* Registers */
+#define CDNS_RTC_CTLR		0x00
+#define CDNS_RTC_HMR		0x04
+#define CDNS_RTC_TIMR		0x08
+#define CDNS_RTC_CALR		0x0C
+#define CDNS_RTC_TIMAR		0x10
+#define CDNS_RTC_CALAR		0x14
+#define CDNS_RTC_AENR		0x18
+#define CDNS_RTC_EFLR		0x1C
+#define CDNS_RTC_IENR		0x20
+#define CDNS_RTC_IDISR		0x24
+#define CDNS_RTC_IMSKR		0x28
+#define CDNS_RTC_STSR		0x2C
+#define CDNS_RTC_KRTCR		0x30
+
+/* Control */
+#define CDNS_RTC_CTLR_TIME	BIT(0)
+#define CDNS_RTC_CTLR_CAL	BIT(1)
+#define CDNS_RTC_CTLR_TIME_CAL	(CDNS_RTC_CTLR_TIME | CDNS_RTC_CTLR_CAL)
+
+/* Status */
+#define CDNS_RTC_STSR_VT	BIT(0)
+#define CDNS_RTC_STSR_VC	BIT(1)
+#define CDNS_RTC_STSR_VTA	BIT(2)
+#define CDNS_RTC_STSR_VCA	BIT(3)
+#define CDNS_RTC_STSR_VT_VC	(CDNS_RTC_STSR_VT | CDNS_RTC_STSR_VC)
+#define CDNS_RTC_STSR_VTA_VCA	(CDNS_RTC_STSR_VTA | CDNS_RTC_STSR_VCA)
+
+/* Keep RTC */
+#define CDNS_RTC_KRTCR_KRTC	BIT(0)
+
+/* Alarm, Event, Interrupt */
+#define CDNS_RTC_AEI_HOS	BIT(0)
+#define CDNS_RTC_AEI_SEC	BIT(1)
+#define CDNS_RTC_AEI_MIN	BIT(2)
+#define CDNS_RTC_AEI_HOUR	BIT(3)
+#define CDNS_RTC_AEI_DATE	BIT(4)
+#define CDNS_RTC_AEI_MNTH	BIT(5)
+#define CDNS_RTC_AEI_ALRM	BIT(6)
+
+/* Time */
+#define CDNS_RTC_TIME_H		GENMASK(7, 0)
+#define CDNS_RTC_TIME_S		GENMASK(14, 8)
+#define CDNS_RTC_TIME_M		GENMASK(22, 16)
+#define CDNS_RTC_TIME_HR	GENMASK(29, 24)
+#define CDNS_RTC_TIME_PM	BIT(30)
+#define CDNS_RTC_TIME_CH	BIT(31)
+
+/* Calendar */
+#define CDNS_RTC_CAL_DAY	GENMASK(2, 0)
+#define CDNS_RTC_CAL_M		GENMASK(7, 3)
+#define CDNS_RTC_CAL_D		GENMASK(13, 8)
+#define CDNS_RTC_CAL_Y		GENMASK(23, 16)
+#define CDNS_RTC_CAL_C		GENMASK(29, 24)
+#define CDNS_RTC_CAL_CH		BIT(31)
+
+#define CDNS_RTC_MAX_REGS_TRIES	3
+
+struct cdns_rtc {
+	struct rtc_device *rtc_dev;
+	struct clk *pclk;
+	struct clk *ref_clk;
+	void __iomem *regs;
+	int irq;
+};
+
+static void cdns_rtc_set_enabled(struct cdns_rtc *crtc, bool enabled)
+{
+	u32 reg = enabled ? 0x0 : CDNS_RTC_CTLR_TIME_CAL;
+
+	writel(reg, crtc->regs + CDNS_RTC_CTLR);
+}
+
+static bool cdns_rtc_get_enabled(struct cdns_rtc *crtc)
+{
+	return !(readl(crtc->regs + CDNS_RTC_CTLR) & CDNS_RTC_CTLR_TIME_CAL);
+}
+
+static irqreturn_t cdns_rtc_irq_handler(int irq, void *id)
+{
+	struct device *dev = id;
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	/* Reading the register clears it */
+	if (!(readl(crtc->regs + CDNS_RTC_EFLR) & CDNS_RTC_AEI_ALRM))
+		return IRQ_NONE;
+
+	rtc_update_irq(crtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
+	return IRQ_HANDLED;
+}
+
+static u32 cdns_rtc_time2reg(struct rtc_time *tm)
+{
+	return FIELD_PREP(CDNS_RTC_TIME_S,  bin2bcd(tm->tm_sec))
+	     | FIELD_PREP(CDNS_RTC_TIME_M,  bin2bcd(tm->tm_min))
+	     | FIELD_PREP(CDNS_RTC_TIME_HR, bin2bcd(tm->tm_hour));
+}
+
+static void cdns_rtc_reg2time(u32 reg, struct rtc_time *tm)
+{
+	tm->tm_sec  = bcd2bin(FIELD_GET(CDNS_RTC_TIME_S, reg));
+	tm->tm_min  = bcd2bin(FIELD_GET(CDNS_RTC_TIME_M, reg));
+	tm->tm_hour = bcd2bin(FIELD_GET(CDNS_RTC_TIME_HR, reg));
+}
+
+static int cdns_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	/* If the RTC is disabled, assume the values are invalid */
+	if (!cdns_rtc_get_enabled(crtc))
+		return -EINVAL;
+
+	cdns_rtc_set_enabled(crtc, false);
+
+	reg = readl(crtc->regs + CDNS_RTC_TIMR);
+	cdns_rtc_reg2time(reg, tm);
+
+	reg = readl(crtc->regs + CDNS_RTC_CALR);
+	tm->tm_mday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_D, reg));
+	tm->tm_mon  = bcd2bin(FIELD_GET(CDNS_RTC_CAL_M, reg)) - 1;
+	tm->tm_year = bcd2bin(FIELD_GET(CDNS_RTC_CAL_Y, reg))
+		    + bcd2bin(FIELD_GET(CDNS_RTC_CAL_C, reg)) * 100 - 1900;
+	tm->tm_wday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_DAY, reg)) - 1;
+
+	cdns_rtc_set_enabled(crtc, true);
+	return 0;
+}
+
+static int cdns_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 timr, calr, stsr;
+	int ret = -EIO;
+	int year = tm->tm_year + 1900;
+	int tries;
+
+	cdns_rtc_set_enabled(crtc, false);
+
+	timr = cdns_rtc_time2reg(tm);
+
+	calr = FIELD_PREP(CDNS_RTC_CAL_D, bin2bcd(tm->tm_mday))
+	     | FIELD_PREP(CDNS_RTC_CAL_M, bin2bcd(tm->tm_mon + 1))
+	     | FIELD_PREP(CDNS_RTC_CAL_Y, bin2bcd(year % 100))
+	     | FIELD_PREP(CDNS_RTC_CAL_C, bin2bcd(year / 100))
+	     | FIELD_PREP(CDNS_RTC_CAL_DAY, tm->tm_wday + 1);
+
+	/* Update registers, check valid flags */
+	for (tries = 0; tries < CDNS_RTC_MAX_REGS_TRIES; tries++) {
+		writel(timr, crtc->regs + CDNS_RTC_TIMR);
+		writel(calr, crtc->regs + CDNS_RTC_CALR);
+		stsr = readl(crtc->regs + CDNS_RTC_STSR);
+
+		if ((stsr & CDNS_RTC_STSR_VT_VC) == CDNS_RTC_STSR_VT_VC) {
+			ret = 0;
+			break;
+		}
+	}
+
+	cdns_rtc_set_enabled(crtc, true);
+	return ret;
+}
+
+static int cdns_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (enabled) {
+		writel((CDNS_RTC_AEI_SEC | CDNS_RTC_AEI_MIN | CDNS_RTC_AEI_HOUR
+			| CDNS_RTC_AEI_DATE | CDNS_RTC_AEI_MNTH),
+		       crtc->regs + CDNS_RTC_AENR);
+		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IENR);
+	} else {
+		writel(0, crtc->regs + CDNS_RTC_AENR);
+		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IDISR);
+	}
+
+	return 0;
+}
+
+static int cdns_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = readl(crtc->regs + CDNS_RTC_TIMAR);
+	cdns_rtc_reg2time(reg, &alarm->time);
+
+	reg = readl(crtc->regs + CDNS_RTC_CALAR);
+	alarm->time.tm_mday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_D, reg));
+	alarm->time.tm_mon  = bcd2bin(FIELD_GET(CDNS_RTC_CAL_M, reg)) - 1;
+
+	return 0;
+}
+
+static int cdns_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	int ret = -EIO;
+	int tries;
+	u32 timar, calar, stsr;
+
+	cdns_rtc_alarm_irq_enable(dev, 0);
+
+	timar = cdns_rtc_time2reg(&alarm->time);
+	calar = FIELD_PREP(CDNS_RTC_CAL_D, bin2bcd(alarm->time.tm_mday))
+	      | FIELD_PREP(CDNS_RTC_CAL_M, bin2bcd(alarm->time.tm_mon + 1));
+
+	/* Update registers, check valid alarm flags */
+	for (tries = 0; tries < CDNS_RTC_MAX_REGS_TRIES; tries++) {
+		writel(timar, crtc->regs + CDNS_RTC_TIMAR);
+		writel(calar, crtc->regs + CDNS_RTC_CALAR);
+		stsr = readl(crtc->regs + CDNS_RTC_STSR);
+
+		if ((stsr & CDNS_RTC_STSR_VTA_VCA) == CDNS_RTC_STSR_VTA_VCA) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (!ret)
+		cdns_rtc_alarm_irq_enable(dev, alarm->enabled);
+	return ret;
+}
+
+static const struct rtc_class_ops cdns_rtc_ops = {
+	.read_time	= cdns_rtc_read_time,
+	.set_time	= cdns_rtc_set_time,
+	.read_alarm	= cdns_rtc_read_alarm,
+	.set_alarm	= cdns_rtc_set_alarm,
+	.alarm_irq_enable = cdns_rtc_alarm_irq_enable,
+};
+
+static int cdns_rtc_probe(struct platform_device *pdev)
+{
+	struct cdns_rtc *crtc;
+	struct resource *res;
+	int ret;
+	unsigned long ref_clk_freq;
+
+	crtc = devm_kzalloc(&pdev->dev, sizeof(*crtc), GFP_KERNEL);
+	if (!crtc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	crtc->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(crtc->regs))
+		return PTR_ERR(crtc->regs);
+
+	crtc->irq = platform_get_irq(pdev, 0);
+	if (crtc->irq < 0)
+		return -EINVAL;
+
+	crtc->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(crtc->pclk)) {
+		ret = PTR_ERR(crtc->pclk);
+		dev_err(&pdev->dev,
+			"Failed to retrieve the peripheral clock, %d\n", ret);
+		return ret;
+	}
+
+	crtc->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (IS_ERR(crtc->ref_clk)) {
+		ret = PTR_ERR(crtc->ref_clk);
+		dev_err(&pdev->dev,
+			"Failed to retrieve the reference clock, %d\n", ret);
+		return ret;
+	}
+
+	crtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(crtc->rtc_dev)) {
+		ret = PTR_ERR(crtc->rtc_dev);
+		dev_err(&pdev->dev,
+			"Failed to allocate the RTC device, %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, crtc);
+
+	ret = clk_prepare_enable(crtc->pclk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable the peripheral clock, %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(crtc->ref_clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable the reference clock, %d\n", ret);
+		goto err_disable_pclk;
+	}
+
+	ref_clk_freq = clk_get_rate(crtc->ref_clk);
+	if ((ref_clk_freq != 1) && (ref_clk_freq != 100)) {
+		dev_err(&pdev->dev,
+			"Invalid reference clock frequency %lu Hz.\n",
+			ref_clk_freq);
+		ret = -EINVAL;
+		goto err_disable_ref_clk;
+	}
+
+	ret = devm_request_irq(&pdev->dev, crtc->irq,
+			       cdns_rtc_irq_handler, 0,
+			       dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to request interrupt for the device, %d\n",
+			ret);
+		goto err_disable_ref_clk;
+	}
+
+	/* The RTC supports 01.01.1900 - 31.12.2999 */
+	crtc->rtc_dev->range_min = mktime64(1900,  1,  1,  0,  0,  0);
+	crtc->rtc_dev->range_max = mktime64(2999, 12, 31, 23, 59, 59);
+
+	crtc->rtc_dev->ops = &cdns_rtc_ops;
+	device_init_wakeup(&pdev->dev, true);
+
+	/* Always use 24-hour mode and keep the RTC values */
+	writel(0, crtc->regs + CDNS_RTC_HMR);
+	writel(CDNS_RTC_KRTCR_KRTC, crtc->regs + CDNS_RTC_KRTCR);
+
+	ret = rtc_register_device(crtc->rtc_dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to register the RTC device, %d\n", ret);
+		goto err_disable_wakeup;
+	}
+
+	return 0;
+
+err_disable_wakeup:
+	device_init_wakeup(&pdev->dev, false);
+
+err_disable_ref_clk:
+	clk_disable_unprepare(crtc->ref_clk);
+
+err_disable_pclk:
+	clk_disable_unprepare(crtc->pclk);
+
+	return ret;
+}
+
+static int cdns_rtc_remove(struct platform_device *pdev)
+{
+	struct cdns_rtc *crtc = platform_get_drvdata(pdev);
+
+	cdns_rtc_alarm_irq_enable(&pdev->dev, 0);
+	device_init_wakeup(&pdev->dev, 0);
+
+	clk_disable_unprepare(crtc->pclk);
+	clk_disable_unprepare(crtc->ref_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cdns_rtc_suspend(struct device *dev)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(crtc->irq);
+
+	return 0;
+}
+
+static int cdns_rtc_resume(struct device *dev)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(crtc->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cdns_rtc_pm_ops, cdns_rtc_suspend, cdns_rtc_resume);
+
+static const struct of_device_id cdns_rtc_of_match[] = {
+	{ .compatible = "cdns,rtc-r109v3" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cdns_rtc_of_match);
+
+static struct platform_driver cdns_rtc_driver = {
+	.driver = {
+		.name = "cdns-rtc",
+		.of_match_table = cdns_rtc_of_match,
+		.pm = &cdns_rtc_pm_ops,
+	},
+	.probe = cdns_rtc_probe,
+	.remove = cdns_rtc_remove,
+};
+module_platform_driver(cdns_rtc_driver);
+
+MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
+MODULE_DESCRIPTION("Cadence RTC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cdns-rtc");
-- 
2.15.0

