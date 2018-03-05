Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2487537-1520281525-2-16102542998332882889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520281525; b=sagJKw2PS7k86wTAPUSccSst46wJrJGgT/TautjjN+Q9C63
    qScbSf9DWB6S6SrmYFCNMa7tgno8fFNUhmyVh5WkvrKLXV5aJa3V1YnjVCDg81fx
    h8I8ecke4tO4r5ZmN3ua2pN7VkM0hU3shMStoWYmliytQl2IgFKOVOkZj9bDrvo+
    zXwYBtM2ptdH7gQ3Y3DUbK4Zhq/fUUTiE6aVq6lWlfZqV7Bl/csMX850EZVurBha
    FqjF1eUA1waX5RRsIZBLgC2P4LcF0sWKQa1uWaa/Jjicd9wxyidv7H9VqCUFQtgV
    RmskR8we5/v2laXi0kP/mHiZx+NTyYFFnHj5oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520281525; bh=h3Grdhhe+0TMJpOeWPP+CJsY4jeQZ1s6PJY8OX
    JP9/w=; b=kg1RzWmgkrPqU8XQKnCCnwA8vEb0iJM3GRGurU1gTA7HEW4KYfMNNx
    Fx+K77xy3GBSWB82B79ekcK2PRqTAGEgeRgm8LvQfq0L3VBd17VQGw7xW8swEYo2
    byRjOqyX+k7HChGQVM9Syis7YqSo3SJ5QefYmm6O0DMJr4FFYxQHWeoVpFkyJoAp
    AeTWDshPq27FUbbu05ffEChYH/7z6RXPXe21PN12SoD+rQKtTzM8fGnQ3QxC2jUe
    a3qdRkPHYFWgOGkKi8g8myrbREINGuUsUCRrlBQ+2nCFl6OgMphbmDPmeDL+QJVf
    FUXFs+D1JTGBZQa0QPrdWLShLLy84TuA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CVbJ+ssV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CVbJ+ssV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeCEUZJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:25:09 -0500
Received: from mail-sn1nam02on0104.outbound.protection.outlook.com ([104.47.36.104]:6464
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753168AbeCEUZI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 15:25:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH AUTOSEL for 4.15 026/102] ASoC: fsl_ssi: only enable
 proper channel slots in AC'97 mode
Thread-Topic: [PATCH AUTOSEL for 4.15 026/102] ASoC: fsl_ssi: only enable
 proper channel slots in AC'97 mode
Thread-Index: AQHTsz5iu/nfo/Bw/kGYSI82bRNB66PBcJaAgACpAwA=
Date: Mon, 5 Mar 2018 20:25:05 +0000
Message-ID: <20180305202504.xdotkyvcjsyt7g6n@sasha-lappy>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
 <20180303222318.26006-26-alexander.levin@microsoft.com>
 <20180305102009.GA8588@sirena.org.uk>
In-Reply-To: <20180305102009.GA8588@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:FO3hymZDrhrcME8aiB5A+Ar+Wwz2oYFB5Z13+3o3JrsokQylBC2TTURZdF6cvRlNVNXvwMXFWDQWXck1whHGokAZIcQMGvc/cZ86bi1zdgb+u4+xZOWHG0HC0BXRFyn715ByJdFnSEJ3sIc5Z6hZEDU9w7QUmWfQQ0rKGIYEGhQgdfWHGUcVYs5ewoNsZcl3LfaRS6HMtAB9TF+rBNbUCg/oGhfAq37/axfQ3Q6c0x4mBwH24n5tZKfas79sliST;20:grVHjFRALran6slfHiwk//vH4GbZ7voKELGrX4QUUXZj6AsmU7YhpFVbmBAVOuttvEcPFCiNoq/xJDUZKC1OTCPCpc3n/swrne8E0cz6qc0tlnXLaMuXxsy8RjGsIJs1olxpads3D3Q7qFVrNxPlOJ4XsjsI7vteVSAj68TN3Us=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f5a6adb-5a39-4e86-b2cb-08d582d72f15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603322)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920F00F2330B65A4171724FFBDA0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(346002)(376002)(366004)(396003)(39380400002)(199004)(189003)(33716001)(68736007)(86362001)(105586002)(6512007)(4326008)(10090500001)(14454004)(53936002)(86612001)(9686003)(8936002)(97736004)(106356001)(2906002)(81166006)(3280700002)(3660700001)(22452003)(229853002)(6486002)(6436002)(316002)(6246003)(81156014)(66066001)(8676002)(99286004)(7736002)(5660300001)(72206003)(6916009)(10290500003)(2900100001)(54906003)(25786009)(2950100002)(305945005)(5250100002)(3846002)(6116002)(478600001)(1076002)(6506007)(59450400001)(26005)(102836004)(33896004)(76176011)(186003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ZaTot6O4zRhdqxcYoYFYId5bXtmmh+4595PhfWfgWo6AukKTsatBfw0qwkHrNJki3+8WHS7vGwwSDwrpsxnc/jGzf1wyKAoPGEI4wMfV2/Q856z52PfoAtBfbJMdhHo5wosTxf88P/1Zj0Yswe8HFRhMpoBrantYMl4m/YmVOofWFO46c+Rzr+jI2K8bdPmgqBzagYzTdLcilEV+JMzHGhvjs65IBfPwsWUb8fs0FTyAdH6dbkuxXoCUEPwLa5ZhMOeGS2hMxdRQNfAWXqVkoGSIe0KJLsR9d7wOBIHOGD9v7STDWr+SpzWuJ4FzfHmgQN5PtyDqkwj+QDBhXZsFxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA29C76F77E22C4EBCE28F8FD47A54E3@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5a6adb-5a39-4e86-b2cb-08d582d72f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 20:25:06.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 10:20:09AM +0000, Mark Brown wrote:
>On Sat, Mar 03, 2018 at 10:24:24PM +0000, Sasha Levin wrote:
>
>> We need to make sure that only proper channel slots (in SACCST register)
>> are enabled at playback start time since some AC'97 CODECs (like VT1613 =
on
>> UDOO board) were observed requesting via SLOTREQ spurious ones just afte=
r
>> an AC'97 link is started but before the CODEC is configured by its drive=
r.
>
>This was part of a wider AC'97 rework IIRC and I'm very suspicious of
>backporting it independently.

I'll drop it. Thank you!

--=20

Thanks,
Sasha=
