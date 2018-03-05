Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2498535-1520280405-2-10162366045714533911
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
    t=1520280404; b=Nh/HM3FgVuYiGfftVpKVlTojAWrxvscLjYp+2hLZdsiY7zx
    B65fKmQWdLHY4lr542v9ivoFhQCvvBSi4n+55/Q5bCwu585Af6CESD/KcBIDG9/L
    pp2la9+c/mOdS5pJA0HrrJp/S3KAfGbbF4NDjapmeaN5jKRWHrLmPWZxmS2TzHrL
    IdbC5T3IkIlTeIkclnguZT263RACQGekjBan2vDRWqgQYAsLXxnsPaxJp911oqZL
    MaPHEUjwNMCYFp/PCnnfKEJPZlvfeBU4VkwYa4/rB/kzdawylzayYIBvwQHkEdHI
    C0anbEe2G2Q6ash9qrog72y7JT7ukoiY/n/TRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520280404; bh=wcWAynNzoT/T3Ja93cnF8TsfXV9TSETFvw8VnI
    420dA=; b=STxt8aEbPDAbMB8EFcrFGvvPNgzb2YuptcA1YEig/WkzD1ty2Pj7uX
    ipRuF2N03PYnahHYU+DqznddSR9WbIe8jwKfpODxF39IDtdAZB04nItyByJYeTDe
    DZxfTYnKR9rCXGT1R7V+F3onOjf2FBumdp6LWZYhKQ7lCWvUXyJkw94tKqG06CFY
    xRTED4KFabjwNQjesBBnIA5BdYUuxsj7+ypW58SkjS3azwv81c+Q300tDRvOBUxd
    eVAQMD9L5wGtY3pd4sY3dzYTJFplNDD/HDpuuW2K96xX0tHaCNlYTlWa+5ZqUeLH
    RGdOZvbfIfk5O9bR+TlqePh5SulodiLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZTdjJk33 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZTdjJk33 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeCEUGn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:06:43 -0500
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:7008
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751764AbeCEUGm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 15:06:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.9 005/219] kretprobes: Ensure probe location
 is at function entry
Thread-Topic: [PATCH AUTOSEL for 4.9 005/219] kretprobes: Ensure probe
 location is at function entry
Thread-Index: AQHTsz7h+vIeWDcysk6ztI3Ut2DD/KPBOXyAgADa9gA=
Date: Mon, 5 Mar 2018 20:06:39 +0000
Message-ID: <20180305200638.fp3lxnkslgnlysxs@sasha-lappy>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-5-alexander.levin@microsoft.com>
 <1520232322.k5aakv6abc.naveen@linux.ibm.com>
In-Reply-To: <1520232322.k5aakv6abc.naveen@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;20:6lA9lQqPLYCFm56fE2zeHON0HorY7EqcPHK1TxJm9JroaDZ2todVJS3A6dAVFlz7PDuvCIZeH4FQtJsyydNDssOm01xyDGvHzKzjNSuCc8cve5zf7sxKVMAqucD8VHD7zPyyNX4lb6VzqQQehbe1WMeWhRgutuGYwacMHRf9ccw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e96013ca-a0d4-46da-1dd2-08d582d49bc9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603322)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726DFEE87A085E228E8218EFBDA0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(189003)(199004)(4326008)(22452003)(6116002)(3846002)(1076002)(97736004)(3660700001)(66066001)(99286004)(81166006)(316002)(54906003)(33716001)(5250100002)(478600001)(3280700002)(10290500003)(86612001)(25786009)(2906002)(72206003)(14454004)(5660300001)(33896004)(105586002)(6512007)(9686003)(106356001)(6436002)(10090500001)(6486002)(6916009)(26005)(76176011)(229853002)(2950100002)(6246003)(68736007)(6506007)(53936002)(186003)(86362001)(2900100001)(81156014)(7736002)(8936002)(8676002)(305945005)(102836004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8t2mJwQY1CamaNgU+muCRw1ty36ieGqK7kt9vRJ+a0YsVL5ZHhUuM1D+r3mcL8AxtRE+lrEKd/Pyr0x7tBlBjVrRo53WbTyykO/ob6Wi13OuYM2X1FWG13ZGOWGPc096pnaX5EeOU8iJruYufwoiG4J51jIMfeCgscf3tlLENMRVmAOPAaUYh1WGhNylGhYcsHMS1hhjoulWwlDKVVkqSyPHJTNzHdDiIXa2KU0GWtgsptco/YmqpfvvltyprPKmi54X4de8TnA4n4rmvqKPgVMztskR5yF0AKQlc8YZ+drkhuH/0QcxR7c8Dt1iV9m3xpKPzFRfHrj3EE4SplmUOg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D529F911EC88346AC1E2FA2AA017B8E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96013ca-a0d4-46da-1dd2-08d582d49bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 20:06:39.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 12:32:57PM +0530, Naveen N. Rao wrote:
>Hi Sasha,
>
>Sasha Levin wrote:
>>From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>>
>>[ Upstream commit 90ec5e89e393c76e19afc845d8f88a5dc8315919 ]
>>
>
>Sorry if this is obvious, but why was this patch picked up for=20
>-stable?  I don't see the upstream commit tagging -stable, so curious=20
>why this was done.
>
>I don't think this patch should be pushed to -stable since this is not=20
>really a bug fix. There are also other dependencies for this change=20
>(see commit a64e3f35a45f4a, for instance), including how userspace=20
>(perf) builds out the retprobe argument. As such, please drop this=20
>from -stable (for 3.18. 4.4 and 4.9).

Hi Naveen,

It's an automatic selection process that attempts to find commits that
should be in stable but weren't tagged as such.

I'll drop this patch, thanks!

--=20

Thanks,
Sasha=
