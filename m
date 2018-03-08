Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489607-2-12165907312728523976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489606; b=uAYixXytkXZ5zMUdY6e/7vgsUAnhIKli4oYI6ZlSqbSEkyM
    TomW35CcRKdlUjoS2mUjcl+Cor8YcNKxIoZt9LKl2AHSLpJ7obJDytpBt6VxzKmv
    a24gu0K6/JuO2PeusD0jKOEVb0kpz4xIjooXnQ5e2yLa1LC8AuZNpCHsI5UttKnV
    LJ7B4wcia7EBQ2L0atRlmMFGr21/B24AxYRyalS0sYlMLNQHaKDIDFQ5UOcjfKes
    alQkzFFdnIaaMK67MqrN1qyJX6Q05hdPuLdtnHpS/5mtwzEX3CI15g1L0UVJbPUn
    t9dDi70P2MN3BxBstzgmi2dCDV/D4DJ2l8oRbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489606; bh=1WXC6l
    4oGfs3EGhIYsOOYJHWuoD0M6mNUx2YpmzUTLM=; b=BBe9OUW9BMuVM8CweZwHOu
    /+JL1pK3LYtctmoovnACI/2dH7Bza+/6GHymeCJP+XSXk4TkcRn+q/jwFo90dUIF
    82JXNS2411fVCORtv9q/D3HOmbl1DCEniivp18tMcPFc1tKk4lsi0QqzwM4SmBRV
    VR7dKvHMaYU2B7UJdKUyk8FPDOv3Ym7VjQoKnUAqzol1HMspCgeYo3NFNKyiKCBn
    PSifNDPBPTQu7B1kieKIJj5tL19Wi2+MC2pYi5edWC9AWkORK44imrdjGXM+nERr
    NUTnh91PqsXi86j6G/IumN9C3gCmtkrFc3QP+6P9JuXoM0kc7Ep5CQJIFEu7IbsA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bU/Jucy2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bU/Jucy2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965979AbeCHGLy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:11:54 -0500
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:43648
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965406AbeCHFBg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:36 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maarten Maathuis <madman2003@gmail.com>,
        Maarten Maathuis <madman2003@shikahr.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 083/190] platform/x86: intel-vbtn: add volume
 up and down
Thread-Topic: [PATCH AUTOSEL for 4.9 083/190] platform/x86: intel-vbtn: add
 volume up and down
Thread-Index: AQHTtpo8ulSdZLu/QEWTtcDpA940aA==
Date: Thu, 8 Mar 2018 04:59:28 +0000
Message-ID: <20180308045810.8041-83-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:xHTE1037aR6TdF+iYVr1VdSeBDO2IylkIYunB8aZvA3Z4XL7PORi0jnJ3d/J7JyigaEZPhhFLDJ4+gMyL5CvJconqn7Bx/qQNQtaIcGowVE/wpWIu1FhqKGjWradwjtHuHOT36dUJwLvzOD/Rm+kBHofVOhcA3cAWlkd/9pL9DorzPLFjO2bDyanqHUzsmkM9Ofq4a4uGIwOMJK7V2Hxi5UcYOOA5tuOkLRjWYAJA1jIxlaDCDtryJfeZTcewFmn;20:Aj32MYUj8PmIAochRc++BQSPCjAaAg617T7TLNomRFIYehdXpdh8aVFZ0OAYOSkt6+k7qrReVYvXALfBKM4DWns9xAH5QOWj0LWWbizOrwZC4SphEPnO+Vh9vMEt20YPJyds6hd3Dr/faFP3pjgJlB5fvb4SrI4S21cJK/S/0EU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45dff2c1-c0fb-44d5-5bb6-08d584b1a777
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09990D653C854D4B81308573FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(6306002)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(39060400002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OwN7jfn9toYKLcpCkiCYxu7PT32D/rgDQOs82FeG4prHS08xxjQTOmKsINkNgEVkKn9sUQlsNlNiO8zUxlEXyucC9k5fsCMnq3CvUZkfwH3GUoXWPmyvMOpxCxuoKHBWar51TnxQvh4Ha07BWo8nFK3S41amMiM09hRJh37A01Z9BK5PY65URunvjCwWFL8EVFIpj1sHKzNbPjs2x2HjZjeQZ3xqqqjmcMMk2iz6dFhHFoh5Zl7UM4SkSAWeiUPwpO/L12W+MO3EvtWvJoPinN1GX5Fo2EJMvegpD3SedcNSpgxZz8iVYBugI1mHbwTYaJ+4IMPrtPCn5R16TMqXLA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dff2c1-c0fb-44d5-5bb6-08d584b1a777
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:28.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maarten Maathuis <madman2003@gmail.com>

[ Upstream commit 8d9e29972836b75eb74f533594999500a4c7cc19 ]

Tested on HP Elite X2 1012 G1.
Matches event report of Lenovo Helix 2
(https://www.spinics.net/lists/ibm-acpi-devel/msg03982.html).

Signed-off-by: Maarten Maathuis <madman2003@shikahr.net>
[andy: fixed indentation of comments and massaged title of the change]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/intel-vbtn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel=
-vbtn.c
index 78080763df51..a74340dff530 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -37,6 +37,10 @@ static const struct acpi_device_id intel_vbtn_ids[] =3D =
{
 static const struct key_entry intel_vbtn_keymap[] =3D {
 	{ KE_IGNORE, 0xC0, { KEY_POWER } },	/* power key press */
 	{ KE_KEY, 0xC1, { KEY_POWER } },	/* power key release */
+	{ KE_KEY, 0xC4, { KEY_VOLUMEUP } },		/* volume-up key press */
+	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
+	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
+	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
 	{ KE_END },
 };
=20
--=20
2.14.1
