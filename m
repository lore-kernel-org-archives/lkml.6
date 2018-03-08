Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488703-2-10316171024534599478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488702; b=FaG0rc3shbK2oJj4YEZ9P1MiGNYExMa1VGnhk+yR9Bxjp/r
    wKVcjtlxPi8EZs7bheYwMXX/0bIM3t/Q2FmWOsyB4GsQE6qt7aWKpjUP3R9QX14b
    a5K9kmdUi02x92s2TwP99Dx4AhmO+UVPVhyie1qAYwu2eA0rNN/+iqUqQmhMrNHL
    SMk3Akb5+0fNRHrZVbl4plGQx83RrP3HryUeDlnA3TawbxFxRHnSj4oj/ypI+K8Q
    aike6A4l+nuGHTeq1oAoiDIo+ghkdRa9UsAAI8yGnZ0o91sp7aC63M+fqlBOFFfH
    8uf9bcKrmRDD61DrUSKc+34QYR6Fk9CAGuCFa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520488702; bh=RUMLOeOPFboCrHLsQjBgojSLRqTMphoBKQm2T0
    Zkhe0=; b=Fn6evchEvWkkXCOk4YW4RcCfvP67zmco0+eLfyFfd9Lr3f8KYOsc9b
    968VEOroeh4KsXP21017vjwzZ5G/4kn/RVSArHHrK92J+Mf/WC/nyqffsuchs1Ko
    sknPOUHA2KbRe0Ea/+Lp1L4KaqbHzEUTCQIsXtaA+9h8Xv/Q0QNXFCY++ocbDJ/G
    unXxRsrKKTBS2xlO2u4lnwoCpHsyFSGAl/mzGNyTsNF0FwSCPf8YM5xy56SH2Rt9
    pkAiE2oBTv2c4kmBl+jP6k/dabjDfF8NjypKF78Loit6Uh3Z5ezoYXDDjE+PhJH+
    gGFOdIy/PTzxR0vzdt+Z5zUdOUeLfpIw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lgU3iyid x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lgU3iyid x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966004AbeCHF6V (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:58:21 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965988AbeCHFDV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergei Trofimovich <slyfox@gentoo.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        H J Lu <hjl.tools@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 135/190] ia64: fix module loading for gcc-5.4
Thread-Topic: [PATCH AUTOSEL for 4.9 135/190] ia64: fix module loading for
 gcc-5.4
