Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235361-3-4030001775717824981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235360; b=IrIdX5eFVJrb+U3MwFDECDDq/zy2AiNwabLm557ius0sCvapOa
    JY+F8q5lZxS8kdGDEnU5RAPUzSrMlpP2H+6KdBidf6SdPp1YgnIseCOBL76eyJ1x
    NLLa7wGsxAlepFUZqmGT6eGilYG1W/cMS9f5+M1krCw51vQq6AxhzWgbjruO2gQX
    xQurGQjnJxJiRwVCbLGFVZy5K2u3tVJRYFNx+vRkQMep1z2lRw6BC1vPezRUkbgg
    LZ7AeDvqLniOyeDKnBLgZVSvWcAMsZ004kvlbbI3oEp/xOUbZjBlM/zYs57/xKgI
    iU14ia+VDbZZzrd0hYK/C2PkTO5sJo5r7vMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235360; bh=/tH4iGX1QS
    eNu2FO8bqKlcsFMO3cmCRwK5VQAAf+Uzs=; b=hwHKSqLlWKVtIuAMrhwuvPkB6j
    vKC4SRx+LybecPTDeQx2Pk3Dn2J7sRu/oG7KWWoidhbQi00ct3qj1ljMpktrqhJa
    JgYvVNHXjCCJeRTfBCGlnt9h6bVOtVUcLwHYuqFDV76VQuHUqeI/JHNpBAdjJecU
    Qdh1CO14eh9TniF8ZAdgPL90TmSw/s7adeVr8zyj5HBpen0tRIp7qzkmjVHyI0jI
    eaxR9aKBMkN0wxv6Wq+ydHGHuK9nHy/Ed1E++CxtIkxS6BoR9illVuszqYjH9O9w
    SaDlnhaZ3QPz20Sjm4FysmhAAnL8fZwiPPCZ5+gHgjk458VgJovACu5WzHrQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MtExG3iG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MtExG3iG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBb94LwuhXezmiw1tIOk7+7rP1rqF2aHo4E5+tQj0JaQj4E3WY1Fq1QVSrBbc7Je8vXe3E28BKX4D1wFLnqe9lXWRe+0Nr4e5V2/q3bDb4sTavz+ihp9
    rEgRs/k9R8e7BsCSlWWqj1CzMDA4LqOnmIzQF1TSen/G3bcYFmtx/8rGWpC7PHqW8LYiJ/54mUpS5pPZL9XR90Co/VMGl5WWITJ+IzFLHfP/YucMwYBL7oYz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=G2YI053_dnqyvRuSU90A:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933290AbeDIAkZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:25 -0400
Received: from mail-sn1nam01on0127.outbound.protection.outlook.com ([104.47.32.127]:39117
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933265AbeDIAkU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 036/101] Btrfs: skip commit transaction if we
 don't have enough pinned bytes
Thread-Topic: [PATCH AUTOSEL for 3.18 036/101] Btrfs: skip commit transaction
 if we don't have enough pinned bytes
Thread-Index: AQHTz5qy9owlU1oAjU2ERf+hwN5ctg==
Date: Mon, 9 Apr 2018 00:35:44 +0000
Message-ID: <20180409003505.164715-36-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:+m2TkT2WS6B1sLz3CdM8sCZEcCiRnvly8xDJdm7/iq1+0pCkjPCZfBi6vaOcmEl3Cy4oAg5M9IJ3CBHDgy2UfpXsLklX5usS8plft0TCuaE64/V2uNykq422YlFLLSw2ob5cB/Cxwk1UmaZEyGu+43s8R/3bSngMwkoX4uTCG/T8Igalyf+qr95gL7cHPt2TuKM24jeJwr6Hkm6yCD4Q0F3MzQGVSYT3FZG+boi51uozx2D6l/u9wemSU3+jMUzz;20:WaqP475giSRE2sGkUk4K2TQBY5fIunk2IqoNjfHsRva+kPSUANiMWDGzHCv53Zu0CWoMgSdIdT06lR7zenwn7YiZmpuVWyxGssdkW9rlUsQZRKrrCszPCDrynYs370BgeUEHDNNH8utC2lV1M1rqHohXu9IECzEdZNeiFqlICYk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16062cb3-c1e5-40de-be88-08d59db277b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09668D87C4990ECA3C8724B7FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(551934003)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: /POtYHFRICNUf4tL+qpvuF2552qtEsOZybOmOH28NB2S9SarfF70Z6PsNyepaQHGotpJQiALvAIzblhkz8uXNwOzIybWLJYZ68ZlQoEggpXdPNwSLVneZihRnST8iDcechtm4EdTBwqG6BzZS/vB5eg8rzBdGIEBDf99zqKVT0u24OzP254fz3mAIEZ4/GoKp8//Tm297jyL/xDRRyfffCmtLP2EK01kyq3dQQjM0sxwEsMEa6RccvKBFG5fBONK3r/TS9CZAtSisP02a8LNl8WLrtwzCUsSazNKpOQmz5YhFHR9kBiMXSnBvyGK0k1lUFrRQCDEcaUDxXdudI5QQ9TYY0LkYjbo6vKj9IrYZ0yOYvIK6a+BlSSjzqCowJHdP1hrwmdORQf0aqwxLqcDFwXqEyoEKrLW89Vyy2mJaL4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16062cb3-c1e5-40de-be88-08d59db277b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:44.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 28785f70ef882e4798cd5706066a55dbf7adf80e ]

We commit transaction in order to reclaim space from pinned bytes because
it could process delayed refs, and in may_commit_transaction(), we check
first if pinned bytes are enough for the required space, we then check if
that plus bytes reserved for delayed insert are enough for the required
space.

This changes the code to the above logic.

Fixes: b150a4f10d87 ("Btrfs: use a percpu to keep track of possibly pinned =
bytes")
Tested-by: Nikolay Borisov <nborisov@suse.com>
Reported-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 131fe194f9e9..c00a129b9b21 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4207,7 +4207,7 @@ static int may_commit_transaction(struct btrfs_root *=
root,
=20
 	spin_lock(&delayed_rsv->lock);
 	if (percpu_counter_compare(&space_info->total_bytes_pinned,
-				   bytes - delayed_rsv->size) >=3D 0) {
+				   bytes - delayed_rsv->size) < 0) {
 		spin_unlock(&delayed_rsv->lock);
 		return -ENOSPC;
 	}
--=20
2.15.1
