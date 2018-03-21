Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-692439-1521662307-2-5594223656758622774
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521662306; b=L4e306Mqg2JEWSEvb3Bu8PSZKuvXZHft7pb6GLFWyjSPqQQ
    OHf8482S1cRxZX0tCXncZUlcl2IawFTyTzyQKVMqTjXB0AnoXmsDEU9VfJrnbRkS
    xAPkxEcOMlPADklpRy3Zi6MIcHqOntRQ0IqdJLg/Qy5N/4PF1orU8T6IZ/oHoL+c
    qvsY37sq+oH8gs0/NK9mAjp7/TByl9KReG5o3ism/NWbi9O9S96V4eI75JYTe9Fs
    BjYDLF4HA0J48ZW4tkapH2GVEgBddw6DBfqPAHzUX+UuB631VZgOfiJ2yULo3MTM
    ohr7RRDHTcpXq4CVRaYNm+etn4aqYRF1Zq8GYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521662306; bh=pOi6G4XGGH9/wifcR0P55bvSoXc2fR/O0mUTyD
    fluJg=; b=eBqJRpTYuNibbn9ryUxx2iZ6OvooLAtnsG3YgVDlcRqRnWvOKpam0H
    8iZgg4h9SKm3JDmmAToyjMQ7AoH/ESLK0LLB9SE+MKIivXy4xP6EvoyP7eJHBCvM
    HV1BLD21YGyO2z+JvN6QkgCAuD8H3xy/IHZZp5YkdFt8pFM0viB3BGn/RELa4Mtv
    DJNW9DelZwNqJBRDSVQml1Hv/QSREhK1zWieB569hlwu4XL169MdhM4G68gbhz7u
    8JgtLAv1Y3kzPHMFmb5bsmkiRVF7A67U/aQOLtYvzn3d34r4VgdCIkiWDQ3wXm1p
    JzpXlwBsuQueVbkt5h3E1zegU/8aI/uA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k1qpKTp+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k1qpKTp+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeCUT6Y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 15:58:24 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:53573
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753021AbeCUT6W (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 15:58:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a
 conflict with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5nU1jM4TEEmbE2qukzwpEcuiqPZPv1OgAHD5ACAABmwC4AAAiQA
Date: Wed, 21 Mar 2018 19:58:20 +0000
Message-ID: <20180321195818.5uoptnf37mak3iq6@sasha-lappy>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-118-alexander.levin@microsoft.com>
 <87zi327ozu.fsf@xmission.com> <20180321181842.rhniantbvz25bu2f@sasha-lappy>
 <87370txl8a.fsf@xmission.com>
In-Reply-To: <87370txl8a.fsf@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:/UD0bTLYpUjj7z/BTzPv3evis2PzeFKjDDbp7AW4vmCOdYrmR1VtxiBBpjLY632jv91WKpo3x8cX90WrjU8BoAw4514lXDCvRvGnj78cXCcKLqgVmI3phOumHQYggwTtpr8Nkjz/bqLUwmtDQwBA37TqbtiA+l6Q1Kb5cpMUnvR8G6hPw/ltmBpKKz0cTtyPs/vzU1r2+WR+FftuSzDH0uuko3HRBpnLMlSmiiDs4t88mLU9gAcPt2aT40ReJDfe;20:VQwtM+izKbK2j9CQflYKv7yfN5vLYPxyyEtaWiNtbYKsc0yBQv4SLqVwtEG7TOCnE6CQyjLZH1seUPkz4K/lAHGS+2o0UW+RYKMaVTM/lWfWY9V2v7oe/7a6nX8Re0M6uB0SSZR7/jranX/3aKgJ9unMd29AJWNW+UFLH+uPSKI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2f5dffe-07eb-43cf-2935-08d58f6618b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091702F11FEC6AE8A818C965FBAA0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501316)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(478600001)(22452003)(229853002)(316002)(1076002)(72206003)(106356001)(10090500001)(14454004)(2950100002)(5250100002)(6916009)(2906002)(6116002)(3846002)(54906003)(86362001)(10290500003)(93886005)(3280700002)(8936002)(8676002)(2900100001)(3660700001)(33716001)(305945005)(7736002)(53936002)(4326008)(6246003)(6436002)(66066001)(6512007)(9686003)(6486002)(5660300001)(8666007)(97736004)(33896004)(59450400001)(76176011)(86612001)(99286004)(105586002)(81166006)(6506007)(186003)(68736007)(26005)(81156014)(102836004)(25786009)(446003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ifoY/LpSZBTn/w5oZJNa5gkBinoRez+4JDO8ylR1rakFd6mhxCLyTAwDCgtU6qJ42fjBVUoTKkzM5DQ8jEp5Z0biQ4y4veNVWOLww0eJ/jnbgTrOdtO9MhK+yiFx/coUHegs076hmzc/9NYg8PfEhc8IzCiT/VU2zk2NJMKa51Ezj6pMFfixf8jui3vzgXqgkECwXrZVt4+RqqiFSCGZ77figs5d4wYbNw7EAB0xnrQY2rawFF8mbk6Wk3TLxchhTxfvvUAReQKrOnt11yI59lA3+qWLc2ZB2rEQlPs8mjJQJe4yCqaixQcZoVzxl/cDgXXBIvqzeGpmTnyRdpX5zw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4D1328343F2C5438B8D95E39933A8B7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f5dffe-07eb-43cf-2935-08d58f6618b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 19:58:20.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 02:49:25PM -0500, Eric W. Biederman wrote:
>Sasha Levin <Alexander.Levin@microsoft.com> writes:
>
>> Hey Eric,
>>
>> On Tue, Mar 20, 2018 at 10:20:21AM -0500, Eric W. Biederman wrote:
>>>Sasha Levin <Alexander.Levin@microsoft.com> writes:
>>>
>>>What is the justification for backporting this and the other similar
>>>Documentation commits?
>>
>> It was flagged as a bug fixing patch by a new process we're testing, and
>> when I looked at it I thought that the commit message suggests it fixes
>> an ABI issue.
>
>Unfortunately they just reveal an ABI issue.  I believe there are some
>fixes coming but given that the issues are a decade old in many cases
>actually fixing these things must be approach with care so as not to
>create regressions.

I've removed these commits.

>>>These commits just introduce a define _FIXME with value of 0, to
>>>document that the userspace ABI was handled incorrectly long ago.
>>>
>>>These commits do not fix anything.  Thes commits do not change anything
>>>except a little how they are handled in siginfo_layout.  And I don't see
>>>the changes that introduce siginfo_layout in kernel/signal.c being
>>>backported.
>>>
>>>Further these commits don't even have a fixes tag so I am curious
>>>what is triggering them for backport.
>>
>> We're testing out a new mechanism where we train a neural network to
>> detect bug fixing patches and flag them for manual review. We're working
>> on a FAQ + more detailed information right now.
>
>The neural network did seem to pick up on something that is worth
>looking at.

Indeed, and we use review input to retrain the NN on these commits.
Thank you!

--=20

Thanks,
Sasha=
