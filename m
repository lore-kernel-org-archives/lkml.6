Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240618-2-6586039721126875640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240618; b=iHJXOMKuNK2C0KR2JtdLTgowps+MYj8RLdS8nNYkSHWW/IJm6a
    S5AF1LurYW+s85a8CZPuYySa9oIfhIbMtgPOs/h0EBoRGCuVdaQjEe0lPcXxFfVx
    KMxXZNfc5jE9LiIZOalIY/sbLF5b+viIfJii43OsCrbVRL/bUiMjxlMfhlqbyFv3
    uQJuvofEprE1EE2ec9ehe16V2dOk+C+IVo1juR0kNisD0AXNF0QogNBXt5DF5Kcg
    b5HOHSHhstVBdYSZGfaQ/zo4Iid0IA7A7fFo201Wt5kfa3SFuWtEqlHZ1xD9E6gf
    k8gS8/SdwXrRk2VGnjNsAy3vOfes3FuGaOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240618; bh=UFWaQdQdqE
    86Q+4h9yzR3t15LshwWmMQMYTIo9gOcrU=; b=GzkPgE2aT5rctFkTh+k5O5GIFr
    I9/2a5x73HC7ZJqOz18GwcsdajiCVbmtGjsi+gAlVmdMO9qQrPpgWPwNWWmicHXT
    xYZybU/m+njouk+TVwSX0YUc32c0MLnzdEH52Tmr1xoFUNs1JaKLrtEJreaTMC6q
    BsCe1fHcHpXtTwQwKisuD3vQfxQYgYfmAFoaX4iL7Zr25nwfDBOaAX4+e61w9U9x
    +5gzjIroNYEQ5l6ELSV/wdQQLYUSoXn4EfkO5WGyeiP+zTgWGOrBW7fTwjoR9Wnt
    4LsB2f+FvKPgI/F8Ep9Gl5f16vvH1Fq1jcpUWvI6RIx02DbxNDA56sn6Le2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HD4DlA2q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HD4DlA2q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBMwHl+6LtXZUkNz1lo/sF352U4l1AApc9U3LyHmhQQb0zmuKlPuonv2AucRqmx+cIGxy33hcnoUW/TcrMz97qATPPWWTwVNp1a4aTIwx360Ucmxc13t
    ZbzWn+S7BEURlFZNLt7FEL0VdRltHX1Pc2mpUgQ7caG8bJOPTd1JTzOC79HSBGpzQr6scASjruQ+Q/qAzzkiG6X056B+EFzDGfmLd1CGrN/LdgQbRO8hK9T2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=vmLDa1wCAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=v3gzP6sNgcPrEcW6E3MA:9 a=wPNLvfGTeEIA:10
    a=h8Bt5HTj68qkN2fS7gvA:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756406AbeDICXV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:23:21 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756008AbeDIA3i (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 108/293] sctp: uncork the old asoc before
 changing to the new one
Thread-Topic: [PATCH AUTOSEL for 4.9 108/293] sctp: uncork the old asoc before
 changing to the new one
Thread-Index: AQHTz5kYrj1538CEaU+CUGOIbPJs6A==
Date: Mon, 9 Apr 2018 00:24:17 +0000
Message-ID: <20180409002239.163177-108-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:jckDRRkUmkeA3GryG998/Qcia0zoYTpzHXUAHUWqje5HzrRGpxkVcP0R8Bv2wwjmd3ANX2Crusan9U97FLZ2lKpsj8ZTtkmnHQgc0NiHi1T1wuzVFHYrO587Bn98eevK1zB3RmqtrOHePMh7WPeJMdUIjkjkIStEoMmli7Dd6XDEMwI1esk8gAD1SCsuauNRop5J1dlBU+hxp4RUklWiQ57wbh1aM8Abs/LmHTYTzuJpPNplFxd6ShMLHyFqM99P;20:mJNYJrBxcHGpsDJzVGFE8hRwp5HRnTioEEbsUon7SnHaMEAKwIpP/o0xygCthY1Dc4rAZdrFAnqLfO1LIl2yDA8RTDAxCOsjNORvi6TVZlK2nG+v2WpkcbhH9Ul6Q7aPxtbYxLKsL929YqTFfIjYVHEuusQzEIy+oeheoURdvR4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae543a49-1b94-4dd8-3963-08d59db0f87e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967D31A229C894D6E790A26FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(39060400002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +M1WtM34lWLnsmf8unB/xXK2y4PKzs3Ju7ussYjB2jCEKJpaLmMHPYwXqSi0sq3wSbaquJrl6wkksG6dPP8FFBP6u/94xv+V4WL03o57QJ5UE/IQj1pQdOtwdSV0ABNDShyndvuZ5gYfN/Fzof0V/ju3mVF3Ppu7QYN1x1Ifjgl/FdSIN24NujCuTta/XnZBU+hlRajWEm06WjaXjkZl/bIRH4HUmVoIpukuM+i6c95CDHbDayDOI1U9NuOiI2v0Bq2yoWoXPk92FKmcLOQ1PaCQeInRxlQr1qE8X+UK/P9mXdGZJYbjTW0Fypj7Q3VMozqJ87mu0aH/4tKEuss/kiE8ZszYeSrOtN8Q8lZtrnscCI4tqywekBd5dQn5OElKt9N0vA43Xbr+vUJMcBLyWLVBU1JNA9PyPW29x6oMbxk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae543a49-1b94-4dd8-3963-08d59db0f87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:17.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 8cd5c25f2db03306727d2f6b8f28956169dc1123 ]

local_cork is used to decide if it should uncork asoc outq after processing
some cmds, and it is set when replying or sending msgs. local_cork should
always have the same value with current asoc q->cork in some way.

The thing is when changing to a new asoc by cmd SET_ASOC, local_cork may
not be consistent with the current asoc any more. The cmd seqs can be:

  SCTP_CMD_UPDATE_ASSOC (asoc)
  SCTP_CMD_REPLY (asoc)
  SCTP_CMD_SET_ASOC (new_asoc)
  SCTP_CMD_DELETE_TCB (new_asoc)
  SCTP_CMD_SET_ASOC (asoc)
  SCTP_CMD_REPLY (asoc)

The 1st REPLY makes OLD asoc q->cork and local_cork both are 1, and the cmd
DELETE_TCB clears NEW asoc q->cork and local_cork. After asoc goes back to
OLD asoc, q->cork is still 1 while local_cork is 0. The 2nd REPLY will not
set local_cork because q->cork is already set and it can't be uncorked and
sent out because of this.

To keep local_cork consistent with the current asoc q->cork, this patch is
to uncork the old asoc if local_cork is set before changing to the new one.

Note that the above cmd seqs will be used in the next patch when updating
asoc and handling errors in it.

Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sctp/sm_sideeffect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index c345bf153bed..255dc92276b1 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1712,6 +1712,10 @@ static int sctp_cmd_interpreter(sctp_event_t event_t=
ype,
 			break;
=20
 		case SCTP_CMD_SET_ASOC:
+			if (asoc && local_cork) {
+				sctp_outq_uncork(&asoc->outqueue, gfp);
+				local_cork =3D 0;
+			}
 			asoc =3D cmd->obj.asoc;
 			break;
=20
--=20
2.15.1
