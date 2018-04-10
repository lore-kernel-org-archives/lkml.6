Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3968727-1523368191-2-6815758665776025870
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523368191; b=I994L84GNXkzZhRY6iuuFVSKgAomeGlx0poCbugX2SOvvz9rHp
    QDHp1Y0eRjIuRHJklgiyq8LVs1kA1PNYoAsSlek6HwLLBlX3XSBOe0vUviu0kKp2
    gYhkKl+DoNAo1V17UgN0RmMDNmQNT3c6C39TVYKAyjquEHVJOxAcRXT2QBnJrEx5
    32N6oWHuPPglLVyzO1paTjmRXPjgiHqMwHP3E0rl+DawcF39G9aQeLBIyf+C/x1i
    hCnYiF4SCvODE9Qmz9Tnq6QVa/FQsxo9b8AIi3/wFfKnzUFyBSZ4cF6n3mfNH4d6
    DwXI35zGCcCrcn8OQa2388cU9BwjMCvGFL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523368191; bh=qDuoS
    Akc02MOwYd7ErIe0EighoZcXnqO1I0j/bbdn8c=; b=khc+zsN3FVe/+GBr/eFpx
    f7VGJq0VBoatq1kMxg2vCy2lbXr7dZ4vfXfq9HGkPR+5Nu72Witw+VPxvZfa0ncj
    xo/4SChuoOu3a/I431M8QjvFMmh76gX0QJp654ROp3ePXdcwC0A39xf3UhcVEI8f
    nkCA5K8bR/eOTQLmZdlCRbbIAAmoadEeTLelZF3r8rWgGhjyrTGrwa+1CFCeumtC
    RzpC3V5eC0aIvblKzckRlWqG6FgVkXvaCEvtE4gqJv44BZmCDak+spRXq9OhyWSz
    kzkx/Cw+0v5PQF8MujqFG7BOTlFht8yrmoI+HmAh4gEdcUes4S1Es+zdY4lk65sE
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VH3HdXRL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VH3HdXRL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPzEM3kBq/14v+0eL15nLNg9mVxhM2L7FX3KdfdrSigLZ5FrcxBpkpehwnHOEd27sSIsSEV/sULjy1G/KL7CDluGX+F++GHSTG1AyhonkXO8ocjUIo5e
    XBW+Ern+Nq9IfX06C8o1caPwmt4WCKqyo/0L7pr9SgeFZrtLQfkvjQNzxuIpVAZiAt/ztEBvKyisqhR8t1VDkAmAVQOdLMuPJEqsBVNFwgv/5Fi55c/PhU60
    fzzs3W5/4WHAMkaNKMdkcA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=1kne1Cjz6cMA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=8KKHSzXXBAFzjPyim-QA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>, Mohammed Gamal
 <mgamal@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH 2/4] hv_netvsc: Split netvsc_revoke_buf() and
 netvsc_teardown_gpadl()
Thread-Topic: [PATCH 2/4] hv_netvsc: Split netvsc_revoke_buf() and
 netvsc_teardown_gpadl()
Thread-Index: AQHT0NLE3rPpnc86ZE+1LR3nJ1J69Q==
Date: Tue, 10 Apr 2018 13:49:38 +0000
Message-ID: <DM5PR2101MB103266B682025C4B7A8ECB3EFBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <1522955361-14704-3-git-send-email-mgamal@redhat.com>
In-Reply-To: <1522955361-14704-3-git-send-email-mgamal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB0872;
 7:Z/g/r6IRdaFjxiLkLDg3DnUYTR5pXF6Y8R2OTAexLWBqiYgQFdOn7wkk5qy9luVRP9fpTgL/lzEW9ply1XLLVoFLK0FKcV5HUsMYXisPMrmVBMzwYT2NALwuzOzW27u7Z6s4kl/xILR6LKMdETfI5Tajh4TM3lBp4R+HwwNLNXeAUDQJv+/tsG6NA+EECOe833nrQajSwlvTvLvLBu56vAEpWCDHbyNhlsyoINJATHPMFN+m6hV8fM5kv/bkNNDH;
 20:ZfSFurwhTEI2tk5yFRsPDw01zvJVklUDxcAa3QQlaBD/KXCy3Vv4NlBbRIxgFHKeDyq7TXSyEtSvIEsAZib1uzoh2RcCo43wdm6/0f2CSArfscKiRbGiJl6mLYkbvKGNT5y6sLDapfU6xPOYG8XvvLrs4yOge19w30mzmuuXOIM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0872E89996AD98D83C6DAC78FBBE0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB0872; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB0872;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(10090500001)(6436002)(316002)(53936002)(6246003)(105586002)(8676002)(3846002)(6116002)(3660700001)(2906002)(3280700002)(81166006)(55016002)(81156014)(8936002)(9686003)(575784001)(486006)(1511001)(66066001)(97736004)(86362001)(86612001)(446003)(11346002)(476003)(8990500004)(68736007)(22452003)(102836004)(26005)(6506007)(76176011)(7696005)(33656002)(59450400001)(99286004)(478600001)(72206003)(2900100001)(305945005)(7736002)(14454004)(74316002)(229853002)(5250100002)(6636002)(2501003)(4326008)(106356001)(110136005)(54906003)(10290500003)(25786009)(5660300001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB0872;
 H:DM5PR2101MB1032.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
x-microsoft-antispam-message-info: I+FMRCMIC6QWHXxUMlik08PYLNo6byJpFJQfVvrr7pWw90IqCfFnz5JrHdbXV0oPn38iCm+sXjaQjbSs0QR0sQeG00XuT7of/2ZQwyu0Ri8gceUf/3ZnOnRPXrpyUoOnIdh8/TdHpPAOEE0dm7OVCQUTdixDXjR617kWinpBQas76O4drxRmPy8WQFONpbPCGNgJS/YxQzn4gjFbEBOYAsC6iKXthgkPu7pMVHmzQ169FgUK/U696nV/8H+BxiO6ZUTCE+8kO1indvx5juM+Wtlbwwr43F+fU7JhVF4xCxfA9rqLFQYq9sO0ZH4UI2d2LK83qdvNyljRA+crXiN6dsvEcNi3dI2Si7R2Ue6a74vlkCKMBdBrIQEktjAMVlSoL3ZPXs318E2Qw8FU1AAu2yhpMIJidRHVlFlKOE3VaLs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a40ae6f5-e0be-4531-8468-08d59ee9e757
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40ae6f5-e0be-4531-8468-08d59ee9e757
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:49:38.7384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 0ef58b0a05c1 hv_netvsc: change GPAD teardown order on older versions.

The bot has also determined it's probably a bug fixing patch. (score: 3.6623)

The bot has tested the following trees: v4.16.1.

v4.16.1: Failed to apply! Possible dependencies:
    2afc5d61a719 ("hv_netvsc: Use Windows version instead of NVSP version on GPAD teardown")


--
Thanks,
Sasha
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
