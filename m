Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246421-2-17022112697658568544
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
    1523246420; b=uiop/F1WGCtxDn8KjsRAYGhQ/6bWKedEpyzL1Uo5+dH0Aa8bVX
    T8ORon8+Iioy5IFgYoWqvIdDWhZK3HZnCdj22Ryb62ev4ng5JDt6T0kBvXNqezgp
    BKw2EWV3LXm5o2VkU3/KBUwmmaZmhRvjS+gfzJ8tdDfywUiaR2gSKMyGu733I3Pu
    PEVGF0GPhXwrelrrQQC1O3C4akZAwi4HdxtbsvQu2UgAxFW71b6QismRtA4wbsIQ
    Rrvy1Mzgbb+/krZD+pqJSkwia49WcSPTMNBYkrcgMau7TUV70yA5ssi4CJSBzuee
    rTu53OLqacwuY+qmT/W7BgrnKpoil21TU37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246420; bh=UmlLDbfp4f
    Sp7kSkOg2ge47Xxul6jEn/QjWe4KcbOlQ=; b=ipBQmFcCRt5VaQYxAJhXj4nmCS
    0Q/4fEDxNF/r986GGqAvzOGr7l+MZJa8kCQPhtfdD3YNO1cCj2Ku+UdJ9G59Etlk
    pGUlekvrpWAgER/EdDR2cubf5kqr+gtCVaON4YHdy8VPnqhDyfx32k7+PSyI97r0
    SvqZaoA07GntC+M/52No1Y9TJzahOyEOhqZPoCLOytVuMzot5dGhXpL8OSJlimfG
    v/aO0gJxx0lIoL7RHVO7/uJrI0GRgbLNSiDLN7d+VNWwUzEFoiMd7gjv9GeH0ps5
    3xwUgKRgezjAk5vauq1tjgQGN2co2D8J4Q+nGIyN6on22ERZengwwYyPjKWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mHP6H6Mn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mHP6H6Mn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxBaeTPVbDqrdzm0BFlx5ZDRj4k8FlJkTkTEoQEgC3uJ1JZ5J7491+1KEtaOm/hXkqzFD4QWyN55yzOTm8Jd2NU6HMJbVkVnqhhLMGQ3TjVYkKzDlPx
    YIG6202U1LDHdf6ccf6xDVVmwIX7Pp/SfOh/W2EH6fup/YGuAmP8c6rwCWkpN3pk7sBcbPzQdzyGYlWtqr8YYPUwXlm53I1+G2EWEyf9z37uI2oIuyRw2yOM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=CayBMKeuEvu4Z8dvqTcA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeDIEAD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:00:03 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:37278
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753603AbeDIASd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Anand Jain <Anand.Jain@oracle.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 064/189] btrfs: fail mount when sb flag is
 not in BTRFS_SUPER_FLAG_SUPP
Thread-Topic: [PATCH AUTOSEL for 4.15 064/189] btrfs: fail mount when sb flag
 is not in BTRFS_SUPER_FLAG_SUPP
Thread-Index: AQHTz5gpd0Mzikat/Eu5QXAWvDiCUQ==
Date: Mon, 9 Apr 2018 00:17:35 +0000
Message-ID: <20180409001637.162453-64-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:I3OkYdFcLKJIMxh1hGDppOmxKnAMgobYABfPx2cSfEtYMGmqJWS8a2BZwNxFszaDFt3V/xsKQfam3LH9WPQotemiYU+7BpxXdODd+zgEnH8nmrFWfYrDartoYajQ0RQJXm+mUVCrWDpggGnnefUGlTZRh4WoGavWRzMMMeEkq4z0S4OU940kN1p7+8NlL+jh01sqs4EFe6M36DMFqrye8WQF1IYnDaxZzRK1v0e+CJOnF+Lu1t1xBCVueiQenNez;20:DItFLEV+4F4v27kgdLvR0HSP0LG2WPVlWLOA2QS/Gl5Jd8QE2HmvPpoVPQtSQlKdh6GnknXXwgFg00+B0vpa/j6jtX+l82eSdrHRxQsQPyUxSZq9mW+xvvia9Hb0hnDzcDpy/OyHx3Upwmf6ZxCs7pSpB41QrAHfEymSlD9Q74A=
X-MS-Office365-Filtering-Correlation-Id: 6d52136e-06a8-4ed1-2af2-08d59daf6bc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046788684FB8FBC1A5A0B32FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: oM/me1+Jw0vy+mimdzvVZQx5wpfN829+g09Zmzx7E/xKJgV6u2gt2QvOxkgQIw3xuwluux7wvGkR0HOs2f481ET6Mk5GxPNHVE+NlzIuRQQVtQjJPPTVEeacU7OAOZ09ViYR7q3hI9HODUQO1WlW2/mAQSQ/Hu0B39fLXjMdBqBNHqMMwKgvuIsj9/HNscUfLUYFt01gb3LWvALB5GTrcS8eZnzyPL0LjSeMAQJfFt6Tfk8IVxD6J/t9byGUqKRrm37pxBOVSx4LTYgYFanAa9KryRfzLVI07oM87/CR6Lo+at7lP56BhyPNR8c+8V59TQJxYzDueIREYkZ/5slH8da1udESwbQlicxQ8rDcFmUzkcxPzDZoim+3ltxAVoYrTZaitWx83F4RcXxH0DSw7kgLR0SV3lcw0Y280FMsYbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d52136e-06a8-4ed1-2af2-08d59daf6bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:35.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anand Jain <Anand.Jain@oracle.com>

[ Upstream commit 6f794e3c5c8f8fdd3b5bb20d9ded894e685b5bbe ]

It appears from the original commit [1] that there isn't any design
specific reason not to fail the mount instead of just warning. This
patch will change it to fail.

[1]
 commit 319e4d0661e5323c9f9945f0f8fb5905e5fe74c3
    btrfs: Enhance super validation check

Fixes: 319e4d0661e5323 ("btrfs: Enhance super validation check")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/disk-io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a8ecccfc36de..3353d3de726a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3910,9 +3910,11 @@ static int btrfs_check_super_valid(struct btrfs_fs_i=
nfo *fs_info)
 		btrfs_err(fs_info, "no valid FS found");
 		ret =3D -EINVAL;
 	}
-	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)
-		btrfs_warn(fs_info, "unrecognized super flag: %llu",
+	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
+		btrfs_err(fs_info, "unrecognized or unsupported super flag: %llu",
 				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
+		ret =3D -EINVAL;
+	}
 	if (btrfs_super_root_level(sb) >=3D BTRFS_MAX_LEVEL) {
 		btrfs_err(fs_info, "tree_root level too big: %d >=3D %d",
 				btrfs_super_root_level(sb), BTRFS_MAX_LEVEL);
--=20
2.15.1
