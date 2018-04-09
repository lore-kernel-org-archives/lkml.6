Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233757-2-8089674912844029834
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
    1523233756; b=EQVxKc5vAHFDGIL9TO1/xDgumMsOUhmafLvkwfymvR7wayjoo6
    DUTtyCBx1nok5prf5DtXs8YCkGVnLJxNf7TI4rnwgNhDYZxbFFCKHvbO+mppwsny
    xaJRwVHulpgPEMKD9dsC8dhV1k2vBNJ7ICe2m5cpVJ780wvltCc1ygI5Vn8J19gd
    BXAX8Noju7cCK3mEYE4vIY0m+OyXxoIUIc8U0Xp1RFcb+kVtc9qKgBhj8T4VyktI
    NOSug++Bgc5tOO+h/41WbcLOWQ8L+FzWYcQu0zup80D/UYTxBzV6FhG22ab9Y13o
    6IOC9t3W7VsUGvH/s7vOau355UKF1ZnAEfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233756; bh=trkcWN2d8W
    0YlgeGhGzE0O8Mu3YTCzRQKWmXW+clE5A=; b=QZHmbAcH7g56nr6PKy+n7FM6su
    B44KC2m7WAzPCWAgoqEOWRfa3hlTjLFksafEIswFId16KMuTQ/DqyGIqlnEQuxlG
    AObsCue6w2rwUYdm89xaUTUEFOZyJxVlJoj7picoyOENJz/KVdgxYKjPmayG/KcR
    MW/H1x2UaHXmOLUWQZ0c/wBWJOEUTcdWErAeIxmAfdNQJG2BTPa3z9mzXIxdyVub
    EU2RkVwzv3HU9Ol5HHaqGRXCoMSYGjl/9AGHAyTKGlZ0+kxUd3XBnF/cNDLB87GX
    pT+YyuWhBeQ/304pArW0jmchG7yanVs/9t9+uOXjiJagBexvCIq2t/60wjYw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vwk8F29D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vwk8F29D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEx/Jdc7r+Vy0Ht3HJfoDTSohqeD0KB39udf68A4c/0nWYVk4CLaiPvXM+2nXTw+x5NhfbLl5AASNnYJeczvSmGq8CeS6GFVWBZodLpz2a46eAvxw3++
    He79rGg4KjpngsVi2oGWKtL23gB8aVOFWf8ADlOOqJZmFVFcmDS44rB7CKFYSsrUxzcAI1nSrYB+sXuGZykGoEoUsvT51EIQsWK0sBhioD/ACE/143tXQ3EB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=G2YI053_dnqyvRuSU90A:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeDIA3L (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:11 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:61603
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754244AbeDIA3J (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 092/293] Btrfs: skip commit transaction if we
 don't have enough pinned bytes
Thread-Topic: [PATCH AUTOSEL for 4.9 092/293] Btrfs: skip commit transaction
 if we don't have enough pinned bytes
Thread-Index: AQHTz5kREOvLT90XcEyjnTHWIX1ezQ==
Date: Mon, 9 Apr 2018 00:24:06 +0000
Message-ID: <20180409002239.163177-92-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:FSwapj33pjNJIRZ+Vc+suZcqe8zvVgAut4LzVAD886YDfPOuAX37Rh0C3AKbtTltezpd20ZeiyVE9tPAZU/mawv3xr843x31l1+AFWFx7dopaxXvyECvlZBk9S0SHRYVbl17Wqk4RDQn0bY9ana5KGtyePxive79nAjJSuBACIWO40dyxgGXdaf5TgSJkd4jA0F/ed/ooeGp3BxAYyOJGSPrgJuuKkcD2N5TCe4tRV/UUk6o64TOhQdhQVjZCMOC;20:bn21CUqFJ8DlytWaoSWE4lp3H3TQYfSsFcLkXWXFuuh86ygvmnn2qrHID0BlL5zAKHw+gkXcs65yIUYovfCLHTcRosLJXLI7M2cLF1DmGtPkVlbYVS9p6PNtcenfs9ypn+o2roYVWGpSi7EFVr2fNDlPIFyR4Spz2e7+QUO+7FQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2dd97ba-7126-48ac-133b-08d59db0e88a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09677579D129C7000532FCE5FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(551934003)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GqdXEtEL5BrFJdrLK82Y+L9kTAmexAsaFATnJjkRPCiFwbk0Y83VR1wWM9q6dndSCzhSmfWhVLtkf4jq09+wgdw9TC72d9wy+ayixen/QgkJBJcEmH1acUW/WCAX534i8xLvxhdJctzFG+J2AUHoUmtB5OfeRxGDmJGxLl99IlktSNx8VZ3f1NWAEGoCst5A25bPim/X20ZFIjvhje2p3QQvWP86GJQiNAeyUUfIzn46gihAwbFsV5nyS4nzWVbGQhJA2tfJFpfedbYd+KvUvEhv7A1shL1tWMYKDU6SLdT1xn7YdxvHW4fSkPEczt4pSExH3wdZcspekCv9iQgrau2ySYdLXx4Y/CruzO1xnZFec5AWKIuO0wNcVFUOWdxGmutLHVSvzdqyEBPvIlOEM7HrSX8lMtPOpuS6NfZ5/xE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dd97ba-7126-48ac-133b-08d59db0e88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:06.0187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index a29730c44850..f9d87903ef48 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4818,7 +4818,7 @@ static int may_commit_transaction(struct btrfs_root *=
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
