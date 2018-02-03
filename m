Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681266-2-2866900164360904320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciisv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681265; b=ld/R43hMLUfP5lpyMV+zty7+8joTO/9r+R9qTyDPDFGBA60
    87xp8ElzAlH+9bnYJFyxuzASCBec0zKQn1RIHzah1sD+jJVWnbXxj3PkdW7Ns6qj
    mPwyQBVBi84K899O9zjJKYK9c1u5NgadsPypdl5BbNy8ssxX51Kan4FWwSyyqNFB
    vryk+Wxepve2rzmaI0qBHJIEDbB4Y2x6w+Phv7vDCNkp6s2R5P/R2gpXnGxCbBB3
    hpgaWTT1VURmaTagoQcB3B0jFCfW4py97wHcGpp1iMH/c/8c9qONDZynkCUJC64J
    uR+u4ce8dMe6C/PlW2RpOvjhQpgZ9T+rwBvizPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681265; bh=yaA4sl
    5GiFI09XH9X+/BMKNkUXMf8KMwkCyPhkt65yQ=; b=gLhN7pydMLWl5OIVjMIXCW
    Co6lKwyCndSZiNWHKSUvkgDK+qBuS1BQIDLPfUfs1/V03dfFOAdvVWSyRJrK/nlZ
    /xp8wp1Qj6GgujmNzIfGJ4FROW9cUw9F2+f9N100gCnFdMVx+cQjPQfSLA9FqSdk
    tzXCClr4TzpKEJLVT4ZiACJ1Z7MvLvog00Rk62S++j3Av14nym5G4bwV5QBI4ZuO
    SmF59DVMWnSmjt+OHIaNQR2B5IkongmEFdYJEiOeaYHFlRhKwAKk20aKP/udH+JN
    gX9UYrCXm+YEEnCyfP2/NRPEPZAnua2GmYwJ4vWyzzFXrT3f/jzPVJXUY5bo625Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dsx6dAAB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dsx6dAAB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753112AbeBCSHj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:39 -0500
Received: from mail-bl2nam02on0115.outbound.protection.outlook.com ([104.47.38.115]:21822
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753353AbeBCSFJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 096/110] nvme-fabrics: initialize default
 host->id in nvmf_host_default()
Thread-Topic: [PATCH AUTOSEL for 4.14 096/110] nvme-fabrics: initialize
 default host->id in nvmf_host_default()
Thread-Index: AQHTnRkDISDYiIcGGkOSXfpHMOG9Aw==
Date: Sat, 3 Feb 2018 18:01:29 +0000
Message-ID: <20180203180015.29073-96-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;6:UTr0c39AHfEHG1iSTLld7OdHPamu8UHb+i+F1Azw/CfShVpEz6/2G/fYdu8J//dsD50LWm3J8X5mCJVXwJbWyPPkQZdPCW56DX2qQE4CzISZJbRUR3/kYIXUioIkd1Q9ekh5hSKiAmcoMtR5ZQjYQney3G0Ihxc0tBbLVhTOXmFD7XZR8zEUErvnqp68REebL2F1SCNfhBdQfIRkBjg2+3puNWhhQP0uB0fMpG9AjNcgK7ETFPrXJJzUDvOzlgjFde9m1raChOFjiXxKrgpUirgCiX1vsBPrO5+JjgzL/OJtE++ixzB3/vZ1MKpQ1C+E9c2oXe6ZoRQMNk/L5EExTFZAVCafIWD2KgH0cCN253o/numQ0TzYJmqf9TCq7hyJ;5:ndrhXttMfDyBjNC1Wka6QuOJ92kpX2W98FmjB+KlGiTRrRNCvRDKwBSZcUuf8SxJnaBUOUHd8uF7O6F5BFaXbUn+J02/NrMQzX7/jnAzYDlvhZZhTeOW6P9e8SerATeWQajQfWY3GqSRNmfntl+Z8N6yy4r76wwReTKPkG9l/7s=;24:xF9ygvHU598aKuVnsx+bKUh23e7Bb8l3qeix+JblGdwtr3fRxPmA4Us/lDtXfmo1ipyUF/U6DM10Plx17bjeVPHvtfhIJxpzFFEbfSWZULU=;7:BjY08m7lao92KWJbu/Hfs+jf/g7JW+XGh0mSI96Mixh0XHeB0QdWZSYVXAyIB/trqA5kjPVWjMLh+DTSza6AnlJqefIAhKtJZqfXF4BGxLQ5rBWTEYRdXQNpwBgSlu0afIqElC9SQJvYcdut7IziJ+vGG0PByJ/bhmIKk2m3QscyOMNDX0bch4UXvPNVcHDKQLwKUDHGNqpIghKjgnqfVwOCkRLLu9rAjruzPS6QlmMut5roXmuJxFLtbJp0XlT5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6498f20a-dbc8-4651-97c2-08d56b305635
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB10413C1533E3101F59789D74FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: I1xjq5suoEnEsLuPQAcBx8BDWbfPRkmq3DHXgwgfoJrybTCUS50TAkr1EVwdosD/fIk2a30yqCgwmC/cxGwexQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6498f20a-dbc8-4651-97c2-08d56b305635
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:29.0815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Ewan D. Milne" <emilne@redhat.com>

[ Upstream commit 6b018235b4daabae96d855219fae59c3fb8be417 ]

The field was uninitialized before use.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 555c976cc2ee..8cd42544c90e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -74,6 +74,7 @@ static struct nvmf_host *nvmf_host_default(void)
 		return NULL;
=20
 	kref_init(&host->ref);
+	uuid_gen(&host->id);
 	snprintf(host->nqn, NVMF_NQN_SIZE,
 		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
=20
--=20
2.11.0
