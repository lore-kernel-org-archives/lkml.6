Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490379-2-339600837667209054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  TVD_SUBJ_WIPE_DEBT 1.004, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490378; b=pNeWBxkFwg/4umZJJZwafC7KbXHCM7iNpg27E9phGPlLTW8
    M5XJ1Aldn0vfib5Z9sdGtiuegAWF94rv0tyb/jHD5VB77I/AAe6u6cKDBrSBPOPO
    PmaJAYYXnlZz8pNJ0A92DhB64am3u1vDPYxyp3aG1c385Lh5MJaQrH/PV+UqjR8j
    YNjCl4h4uEGCf7mQzfc8AQ88ZEGDs/+Pn0B7BxBoyJZWuSMSnadoq/rLhQmtldNO
    Q3/6dnsM8acOo5HVEfszJROA/+oopOmjEgLoEfsM/9I1J+ZxTLIbYVxP5N+cIvTr
    bfSFOriCpt7fAYAH4GzCOtH+/g/wg6hND6Ga8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490378; bh=h/3wZY
    qPQR6w+BFQhZ5j/spbjoJRAg3iKOJsU07+r14=; b=asfcx3yykMDyMIiryxo1mq
    iYzOB+3deVA0h7irXAuugyr6FDE8HmUVY3MIauoVN2weg8MjHbPsbSwEvuQlb331
    T6hIRjJDj4AvMYEcC5ergtce0Cdj+ysf2f3YuqphDavkjBpSehJi1fR8lii4SgZG
    Rz29kRQmEV4N6Y5g7/2kP+FoBhsbPD9kaDbL0SCsu9ef1ioMZrKL5BDKb4sH6hKt
    dfWFkWCj66q6HEM7npAkXxXPxMeTl3p+fMtgI8UUKdeyt446IIe/e14WNNGirJg1
    ZccymeZY/8G6Ufg1hOHe9xvf/HLLiFLhM3jVDlmsGmzUPkZbz7OKB2jayYMeT5sA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gsbVMZQH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gsbVMZQH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965622AbeCHGZd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:25:33 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:45505
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755324AbeCHFAn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 044/190] powerpc/64s: Remove SAO feature from
 Power9 DD1
Thread-Topic: [PATCH AUTOSEL for 4.9 044/190] powerpc/64s: Remove SAO feature
 from Power9 DD1
Thread-Index: AQHTtpoyABdgcr0PpUmjjC0jkaClZg==
Date: Thu, 8 Mar 2018 04:59:11 +0000
Message-ID: <20180308045810.8041-44-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:JH/x4RRsEnmACddjTmnzYiyE45r2RPdrFUPjl07digaB6RQJHfhPD6TcnwvVvEbE9aMTou7h0keHX6sLc8UaSdmlHILQCZcesHcrtCvS7KR9A53Gqky3o1VMLwZ/gFlJ/Aus8/eyadJlo8ki72nWjL7HXHpVHx2GHvwUVmOYj+jzEW+LT3h27T848bhUfPipjcZ4dWlj+OwFKZU1SHVu9DLUbSmTv4CxTAf/HEwuJ8vz6g8EFE+ihgxfk5T0LpDB;20:LM0Ufm+QPNa+TT1V9Ym5xAgJjcZs7tCyKBJNrdQqZNokBxe3qqKtX6ybpy5LCwgduCwR8oEQ0hxHZivHEXjA4US3VaduMw5vk/e8Ce0OHvd1g4e3NPpxHoZDCIIItArXDEUktE1Nn3htwYrCdKnMuZ+04EvHWYq6ZbYCbFUADk8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55c21d13-df72-4886-0a73-08d584b18b1c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110907F6194861ECFEEF38EAFBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(39060400002)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Dl6hQeN1dZ/JSJqgmP+7cFfvjhBtlvBMFUC3KsauFhz0wKpDVO1D+G5FT1f1vphdwSf4WvVOKcgATXWnl0F36VeGYzgYtKMH4j1yPXkDeO47Q4P337qq77IRqheLAY4ZkLQu3cMDhCgcjrGLwc0YYA+pCtnaubSZaboi4LP/+SHU8mo258OecvcmczbklDv8HHMOBmllyMl7F0Dyotq13JII5IB03HGqqQocd60JcybPvodIMaqBALCX8bYoOo/BIkPsi3mTXo1CiK3v9Gb47FEvzH3OSO0KPcIo5SR1TknnVe3UzauResAOPequWS2IveXLfnK1ZeaZCohNofFiAA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c21d13-df72-4886-0a73-08d584b18b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:11.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit ca80d5d0a8175c9be04cfbce24180b8f5e0a744b ]

Power9 DD1 does not implement SAO. Although it's not widely used, its prese=
nce
or absence is visible to user space via arch_validate_prot() so it's modera=
tely
important that we get the value right.

Fixes: 7dccfbc325bb ("powerpc/book3s: Add a cpu table entry for different P=
OWER9 revs")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/cputable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm=
/cputable.h
index ab68d0ee7725..4e54282c29b4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -474,7 +474,8 @@ enum {
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
-#define CPU_FTRS_POWER9_DD1 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1)
+#define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
+			     (~CPU_FTR_SAO))
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
--=20
2.14.1
