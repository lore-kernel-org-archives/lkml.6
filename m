Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246257-2-82587464879870236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246257; b=HmZS7uY7AGvNe6TOjh0I0pNE4MBK4ORZWbunFOxQpXB0Ge+JzE
    BOWeEoJj59VtIJVK6MEik+QOazARbdELIqeMLLGYBirMitIUByCK9lW53umW9361
    0N4VJcVPJx9ULsAAQVLoZrP5UuQDoDerdkpkEUlmE2YtS5bLZvWVfs+X/GqHXCZZ
    JfHCIsV95BNNsC4fEFmVfN2TAK7nuApWVIFngCJvT2nKeQ4YzQg0SAe/kt54P9Ll
    y0oCCRQt/iZ3tlRw+vrn/yq0frzbZSmDWdKfPMv7I2BVZsPA8U01jJWENf91+UT9
    pADF1H4k8T7uRvWIdIiKusOJceG1sHK1gXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246257; bh=Pkl8pkHdyz
    H0S3VMlALYkrb/F2nQ7eANsuzaFWbVHv4=; b=k/740IkIscIk5kY7CuMth+on50
    gZWMXaM+2xhCTesFJYzAz4el98TM/n6TODnevPPV3y6JM0zGoFqMyg5gfxF++/G9
    IqpCGfq2dIzz+V/1oCwYrKawlyTBXIayER3T111zWiaurK8LwR/q5BGqFngqrMfy
    8VI1wI3h3SxUPhtxIFdW1DqVP9F8fQwgdzMAIul/HihqP9Uag2ScGwugpdV83X6O
    PhTUGr9fM1WqsRKNqpyq/RhaRTLjlyZbgIuGyT/No3yavI+F1GTPTYAlqKeAvZFr
    ieYV0v765Vni6EmRM9+MzlM58z+qEFKR2LiYTxf68caKIybGrtOxBG81EyNw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HfBX9s5x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HfBX9s5x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCEaHc6iw+A9irQlKGZR3jrl3yKWpRXGWUU5tl1Wi3NTK4ouKKXXS4ch4CTkhKm/Sg3KjHDqQbHoV80NzIICQXjWu65nbDxOQwaBk42sHBV1nXvjVs+R
    7+rcuhVvC0Q51iC/+38jya6BFWx7EUXEj4AggWOYntUm6pe2QNoAbzgbmexpOHp+3xEiTX8Hdn8kDriSoFHmeOMuWfrv7EYOBH0YZuAxhjjK7zaCz5DC2oO9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=b8Phnph2cacwq2ePh48A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeDID5J (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:57:09 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753723AbeDIASm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 076/189] selftests/bpf: fix test_dev_cgroup
Thread-Topic: [PATCH AUTOSEL for 4.15 076/189] selftests/bpf: fix
 test_dev_cgroup
Thread-Index: AQHTz5guhiGpA8wpR0iaHl2RDRsY+g==
Date: Mon, 9 Apr 2018 00:17:44 +0000
Message-ID: <20180409001637.162453-76-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:k8hxp4282cCqzquvQo2yb/CC0NRbxt2OfNt5VkTwnlzAPo7/hO5BnPuUOlGldIdSItdcpL94XqeWAA4+IUlNQRBUFjrBQux2zktgcz2UainuOmwEq5SkR8/XJOb7XTY6sN6UKiEZMX9Xi8+WY+ytzC+UykkFsWuiI1A272YeqsAGCkdUGj0dkyxS5uGvYOIYqbywAOerV4X16qgMNxM8V3ETuAfnEYv6vzCBl0QvlvZj+4hE2FVREz5Y8BFiduJT;20:N4cQjzymbFQcKtUfriy2p2ss7/FJFzX+4bZBCj2pCuLbQ6lwxZOSq0bMAdQbWgoR8kRK3u6OH+sNip7+YBKIY5Pz7ir9gGJMEH6cAM1lO9kHXc70oMSVNJOfobwpKXWuT3Db191UZA/Oy/WIBT6KSdY9tEMbwAR2spFU2CFTXac=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1eeca884-b364-4d3c-dad0-08d59daf6fb4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128316B8F6AE7384475E213FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yEAyQbKJ4hESwZ0lGgxhxCCP+iRx/LqOhH4URm0i6mClazyKxlhrLoNkNBSIiNM3u669/WhlkN11QzvaC3+P+9I63kyeIZDDidRUrqU0ED1k78YOyYHb4ksAPVhgWsq6DpZhco06chUS2UiKxV+b6Kwp27kna2dY/I+AHCGR7qiVW9XkMqSbg6usl+v2oLQITsZ+CbvsQ6LBdAK3qsoeYJO0xnzitIVcvR8mhpIjLg1DraLeEeNg1gsAybcxFlJZ6w3BsKXmWp6rrLi8aPrmu7zfnirTTE6pWzl5l71wJlpBb3SbPi4AE4Qn5viXq78Gw4rWr4c2tbyLDItXnZluIbREfupEDDn9aoFWDGle97MhXPV6faU/9DA1ZtCPFRMAh5jWDrNC/fqVLXDRIcmayTPKecfg+XHBVNZkpXhSDFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeca884-b364-4d3c-dad0-08d59daf6fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:44.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 8e6875250a1189e0d8db8b05e18abe63c2744521 ]

The test incorrectly doing
mkdir /mnt/cgroup-test-work-dirtest-bpf-based-device-cgroup
instead of
mkdir /mnt/cgroup-test-work-dir/test-bpf-based-device-cgroup

somehow such mkdir succeeds and new directory appears:
/mnt/cgroup-test-work-dir/cgroup-test-work-dirtest-bpf-based-device-cgroup

Later cleanup via nftw("/mnt/cgroup-test-work-dir", ...);
doesn't walk this directory.
"rmdir /mnt/cgroup-test-work-dir" succeeds, but bpf program and
dangling cgroup stays in memory.
That's a separate issue on a cgroup side.
For now fix the test.

Fixes: 37f1ba0909df ("selftests/bpf: add a test for device cgroup controlle=
r")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/bpf/test_dev_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/=
selftests/bpf/test_dev_cgroup.c
index 02c85d6c89b0..070bc3c9a873 100644
--- a/tools/testing/selftests/bpf/test_dev_cgroup.c
+++ b/tools/testing/selftests/bpf/test_dev_cgroup.c
@@ -19,7 +19,7 @@
=20
 #define DEV_CGROUP_PROG "./dev_cgroup.o"
=20
-#define TEST_CGROUP "test-bpf-based-device-cgroup/"
+#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
=20
 int main(int argc, char **argv)
 {
--=20
2.15.1
