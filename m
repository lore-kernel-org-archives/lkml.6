Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236870-2-9378598237338277016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236870; b=R+0T3DGQmBzT6OqFGee3I2uc91Hp3V0UpJ7BqBTBCMd1h7OFBd
    eL5ANXT0TVdfXow0KjtM8/HZqHjg45MzAumFoBtVc1ClLAqPVJw0WPWQwt/Dt0nr
    7fNm16B9mddIG0OKOWSQcKLcdFaTJKA+q6bE55ZgAjRTzDmyxhuJTpmlBwejXOqS
    vXj2bCwVVAsy0GoornZliZPwA3jBurk3U8O+5NuCqHnqSuzxhNlmiuXe7SClAEpw
    9pNURqNhvbb8c0KGnu46pztbL1Xild3GucKyUXwe0zWLaiZ8vorQiuTUpn7fqKCb
    v0HE66t44vneiHqHsKXbEBZ8EtmHWHkFNZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236870; bh=SybOediApR
    qhVsy3Ea12peFVsuuUTT+TFwWiR8aAt2k=; b=Yio5CpRG2W/vaYSfLPAWwDMaU/
    q7D+q2rj59MHQ/Uojs9Jmf0vBhEwitayHZTCf//T21CYThxFxcT6qfIBQrbZwtPv
    yjEQIqiEFqY11Jv5pt2t3JVRmR+jALiJKSDo2pavDNnBYXXB04iCz2aWgKKxIS+Q
    YohHFooBJNc+/dJoHEyWKNumi+0ElhK39I1zztIkPRi9eVUweZery/Wkxe3ixawk
    CWEDW4l11QezrrRqOeJwPvSZize/FOBq5nJzfaonzBG4LpbAo+oYoDHNES6mWrvh
    oYdJ3MeLXi6DMNY8q8U1lDo6WQqIRTvxogp+qhof1xMlSk/6yD4hpGMyjNEw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TCBthZvV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TCBthZvV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ2qqI1cMtuYw9a46ztkhfnFCP2c/pV6z8ntFQMxhmvISshk68zV7HWYob6UQmqDf8mqycmx4qv4F3n3bd7mSf+sOueIv34ZQeJMmyhLMz20CT2TXI6r
    WSJyYQQl1MUcLNKscxMlsufPaU86CvMHOcvOcsK29yRWEuh9LDi0BAwoKNZicXtJe9epuad225Qk90tgwYiODfRTVuOafhehTznwVKdf2HQ5QnFE4MEOpgYB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=OEySRT31XItV1Ocz9JoA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeDIBUy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:20:54 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932762AbeDIAhL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 090/162] arm64: ptrace: Avoid setting compat
 FP[SC]R to garbage if get_user fails
Thread-Topic: [PATCH AUTOSEL for 4.4 090/162] arm64: ptrace: Avoid setting
 compat FP[SC]R to garbage if get_user fails
Thread-Index: AQHTz5m7YGhm/cxA1Ua1PIjVNbV6BQ==
Date: Mon, 9 Apr 2018 00:28:50 +0000
Message-ID: <20180409002738.163941-90-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:Z9w5uhNSCyF0G1WvazE3Q/uSB6P5i+G9FYljg6Sy+0nCRkne9XYXXwWgrr3PX+rgY76zkeK2Y/f1AADccwYNHW4cQNIXs1wqZnnmmuwJzfr3Ob+tNa3/yC7rNl37v44AT8BVlgGyWm5s492pr30ANSd0tgm4Gh8BgmYdT/th9fD7b7xBQniNXos3resrm5dnaRMJiv32GJx8kcy0KTsxvWIm5CiRYtTxunks+v26N4px6cgK6vPtePqU1ssl9lJj;20:dcP621dpjuXmsDQ+j3e38wq1m8b4GnpMjENtCBXHJRrev22J2JA090wN0BfSweH3Fs3haxjfCYwoTgltphnR7dZoUVZSB96a3UEk23I8uBE+PPw9s20zZu2Ba4/+WRjpcE9mI44qnq8vjQcUPs1pWHsF5Wr0NNdsrKy/AEIWDPw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76b106c9-9015-4f7d-e37e-08d59db2067f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031D82DB95611AC87E2D852FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Vc7ZmIuD8OzNJ5YN6giiilFkV4opDx6yHzaR4WJ3+pN1Yz4UkUnhuMVFbqOr+OmLH1BHxj33dkTNuOqGZ3mISO8DFZoLS7GqkA2PU4e8vdoOoktgI4ExVCFTtiFeYArxCemanm6Q6hQ2OXooTuGm7pDhOH50+JBp8hxN5Khsg+mwm7dyoQzrUrJkxsWqrx+P6vakudQjK+mvyta/JD4s/syaSonhBILtoJm9RFTIOxYafjFYCoqVN98gwtMPz9VbBV3tf/1ilSU2hE5loH/YOHhpu+OINTe0HbPIT7lH8YA6CCDJit12c6LDdw8cTZ/A31scslQRokPwfD7Eh8cXolPepVh65opJVpZjlzohU9muW04Lbua0g4JsbS8mCWKhZGzVhHeIt4wuX3ishe7KcxCVZW6PEyWLU4L7KrOAGEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b106c9-9015-4f7d-e37e-08d59db2067f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:50.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>

[ Upstream commit 53b1a742ed251780267a57415bc955bd50f40c3d ]

If get_user() fails when reading the new FPSCR value from userspace
in compat_vfp_get(), then garbage* will be written to the task's
FPSR and FPCR registers.

This patch prevents this by checking the return from get_user()
first.

[*] Actually, zero, due to the behaviour of get_user() on error, but
that's still not what userspace expects.

Fixes: 478fcb2cdb23 ("arm64: Debugging support")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kernel/ptrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 183f39384e4c..b81fa63bc834 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -834,8 +834,10 @@ static int compat_vfp_set(struct task_struct *target,
=20
 	if (count && !ret) {
 		ret =3D get_user(fpscr, (compat_ulong_t *)ubuf);
-		uregs->fpsr =3D fpscr & VFP_FPSCR_STAT_MASK;
-		uregs->fpcr =3D fpscr & VFP_FPSCR_CTRL_MASK;
+		if (!ret) {
+			uregs->fpsr =3D fpscr & VFP_FPSCR_STAT_MASK;
+			uregs->fpcr =3D fpscr & VFP_FPSCR_CTRL_MASK;
+		}
 	}
=20
 	fpsimd_flush_task_state(target);
--=20
2.15.1
