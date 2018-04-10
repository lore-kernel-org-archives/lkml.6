Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968727-1523368186-2-5333256121007960173
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
    1523368186; b=d+b0YEDmD2iJXQGo/G6ODbiN2jAj33R4K2cFqsCJAWajoblPr2
    rNLxUdDhma0ac+HQzxPMjbUH706/fDH8v4r0cMO8u1g+NzmNFd/8gF1dk2/4NLaO
    1T+2QXAh/+td3x7eXsqSgfnCTIcsLQYtZztV2Vnqa+7/eg79h7vDhYWbhKQC1+mR
    ueS9i+Nz5Zk8j7wQILQHibUQKCdWb8ns9/BugmbnvpdFnAcKi2vjurhVx9iORrjX
    2ALprpWyCUDbaMUFhvXDrHJMK4mylPNlDCAlwl6ZMmxpPwCAqNgw2H0ICHLbL9ob
    z8b9Ul0qf1iyt0mIw7APkBYJZVnVGaE/74Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368186; bh=QdqVBwIS5X
    HsWUvAARDsIOCwM3nOIe/14nmDlaj6lk8=; b=n8Ethj5QKGnX4dCHq15dNJCbVs
    W7wVdj6XXLm1FRMBXJVq+OwMvwn34K4oBB34IJheNtk+6XvazS56W0LilhEfeXxB
    S07oZPHhlwgrJdG+1n5X3o94HRot56e9uxtjcDvV9o15AgQ9GeA//VxSrBNRuVdo
    kNPSmoJ9kvoq2iS6WHhoft94EIDZUqgg6JhMwWXrHZ3Q5XPal+3WUcQ+v2QErl9k
    oUMCR+zgRi9EEqM3FMCHi23n0A/VcDUI+wHmx7gbs0L7n7G2DBPeCO/k0FW/8mwW
    hiBIipsQEfJjXTP0V4vYep+2PBmQ6jv9efRBAT8ZzbPPOyvMUXA90Yw8tSDA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xun8TFIp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xun8TFIp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDm5zsbAcq3jR4X2cvdb5M5OceiW6/G/XqP9qdwXdb2Q6OuqBMlKJtt1tC2f1qC8u482Ky/sbl9odwYcGHV7EoaVwQwKlaUpJ0UdRM53FaTSHI7KaLF4
    fAaj1bQEScsYNRU8EHxfAtD6S6+BkVylpxLAm2p+NdQRqQRW1gX5N5PTTaZvhPs4HzFqwub+aTxB9uZUeEfdSXgc0ROhhznGgOgYzbOxX4FBB99Z3laRrJLA
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=1kne1Cjz6cMA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=8KKHSzXXBAFzjPyim-QA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeDJNtm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:49:42 -0400
Received: from mail-by2nam03on0099.outbound.protection.outlook.com ([104.47.42.99]:18116
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753331AbeDJNtj (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:49:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/4] hv_netvsc: Ensure correct teardown message sequence
 order
Thread-Topic: [PATCH 3/4] hv_netvsc: Ensure correct teardown message sequence
 order
Thread-Index: AQHT0NLDmu52dVW/IEidno8RLTqWhw==
Date: Tue, 10 Apr 2018 13:49:36 +0000
Message-ID: <DM5PR2101MB10325F63F4BC3514D65B83C8FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <1522955361-14704-4-git-send-email-mgamal@redhat.com>
In-Reply-To: <1522955361-14704-4-git-send-email-mgamal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:Hj+ReZuHaJ5XP5cmHRgm1pipZi5b9zVlc23U9y+5UkZ9naRnBFo0/q7BNogXzgVIRuKyX05/HjlN+tnYicqDdhnAxVQbx6ueJeaSw5sz+uE2xFHvNsmLEsxaj6PHC/REc8vCP6//Lj6CkjyU12FH7HbVLmaqUdvHUdSpAU4bO4sL7BmEd2xxHeKngn+32myHAY/TMBWCArU5gEvScKqRRt1OeaylkKg6SYeCz0VmHWNRtTxCWh2juhqjtclf/jLq;20:1mpTz/mAML4SGaSru59Q1wECokRgaQgRH7xY8VXwzfu37a70MGGKEY98s0O/zmehIdtRLuiLiMOnzZmhH0+bg+gV0hNAdZyuM7/HS66+4vu4LJhGKymdimoztT+87VA5/DQw6UvtnGtQ9IKklVxX9G2fI+BbTA4G7+VzUhOxeFE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0872D6C60A1A659EDEDF7361FBBE0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(10090500001)(6436002)(316002)(53936002)(6246003)(105586002)(8676002)(3846002)(6116002)(3660700001)(2906002)(3280700002)(81166006)(55016002)(81156014)(8936002)(9686003)(575784001)(486006)(1511001)(66066001)(97736004)(86362001)(86612001)(446003)(11346002)(476003)(8990500004)(68736007)(22452003)(102836004)(26005)(6506007)(76176011)(7696005)(33656002)(59450400001)(99286004)(478600001)(72206003)(2900100001)(305945005)(7736002)(14454004)(74316002)(229853002)(5250100002)(6636002)(2501003)(4326008)(106356001)(110136005)(54906003)(10290500003)(25786009)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HQZI1eMXJQQdvMcHVlWmGCHxjKwiwIupDjIMiisBS4AWd7BxFM+BARpgkPrSIoREm42huQqvSH0e0LuzLUHEPasiwhcdSPd4k4r0fAVjyriY1WjsaHbb14zJKnoGaumYKtt4P44RiST60KSBrVBg745Mlz14SAwArPt4tTd2UYCG1Xw2YYt5vGThSqViI2Tt0a31Kac0JxaERsBMaibiikoRAoWiIPO3sMAGh+mwXTp6QC420FxCwARedBl+CUjqW/J7thacYyjQ8Njm/g5dsBUL/UCvx/gm1CTv0cD5faYB6W3RmcZdNoPCpulh6WEdo+Zk50fSFpC3sxaXfaUPNNkrlZob0JwMIxDJ/VB9lh71jMZQ8q/Pn1ui/OG1NDb5g3U403RiTDzVKYV4NLyl/DdJRnX4liao+0fRDBPaD5U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1f88d6d6-fd56-4230-5736-08d59ee9e626
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f88d6d6-fd56-4230-5736-08d59ee9e626
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:49:36.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 0ef58b0a05c1 hv_netvsc: change GPAD teardown order on older =
versions.

The bot has also determined it's probably a bug fixing patch. (score: 60.79=
87)

The bot has tested the following trees: v4.16.1.

v4.16.1: Failed to apply! Possible dependencies:
    7992894c305e ("hv_netvsc: Split netvsc_revoke_buf() and netvsc_teardown=
_gpadl()")


--
Thanks,
Sasha=
