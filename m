Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E01320875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cC4bYjQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E01320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbeGLF5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:44 -0400
Received: from mail-eopbgr720067.outbound.protection.outlook.com ([40.107.72.67]:16928
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732350AbeGLF4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxjkRzr6OhuELDbXoqhNa7JUn8Y/WvExb33dUVSu/K4=;
 b=cC4bYjQ5l/tp+K0z7UkfMJkt9z7gyhE4K3kpWirHctu3Z9Nhe/pidJNkq2k37Yj6NbRMZQk3UZgQVDPZguOx2S6QuAEnX0QAFynE8/G4+5/Ujo46ZppNBGyqnFtps8u4qEfzOdaEHccMMWz1Ji4xo78zLJmFETE7ZZ+bFRpl4M8=
Received: from SN4PR0701CA0014.namprd07.prod.outlook.com
 (2603:10b6:803:28::24) by BYAPR07MB4712.namprd07.prod.outlook.com
 (2603:10b6:a02:f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:07 +0000
Received: from DM3NAM05FT012.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by SN4PR0701CA0014.outlook.office365.com
 (2603:10b6:803:28::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:06 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT012.mail.protection.outlook.com (10.152.98.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUb017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:05 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:10 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:10 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lsTr029949;
        Thu, 12 Jul 2018 06:47:54 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lsjh029944;
        Thu, 12 Jul 2018 06:47:54 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 31/31] usb: usbssp: add pci to platform driver wrapper.
Date:   Thu, 12 Jul 2018 06:47:28 +0100
Message-ID: <1531374448-26532-32-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(36092001)(76176011)(7636002)(42186006)(86362001)(316002)(305945005)(16586007)(54906003)(426003)(186003)(246002)(8936002)(8676002)(336012)(50226002)(47776003)(109986005)(356003)(26005)(2906002)(486006)(476003)(126002)(107886003)(446003)(2616005)(11346002)(478600001)(5660300001)(4326008)(14444005)(4720700003)(1671002)(26826003)(87636003)(6666003)(106466001)(105596002)(48376002)(50466002)(36756003)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT012;1:cFWUQKSzVatKJGeNYwQA80jZvkE+CAInRvsQaH/62CI5gyyiZaoKy7MpcNIvPpcnngw0Y4W6uy/mGyk17R0X5uQ9SB0kB6pzpSqwRqjDUZzLSnqWwREWTZISZZmF5Jqj
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96dd70bc-7986-4e58-70f2-08d5e7bb0ab5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;3:g+UoNIsECOjw9VzdStYF/9N3Df7m6/yBTuu9WeQ31nsm4S0/TAGhOvKUgEl1b2h/wWPJy27gqUuX3INkrr77X3q3zSEN1gV28a45w0+0Mtk142uhwM+sWGG9XQuaprrcaX50sI62f3FjNljdmdHWm5Ew1TOSm8GCC3FgjvuFp0VdTPipH/78CEtiaeGdbPwMs6hRupDBAdMp3AM1hTOYQsQM8w/yIdmVAekPlQsV0sM6rud5jNPynnBvaGI2a/F1Uc2xu2XQe+yp/aV8Av2qk6bYX26Dklc/s+TjVobKWyC/gWp3MoNFWA2MBb5tmN0iKKZJdc18oM+OhqUN9tNKkciWNFNlC6HaPkwsAQ4Ztck=;25:Ef3KlIm3Dg+HoKCCUGe5FCwtkXMqGvZYf5BgUKSqLIbgfJ8Q/VHX85QVVwmN51i+lzrp1VquH+9DF9kb9rK5qrO5iHlOz48V4O/M61uTvdNEIcNzh6KiFnjc+xABY+9KAvJucgqiDBYiWkgzPP/qtTdeYuKmVWbGJLY0bhTWHehV4ldaGoxTXr6fblUU4XRhmChmI9q4CFIH8J7fmEoaHBUyUFXsXembm8N1B+Pz/Xn16CvtstRU15Us5uGzvEXh8W6oTAGUppogT/mTSY7K7+RUFtBMIpYQBohMY1oraa6VPVmCIBASf3GsdX2+4s0UCSnGTVw0T1SSzdbCMR6g7Q==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4712:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;31:NsstphTjp25DfoFkZPiN7R0AU8jij8GD6cCLVhHmhB+MlQfdKss0oT4X9G5+EmTV68xcmi+Kd/C10T7wUlTdJWiILl0Vd9R7QYwtn036uRUfq4hIRPpWtzsF71kr64DGQd1kE4K6RoIhRUr+cDRzcHt1YohKABklB1l5HIlY+0QraqR5fBvMNU40vE1T6EsO415IBRi1RLXkLv2sTfzEX2oH6729Bd24ycuJLvnKgf8=;20:3XXN8tjoTmupnyPmzj7b4g614MFQB1QCWlSdNcINFQpXqyWafz+iqa7hbuUXYGHacYvNcX2e3eIcLvAISrvvpXm+y0tKYgibCdaNdA1o96KTS75ZXVtxr+GnCpTBzJdvLeGOJ16v2QhNjdbKX1pBqSQYtYvoEDrPaNWSeUB9IkPdnMwWRO1qX3D7m9UrnbI2mTFNLux/hVwvx50aTFzRZF+G/Yqxml62xDC7uBo1Kx06SC6MaHa88RjXQ5YlDwFzEq3TjKR3szjRYTlsx7peDokWIDAXgcK/TN1HsoL9pT2wQuUkpbW0PZnGXSM0cO/IzAVSR8ywluZyHblFhSuwJrA+ytcWZKECsoq4NKrReI3jUhSxbXkCYMdRc+eIazu8jnx5ng3cfz3OvbgErSIQwI0EQI4+z12y19MMkojH9aZRVRzcFGgR+UNHff3fKmIo4gPzz8lgv5+NR0bzlwwZTiER0ka+04omxyTJrv4TfRz7g9PC9f5Ok0f2XqLEuUma
X-Microsoft-Antispam-PRVS: <BYAPR07MB47122C8421A033D198A19F33DD590@BYAPR07MB4712.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4712;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;4:kVQKEXNr6UXoRWCTzXuprrrpmCf294LKFJ40exuSLYt1Y6Z/xogshp4szwu+2HYqCpb2Nh2toIwOZ3OyO/juTJERModcujsecJwnNagTYRzl50UIrjnQO5nPGaOjF90KPv6CWZwBl3Kl8n2AHX0FjJq/II3Sft4o7amKYuRsSPQUtjk72RZTXgh9+5VVvJG6AVnGmww5C6ojsATwQ+cH1v4GuiGDq0I7+70hDVVo+EFCdjJ3uILURb32OVuBYyYwNIau/b9c4x0cJGoGJe9H9ZAydEaHQXbPmofFqr2683ib5UozYtelblrdC7/g3wUo
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4712;23:6r9EgcU6XYF79IGAmn36moWZg4O6QFerRlmUcdTw+?=
 =?us-ascii?Q?cjm90NdgYItKDMZqvW6LxAYxonnXj6TJ+xUWxw3qpldoeoLZJWIW4HAwzGRf?=
 =?us-ascii?Q?8Z4NltzVek4t3CcJLWbbYOfTbx0sNdI8H5VBBFDVmGXIvib4eDgunyPWFo4m?=
 =?us-ascii?Q?/A+sbOVk4ThZ5W413/3sVI0nMxjM2xiYOEITpgAtbFZ9UJeELsrnC10ZHrS/?=
 =?us-ascii?Q?mdrcKZdYhSA+nJTqb1zXvbN/s7Sy6qSQ8ISygq38h0Ow4nHOSMtQbmN/VomZ?=
 =?us-ascii?Q?BTlxjM217oULHJIf8BT8EEUqdZ0i3IlDh6MlYD6iki7S7wsssnwrE0T5I5WW?=
 =?us-ascii?Q?ZO84R+j6i3WO4NVI6VlSDzSRH9wLLkW1CgXMeP61Yr/dfG/D8hShk6osuE+f?=
 =?us-ascii?Q?1j+VMAVMb1466J6eC7gm2hn2SPDXsKiJMafyYRp8FYMnHXnsLv65WBCIdiEf?=
 =?us-ascii?Q?PEsQER7B0iVxDDnX1/FB53o8GyhRX/suz6UdyJ5Mb4nAR4CppIGB8ms01IJ9?=
 =?us-ascii?Q?hex4BkqxSmcTwD82v9BBiE6LqWOLTFSab9y//PRECzlXa8qqg15jnhtHNTwP?=
 =?us-ascii?Q?IQKCg0Ck9/XPLTzNpbJIGE81AX7q1n3ArHVlcx5+fulpvcJsJKowZxlLAOyH?=
 =?us-ascii?Q?+dIKf+zLRzURwylWqbNn8B+OgqGmI575RmIMZKvrLj1c2j122+uLpc05TPzT?=
 =?us-ascii?Q?4Omj6r3UmRJ6wTwF8eqa6Sv0HL/4bfNCQSauj71k3USI+kRriBx0EuX+u80t?=
 =?us-ascii?Q?pYdDmwgjh9056nSZJxQKFMDYmO55s1A1msyrgf2ksiaIeOpWmlkFGxilOdU3?=
 =?us-ascii?Q?EU5XRt3Fi+N3+czPbPfuP6EGhemfJUDtjtP02FRHPSpx0SOJvoReob4QKdBW?=
 =?us-ascii?Q?6whmUBPptDMRC4TKeTz9mMoNgciNxCCocWcnNBC9DcrCqUkpQAu+PxsVy/tE?=
 =?us-ascii?Q?BQIYisT9NntV7Q7Xw0y/DlFPgowvyEQbiwjU4cvCeGuU5LvA2Lt022tLaKJx?=
 =?us-ascii?Q?MXC9PWJcR7gV1HPx/5EUNdgzLejbxzB5YTXwZH8QXYobEZ2omLVokglSTsFH?=
 =?us-ascii?Q?jUq71v1BfEyhypZU2uhS9HJU4aPfIKshpah8vJ6D3GmuHVfqdfma7vdmX1n3?=
 =?us-ascii?Q?ROE7RmDhgjBLlOQXbtExTv6UMvhA/rjUkCX+K+Z/ZKQCglk7aM3wA=3D=3D?=
X-Microsoft-Antispam-Message-Info: V1vFHhVZgD+3krymo7oAM4v6/oicIzfE0+I0IN0NWJJTYfcGtTh+aC0P+i8wGVOa40B89TZakqvFCOyC4g2hwVXDYwz88KdrhloFnDkni9r6XzzrYlHkwVrgRi12W4gi1SJvqsph/GaA6pYgqwCLS0ij1xk99QTsyxqKbs34US9+t9KEsbF6E6nXauWLAo15QoEBLlH+oGQuVCzsc7g/VaEr9SKk1vw/IHlzndyWIzC+hg4+/5k3FfyRE4GSueGos3J501z7qC60s0ZiANgA1wKbvQzb0BNjXDjEcxC1QtaC4Sp6XVck7koIb21VOb2v3dgSeRCnp2ojXAMrFjxIxNACiUeY/kzX0pF6278eYg+6z5eH07UpCWS+3l5tdZhiafcD8lMgBDD5x1KZYjaZ4w==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;6:0h2rWxvpH54Zd6b+EVkRkISZ0bIsN7m6zGKScCwSvLLhcJemZPoSj+b5qtfAu+PnRfX3L4jdQDq9cjvFJv+fIvmqH3s6mTH/FLs5xSnHWMJpAfKWFG6a3QNZ7t0mcgkhfCITbRKw4+bcfht8tXHJ38wYGbqwwPLxxxN1cS/bH0E0i8SHR6t42fSlc56C4gYf8dCOYQxCdNx3oM5m30rUtBkLtvfQcWB9kTTWtfTjvkyCmEveZdOKBqn2NG3AaPwBQ1T0OoYZzzetpM0ZZITmfTwUTBOcJ7ZcU+XueDUDeyaH+HqOxV87mAKG6fywOknYKEsjp/0/6/vIkkLeyW6wt8xOcwMEKBvThnGeKizoTRkzKMWBgBOGNEtUo+ufMLeAcJfR1nLBeeH2l1R/yr8o/n/Nce24QWlAm/zAoXfCeY9DPCvauzlKxm0BUjZPBmPkH4npgV5k78pIs0fSG5JviA==;5:CMHIeRpROu2FKpoj8nVoHkPZTaLhovrw3WNetIAhpIRmkOwKV18fYbfG953j4G2KKwsBwFmFlXjFevEL3ouHLMz66Or71FV8/aBJCgN8IMYwIub+jI1mrDh7FPhUrOR8Y244FgI0IkxwpWM2mVDNNrOM2wimjnSTWqLXGEPedVk=;24:jGGfPKTNFb1xrGE14JrvuBA3KydMV0mHr50nDpKZxTiWCzedCYHUVFFzaYZM0QaLFHNpfr/NzxwROeOXBE94qkTMVLMOSimQH7WJho0Vsac=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;7:WjHIu6TZV8FzumGehdf+hOG8xpyO8WoYJG1ZwBjQXBULnc8RVtO0EUxW2DC/tdOatyoPnB/KISKy2F2Onz0C1X82wQeeq4iGHg39a1hyUwLW96Fj7M3BTkcaBXQnkHO3QNWaS5ysBvQhNJRMvRhcvT71ng+0yRoeZOgbCjiUZXtJ8ygxtphSDm2RoG65D1I3zW1y1U2zOy5ZrMAw2ExZG7hxObD0wWjypq99s6BerfEoL8uwKm0iSdbF6taTHH35;20:jWk6TQuoIGQ9K42WIUMVed7ewPDXOXHDJp8UxzU26PxtnsaZ5Iea6CaitonlJ1SxJ8q+EyR5oB9jcYUvepoOD6QK27KOPAPdhoZC943g+sOXt8oo2Wj04blQ4CUpqnBNTuq3yCojSy+HzI/7+BUkUnEQWj5/dK14J1gevgzDAPGfELrzRUnt4v+SKg0xFV6H2p2juWUgssr9mF6FIP7SCFzWdWWZih0rMZtuUg6dVDJkI4uTg5Lr1sk5LWU6JjHD
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:06.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd70bc-7986-4e58-70f2-08d5e7bb0ab5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds PCI specific glue drivier that creaties and registers in
system usbssp platform device. Thanks to this we can use
the existing usbssp platform driver for usbssp controller
build on PCI board

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Kconfig           |  10 +-
 drivers/usb/usbssp/Makefile          |   5 +-
 drivers/usb/usbssp/usbssp-pci-wrap.c | 229 +++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/usbssp/usbssp-pci-wrap.c

diff --git a/drivers/usb/usbssp/Kconfig b/drivers/usb/usbssp/Kconfig
index ee20b01753dc..bada82e5d223 100644
--- a/drivers/usb/usbssp/Kconfig
+++ b/drivers/usb/usbssp/Kconfig
@@ -17,5 +17,13 @@ config USB_USBSSP_GADGET
 	depends on USB_GADGET=y || USB_GADGET=USB_USBSSP
 	help
 	  Select this when you want to use USBSSP in gadget mode only,
-endif
 
+config USB_USBSSP_PCI
+	tristate "PCIe-based Platforms"
+	depends on USB_PCI && ACPI
+	default USB_USBSSP
+	help
+	  If you're using the USBSSP Core IP with a PCIe, please say
+	  'Y' or 'M' here.
+
+endif
diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index de8bbcec277e..cde2d4334617 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -5,8 +5,11 @@ CFLAGS_gadget-trace.o := -I$(src)
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:=  usbssp-plat.o gadget-ring.o \
 				    gadget.o gadget-mem.o gadget-port.o \
-				    gadget-dbg.o gadget-ep0.o
+				    gadget-ep0.o gadget-dbg.o
 
 ifneq ($(CONFIG_TRACING),)
 	usbssp-y		+= gadget-trace.o
 endif
+
+obj-$(CONFIG_USB_USBSSP_PCI)	+= usbssp-pci.o
+usbssp-pci-y 			:= usbssp-pci-wrap.o
diff --git a/drivers/usb/usbssp/usbssp-pci-wrap.c b/drivers/usb/usbssp/usbssp-pci-wrap.c
new file mode 100644
index 000000000000..a8511f062133
--- /dev/null
+++ b/drivers/usb/usbssp/usbssp-pci-wrap.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver - PCIe wrapper
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
+
+struct usbssp_pci {
+	struct platform_device *plat_cdns;
+	struct pci_dev *otg;
+	struct pci_dev *hg_dev;
+	struct resource res[5];
+};
+
+struct usbssp_pci usbssp;
+
+/**
+ * usbssp_pci_probe - Probe function for Cadence USB wrapper driver
+ * @pdev: platform device object
+ * @id: pci device id
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int usbssp_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	int rv = 0;
+	struct platform_device *usbssp_plat;
+
+	if (pdev->devfn > 1)
+		return 0;
+
+	if (!id)
+		return -EINVAL;
+
+	if (pcim_enable_device(pdev) < 0) {
+		dev_err(&pdev->dev, "failed to enable PCI device\n");
+		return -ENOMEM;
+	}
+
+	pci_set_master(pdev);
+
+	/*
+	 * function 0: device(BAR_2) + host(BAR_0)
+	 * function 1: otg(BAR_0))cdns3_remove_roles
+	 */
+	if (pdev->devfn == 0 || pdev->devfn == 1) {
+		if (!usbssp.plat_cdns) {
+			usbssp_plat = platform_device_alloc("usbssp-dev",
+					PLATFORM_DEVID_AUTO);
+			memset(usbssp.res, 0x00, sizeof(struct resource) *
+					ARRAY_SIZE(usbssp.res));
+			usbssp.plat_cdns = usbssp_plat;
+
+			if (!usbssp_plat->dev.dma_mask) {
+				dma_coerce_mask_and_coherent(&usbssp_plat->dev,
+					DMA_BIT_MASK(32));
+			}
+		}
+	} else
+		return -EINVAL;
+
+	/* for GADGET device function number is 0 */
+	if (pdev->devfn == 0) {
+		usbssp.hg_dev = pdev;
+		//device resource
+		usbssp.res[0].start = pci_resource_start(pdev, 2);
+		usbssp.res[0].end = pci_resource_end(pdev, 2);
+		usbssp.res[0].name = "usbssp-dev-regs";
+		usbssp.res[0].flags = IORESOURCE_MEM;
+
+		/* Interrupt resource*/
+		usbssp.res[1].start = pdev->irq;
+		usbssp.res[1].name = "usbssp-dev-irq";
+		usbssp.res[1].flags = IORESOURCE_IRQ;
+	} else if (pdev->devfn == 1) {
+		usbssp.otg = pdev;
+		//OTG
+		usbssp.res[2].start = pci_resource_start(pdev, 0);
+		usbssp.res[2].end =   pci_resource_end(pdev, 0);
+		usbssp.res[2].name = "otg";
+		usbssp.res[2].flags = IORESOURCE_MEM;
+
+		usbssp.res[3].start = pci_resource_start(pdev, 1);
+		usbssp.res[3].end =   pci_resource_end(pdev, 1);
+		usbssp.res[3].name = "debug1";
+		usbssp.res[3].flags = IORESOURCE_MEM;
+
+		usbssp.res[4].start = pci_resource_start(pdev, 2);
+		usbssp.res[4].end =   pci_resource_end(pdev, 2);
+		usbssp.res[4].name = "debug2";
+		usbssp.res[4].flags = IORESOURCE_MEM;
+	} else {
+		return -EIO;
+	}
+
+	if (usbssp.otg && usbssp.hg_dev) {
+
+		struct pci_dev *pci_hg = usbssp.hg_dev;
+		struct platform_device *plat_dev = usbssp.plat_cdns;
+
+		rv = platform_device_add_resources(plat_dev, usbssp.res,
+				ARRAY_SIZE(usbssp.res));
+		if (rv) {
+			dev_err(&plat_dev->dev,
+				"couldn't add resources to cdns device\n");
+			return rv;
+		}
+
+		rv = platform_device_add(plat_dev);
+
+		if (rv) {
+			dev_err(&pci_hg->dev,
+				"failed to register cdns device\n");
+			platform_device_put(plat_dev);
+			return rv;
+		}
+	}
+
+	pci_set_drvdata(pdev, &usbssp);
+
+	return rv;
+}
+
+void usbssp_pci_remove(struct pci_dev *pdev)
+{
+	struct usbssp_pci *usbssp = pci_get_drvdata(pdev);
+
+	if (pdev->devfn > 1)
+		return;
+
+	if (pdev->devfn == 1)
+		usbssp->otg = NULL;
+	else if (pdev->devfn == 0)
+		usbssp->hg_dev = NULL;
+
+	if (!usbssp->hg_dev && !usbssp->otg)
+		platform_device_unregister(usbssp->plat_cdns);
+}
+
+#if CONFIG_PM || CONFIG_PM_SLEEP
+static int usbssp_generic_suspend(struct usbssp_pci *usbssp, int param)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+static int usbssp_generic_resume(struct usbssp_pci *usbssp, int param)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+#endif /*CONFIG_PM || CONFIG_PM_SLEEP*/
+
+#ifdef CONFIG_PM
+static int usbssp_runtime_suspend(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_suspend(usbssp, 0);
+}
+
+static int usbssp_runtime_resume(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_resume(usbssp, 0);
+}
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_PM_SLEEP
+static int usbssp_pci_suspend(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_suspend(usbssp, 0);
+}
+
+static int usbssp_pci_resume(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_resume(usbssp, 0);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops usbssp_pci_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(usbssp_runtime_suspend, usbssp_runtime_resume)
+	SET_RUNTIME_PM_OPS(usbssp_pci_suspend, usbssp_pci_resume,
+		NULL)
+};
+
+#define PCI_VENDOR_ID_CDZ 0x17CD
+static const struct pci_device_id usbssp_pci_ids[] = {
+	{PCI_VDEVICE(CDZ, 0x0100), },
+	{ /* terminate list */}
+};
+
+MODULE_DEVICE_TABLE(pci, usbssp_pci_ids);
+
+static struct pci_driver usbssp_pci_driver = {
+	.name = "usbssp-pci",
+	.id_table = &usbssp_pci_ids[0],
+	.probe = usbssp_pci_probe,
+	.remove = usbssp_pci_remove,
+	.driver		= {
+		.pm	= &usbssp_pci_dev_pm_ops,
+	}
+};
+
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USBSSP PCI Glue Layer");
+
+module_pci_driver(usbssp_pci_driver);
+
+
-- 
2.17.1