Thread-Index: AQHTtppKsC3yNFdTsEyLcHCZRVFIcw==
Date: Thu, 8 Mar 2018 04:59:51 +0000
Message-ID: <20180308045810.8041-135-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:/pt47t/IdqI4GxR+KZaT3LPZcju06BPvrSr2ji6QwjE/h9mExhGtZ7O4YawwSIekr51WHcG1Tbf+FzF09pMLzB6A7IkYLeodIOv2RaBNmymXoc+OD6tXxiKWLQFdVUUPcGpbdW1EsJXgrgo+9iOuKp4HX3MmHldCQqye4vggwLsT75NU3QFg81nhUtkkxHmcsc/uCWALvXbR4kt9Sblr/V9xJzVH7AVPd9oomz9iArPaPBweaKd+ghpCg3mvn+qY;20:1b+Xc4hUtdVhvQ3Bx8HWM343y+rNfAFn6NVUS90DOqPq4QEIraEEbkFuURwNWwpBrpS1HwFmACUb/PJYaHjZRe9mjx982zHuhZCXbz573aF51qT273UlV8D+6Ualtej19SUD/l7rSLDRwCdWmdU3I7fgNGZikYgeO0jo058P9lU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b571aef1-0e94-4ed6-eca6-08d584b1e6d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101333553E980996E7D4981FFBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(22074186197030)(89211679590171)(85827821059158)(183786458502308)(42262312472803)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(6306002)(2900100001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(966005)(8936002)(39060400002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MT0Ahrh/LyYsB98NG9lJgjL8RkDGEh3ekxS6DaQu9kpO4X6zRV9ttO4or5SSyowSd/ZEadRzHcjzwrllfS+iNNBjBORZFniVImWizrb8DSx8VVhOYc8DZc5x+D1es/lpkf941oA+/6bJ79/okZ/g621rfGKIGJ5jhTFsfRHRMl7uo7Yh/4+kghViLVZPaPEQvDU+VrpaP+lQd2Ec9OeArG3ezKotlhxPU0JwdHdnHMsuVFD6KbBGDLxsTy8APv57JGOvN+5nrrS0bctflT9tQ4pinGf/70hYgD6FcXG14ceqp90aUUhzt0ydXMsh4hPxVqrQJay/Oy6WHjATcmfLmQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <91FB179F9F955E48B729BE59114F0F95@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b571aef1-0e94-4ed6-eca6-08d584b1e6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:51.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogU2VyZ2VpIFRyb2ZpbW92aWNoIDxzbHlmb3hAZ2VudG9vLm9yZz4NCg0KWyBVcHN0cmVh
bSBjb21taXQgYTI1ZmI4NTA4YzFiODBkY2U3NDJkYmVhYTRkNzVhMWU5ZjJjNTYxNyBdDQoNClN0
YXJ0aW5nIGZyb20gZ2NjLTUuNCsgZ2NjIGdlbmVyYXRlcyBNTFggaW5zdHJ1Y3Rpb25zIGluIG1v
cmUgY2FzZXMgdG8NCnJlZmVyIGxvY2FsIHN5bWJvbHM6DQoNCiAgICBodHRwczovL2djYy5nbnUu
b3JnL1BSNjA0NjUNCg0KVGhhdCBjYXVzZWQgaWE2NCBtb2R1bGUgbG9hZGVyIHRvIGNob2tlIG9u
IHN1Y2ggaW5zdHJ1Y3Rpb25zOg0KDQogICAgZnVzZTogaW52YWxpZCBzbG90IG51bWJlciAxIGZv
ciBJTU02NA0KDQpUaGUgTGludXgga2VybmVsIHVzZWQgdG8gaGFuZGxlIG9ubHkgY2FzZSB3aGVy
ZSByZWxvY2F0aW9uIHBvaW50ZWQgdG8NCnNsb3Q9MiBpbnN0cnVjdGlvbiBpbiB0aGUgYnVuZGxl
LiAgVGhhdCBsaW1pdGF0aW9uIHdhcyBmaXhlZCBpbiBsaW51eCBieQ0KY29tbWl0IDljMTg0YTA3
M2JmZCAoIltJQTY0XSBGaXggMi42IGtlcm5lbCBmb3IgdGhlIG5ldyBpYTY0IGFzc2VtYmxlciIp
DQpTZWUNCg0KICAgIGh0dHA6Ly9zb3VyY2VzLnJlZGhhdC5jb20vYnVnemlsbGEvc2hvd19idWcu
Y2dpP2lkPTE0MzMNCg0KVGhpcyBjaGFuZ2UgbGlmdHMgdGhlIHNsb3Q9MiByZXN0cmljdGlvbiBm
cm9tIHRoZSBrZXJuZWwgbW9kdWxlIGxvYWRlci4NCg0KVGVzdGVkIG9uICdmdXNlJyBhbmQgJ2J0
cmZzJyBrZXJuZWwgbW9kdWxlcy4NCg0KQ2M6IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJz
LnNvdXJjZWZvcmdlLm5ldD4NCkNjOiBIIEogTHUgPGhqbC50b29sc0BnbWFpbC5jb20+DQpDYzog
RmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5jb20+DQpDYzogQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkJ1ZzogaHR0cHM6Ly9idWdzLmdlbnRvby5vcmcvNjAx
MDE0DQpUZXN0ZWQtYnk6IMOJbWVyaWMgTUFTQ0hJTk8gPGVtZXJpYy5tYXNjaGlub0BnbWFpbC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBTZXJnZWkgVHJvZmltb3ZpY2ggPHNseWZveEBnZW50b28ub3Jn
Pg0KU2lnbmVkLW9mZi1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KU2lnbmVk
LW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogYXJjaC9pYTY0L2tlcm5lbC9tb2R1bGUuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNo
L2lhNjQva2VybmVsL21vZHVsZS5jIGIvYXJjaC9pYTY0L2tlcm5lbC9tb2R1bGUuYw0KaW5kZXgg
NmFiMGFlN2Q2NTM1Li5kMWQ5NDVjNmJkMDUgMTAwNjQ0DQotLS0gYS9hcmNoL2lhNjQva2VybmVs
L21vZHVsZS5jDQorKysgYi9hcmNoL2lhNjQva2VybmVsL21vZHVsZS5jDQpAQCAtMTUzLDcgKzE1
Myw3IEBAIHNsb3QgKGNvbnN0IHN0cnVjdCBpbnNuICppbnNuKQ0KIHN0YXRpYyBpbnQNCiBhcHBs
eV9pbW02NCAoc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgaW5zbiAqaW5zbiwgdWludDY0X3Qg
dmFsKQ0KIHsNCi0JaWYgKHNsb3QoaW5zbikgIT0gMikgew0KKwlpZiAoc2xvdChpbnNuKSAhPSAx
ICYmIHNsb3QoaW5zbikgIT0gMikgew0KIAkJcHJpbnRrKEtFUk5fRVJSICIlczogaW52YWxpZCBz
bG90IG51bWJlciAlZCBmb3IgSU1NNjRcbiIsDQogCQkgICAgICAgbW9kLT5uYW1lLCBzbG90KGlu
c24pKTsNCiAJCXJldHVybiAwOw0KQEAgLTE2NSw3ICsxNjUsNyBAQCBhcHBseV9pbW02NCAoc3Ry
dWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgaW5zbiAqaW5zbiwgdWludDY0X3QgdmFsKQ0KIHN0YXRp
YyBpbnQNCiBhcHBseV9pbW02MCAoc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgaW5zbiAqaW5z
biwgdWludDY0X3QgdmFsKQ0KIHsNCi0JaWYgKHNsb3QoaW5zbikgIT0gMikgew0KKwlpZiAoc2xv
dChpbnNuKSAhPSAxICYmIHNsb3QoaW5zbikgIT0gMikgew0KIAkJcHJpbnRrKEtFUk5fRVJSICIl
czogaW52YWxpZCBzbG90IG51bWJlciAlZCBmb3IgSU1NNjBcbiIsDQogCQkgICAgICAgbW9kLT5u
YW1lLCBzbG90KGluc24pKTsNCiAJCXJldHVybiAwOw0KLS0gDQoyLjE0LjENCg==
