Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242495-2-9669532520335025050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242494; b=ro9Ds+nR8PxU5ULYfBh6gt7bd9XqPbSrpcLRcfsGfrHOrPixxT
    HBH3DifIw7f/s7+GZpMZGlxXP1mkvvIdeS+QBZopEyAvwdp5RGlJ0R3WfQU1kcFl
    rd3tkSoWubNFGH+jkeLKth4r8zwqoMO56uYK8A+DADyRpuTHyqoyJynaM9aiCFB0
    anIMYfRIhxp+oAyRnNIz5Rk/I3V3SP9T8gyTsDXVgd6eRncU+tMLpRjoEHrIzY7+
    bw+SymOTjTI+nbTm0ZxPhphsB9lNDDvVyT2oztHUTrdqsZJu8Zi/c8z9DMcXEeFM
    tJXcYrupE+WNvtFj6176zHy4oIL7fRMHNqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242494; bh=Slf2OwMK0l
    wJ/oHNzqeUjh2YNbkTnGqTNNo1YRNnWao=; b=iaFVifLuBjLiJBMIYfVh+m0NyT
    edmPaMB9sSEVuklx8X1OF4HnpdqP3OiDU3iHCcU8jHuypa3EJhOCrp6eGkex2DRc
    anaaP7q7AzHvndrRFF0R+G67i1r7xA+7+6NZI3ARbTUkNmL9+6lgLDRmVw7BmS1L
    kHfewS/De78oru3rqXxgRL/jbDemaZ4bvcUr9IKX4a/y1XPhLP4CbWvlHCysPnNT
    Car3uhWL7uieYRa5RDRPyy3jWRhGBm0sISO0rIA2VSudXNBxnfYbpiZQYMAoJM6C
    gRHgn98L5P0bvcIwkUifU9PkkfFQPVpN9z4//KPjT0iEjoWOJw7lO2ahNsaw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BfSVdRSb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BfSVdRSb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPzPty3PuEO7ALh21KDG9eGVst1Snvtsi9tq15S4CN1Hc9fVufE3wo3/HDJRKuMpKXVN1klFctKmaMFxlXvrlO/hbV2YyLP28qWRi9PSY7QXcvKvmptz
    b5t/r65PTh+vIHPrCMi1v4uHut01h3j639zSqH4RLmvA1GNTY0SwG+AUlMWb76MBO7njoiP9Q8ULGb8BTMRQ82MGxIxTc1BLvkf0gS5ZziORswntHexsjsFs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8
    a=yMhMjlubAAAA:8 a=UhSkpe21RigDWVNyvmIA:9 a=wPNLvfGTeEIA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbeDIA0S (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:18 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:42928
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755265AbeDIAZt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 141/161] selftests/ftrace: Add some missing
 glob checks
Thread-Topic: [PATCH AUTOSEL for 4.14 141/161] selftests/ftrace: Add some
 missing glob checks
Thread-Index: AQHTz5i/4nx6HC62BUy5/SbBUXTNBw==
Date: Mon, 9 Apr 2018 00:21:48 +0000
Message-ID: <20180409001936.162706-141-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:UP1kEWN+QDCB7T202nAgpbVUvBEoR8TVDWia5hWkZgyvOliJ6X9uWPC5CaxPlOMwYtSzv4k2X+uo+ajmbjWseDQrKlBthwb4+5O2OOz91H2RW6XDtY3hHAgcySiDam1j8I4irm/84Vl6XNDjCh9SPhjhUUavFYGQa26Q1axBB8grl7kybWkrCEFuuhZIG582MIyIQttL8z81DBm5VIQs8bdiT5gIV0K67wH/0KAE9cd117rVgsrF9o/5nubupqW8;20:ZBrCjea6E/Q41gEX0mxQBK2YQAm5oa7dua8T964WNrV5zFlPzVcY4WwDlRRUiWt1NuM9UBxlSeRwEGtRGeF6xdNHD1b0Y4qHIS+rSOByMLrwMvXAtlfyj0ZNI9DougyHkTjo9wKqf1CknuxdERsga+Nl9FdG94g2BYcJbW7rfko=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 076b2ff6-b22f-4eef-83d3-08d59db06f7e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725463E20748C9CB7E5EA39FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(6306002)(4326008)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 87UVLgrxdXiVF6NbIIk4MD+IpgngDKqP4xab+lBf1O1YB/OJjmH3axqaLQMX6lQmI+l+xTEydIrlNuTQLE2ZMAnv0YQ2rk3UFMjIVD1ui6D9Nz2RFbPLo0HUfRtCHh/Ytvy0uhVtPXD8VHk2Eag/dHpY/I4CfBqpDSnScgFJJZtEUbzPIJwGccX+DvUnT9hhgA8sKy2i3/XX6ETz8kdyQJK3K1BMzOBGKVpv/5NE4euIz3axQhkLKxfLuMrMrKH7dguN/8/RB+AAQrUi0b69+VYLkOFQ2DjlGENajQhSvs9WwXUBi2h8NB5GsceluoMCTJFY+Wvs3GKIi4YOOWRUsWGWWkbnSiFqSCuR0JL+8KTFFzUipJ2C+Zeg5cMQyUb0dT8LUi8MiFp4HgvdoJONtzDPXhcB6de+4ixZr02gp5Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076b2ff6-b22f-4eef-83d3-08d59db06f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:48.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit 97fe22adf33f06519bfdf7dad33bcd562e366c8f ]

Al Viro discovered a bug in the glob ftrace filtering code where "*a*b" is
treated the same as "a*b", and functions that would be selected by "*a*b"
but not "a*b" are not selected with "*a*b".

Add tests for patterns "*a*b" and "a*b*" to the glob selftest.

Link: http://lkml.kernel.org/r/20180127170748.GF13338@ZenIV.linux.org.uk

Cc: Shuah Khan <shuah@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc | 6 +++++=
+
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.=
tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 589d52b211b7..27a54a17da65 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -29,6 +29,12 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
 # filter by *, end match
 ftrace_filter_check 'schedule*' '^schedule.*$'
=20
+# filter by *mid*end
+ftrace_filter_check '*aw*lock' '.*aw.*lock$'
+
+# filter by start*mid*
+ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
+
 # Advanced full-glob matching feature is recently supported.
 # Skip the tests if we are sure the kernel does not support it.
 if grep -q 'accepts: .* glob-matching-pattern' README ; then
--=20
2.15.1
