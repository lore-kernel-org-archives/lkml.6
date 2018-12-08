Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F8C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A3920868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FzsVGXZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A3920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLHB7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 20:59:05 -0500
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:16031
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbeLHB7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 20:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGMZDT4aOrACbYjWDVj07mS/q1kyImcXl5MBesZnePY=;
 b=FzsVGXZNZuiP5f41AanZJ/1A/gL59xamYcaLe73tJwfG7qa2vlGT8xqi+wD6i1UThiWorMc/3r+JutS2Ss6Ebipeoe0EqkV73gp/wgZx4cTks72WudVu61LTlqxVP0RfAmVH+OW8qfh4ii078AYiDVE5nl93pftG6+9wcwI+BDw=
Received: from DB7PR04MB4252.eurprd04.prod.outlook.com (52.135.131.26) by
 DB7PR04MB4089.eurprd04.prod.outlook.com (52.135.130.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Sat, 8 Dec 2018 01:59:01 +0000
Received: from DB7PR04MB4252.eurprd04.prod.outlook.com
 ([fe80::2814:5f8d:d96f:4e40]) by DB7PR04MB4252.eurprd04.prod.outlook.com
 ([fe80::2814:5f8d:d96f:4e40%3]) with mapi id 15.20.1404.021; Sat, 8 Dec 2018
 01:59:01 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Query about platform device registration
Thread-Topic: Query about platform device registration
Thread-Index: AdSOmIoeMEZETCQHQA6rb4wNZiV0IA==
Date:   Sat, 8 Dec 2018 01:59:01 +0000
Message-ID: <DB7PR04MB4252B09A076AD1A52BC3E92E8BAB0@DB7PR04MB4252.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
x-originating-ip: [150.129.122.229]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4089;6:Hv1zdvBwdchA9dvb8W5ApLKzWRWMf1BMF0oNNTjo9ErwzRboHzOay2I1HPpd0fUf6SX1m5HIMW6kVtfea9NUvn3aG51Xq2DjUVFRgWLAceS4jNxqCLYrqIhLn+e2JRz+YwAgQX3sgzoD/LZ7x8vcxrHhXlybr0oRHORe165DKJZ/LmiztIc8u6UgqRzB0G6QlAmPi5C0tMyJ9eVl7YIkNGLiSdKKcSNqcNLFY8oTwSDdmiLJhCYszvPC5FlheII1GtGL6SPf83GTG5zZ38EnJEVsbJwHlxpnh7g2cTL581OUAtmIqy2rBOXijnvX/EXS+7SAmJ0XMZ/10isOYdot/trpt7tTF42pBXPsz+g6F8jUdB8W3O7YJX1rUSgtgxrmsmshgc7u7yX+lEk3Wl2uBrzXINa/YWGosbET71Qu+10BpKoJi+usLzyHDALjbLzUdv9AfS92KXsPb8uJnJH+PQ==;5:k9f0NP8yZvl9RcXoSoj6o7uEv0PsKBsW+Syf42tAELlzX1ryUE0zKS9M/ElDHhz5nmHEHnChBPxy41VDPr9vhPXo4cZ4cbSeGONhL3vrU5XUttomlYL1ha+io6VEX02j1vds8IyE2ZOLoXdnCrIilWfeUH3Iskw0vircE/549QY=;7:N6Fxz+z5itJuBavqm8ay7qPu8ORquv9hVZi6GbRazL3MONBb/VbJAhJigYUTt4cxexBzmNxdOw3FfxsIfdO1UOPlmsq8YxLu/d5JaqKy35GeaU839hAPFdlM4i/dkYvR92nFYWfxCSPE/vW/L/WY4w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b60b5779-d8a3-4db2-9e8f-08d65cb0b989
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4089;
x-ms-traffictypediagnostic: DB7PR04MB4089:
x-microsoft-antispam-prvs: <DB7PR04MB40898EA6BF994463C7C6AC698BAB0@DB7PR04MB4089.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4089;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4089;
x-forefront-prvs: 0880FB6EC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(2906002)(53936002)(68736007)(6116002)(3846002)(66066001)(25786009)(33656002)(14454004)(478600001)(44832011)(476003)(486006)(55016002)(9686003)(81166006)(81156014)(8936002)(8676002)(71200400001)(71190400001)(5660300001)(6916009)(256004)(97736004)(7736002)(6436002)(186003)(7696005)(6506007)(305945005)(74316002)(99286004)(86362001)(105586002)(26005)(102836004)(106356001)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4089;H:DB7PR04MB4252.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mF55g7FKj+Q5429+jCmVLHcD5F3kAOfSG2tjwE998YW0iR5ynaJbIeNUXPmhPepC/NTD9WVOgjzwcklBGQ7bNVqeroOQTvfEa3N9rwyBlwWqeZ2d/0aiPOSPJc3TB1F9PSniz9dZHvpmO1bCAnVyQDTbsXQnmc7p/nFzA9/VWQxnLp+3gtfLa1MgXcX+4k+Dzj+Qbm9aLoEV110jU4/XuIH5NZw0gx2uuZj/6ggSUpln+a6d8l8vfZcR1EX4yJzgpJrYkzqrvKW9HRP8mKKPZtPKQJbwkHvVHZPQM7sdzSYc5azgFOkritOYzGzYXh9IoYb/Dq94gF21YWsqwrFRsguEFMrsPlIGoz34GXS2938=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b5779-d8a3-4db2-9e8f-08d65cb0b989
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2018 01:59:01.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am registering a device using platform_device_register_full().
In the above-mentioned api argument - 'struct platform_device_info', I set =
the parent device pointer, set_dma_mask from parent device etc.

The parent device is created by declaration in device tree and the relevant=
 node has property 'dma-coherent'.
So I get dma_coherent attribute as 1 for the parent device. In other words,=
 is_dev_dma_coherent() returns 1 for parent device.

But for the device registered using platform_device_register_full(), the dm=
a_coherent is not set and is_dev_dma_coherent() returns 0.

Can someone please guide me, how to declare the newly registered device as =
'dma_coherent'.

Regards

Vakul
