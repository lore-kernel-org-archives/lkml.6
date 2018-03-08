Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485200-2-4185971025151600201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485199; b=ANC8vEnvw8KePWTwnKsIdKfHF4MiqCInfJizI2oMg06Mlen
    lbQosJQ2ttuuQD04SWD3CLEZdaJQMC5ZB456IMCYhx7g7fvGBd7PSBi1+SoaUQmc
    8xKwYUyv6Icl1Oisavnit2oEj/mV2/MLrB+0EU6nPkTWwY7vbbHAH3EgHCv+qvSo
    fwnnZrRQz2I0EZODtFlqHoS27YAYo5ZBX3rZZeJ9JqXRFsn/6H0pEqYiftQEFVgw
    BguP7IqpMThRBu9sdBycWGbxZ79qJ39x6bPup6s0uut0tZvA8xm+vZbWS0MwNpfB
    IbnLjRLxK5eegdOX0lWD8kP2oX+RWzxozYeu/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485199; bh=J7F5GP
    6frzALeVQ7fdvNbBEO/UsIh1GvQvU4hu+wxpM=; b=tjob+d0R5PKxHRrasxkGfM
    1hM30o2FdXAedIZCLgMz/mMmgHLOTHYeL7qveGPJAC9fcN51ruN36oCqjZpgIXiS
    tq/s8szVvhBQElPhppctqImuSGV3EJMxyAiO1zl8OOIFwV0UgjjZGTGLlWHWcVR9
    C26nhvAGBgjhmfIy5Ok/L96otjb0Sw5pTwEMLNxZx9COClDdvaEGZkX+ECL6S3uU
    m3iV6Ex0FIgPR2qO8ZpKg55enBFX9Q5oJfy0xxQCCpTAnytP2H+UGibqKB0Uf2BJ
    TdkSkCnVisojUJ8y4g/A9zijKgsZzeRlcQ6lILUMLzZZm5w8HmM9djSwc34GTgqw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fVWV6cDm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fVWV6cDm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965505AbeCHE74 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:56 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965473AbeCHE7w (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergej Sawazki <sergej@taudac.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 65/67] clk: si5351: Rename internal plls to
 avoid name collisions
Thread-Topic: [PATCH AUTOSEL for 4.14 65/67] clk: si5351: Rename internal plls
 to avoid name collisions
Thread-Index: AQHTtpoIdJRo5HR2WUSIvp7GGToj7g==
Date: Thu, 8 Mar 2018 04:58:01 +0000
Message-ID: <20180308045641.7814-65-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:QtUCIRCKRwFE23n5GWQgy4+6guE9Zr0SXLBvItirHJeNb0nLawNPqud/hFNpdpCQXtIQ+n8PPQBfUsWT4Tm2JgdhvA3EI+88U8DmZobiqqwKvxLuAbNPuF1ZRuN0CvJmLcvioVLH+CIxIvGXpAFipI5kQM6J5PC8Nq8Gr+qRYQjhXlsgOnaJMDJkjdtQJTDVll1MRfYah1P1lVpRMJHihWnya+Ur7aj+YT0oc6VlFO169u6trxMXw/KTrFVtJBRN;20:Q+JQ7F9ON6Gc/vnJHVHYwYAT7cDdmt0lcLxKtDJp3vVbhFxBqJ5wPdhTM2i3FPbzXF7rD0PJdhqFCuQF7+wCGLGXh5pgfeCJAzyd3MyV8FSrSgttgVhTvidvNZwUqWwAYtSTf+DyVYf3xMAV5BjW2Mi1yykr4HOaijV5N5amwZQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9f4a839-d87b-4c30-1b04-08d584b16b90
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09206B84388B7FD493A3434BFBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(575784001)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(39060400002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sTNeNU119XaGxTt5/83vKJL9NjWTQit1Wnzx5kKj9gkBmC6MYBOKojMEZuDBbPh5+csl4SIcEwBccZLznicomog+5sz0rEYGqiBAN1A6zpv1/w3iehQJwBzoi0MyOsJAL8Dxc3N7oyL4obU5KY9alJCYFE17EY1zK+1V1nvSbo6ac9ra6PIyKKi3jGaJshDqxiM/Qw9pWUVLfu5S6HhHUPF0JwnArqGeQkWaX33fLcVIVmKVkZB0elMZ8q2ImsUxgjT229zZoIBzZvQjr3/ek9OWyNq/rPfpmEZj39GRDyh/8Rja+1G4UcLwwjlfvKBccrWMn+dz6kQFhsuoOX6W4Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f4a839-d87b-4c30-1b04-08d584b16b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:01.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sergej Sawazki <sergej@taudac.com>

[ Upstream commit cdba9a4fb0b53703959ac861e415816cb61aded4 ]

This drivers probe fails due to a clock name collision if a clock named
'plla' or 'pllb' is already registered when registering this drivers
internal plls.

Fix it by renaming internal plls to avoid name collisions.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-si5351.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 20d90769cced..653b0f38d475 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -72,7 +72,7 @@ static const char * const si5351_input_names[] =3D {
 	"xtal", "clkin"
 };
 static const char * const si5351_pll_names[] =3D {
-	"plla", "pllb", "vxco"
+	"si5351_plla", "si5351_pllb", "si5351_vxco"
 };
 static const char * const si5351_msynth_names[] =3D {
 	"ms0", "ms1", "ms2", "ms3", "ms4", "ms5", "ms6", "ms7"
--=20
2.14.1
