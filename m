Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9ADC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279320873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="kAxiM3v+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8279320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeGJBxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:53:40 -0400
Received: from mail-os2jpn01on0092.outbound.protection.outlook.com ([104.47.92.92]:17140
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754410AbeGJBx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6vc6/Oevwnj9cUooXKTyZ5hrxQGjSmMR5cwccBdfKk=;
 b=kAxiM3v+5s7CxfPnotfEBX/HCXPDbMjY70uCrc8KB2y8WnGHMz9HyEV1mROsYn9kpqMhvVyDjzw4CK5AMAj0Od6Ka/RVyA5D79twIAhKmD+Fwp14vrThahJKy4xrB96oN10sm7m9MfSmZSoRd7svudaV8CKaOEIfWduySVQA2vE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=masahiko.kimoto@cybertrust.co.jp; 
Received: from localhost (221.114.197.178) by
 KAWPR01MB1265.jpnprd01.prod.outlook.com (2603:1096:402:17::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 01:52:35 +0000
Date:   Tue, 10 Jul 2018 10:52:30 +0900 (JST)
Message-Id: <20180710.105230.2160849304208584873.kimoto@cybertrust.co.jp>
To:     andrew@lunn.ch
Cc:     f.fainelli@gmail.com, fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hiraku.toyooka@cybertrust.co.jp
Subject: Re: [RFC PATCH 0/1] net: phy: skip autoneg of ethernet(fec) on
 network boot
From:   Masahiko KIMOTO <masahiko.kimoto@cybertrust.co.jp>
In-Reply-To: <20180709144106.GJ10376@lunn.ch>
References: <8a437ead-5ded-57c4-c44f-95986442d626@gmail.com>
        <20180709.182902.1637265651643155858.kimoto@cybertrust.co.jp>
        <20180709144106.GJ10376@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Originating-IP: [221.114.197.178]
X-ClientProxiedBy: OSAPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:603:14::16) To KAWPR01MB1265.jpnprd01.prod.outlook.com
 (2603:1096:402:17::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49581715-7cef-475b-0a05-08d5e607cefd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:KAWPR01MB1265;
X-Microsoft-Exchange-Diagnostics: 1;KAWPR01MB1265;3:dPXKJS3I651o2OarjNUc2obQbj7o+ZP5NhUT94gv+JFsGnb0rymB780BrLZWw71THKjHw2UzQy99ESz+VNCHE3E63bMkWHnquHPJhC534P0WoFrMsFEqI/CGxw1wlZ4MerqYbm5bWgFUOwvwVvDuXJAUnMbIyDJQEkCY6byAXiITV3VDdXq55M4BH+93NyKKCIKrx7gKcIEsChR/AMWP/iu+ItrseD0frofdhlIQJZ9UQvKEYjV+TO1EvGMKdiuz;25:FatJbpkMFjuKpp9k9jO73UqGlMFNshIWgQHoJtG57KOP+xuEQjzpqzEq8rTcVdt1cb0oqI7wY6pQ4AU8P7PRGCCcEpQTWgoUuIWBTsXtVXwls9LcfAo3wfJXigm9+mKjkZ8BA0oKLKPM99MD+w/oXlbbaB6RBC8nZWcujvmxoPxqo3RyQuXDU4aFjCp4rNP+Ubo52d1hXutJehpcUt7cYuHnPDegjvOoU/4K3VYPFZeRv2gNSiNevTvmUiPuG3fNI1uNQrLYpgX3ngzMKF+pWcu4oCV79Mpj3UMAQyQlu7zS+e8L2GqMMu7gCABWWVem+IIgTmQpkPSCiBvkem8yEw==;31:kkTn+eHsm4dFVUT3ejeGSkCAoC//T05bhXE2wbXxAGJYD8GVpLaigXDRkXC7hYHoVhtseEzTArVP1NwYmT5WlNs8oqbo4qyme3Vly22SbIGmaNnZC/vvfH0yl/ztXFDgWNcym7K8D1VVkQhHzmTwQBYacWEl+68a6pFeOngztrLt9Vl853PVAa/mEdPwB8hTPzlffKdne8FONdALUJmy7qSbvuHG85wK9O8wGRqE8mQ=
X-MS-TrafficTypeDiagnostic: KAWPR01MB1265:
X-Microsoft-Exchange-Diagnostics: 1;KAWPR01MB1265;20:r5BN3m4pWHhrWSU+iFQEuezmAyhYNVUeHXNr+OKNeYepU/haYTDERj70SOtt3VFhCsJC1zbT/T81YWcgQ7xitHVc7wBQMwMlNffLSDmfrKpGmU7HJ6QmUoWKiAiIeIlZdvfpabvKgCquO9s8vFdP57EfCBeydWduRC95KCEXZZaFcktIH3zDkoLVdpAFt/ag/5KxLZxPtz8hmm83Od6lk1zVr6wZUIB1RnOG0GciZkAQj7eneyC49g+drFvbHI+e+JWbDX2PlG73e/vhscYNWGUfuCtQ+B0rVjEgEC3oofN00d9NetywyEp2KkpttLDd6B/C1F7/lXV/WhTBhhRWGd3eU0SlsaWh4/74zakwfM0dB7QJSP1ZF+DIKp0gZwfqiNmfoDrcy8uAlE7QXdi4Nc3Xje1kThN4ZGAthKo+Uxt/g3ypAOsdpDY5C54BYmUMUEKfzTjRBkDe+dcZM+AF3I6bOvE5t/+Qgw18C946byCuz0E4yPtDJsI4ATK0A2bS;4:Vkdh47q5YHnlsUWrjpLIMBsOXICkhek/Ty0WyhmkGa6RNOUwb6rYlyg9/IbgZinurkeHCvd+DvQX4LUo4jENDFkGcbKe3MtvPCLNlO7QPDs70g3561HIck5hfOc3Bx59AmLdL1xhFboiFWC35SQisARK4WK4mIT15o3SlBEkO05pQbq5aKpLyyIS/zPeGyHp+K4l9+kItg5Di7DDNvwsfQcfM54DLRKn1e0JNsbilIu+JwInWpwXeznxbFF/wYp/TRO3jjVCPGjgZGP9Yymbww==
X-Microsoft-Antispam-PRVS: <KAWPR01MB12656A322A436281965C80BCD95B0@KAWPR01MB1265.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:KAWPR01MB1265;BCL:0;PCL:0;RULEID:;SRVR:KAWPR01MB1265;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(376002)(396003)(39850400004)(136003)(199004)(189003)(42274003)(6116002)(23726003)(81166006)(6666003)(86362001)(81156014)(103116003)(956004)(106356001)(2616005)(478600001)(107886003)(47776003)(3846002)(105586002)(53936002)(6916009)(8676002)(2906002)(486006)(76506005)(25786009)(446003)(5660300001)(66066001)(345774005)(6246003)(39060400002)(11346002)(6306002)(386003)(97736004)(74482002)(68736007)(50226002)(229853002)(305945005)(966005)(26005)(16526019)(186003)(7736002)(2361001)(230700001)(8936002)(316002)(52116002)(6486002)(2351001)(36756003)(476003)(4326008)(6496006)(76176011)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:KAWPR01MB1265;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;KAWPR01MB1265;23:c5dKvw/Tu8J+LUOPiorG26qqV5myQaD4ljUnsm/Fq?=
 =?us-ascii?Q?DFPQv0+Yo3937CU9dZy8hlqjL6fClK8jVjTGdpqdmV5mmBdZx8qyLMDsCe+D?=
 =?us-ascii?Q?VsDXP5omHVdYQ4D1jV9GLciiPlLJARGOu8ATVKdQdaNRKOdkvgPJKa7c0jld?=
 =?us-ascii?Q?ucpuF6yS/mVr9ZIYl6wEGQZmS3ATTOqYUE6TvdnDSXMp4pYzSZSwCq0kS1sT?=
 =?us-ascii?Q?GrAZ6nkWoqS/j1HZaqWph5a3KBczyUIRk8bYm2+Fa5Bqzqno6RTxLsumT5PD?=
 =?us-ascii?Q?wE/WerL8hbrZUGgXoipKXOP2Bu02izJ/t7CzoQLKI57ReUMihLUi9LbJurj6?=
 =?us-ascii?Q?NKbrZjqPqMO2Aoxza8rPtnKxFnOAJ38mUyltEvsu9XTYg0hXlxWZeChbFwda?=
 =?us-ascii?Q?BtZpoOL8rpNQ6orLTfQQ/YXNTWnduQNbIN/oIIBOS35ZM3dHDGOd2XJrwTuL?=
 =?us-ascii?Q?gclWzXZeuRm/fv/ZOyIMDF+94GcHmQY7EMpx04ieMDC9/YX0TJf0gYwscO9v?=
 =?us-ascii?Q?LaDCFDcdy1fKBzCP4len/LQCgykeAr+/pdroWb9tGSsEQ1BNj+/dhiCbnGbu?=
 =?us-ascii?Q?LvkYMWJRfgk0YG5BoNCwKiFWLHm/YoELaU6iQuZ7GiWIwJxDnvQ4nRvAwCp5?=
 =?us-ascii?Q?IKZUk0Y8wm3d3IZnFlgXS4x6pYroA23FXddcU6iec3t8QvDRddVlnlU7nv/s?=
 =?us-ascii?Q?W3EAaAIULWP247YPULtxpnvzOOFyp+rb4PgH0jV1N74FNJiJ5QUg39IQWb09?=
 =?us-ascii?Q?SoyDD4QsGvhH08o8jsUxgl25bUUElI7PQVV6OXrX0vP0NRllwtiStRpGG7Fz?=
 =?us-ascii?Q?o71XftA8y1NX1jS6PjaUSV0y0RYBD/e4tIyUeXuXeHbRKcvFTvcq60b9UkaG?=
 =?us-ascii?Q?3RVfI6upbB5vkv2BibXgDqVHf0myiX07U2lnxU4TtyCVrdmJc52dfzKcbFnb?=
 =?us-ascii?Q?2UOaRsaRPHDtUE7j79Z2FSNKlbj0rFeyIFdmWf4u8JZ3TiWGFHcsR98/rikj?=
 =?us-ascii?Q?MNAeEWtCiF9OHGhzUvjtvMxHIWPfoLIyTchk/hWL79qeTWHsCe3SFYatnxQ9?=
 =?us-ascii?Q?iXHsE+9ggTU8d4QbcjwC8cwT5YuvSCGs7QGKc6rF5eStN3BvN0wVm/jt3R0I?=
 =?us-ascii?Q?j5iyjorwodeoIXWB697YHPRCJfu2ow1ki3VXB83dK7jQS9lsOLPwsuYkyVMA?=
 =?us-ascii?Q?QLipfRpQazepkUxbQrUZAqLh7LZj5C8TsYaMxRPFflb2BPTFb9xaV4K+U5py?=
 =?us-ascii?Q?2Snz/Hyuni3HqOAr6IhGYyYeJtLJMaw1KTmWBBD/xwUa3QlIb/V5hKd42DKT?=
 =?us-ascii?Q?6tHVgXlH3fMeaqxgrTFieaDfqhkkhn7eIXT7teEX0/Ag/Hca57Y5skFjlt68?=
 =?us-ascii?Q?Zl1sQZWhNHa3JAb8yjj8XFfC/Ya7qMOpk2SlXPRzx8UqcMoTxNn6hTHHvn+y?=
 =?us-ascii?Q?zcKKYI5tg=3D=3D?=
X-Microsoft-Antispam-Message-Info: g4Tx9FFfBNgKbSw7UIP7HLnN8KGe4/D4eAE2feI3HcndFsHN9BcYB2YlmTFs1levwOX0ZpE0DWTyn9EcHhKkAVmmWYd6JSeMu83kiwiZy4FZQlS5mNkHgGIID5XygRHE56BOeg7M60LqrFqdrwQT2ygwXqi2+49xsjDEpXnmJG+OEoNmI0Y/TMQdXRoseKMcNSblOb974kmEOITfAizuHKSUNq3WftD2x0xdtXmXWwjE73ewqrTRfdZSu6iMLNEfeUxO7MgI4lnfmREwXN19nD4p2Y787MIBVI2czgJCmZT0kqnHbRyLAunxFc6CugampjFLXiYkhLxjqxfAftyeAGQZcbMP/MUteUBa1rXKp9w=
X-Microsoft-Exchange-Diagnostics: 1;KAWPR01MB1265;6:yWgtxE5Y3bnoN6Rd/aP8cGpDW27YsJPPTJUHCVhxVmP2juL6wc16JJSys/nAhtl22NFVA2HqmuWUb30AJ+f8EEtN7FEjQ/echA1xV6wbDmJ/AivGmS4uwedutxO+UugyGi5aa4CYEN0cOuV7d0W+wep3yCt5czQ6q4L5atrkzvmPOOcezE3GoGTygtxot+j4+xEdoNHYmDibLMgDhOi0mIRw/hXlxY6Yt0/Ap5TE4lWHxuy7NtExHtB5XHtieVzKtNdVXLgWmGNmfnnqxaFIPa2mmPrmVeYTQGfkSiO6+p2H+nWk/wccAu+FiBXcJ3Ixqy40/BVtbqRBGHCvNVTVUOGys+cnfyVLHZqa3xyTM8klPfWImPfkuP8fVyG8XSDMesqlfjCEVeuZk9t1S82caOBbd5CqS/gwBeHWctU5UHHjOgU3qySlV4Py6CFpOG06dicl6q1CLQt0FqhAnCljjw==;5:6ehk4HcxYCyMg07AvbE68e8o0lE7jOzcu4TOvHazD/trSbdZrymF/wDpzv9rz9eNU0pgxaoFpekDN5Dy7JlDMoQFG4zK+ex6fZOxZqOdFf+KMRcM074XijApckS4kENXmSB9hl2Ul/U94PD8dnLyPKilJVD8WHL+c1qRKVTMrv0=;24:DSfNVzOIcFQQie0OgRaToNTeIcPA/197cl3IvTA/Cp0E/dA73vOR9t1fYDW7mRQ+Up1dmvqeEkOUFtWHlOingPeBXYfpRhUN4RjGpGipQaw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;KAWPR01MB1265;7:CxkviuAdOTM1y/9Adjdps2BAbi0CQNXh766Ghl4wHwU3of3cFPMdwn2CkbcBp7rhe0UFV7wNf3zhmFpuHbhGPM9Wf+GKw8Uw13z22BM6VKYaFv5PerANt15g3ONNfsZRcqJpP8lH+v/9o1K9DPMMqthguRig//ttClQkXDDfq+sl5zJr5O3m6p1AFZ6LD0gfY91RLUH4WpbjlKvnc+jYByrqiWOoQXu/BKnrNAVOcmgRzb1g2R5uoHThj9UwMnv9
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 01:52:35.3121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49581715-7cef-475b-0a05-08d5e607cefd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KAWPR01MB1265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  > >   > I completely acknowledge and support the use case, but your
  > >   > implementation is definitively not the way to go. In my experience the
  > >   > problem is usually that there may be a disagreement on the
  > >   > Pause/Asym_Pause advertisement bits and that alone is responsible for
  > >   > triggering a re-negotiation. Can yo check if that is the case here?
  > > 
  > > Thank you for your support.
  > > 
  > > Concening the problem about PAUSE/Asym_PAUSE advertisement you pointed out,
  > > I could not understand your consideration.
  > > 
  > > Would you tell me more detail about it?
  > 
  > Hi Masahiko
  > 
  > You said that the PHY is being configured 3 times, and might be doing
  > auto-neg three times. Often a phy will not actually perform auto-neg,
  > or do it much faster, if the advertised bits do not change with each
  > re-configuration.
  > 
  > So check how u-boot is configuring what is advertised, and look at
  > what Linux is configuring. In particularly, look at the pause
  > configuration. If pause is configured different in u-boot and Linux,
  > try to make it the same. Things might go faster than.

Thank you.

I'll try to check out u-boot side by mii command and Linux(server)
side by ethtool.

---------------------------------------------------------------------------
Masahiko KIMOTO,Ph.D. / Cybertrust Japan Co., Ltd. 
mail: masahiko.kimoto@cybertrust.co.jp
web: https://www.cybertrust.co.jp/ https://www.miraclelinux.com/
