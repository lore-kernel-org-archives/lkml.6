Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CD6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8432087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="C7zcT6Fd";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CvCTivUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8432087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeIYPWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:22:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49082 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727606AbeIYPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:22:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8P9BhJE019845;
        Tue, 25 Sep 2018 02:14:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=cVEBt/8RTC889i88u+FEfP7oebmqKbaf0nYxeFN5m4Q=;
 b=C7zcT6FdTc9swHvpAlm6CHoTfNQWZfcsrKFBtk5u+GO7XttRD6P6mokO3YwEQO6i6HKZ
 Qe/Q+TIVQEW5EOIwSwmnkGJsk51QOGyrNrGMr/RDB1sY7W2oU3dM1x6DGGar5ub4T0WK
 SIWXRRSnmtTJj47eLXx7CASRanT6C42JHylRkpAuC2YEwGT4rsOFlsf2effGSil+BVQg
 uvgnYVV1gM2XMbHAp7spXa32iP994lfAlakzCkYlSvOkPu2W9LKfGHlzk2VLVf05R5sL
 /Dclh2PUzSiI00uniHdcSQ7my+REiAEKO1j1RuNo6FdlP3dxh/FwsVUsimoRgFzoacNQ Ug== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp0048.outbound.protection.outlook.com [216.32.180.48])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mnj9vkfg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Sep 2018 02:14:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVEBt/8RTC889i88u+FEfP7oebmqKbaf0nYxeFN5m4Q=;
 b=CvCTivUnDTWOPsUD4U8EBFUVpHMVUmcisDFpY8kCS37NUJlNY6b6nlUSfSIS+4AhyLo4jmzyDaUMhSFEcoE6QvLuPlWHJ4xRjNFAHP3kvSyoZwOKgZdzZwGXPTJ1+28aUobOGAvEelZCazcT28mauDWaJJB0Mc4309O+/oOWr7k=
