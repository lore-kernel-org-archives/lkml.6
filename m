Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77473C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BD92075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hC5QgRG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BD92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIGFBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:01:20 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:31072
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbeIGFBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WiJweBUesI/Am+LryzJOceotFpM7lrFMgC22JziyCM=;
 b=hC5QgRG+F3lugMoRvPLhmpanZqivac7Du8EtKtEREOLh1PuxKA1a3vdJvI6wOYzzPhdAHAsOFSP+W684EcKtFbe7G837zO4Yp1BRv9t5dFEd9Ao/B/0eCIitJRCdmgz6zDO+MNAnnaxj3o1W6x1iO9vXhCLXoEaSad937t75j7A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:23:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:23:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [PATCH AUTOSEL 4.18 043/131] ASoC: soc-pcm: Use delay set in
 component pointer function
Thread-Topic: [PATCH AUTOSEL 4.18 043/131] ASoC: soc-pcm: Use delay set in
 component pointer function
Thread-Index: AQHUQr1niRue9d/Q7kWN0UvpHCdMtaTeaaAAgAWS0oA=
Date:   Fri, 7 Sep 2018 00:23:14 +0000
Message-ID: <20180907002313.GB16300@sasha-vm>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
 <20180902064601.183036-43-alexander.levin@microsoft.com>
 <20180903111626.GC10302@sirena.org.uk>
In-Reply-To: <20180903111626.GC10302@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:TB5T+uBkpCsWdlIXAgclQs8047Wps+666JY4aTs3D+yh8KI88m7EmIWL8sASsN0qwszK6gWUyuS9gk4uU+Yy7d5ENo8lcNMYVeBklUyZCtrMNovYznKY1za1pE0zEA/9lV4WxhgKRen4WQBwrOQLyB2nyB1wZ0vWwASHaTVmGtcT7ngQNcoS0DVaQY5pkOeaH79QD5e5K+yGx6tic6Bz3p2+FlGoX47A98OmNmT0GAkrmpxzg8pTQi6NL3s5fMi7yCTa9sBaSf0owb7mlw5IpFbzGqVJmmOhwja24kH7UdA4KPyDUsfGb30btJ40Ufoq9Ph3niaEW34nt1qzY3EthebWWKXShHDWpMRa+i346bDrLxOU3Ic74mWMMD0NKWFCcyFEIGe1HhBkfP74Uh3wg5ZR9L/rhMrBGlnhIo222RLxk5KpRc8c6AQCGgQ3PhsboUIzus3UMkgUkUlGXjnq+w==;5:Dedrxz+2Dt0Ibwr8yoxQKGjr9Q9ioqCQAOo2LJ57I3RVC4V+Bk3TwqjOq3tXn0pKc93xniBEGpK4Eo60mhWXv/8H0sne/ibGbea6pLLGhT1E11pBMvfFbAeoKOBkhQnCDHoQFvXagDgO8txZNpQPIYOyGtEnVoO/8zX878MAQ+0=;7:pSP+YO/3B8aTdYUJ7IYxjdQGnOyyoydx3LEHyUOCNVk5ufPyuR+A07uS9TYfTwqVhiS72PZnFHZxA5E+bxi1bWMPzXEz3N57lngHunQOCvWP2oqmBoe1rVhSniKP8ExlGQVzWoXypcMkAOKuN5BhwQ5sxHgJG5ofKDJvNvs9ECJQGaI+pRPfx9ECzI64JmSJmWgkdn5XxVSkOKsWv96uOhYRBjEsoyMZoUyo5QnmyU+6uD7bgmbdhyoWgOqRGU4Y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d3a67512-b9b2-4a8d-9745-08d614581a2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821279D1C5ACC373D9B5988FB000@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(33896004)(105586002)(476003)(486006)(11346002)(76176011)(446003)(2900100001)(6916009)(256004)(14444005)(217873002)(66066001)(22452003)(86362001)(1076002)(6506007)(316002)(6346003)(25786009)(4326008)(102836004)(26005)(54906003)(86612001)(6246003)(3846002)(6116002)(5660300001)(229853002)(6486002)(5250100002)(14454004)(6436002)(7736002)(8936002)(68736007)(33656002)(53936002)(97736004)(10090500001)(6512007)(9686003)(33716001)(478600001)(99286004)(305945005)(106356001)(186003)(81156014)(2906002)(8676002)(81166006)(10290500003)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6Ribk7ZnfyeNUmlSSTg+HVUOD68FmmccXBMgiEpnqUeGbzokspOsLqNy0jDJ/lB3RGY/NrTCFYw3zoO6iHG/FIp9/89PtdRCkcjlZnzDGthdhctGBstXoN54lGcFRNk46XD0kU6CMx03HmU4YJC23/lWNO54gLJmZ4PNwCISqsTDeYCghStGDaToM+CUeEyQm3/ZT3z2Oo2Gh0fuHMfMQtJEWC8zvu59uYeZa4+drvoIEY5hXwpWbsD7GJv5fHd1K2HOnHcTaezQ7YjUkgBOg+bimWuhCaW3Z2NBZCS/Xiqcy63K7XUpOGCmyb9SsXeAZiGtQIa8U/Dr6eDvDYIfFLkB92k6mF1dZOX96lwi5LM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <570785E896CC5A429FB621208C7C9C14@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a67512-b9b2-4a8d-9745-08d614581a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:23:14.6420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 12:16:26PM +0100, Mark Brown wrote:
>On Sun, Sep 02, 2018 at 01:03:55PM +0000, Sasha Levin wrote:
>> From: Akshu Agrawal <akshu.agrawal@amd.com>
>>
>> [ Upstream commit 9fb4c2bf130b922c77c16a8368732699799c40de ]
>>
>> Take into account the base delay set in pointer callback.
>>
>> There are cases where a pointer function populates
>> runtime->delay, such as:
>> ./sound/pci/hda/hda_controller.c
>> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
>
>I'm worried that if anyone notices this at all they will have already
>compensated for the delays in userspace and therefore this will cause
>them to see problems as they get double compenstation for delays.

But what happens when they update to a newer Stable? They're going to
hit that issue anyways.=
