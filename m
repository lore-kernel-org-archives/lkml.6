Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683500-2-4626516608551694878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683500; b=sUhXWVlxeE9uDue3yaJ1YDK+vHPWgG4O0HQF9lgk5UAaEBT
    vks7WMiOV7xdC9oX6s5HkH/xXcS8TEcWbT9RJLQNBxy5Hl1x04kdmF1xoWte1QsV
    jhz68e1bzH7TCpd7xmlhchTBD6V3FHyrW6Ys8CslJiAwQKmfraS1jNSctyGLA7wU
    MQ5QExXzSYWeZbrF9FjqeiYr2Bp/3FsGfExLERawTHBz3kxpumaa1xxitgCyWf63
    QHCazxyX9mpH59VQziKatHwTzcUbo+XFO/0sH+sMLnRI6FFzjjKWg7Jb5GKVZrMQ
    fxqaCuh1yJT0x+C0MSiieRm7xW2I8VnkAWDw7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683500; bh=F53XrF
    qFfXxUBE2k1r5f5Q8aRkYDYmi+0U7Oh2/7CCQ=; b=GECuWUC4dfI+34vY7vY970
    XQV6lbmBqFg3oWW/VCCNjp5GP9lA2Jw9yehUa5CNJTUcQktmLrN1J5gTugtgQlD6
    Wud4X9YuclEABMtZK6W7V23Py2BBO5gPqR2igkuGNlyOzFlR9sAsY9alXRu+3qBW
    U/0UFCWJaKBvkfTk/6pkJ9047QBHPGwBHUclQ1f3jCnGvQ8TsZ6Np1eLiuH5729a
    d6CMaRPYCheYzBTH9VxrDQ7u2G75QalfWm3pvHLXIJF5UHpDfuX2ceUsSy0YX0FY
    EbG1/zPv28TKWTvhMKE1ZKr1vqRS7rynLFqCJZWJVEk+kuxDanz2qRHKM1iwq/Pg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VVJjxKyT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VVJjxKyT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754823AbeBCSnT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:19 -0500
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:41422
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752748AbeBCSDJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 036/110] ip_gre: remove the incorrect mtu
 limit for ipgre tap
Thread-Topic: [PATCH AUTOSEL for 4.14 036/110] ip_gre: remove the incorrect
 mtu limit for ipgre tap
Thread-Index: AQHTnRjqjMqkUU6nnkyJvxYVmBUTHA==
Date: Sat, 3 Feb 2018 18:00:46 +0000
Message-ID: <20180203180015.29073-36-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:RmMqps05tizCIjVOQ2UUMCWz451JO4rCKWnySRd1gHOGPQqDckCaVoZngpN4oZVmbMta8tG52uXjg3gxohIEPWPTPkax6vcfepr4X7Qig+n8Z4NlQdcZzC1SSYkwKqcl+8vvqW8CrkcLs7i3h2mrbAqh9iU/QDT3bSJdzYWDZE4iVHt+A9aC7Z3rFllTQmAam+O0+tWqkWyiiXvU4/oK9KAODvJD+eaRad1kA7blkZV3qXvMPbI/LMaiN11j/azfHdZ5aNH8sAcRYv2R1nrpowaaMyFVxAgKyV8NqWvijMHUiGIXDDzGW3R9uQoQJ7NSCqf953kAELjchWOmi5BVkiQvoO+Aj5toaP513WwldB0zgaMopUds4qISmC9+PDCq;5:vO6Lh3PFo+6yqLXBPA+g9vWaueiEcFlcfqTuuNr69C+bkyHQQuSieemfU63ozXdGorCHgdo5OCFQ0fkph3J59ml9PFoja3AZcmbcop8UlHlCLg2YGhI2tUgLsoWKD9eXnX41faXHw8INy5aAxnhlh1O8inGwMn3Jlkbdhntz+E4=;24:zf3ozWAFFEzrpASiU+or+s9AIk5WTpzNS6EEY6MhuMReBah1uvJVMK20A/AHG5b+w3QrnOQsALDVlfE4MscyYh4H44d1RtNDnfr0GDi91B0=;7:V3ZCPLJng3GBRGNlSUclYemC6z99wsKVVrhBnmYobJeQrkYQjN7GcXrq9ztYc9Yzdozy4vFkLHEIWaKb/EtdRVG7syI6nkN9iqt5rbs+B2fJY0D2Zrve5vOpZZpQbaOHOxEfkV3Fhm5jrf143KH1Rpjw0dkUzbonBFu4YMys1OHvP6szLReVn1oWQjI2YgXWLz9grgXYxthx5KhXqj3ZzmMssGG4kn3MmTocT60PR7El5TEcNjdRa7BYl0R3dDzk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a433e880-169e-4d51-c3e5-08d56b302071
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB10907EC5F326E7B88AD892F5FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(39060400002)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 1MOVt1Srt5Odf01hSC8wRO6o/i9sMoQLYinDAtd+LPFR+EBCoQAbRkznC5K121QpAuoWyA98fbXk1OeG7R2J6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a433e880-169e-4d51-c3e5-08d56b302071
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:46.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit cfddd4c33c254954927942599d299b3865743146 ]

ipgre tap driver calls ether_setup(), after commit 61e84623ace3
("net: centralize net_device min/max MTU checking"), the range
of mtu is [min_mtu, max_mtu], which is [68, 1500] by default.

It causes the dev mtu of the ipgre tap device to not be greater
than 1500, this limit value is not correct for ipgre tap device.

Besides, it's .change_mtu already does the right check. So this
patch is just to set max_mtu as 0, and leave the check to it's
.change_mtu.

Fixes: 61e84623ace3 ("net: centralize net_device min/max MTU checking")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ip_gre.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 045331204097..1933654007c4 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1274,6 +1274,7 @@ static const struct net_device_ops erspan_netdev_ops =
=3D {
 static void ipgre_tap_setup(struct net_device *dev)
 {
 	ether_setup(dev);
+	dev->max_mtu =3D 0;
 	dev->netdev_ops	=3D &gre_tap_netdev_ops;
 	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
 	dev->priv_flags	|=3D IFF_LIVE_ADDR_CHANGE;
--=20
2.11.0
