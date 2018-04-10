Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523368171-2-13207879194065080805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523368170; b=G2AmnKdh69kKXnPFTNraCeeQMklHcbMKrw1btDd2L6gBLHtNSt
    HbOBYa5h6PyKcHeXwezJb3PqemTsqt48FatEsoxStFP9KXCUP56G+JJCdqiQRUHO
    PygoN2MB+4nMgycuxCg9s2cUAeZsleJX0Z1Bx0ELuCxO7VV/unWrWSN/MZIs5Huv
    o12yD60Wto1xUwpdZ34tfefxzL6bSOnC1byQpgusJI20ksXnAU0SLTTDansD5yPO
    Wzg32zWjuOeU9tOfS9dgqCSi+cvKF8AtZ4q+mgDRfWs2AOTUZntPVqXTVuLor1Rg
    agmrNi8nRZgD6MW1j73z4Nmi7daGTbJ0Z9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368170; bh=LdrsEoBJYx
    6LN+2Ng3Ik3tzx20DfZnvWjeKWEcSeZd4=; b=Ar20L/nNkXHIg1KvB3mSnYhLRT
    4q5iIB3bcNt7lfouBBJL/1IV7l1KyvBxeDo19NsVbBd1HmH8ah4ffWensXIjmOOX
    V5ARA9GOub3YiF2dZHPU/Zujf3M9M594y4D5i509kThUFEGdrt38tFhDcx+O/iM2
    HHogRpA7xChhFbO/YUUy4daPFlXrRb0p18XMx7KH6MZD80c7yM1XMtBd9RXzf/88
    6zvUHJw+Eh+H4rvS9uWTcAPMIENhsylDeKSMSkin24o5B/USdUH7D0ElcT7/iGZ/
    LFH6dfEDtcZMZIr0TUuo+MtQRhD4I0VWnLeBk8Vw5o9Igrt0roJ/h8SxkUbA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ww+JNXrp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ww+JNXrp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI7boizNRuvC0E2hq8ocl5V/T7QEJ6FYZwBon1GXWKG4lB9xCYOHgjcr8XIZPZv7WCxfNaJi5JEHUZItdKSU1zqq/gaOjE5ZPWKTcZFy4IXwdsVhYqUn
    snPSWpEK/cF27/XR/jfB2jKQRXvt3XSJDF+hwIS9xBUNAZOhn4NX+EyzVq9aqMn8RKenT6WiPDuTwmaJggchtztjNv+mYGf1eJC60Fft/5ANsKC5sIC8XB/O
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=BHzdoRfpx9IA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CpHha7ENs2o_djBeLkYA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeDJNt1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:49:27 -0400
Received: from mail-cys01nam02on0129.outbound.protection.outlook.com ([104.47.37.129]:8593
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753710AbeDJNtZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:49:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Thread-Topic: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Thread-Index: AQHT0NK74RFYa4tLfUCn3C7f7PXYhg==
Date: Tue, 10 Apr 2018 13:49:22 +0000
Message-ID: <DM5PR2101MB10325D85829E62CD43128227FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
In-Reply-To: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:fpUdcI5s9gSd8ikgtPOLG98C3F838GRFo+dyFBOaoLbCspkoSfsEkV43XpxLzjcaQweTv35FAol4MmtvK9BYCnHfxqzBQABHGVmJv7+ZZF6/VpOoL7v/v8mMc+oNGpSgMpKrn965e+FQvZ6qyY1OA17SCF3Nig8iZh4AL9ygUVzQ3EALvZ0GkZeunFMVdY6VG6+4+0bYfW6VrouUF14bkoKtTnqeClyyTODe1P3obgA6vqWbu90f0sQIW/bkJy9Y;20:pRyiY/Ms/6b/ZrmU329Ae7AlXEfmaQXGs7195vbImZnRr0KtH/v1+Tnt3D0vFekfR3HmMCP65ModfBgvdUlDLYWHDNfokkfN+lbMEMv3SrDfPOU/nIQH+V9xXUqc7bPVG5ywPDDELpkhu5hRPCEZ5gQ7BTg8L496qD/+Krs/yRI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077F584AF1293DCDEC2A43DFBBE0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(39380400002)(189003)(199004)(6436002)(33656002)(97736004)(68736007)(22452003)(316002)(86612001)(106356001)(86362001)(76176011)(7696005)(6246003)(66066001)(25786009)(9686003)(1511001)(26005)(99286004)(10290500003)(2900100001)(72206003)(53936002)(3280700002)(55016002)(478600001)(105586002)(8676002)(3660700001)(6506007)(102836004)(54906003)(476003)(11346002)(2501003)(5660300001)(8936002)(486006)(3846002)(446003)(74316002)(81156014)(81166006)(305945005)(59450400001)(10090500001)(5250100002)(6116002)(110136005)(14454004)(2906002)(229853002)(8990500004)(4326008)(7736002)(40753002)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: KerhLb7W4Vih805zVNIZcstXLc7lFv+sHrJZl8pF0t9pumiO8UPr2x2p+cqUhFkQX770hcu5jR07lJlxYHbssCMafo//wCoZZhn6zVHH7/6AWTFsLHBHOrGae/pXaz39TYyrHh1VVJslOgMsUS/9TizohLUb1OVAUAyC/LPCjz4L3KCsbaJW0es74zrzbrRYlDj/yXnXLIZ5FURXX/p6raa+yb9L0qbrK4cVD2Oux6TtYqnqP2TAEVrVLbB8Qj6CYFTaAmX2RejDP+RGI8pJGNlh5FbjgkjCrTZXJuZEDHBKCNJZit8e4onbGGXTdzqxKgCU3KcvA0Dpoy07G6SNGht46IJCwCzKp99k+NSM+CjUVB5B9vGqDJ6PbddXUnf90tqt1Tgqz5HXueWLSqhp+1y6oVZaw7RJrZ3bqM/EDK4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a4bc6204-63be-423b-2ef8-08d59ee9ddc2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bc6204-63be-423b-2ef8-08d59ee9ddc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:49:22.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 32.4825)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.9=
3, v4.4.127.

v4.16.1: Failed to apply! Possible dependencies:
    Unable to calculate

v4.15.16: Failed to apply! Possible dependencies:
    Unable to calculate

v4.14.33: Failed to apply! Possible dependencies:
    Unable to calculate

v4.9.93: Failed to apply! Possible dependencies:
    Unable to calculate

v4.4.127: Failed to apply! Possible dependencies:
    1c4941fd53af ("locking/pvqspinlock: Allow limited lock stealing")
    1f03e8d29192 ("locking/barriers: Replace smp_cond_acquire() with smp_co=
nd_load_acquire()")
    64d816cba06c ("locking/qspinlock: Use _acquire/_release() versions of c=
mpxchg() & xchg()")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks,
Sasha=
