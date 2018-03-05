Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2498535-1520280611-2-8962486580887521518
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
    t=1520280611; b=bsqIeRM8CkXAwbQJ//uw28aJ2eO2oDGa/EJdFiAnc3aufOj
    sSRjjCtAMXxhXeYdcTl1XdE6FReDs//QzjebMXkrOCgs9qTwRxv8fJs2KlFZ7zWg
    7/ul7pTSY+gS4Vc3yQd1d0NteVyMyCoCrCS1Erf/s+zI1Zjan7cqUB2IzZLR2UAe
    tWkHKx/qdM00ko696/0OCYkKt277pO6vd++gjVStQOB5pD5a89HVMfIBRmjmYwfV
    G0Ef5YrVRdyBzT1tXrXLyAp7BMP+Bqs6QcgLlZw3itbsJjwcsIMtbTmtr6+MF4Fx
    npvp2qE9QHKF7paKcfXeuQey3ayeLWwTjl/5OCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520280611; bh=10jO3OsGJlryjoDKIw+agVbpwc38QJzfp+Mp5U
    E7hNo=; b=a3+vEu0FPc0YhMplSXZfp3i4R3AmUT908smvVGuZgxu51OOQV17/dS
    2cZBt/UCNw8pMI22hg63G7kR4ll6WBQRJ8pQ4XJNfoe9OideGWu9dHnr6y6ANQco
    RoXPcs/zXcREZKw5/0/q8qbMn83JunN2BYt8TD03oBBQWoWgKN7iAmYgHbeKFrXH
    jTrAZrnBmNpSwIPJ+wh+2SiRtRPU7RCQHtbEr+Tn3E8A4pcZTBaYv52i67uohr6M
    0f6wd0dP01+s2kPxX2Lkg0iSSr7lyM2catmkvlg0wqAWzS6gdQVyDud9DUV+4Gun
    8gJ4LoLwM22DPT+zlFkDG47JqBe8T9Zg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iBXwsSHS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iBXwsSHS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbeCEUKJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:10:09 -0500
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:44876
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752321AbeCEUKI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 15:10:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH AUTOSEL for 4.9 111/219] ASoc: rt5645: Add OF device ID
 table
Thread-Topic: [PATCH AUTOSEL for 4.9 111/219] ASoc: rt5645: Add OF device ID
 table
Thread-Index: AQHTsz8G3m7zhT9nPUWUywJnKNOuCKPBdrOAgACeiIA=
Date: Mon, 5 Mar 2018 20:09:29 +0000
Message-ID: <20180305200927.rdn35ktxxsnx2hu2@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-111-alexander.levin@microsoft.com>
 <20180305104203.GD8588@sirena.org.uk>
In-Reply-To: <20180305104203.GD8588@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:5fRZTmORWW770FsrUTphprdXTFH/ECB6j7EE4U1pPB8+juHk3+bwg40E2IkCkVwlFKUhrvKUksaGswRVl/GlZQDYn05Q48F9rKoaPFO0Cc8YYpw2LEExUYTQ9K/ao8/E7fASXb9c3wqLtJNV//L+a1XDInD3bZNzm8HYQplYDaCAtmRJfyQ8Lqb8LAYLYp1ptCO1ft7+e6LynvCvu7FqMvx2Cw7twR2Xxtln2De79CXW2c7vvaFnamUqXdYOhmPd;20:hcpEPeTFcx7AqbZxkNivDfsPR0+YyzxHeDiLoaebmVVIeUxmLoPbn4BcFNoLCE/Eu+2MeM0kq/VVBEBNWxTHiTc7+sGZKK6Domm3tCKAhIcad50uG0TQarTHwaY9cUyqjaySvBqT9OtLY+Rb5AvXbPvMfDaRWg+cJBKBB7aTiuc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 884c0868-bb0c-4f95-7113-08d582d500a4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603322)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047193A05D0755D704A4B53FBDA0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(346002)(396003)(376002)(39380400002)(366004)(189003)(199004)(81166006)(86612001)(86362001)(53936002)(6246003)(4326008)(8936002)(72206003)(10090500001)(14454004)(33716001)(1076002)(2900100001)(229853002)(6436002)(9686003)(66066001)(68736007)(6512007)(81156014)(8676002)(6486002)(76176011)(99286004)(25786009)(6116002)(54906003)(5250100002)(3846002)(6916009)(305945005)(2950100002)(316002)(105586002)(26005)(6506007)(33896004)(2906002)(97736004)(3280700002)(5660300001)(10290500003)(7736002)(106356001)(186003)(102836004)(478600001)(3660700001)(22452003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Qb4uQD7ASu/Yx8Wjpg87XreAu7gvI2N4RsETb6P/c0HGAbm06dq5D0qpyUPMiKPl5HKUDD1riuUGNNWbQHElHoN0DTNu5jD6akTB2uVcMaed8+JcNzSw32ojPXnRvJpmAMbmjtvqTb+DSeBGw0e9/lmgTEn8TX6zwDSSLpTVcNDQpA/vMs6x/oqW4T/OTBTVFnZAQ3aIm3byIPdi083/SSyqJmorH7+w0/ZXRBqyp8dm4K82andMmKjt8xw+aqQ/osLa6LZhqYUavkiDe83PTPe0PsNoCPYwHnLH+JfTx30Tzn6Shtn54p2QK1SdTfN0ua1eCbrhZMcjKD4wGS8FcQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59F2CE3CB0A6DD44A4EBB79FD99F9934@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884c0868-bb0c-4f95-7113-08d582d500a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 20:09:29.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 10:42:03AM +0000, Mark Brown wrote:
>On Sat, Mar 03, 2018 at 10:29:00PM +0000, Sasha Levin wrote:
>> From: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> [ Upstream commit 9ba2da5f5d18daaa365ab5426b05e16f1d114786 ]
>>
>> The driver doesn't have a struct of_device_id table but supported device=
s
>> are registered via Device Trees. This is working on the assumption that =
a
>> I2C device registered via OF will always match a legacy I2C device ID an=
d
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have a=
n
>> OF device ID table if the devices are registered via OF.
>
>As the commit message itself says this is not fixing anything, it's
>defence against future changes.

I was under the impression that this refers to future HW changes rather
than code, I'll drop all 3. Thanks!

--=20

Thanks,
Sasha=
