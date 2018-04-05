Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1432864-1522892119-2-2230140812121898945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522892119; b=q6j1yNLSq8zcyrFVYCVEaZ6VAgU5c7kr00L5H/Dga3yH/ZkYyi
    OLIemroTsjaw00ibkkuh8yWHCbF0d1lZXCyuLMtsYW2xqLMf6dmd90oN0Cm/xPRV
    b8nOC8aE8QoD+0pEKgZB1E0WSfSSOhMXwCS6PSXudu09AeUSrU6deLnV/Qup6R51
    S8uo++va6xSPXQpA4wWAKb0n7PRDxrSeHEB66BEzZ0PimKX7hhY7k9cSAkcxUUBA
    0BRS+ej4Y+BD0y2AEfj1+lqjN3eiohffOCSfdHwp75yVpaVZPpegctZhOw8nKQVQ
    PFFGcyosRtKtJOOjDnjBuj6aSswjjGyXW6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1522892119; bh=RHqmupeQZN
    Tz6WO6zWms50AQ3Uh6Md5WL/4zw5ZZgI8=; b=nf9j8RF40a1uoYH2J3lNpx12lY
    RfHjwikgdPDyOWyD9um38M6f5Lh3z7gfgykNAY4f/XVyRAVdb6XkCLNQl+itJYgM
    AOTJp/eB2HTeW2DIha1gaf2x/mMZUWeRruIML+NTD/l59qqRyFHD52YvXLLCD7Ev
    Pc45JZP7Tna0QMxbcPAtoV0kr1DUUCa43vik2LmnxADVJ69IBfa0jl18lIYY95H0
    iKhObt05BYYKHeFTdJH3pST1oIQQK0GVTGdBf32IAixi4lexHc5USxbrPV5u24TS
    uN/ZB8A5x4Av7qxwFvemAxLWbWIURQVdv/r2hVmS8Kec0I9cSb+ILQrtpO7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d1mB28gR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=d1mB28gR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNyDYbshgTNYZFsUVdVKJzmAbXhNzaDz1cKxOJYS+uUQQlH/OUmufsej2XlS2RDebwDMMtrFhx3jVicBiMh0cKi/e9mZiPnIsjEKUabGZB7cZ8ccler0
    RM+DrWCQPV0aYVxocS1cIlHLZ1LxpqN+mExzBX0gOIXiof5WAmVlf/SidBWibtTd4F6TriCsg0mckzjUxbmdFxrea0d7dnG9R0Zey7ZQbHqc+jEGkmUmrVzW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=Gi046VCKzXYA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=0dTTINSRTSE6oYq6QsUA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeDEBeH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:34:07 -0400
Received: from mail-bl2nam02on0112.outbound.protection.outlook.com ([104.47.38.112]:13708
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752796AbeDEBeD (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 21:34:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 02/45] Fix exception_enter() return value
Thread-Topic: [PATCH 02/45] Fix exception_enter() return value
Thread-Index: AQHTzH4s3kif4SBXHk6PyFsZ0lcLQw==
Date: Thu, 5 Apr 2018 01:34:00 +0000
Message-ID: <DM5PR2101MB103227BBCFCF584F280BA8EAFBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <152261522745.30503.11022506204837457606.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261522745.30503.11022506204837457606.stgit@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:uVW+55fZmWIgMRjWX0ehZLBwFqF4BHUiiUicgc2FZTWrzUJBhhUK5pwd8WfQkEHDAKbxUteS1PwE+WJZJYAxYmVzdehnsxYjOWMULQ7HcqaUOFIe5KVqxjnboVMtRBGpXdvIa4PaffIIjp7q74zbkJhkgKkJLHkNVc0+6UDa/4Z1DaoPf4Flls4mjiz4bBL3nNT2jMfbJ9wMO4ydsNYecG+oWkhsASa4FS4SNTC7qzeitDTCGUmBbz/cusH0L40F;20:oBUQsw5ZyxEof0qy0/4X2pvOPG5PfvP8UeqJxaVodtrF0mZ8yGlpneYVrIXBIZix0Jr1aCEVQvPAxG8hGFMlqHGwgH7ueTzOFoPyNVcFmfvWLFtfoz+pjWEyNGmNLzR4XKlrpOXUK6+Lq/MBqfGWTBQDXlwnE1YISfb0LModjlY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad6052e0-7843-4f59-5ad1-08d59a954f1c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0933E5505ECE1E2AB9E2BBE8FBBB0@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(86362001)(97736004)(7696005)(22452003)(55016002)(9686003)(110136005)(11346002)(14454004)(53936002)(5660300001)(99286004)(5250100002)(66066001)(8990500004)(6436002)(6246003)(26005)(4326008)(68736007)(316002)(10090500001)(2900100001)(446003)(6116002)(72206003)(3660700001)(76176011)(10290500003)(81156014)(86612001)(8676002)(3280700002)(106356001)(33656002)(476003)(2501003)(102836004)(81166006)(478600001)(305945005)(105586002)(229853002)(74316002)(7736002)(59450400001)(25786009)(1511001)(8936002)(3846002)(6506007)(2906002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Q0JeWkS6Vr29/h/42GsiqilatWDIBJj5iHAX67hAWSdQDL3JaERIZBBnGzsgprfMtCt6YQ0cCuw0MnKl6teBFM2lssRKgI/zNU+8x46/GgZyCmkkKbxlb7nucolQesGc4+1csDplGDvB86ITXM+/SlOmDLMKf8G6zgVRmajhzvtD3sOzIBD71qO4szlxziDsH3H7LlfAKqjywWPlPJp2LwgX8MHKQdcDiLWw567l6hpyotldlyV2wLO3Mm5N6k7izqJhqWy9wVlg6oh3G1FqPtsFHl1O+6ZF9DcludysMIfXQ8EnjxcXf8pnRUHRYWhyxfNChimn8LbxUe3av2Mq+S8LelVnAjS1CdQmhng8uteiZQxhs525py7PZLViv0DBB/DQdYilfaV4YedgtC+6O31Tq2UR8+GrK6qDSe/rZm8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6052e0-7843-4f59-5ad1-08d59a954f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 01:34:00.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi David Howells.

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 5.5190)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Failed to apply! Possible dependencies:
    2e9d1e150abf: ("x86/entry: Avoid interrupt flag save and restore")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks.
Sasha=
