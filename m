Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488142-2-13024753592937248799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488141; b=vgj+1WmEZfORHv7QjxAMXpPOSXn32G3Wh/ymz0bZDfTvwbv
    mBVFqhL98SblV4ooj2cvCpve5FfXGGsxRF5t94kS75kHfp0tWMSf40PpN5AgMBPI
    kEzhQ9t8fLT21irVi8dP9H7J/vlX7GnQx8qPzmMJgHFob1ZNKnmj1DmYtBgMg9Yw
    g3vIRZHyx/t5wgzynryKTZ4eR6vAOVn9A1SHHjDKz2V3LyxRzSRnMBPdHzz9hLMu
    EYC356b7rbMuD4IqJTKCExkGpGdGPPbAG7TMJ2zTD2YQSmqpLtSVPnTybXVhftbm
    c8Fa9oAnR1uL6RbgWdnsQM7lLRFzsoCkj9i+OUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488141; bh=Flq6nb
    l8ndIraMnZL9qw5DaRI0p5t3dSkxfDweNMlYo=; b=UBoeQ64asLLj8vgJvZlk8w
    PztZKZz7RLkF6Vc6ecan+CclsydMox9OpLTp4ybr3obs40VoPY8a2AJNBghqeP1u
    7EHcxUWtMRhmDUrQl/su3s9DChMcuXoIUUCWwtfeJYT/L1Vx506jMwRRtjhkOIJ2
    /cSKzjA//razFVfR7YWeOylLjbUeecT6SRkXbwqRRWwfUFkIYWZ4DRYoeAE5Y9fW
    wJSEUPW36vvhPLUKD/xPCaQWPWiHEe9ngmD+U6/d/jroqZ/A2JGqKzGLdE7MYR9Y
    NVB74IvJxxASoKRSxp4PYL/6drnwpXYCUFbOsToCPrsFosMqGHn53TRdcz029B5w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BJ3FDqFo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BJ3FDqFo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966305AbeCHFs5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:48:57 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935569AbeCHFFB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 183/190] ip6_vti: adjust vti mtu according to
 mtu of lower device
Thread-Topic: [PATCH AUTOSEL for 4.9 183/190] ip6_vti: adjust vti mtu
 according to mtu of lower device
Thread-Index: AQHTtppXccObetgXE0a5UeOJI1a1KA==
Date: Thu, 8 Mar 2018 05:00:13 +0000
Message-ID: <20180308045810.8041-183-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:SnzH1V/sOdWyG6dI7mauWbaxK02EYq5go9DnHkU+yG0MctoUdzFQKJIlO5LchQUK7wLW8FninaDEBUiOVHkwpwaNR2QUhKj5FCngtcwBZnHTX+lbyxfpsejQLwlrbUXbESlVshwbQy2dQbeQK6GOpbLWAyByejR1uKa8NyZrhDfwxMnVR3Nio7MzrR+gl8QJTCnVqfu6pabceOifPyJfzkAVMU8UoCNhYQaATu4KDudEqTKsIVS7SFeVc201uDeh;20:2wRe9/X7fE6QfNpl3CCuFD4UhgcnwnRPSD/YzYstGzrWHK3otVSykeEf7w2O0v1jL7nlvQ4YS2o8y4wBWrtv+i4/SlqD9klfSQXRrlIC0HljKVcN35C/dXGDfW9xDE/TSOSzlUHRxEdViunD9ZNjAeb4d+9fOQSwElrjR+588Po=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aba817fe-9ffe-4764-fd8b-08d584b2244c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981615AB75552CF1FD9161AFBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 5hx8Vy8Cxt1a5GOKJBiIoL9TIF4zVqcoM8Sq5ewGZvirB6JQEgQpdkVPIWoHMk6eUxoUqfNwanSWV0nSxns3uwhSz84hBtOoYw4f0t22/2kKwkOhwSXyYfypOfPsao7w5YLWB1p+WcYBtsJmsPH941srR8PLJMK8p8mQ0z+w25f4RZRMlkYOCi9R830AN0jtbfJnmpNbaqtR+uH8y5j0iPWrxoDwQaZpM2v6+fAZQs55LLo3JzYX85B87VVy9nkzwVZfax/YCD0M4Zj6GV9UJYKjouq0AuXEOh2qRznEQqpzg2H7wKqIqY27e4WzBszJc/x5LmTTYljlaUhzjmEuCg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba817fe-9ffe-4764-fd8b-08d584b2244c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:13.5800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Kodanev <alexey.kodanev@oracle.com>

[ Upstream commit 53c81e95df1793933f87748d36070a721f6cb287 ]

LTP/udp6_ipsec_vti tests fail when sending large UDP datagrams over
ip6_vti that require fragmentation and the underlying device has an
MTU smaller than 1500 plus some extra space for headers. This happens
because ip6_vti, by default, sets MTU to ETH_DATA_LEN and not updating
it depending on a destination address or link parameter. Further
attempts to send UDP packets may succeed because pmtu gets updated on
ICMPV6_PKT_TOOBIG in vti6_err().

In case the lower device has larger MTU size, e.g. 9000, ip6_vti works
but not using the possible maximum size, output packets have 1500 limit.

The above cases require manual MTU setup after ip6_vti creation. However
ip_vti already updates MTU based on lower device with ip_tunnel_bind_dev().

Here is the example when the lower device MTU is set to 9000:

  # ip a sh ltp_ns_veth2
      ltp_ns_veth2@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 ...
        inet 10.0.0.2/24 scope global ltp_ns_veth2
        inet6 fd00::2/64 scope global

  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 1500 ...
        link/tunnel6 fd00::2 peer fd00::1

After the patch:
  # ip li add vti6 type vti6 local fd00::2 remote fd00::1
  # ip li show vti6
      vti6@NONE: <POINTOPOINT,NOARP> mtu 8832 ...
        link/tunnel6 fd00::2 peer fd00::1

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_vti.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 912333586de6..345efeb887ef 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -625,6 +625,7 @@ static void vti6_link_config(struct ip6_tnl *t)
 {
 	struct net_device *dev =3D t->dev;
 	struct __ip6_tnl_parm *p =3D &t->parms;
+	struct net_device *tdev =3D NULL;
=20
 	memcpy(dev->dev_addr, &p->laddr, sizeof(struct in6_addr));
 	memcpy(dev->broadcast, &p->raddr, sizeof(struct in6_addr));
@@ -637,6 +638,25 @@ static void vti6_link_config(struct ip6_tnl *t)
 		dev->flags |=3D IFF_POINTOPOINT;
 	else
 		dev->flags &=3D ~IFF_POINTOPOINT;
+
+	if (p->flags & IP6_TNL_F_CAP_XMIT) {
+		int strict =3D (ipv6_addr_type(&p->raddr) &
+			      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
+		struct rt6_info *rt =3D rt6_lookup(t->net,
+						 &p->raddr, &p->laddr,
+						 p->link, strict);
+
+		if (rt)
+			tdev =3D rt->dst.dev;
+		ip6_rt_put(rt);
+	}
+
+	if (!tdev && p->link)
+		tdev =3D __dev_get_by_index(t->net, p->link);
+
+	if (tdev)
+		dev->mtu =3D max_t(int, tdev->mtu - dev->hard_header_len,
+				 IPV6_MIN_MTU);
 }
=20
 /**
--=20
2.14.1