Received: from DM6PR07CA0031.namprd07.prod.outlook.com (2603:10b6:5:94::44) by
 BN7PR07MB4403.namprd07.prod.outlook.com (2603:10b6:406:b6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 09:14:43 +0000
Received: from DM3NAM05FT064.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by DM6PR07CA0031.outlook.office365.com
 (2603:10b6:5:94::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.20 via Frontend
 Transport; Tue, 25 Sep 2018 09:14:42 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT064.mail.protection.outlook.com (10.152.98.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Tue, 25 Sep 2018 09:14:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9EcTg028551
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Sep 2018 02:14:39 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Sep 2018 11:14:45 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 25 Sep 2018 11:14:45 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9Eawi006785;
        Tue, 25 Sep 2018 10:14:37 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8P9ESg7006589;
        Tue, 25 Sep 2018 10:14:28 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <rafalc@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v5 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Tue, 25 Sep 2018 10:13:30 +0100
Message-ID: <1537866837-4408-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(36092001)(189003)(199004)(5660300001)(426003)(14444005)(48376002)(486006)(50466002)(126002)(2616005)(476003)(186003)(6666003)(26005)(8936002)(86362001)(42186006)(54906003)(16586007)(316002)(47776003)(110136005)(50226002)(2906002)(51416003)(336012)(2201001)(8676002)(36756003)(356003)(246002)(7416002)(105596002)(305945005)(7636002)(4326008)(106466001)(478600001)(87636003)(26826003)(21314002)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4403;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT064;1:Pmrem4+Th2kOccEwMvM0oCagyUvcF4WNJctCzjkHB+DOYTe59W5udY5dnwqnQfSy7kkygU0cR62oOGIi+w2rMdbbKEkHFOPp5/ouVALOKwwLrol9P/wOZ/f/Nw0OWbUU
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89310055-f08a-4e53-2924-08d622c7543d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN7PR07MB4403;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4403;3:g4geS8mC6dFqD5qThgpBIzjbWgCgcRdjM6frOuR+duEtiI/3O51gSoeuOeMQPvfapywHttt5iXpGXmqA2Au41b0/udJmjRGJn0uqNpiUz/crvzvcJCF3shnfMn+JBcHirXUHBxR/sbi0zE1BJWUdSFaGUwBxjJM6D6K4tMNeWTj9OrRizz2YjClfcoq9atyYTRi1VTIeIIvvK/WygM5NUbaDTBFIkHy55EJOR6gjJYwxnnnpnPJax/DgiwhLvKQOKk319VBwBld73MsaCmalOO1rtoMUMpcsL4+9AMCsFyBqn0T58IvHxZpqjvGPXxMtstbNwyKa5vjkpYwYVknmY2uw/jnBcgqIbkdIbog2kzw=;25:eH930ywEEZxO/C3po+Ewc5JpdTRHqzHNRJG6Gm+Q49alT7h/G9UPe7gOBx5MXZLSuQHziLOZrEMtCVm7h4AaQaE4QHUBNyA+TqwMIrowYAdjXXm5HsWAZy1BnVnKwWH2Gb+EDK4skMmcwYJik1IWeIn74L2FVoqcgGP8MMVr/E2AvVrhdYpgupUFOr4bUIFqOa4oEbexKruFzFJFOaSxs1X9awVDIMDrh4i5cUavqjr4QL3J2n2uPwFxzCHwPEFUWexOkYUX3hkV2gtq36moqgNVqFznMrA/nnSqxNkpI+1ewmlF0xbY5SBBIGJUwRH6CpFn5IQn7wng69fH9BcSNw==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4403:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4403;31:kmMylaHtw01uBscyrgW60bclPLUbWkEVauarmX2KQHyeCZ5+ZbyHncjp6c7VAgTzK8qcya37yH5LUzNYGVghESiQ+IeztiaiGsgM6pw6RCMbBXIWl2ArzzcXUqmbWZnTCIyKrje2Tj1EvmLpwlkVPS/ySKF0AbqVBFAlNaG5z6hgahLIEg0BIzdzjXSPE3BKkvnAuSG/nBBl9ZA+KwPTfml7DsY7pAAOejtpCk22zJE=;20:8qaQ47RzoGP5G4eDYTMJ8BnYXqVrN59REf1Y5RT/Q3EL3148TUDDMIGzbv/0zAupOJixCIsgVp1jIZH831NQ0aaUHANVMM5lT9fRBDBdM7zyLtGtzmGJLIZ7F9rHpazZZHdQby9GL5hkXL7t8n7bwtmz+ujY2uwZ1cnDuIx0UTnrkHt85/iQyzeZ85EJoNeglCgf9u/HFxJLtIlnJJnGqmVqpX42N9ZfcJESHUwEtoe8LgeSIdIlvmJSxFsZagPVDrc2pA4mAhhLLR15O8KxUJ2KVHEC2wykdaXRoUwFm3q2TyOswZj4n1WtRrdepWBUDz/E7FMYlKaQpg7K6JgwSp2lPgHAJNGu/nc6annawZx/+/d2lN7OE/OwPRAhxNsfAcfw9E0cRzmmQ0qdV4wB1T5o4EkH7esraBjcckkYJO35OJTfMNGpOoaZ+3/NH3ITMup1CIxmEaEtvy7k2766I5B3NvA3HablbtjAXU90YCaclMkQ+pUmp/XhDRST7aVj
X-Microsoft-Antispam-PRVS: <BN7PR07MB4403CBA77266E83B95D042DFCD160@BN7PR07MB4403.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93003095)(149066)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BN7PR07MB4403;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4403;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4403;4:ScQXCysAiWMx5IY72w4TfbwGG6TSibeFagk9GJ1YJj1lqbA8f7pCaPC3Hhzk8klSqKcNxbx2QhxAMweAzln23YDF1KkC/YGlOSQMbjLBDNhwdTORK4zWYYvvPRm5MAzU06NkB0O5ditjOic5lqonIufh71AAJ6wgoAl2SAZDsGUunRFb7DyWhHzYksAAZncYjP/MefwYUGOCmXoenDNyMT59M83EmnHkfMNgPnP1SeFf9WOgUxs+Zf0I+YW8bvOqHF7NKYn+H7iMnt9/uQVB5Q==
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4403;23:qj1J63tScR3tF91ApWLwkfw6fsLSAEM3yUrvrr/4e?=
 =?us-ascii?Q?SGG7RLs7GcCuyYKu+jew1D5+MTQfp4Qva5/fnjqb53gnhRDChi24O9HhcYhf?=
 =?us-ascii?Q?qYD/wtEa91XovORtMJvzJI2Mkzn44mVgzF5CBNGNkv3xbBgfLr0/bNh7/am2?=
 =?us-ascii?Q?pDiHEn0f2kVFpDmObOsHZmgJ+rN68SdR8LSJ1mdh7nuLOCANiTEWaTbt3uXN?=
 =?us-ascii?Q?8N5RX7Ih9k5BEzEGcqBCbBwYb4Rmp4Ws1KwODbuMnJWPsZvGD0lyEQgz5FGE?=
 =?us-ascii?Q?JlfdUUzw74wXXqtY9FiGc7usQGkJBIzUb/vWF8TDtVpPmuwauMxkWUh264B4?=
 =?us-ascii?Q?t4XJv8pc6CX2HxwgLXb7O8u/r43W5LpqNIq2Vk5UIgt91veeRbcWmoZhes+e?=
 =?us-ascii?Q?ek4gUk/abpoPwlYnEwODjPVeYHCnmWjXoeJ3XrdS52Wc1/2QG+hfIPSQq81/?=
 =?us-ascii?Q?C5NKkN9qD5kgPmK+Q9pisFwAWmB9Y6nAijrI6GS5P/LqtyaJCMYLBEpBEKOf?=
 =?us-ascii?Q?CY+fAdgjQc8nX3EUZIz4adKiNY+yQn8nNggW45RWptJmj0lb/++9EK3tg3Tb?=
 =?us-ascii?Q?1ZgE0J1ARQM3zUyOBB2FZkZRVvrLM8DWxazBJqCUaLvKIGUygXY5LcwuwLbh?=
 =?us-ascii?Q?l0UVxwHpR6sOxxyFJkNJhB+KunK9W96MnXhRHHGlx1vnVSUD+WKRF9DrMEhX?=
 =?us-ascii?Q?RQv6THB3E+lzIP8QNAOOoK8NMoxQfFuSvaNJ/46WFn9cbt+xV6iB0nZ1nbfp?=
 =?us-ascii?Q?I06r8NkK61ozH6xOUBcctf1v5+fjjdl/Au3Zx2yVmN3q+w5tlAY7d7+obeiq?=
 =?us-ascii?Q?4sz1ct3PGpaRTi48S/QWjymGpW604S9e/uYt8eM/7Y3PH4VF/FwSGE+p6PFA?=
 =?us-ascii?Q?vpSXla0UwgJHE+YXfmdkseHHUGnFJIyGMcJImwkw0vXy/DrjPvs80JFvsnOG?=
 =?us-ascii?Q?0SdGzUFyLSOWTsoYnfTH7RdJQh/OqZkWYO8Qnss5tlDsRy34inB1ZgapAJgU?=
 =?us-ascii?Q?NyTnMW12xe6PbbSu9IPGvPWXmTIHMGQj/jaaw+dwUP9cDTbWsWLYqW8effkq?=
 =?us-ascii?Q?/rqWAGUFZfyc08cjGUOrn5ShttlLYYvP3/7Z8EtMqE8PfKvVT5BdakVd5AbU?=
 =?us-ascii?Q?uOSqtfpdpju1kk4tN0EKW1krUS/0abu?=
X-Microsoft-Antispam-Message-Info: C8J/4gjk9WNngE0/SqgvM190Q3Me/oa9pSnWOWCepEPWhP/jg2zvrBRRC8F5Z5Sprs/mkqXfWvNZnBh32fvVlVzqKeqTnEkhv4Jq2/21PsKAsmX4tW/1G681QHxUbIrmi/Db5SKAn5sb4lpOV3gFcDyZpISErD3fHtLVZJVWuEtPhIKsS1H19XNfjUTH7PuzLw1vGZCuc7zcVwi87brpZJBGFQGvwRWA7ZzPjrFdAw4+PkurynywFKJC2Gqf8HkePqKw8j2l25YASxQEHjhHWpjxDlA+uUlM2vbhCbbN3LoFOKU2TJBnRUhlroqV89/qA9Ua+bazHaj0fOk8M6zM6YqiEW+CIPumYVD6I1ghffbAaTafgai7E0jO5ndpR13wsavvGckUHOfr0yXepGpXGA==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4403;6:NpOtLbpdRhbYF+8fZZF0ovkRNqmagopy9lPgRCtRJnOpIHe3T5NBbQz1WZDW3s7sFvINLWy3um+zqn3nAARvEu6DXLj03c6mZqPuTEFn+Kvx3RfXtLEWAYns2HNdJjuP0cOgLvoSAGxc0UiJBbWU7NvvNC/QikLM1QMxASz6U8TRdL6xN6yNWFhcy7JlrWTR4bGkUcIFZA/acQEgB9rjacMZNXO1oO+XSvINax2luHBqRnhZ0Xx+tPBTa9HXOiJbOwDmUDsUwqUGpVyzy2BtbX+nVnN8xmyaTesaUx9W8MHm6W7FL8dG/8679BnYSrYBYbXPhZsFA9Ky0d0VXXpmlbYm7jBGRTMyHpMvSvTiIzpiIx4V2ZZRp6nzi85LN1CVER8EKWkv/Sn6q+gov6q23zrKbik9oigdK2vUCq3uSMUbe0U1b4glSHMH6leEwjFxq7g4IUuTE1lb7jX4dpOTqA==;5:wGE/rmZEEcNI/J9BwtZvewgs+L0QKnLmDAjQ/2cArQhLoKvw7WNKhxkyrS0QMuQUdfpVh69pAQmkmZWFtyMaVW9nf4q3PP5MYfwnKUv2nOnz3Dx47IRLKoCsMXKWwle9qKIm6gOvl2h561rZpIHow0CnW8Kj2ObN2V+qdiFL/kw=;7:4OmZIgIFOrmfgblMbAknQMJD/B2eiRAySBvogRgU42QfTb1nyvmC/i/j1ieIB5HHpEm/35DAtuk1Kxj1XIkTW+jSJ/0XCEfD6BKez6yl1BvNQ/Up/okN67AK0WtPHmUrCp/cx8inVJI/vTIBuG39IOixvOXrGh59KhYfKPX8LSusRayGD8IAKUO7TVbI5KcBAUHzJDJU655NVfIARZOV8e60v/jxfKRW/i7AU/S3CM6I2UfuS2iAD8QzjRLh9iVV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4403;20:Df8mlRj1cwctSX519N2GPtqHmx4KuF0B2LlQweAsl1KkPTUG+gV5xmop9Hz7emoBcmv5zGDwoAXfbmOfQTaZFTkhSGpRoa4GarBVaFtKYOHvnGEs/rpLS0vEFa0JEnMX3Q/RLeWcbX3JdZUcsKUYLzPB1uEbIf/usdMems85flFfVgbqJzks/mp3CoDpaw//7/nqYcNiAXpQNwOtsTlGMTbuDfVjTgZLDg39yvmxXotdqxV3Vkt/jDNPN64MUPtJ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:14:41.8040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89310055-f08a-4e53-2924-08d622c7543d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4403
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809250096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is the series of patches that will add support for the Cadence's DPI/DP
bridge. Please note that this is a preliminary version of the driver and there
will be more patches in the future with updates, fixes and improvements.
Please keep that in mind when looking at FIXME/TODO/XXX comments.

Initially, MHDP driver was developed as a DRM bridge driver and was planed to
be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
a driver for Cadence's DP controller developed by RockChip, but that driver
uses the different DRM framework and looks like a part of a bigger system.
Both controllers (including firmware) are quite different internally
(MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
etc.) but they have similar register map, except for Framer/Streamer (which is
noticeably different), so they appear similar.

The following patches contain:
- Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
  modifying it a bit (mostly new prefixes for functions and data types) so it
  can be used by two, higher level, drivers.
- Modifying existing RockChip's DP driver to use the common code after changes
  made to it (use the new cdns_mhdp_device structure and new function names).
- Modifying DRM helpers a bit. Some are required for new driver, some are
  updates from DP 1.2 to 1.3 or 1.4.
- Adding documentation for device tree bindings.
- Adding preliminary Cadence DPI/DP bridge driver.

Some of the things that will be added later on include (but are not limited
to):
- Support for Cadence SD0801 PHY (PHY's driver should be on the way by now)
- MST support
- DSC support
- FEC support
- HDCP support

Changes in v2:
- Added actual description of what the patch contains, what is it for and
  what's going on here in general.
- New structure. Now we have one common low level driver + two high level
  drivers - one for RockChip with minimum changes and one, more general, for
  Cadence.
- Dropped some changes made to DRM helpers.
- Updated the device tree bindings document.

Changes in v3:
- Corrected dt-bindings document
- Enabled some clocks at startup (since FW doesn't do that anymore).
- Changed Firmware file name to match the file on Linux Firmware repo.
- Added SST audio support
- Made common functions (in cdns-mhdp-common.*) public.

Changes in v4:
- Fixed Kconfig in drm/rockchip
- Fixed Signed-offs
- dp_link_status() is no longer public since it's used only in drm_dp_helper.c
- Replaced EXTRA_CFLAGS with ccflags-y in drm/rockchip Makefile

Changes in v5:
- Fixed Kconfig in drm/rockchip again
- Moved cdn-dp-reg.h (cdns-mhdp-common.h) to include/drm/bridge instead of
    drivers/gpu/drm/bridge/
- Updated the mhdp_validate_cr function


Damian Kos (1):
  drm/rockchip: prepare common code for cdns and rk dpi/dp driver

Quentin Schulz (4):
  drm/dp: fix link probing for devices supporting DP 1.4+
  drm/dp: make dp_get_lane_status usable from outside of the core
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
  drm: bridge: add support for Cadence MHDP DPI/DP bridge

 .../bindings/display/bridge/cdns,mhdp.txt     |   43 +
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 drivers/gpu/drm/bridge/cdns-mhdp-common.c     | 1107 ++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1304 +++++++++++++++++
 drivers/gpu/drm/drm_dp_helper.c               |   39 +-
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  234 +--
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |   43 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         |  969 ------------
 .../drm/bridge/cdns-mhdp-common.h             |  135 +-
 include/drm/drm_dp_helper.h                   |    2 +
 13 files changed, 2744 insertions(+), 1150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-common.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 delete mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 rename drivers/gpu/drm/rockchip/cdn-dp-reg.h => include/drm/bridge/cdns-mhdp-common.h (81%)

-- 
2.17.1

