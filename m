Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493040-2-16977341276521831182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520493040; b=JY8kjb9yzhIbIXB4JBG4QltT26qRUmT82QIiyTg5lkjaRuS
    9lvLdWDNHY7i77Dte0x0tRZxILpQva5asssT4SPvMHfQW9mMxECdgMJN37zswt3D
    NeOM0FzWl5d7iXsuxvYD92RWqm1N7UW9m72/BMV9doETyl2u6P5RWf7ddvx7tbb6
    4o83lvZpdc2bUMkK+2iHzEoHenKUS/XWiDLCah8EcnD0NdsX1+RBdjFZNeK2IKpL
    3wMZslSUt/05EGaxx+4i/rhWGhut9hLdkvgyKPWxPQEYOPRt19D9ufxklqWPZvdT
    x+8Y3FP38qu6IM2Gz3yXgdkMtSnJJ8G/CVEtM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520493040; bh=0iEyqKWYCncOBC9g3raUgLa2K1tOrJi3lete+n
    zPNDA=; b=vg+ybFZsWCU4SUDxsEfYRNWo5lXfU6ihGB/EPbkS1YBNPADIxGA6n6
    gTxNI9tJPHNID2/iAPKA4lJFcZrhPoRfaf4JwcrekRjIiQNKjo/8RGF2CkMLZZak
    S/A91b54iOfywvc+qidHZoBOL9Ws1RkadtzzDRR6ho8sE2Hngia+8cBidcmQOQnB
    svObWh8TL9+uOnXbJ2MsXGmP0j+QFOzKWRqOgLAMAIJVttuQBVtOW3oGJtXFqRG+
    upB60Pg+lGzG8AvkKE4M+U8jT5SYVToqkYI84vbl5lnZyJwuuHOlrziKZ1/ZLCIh
    I9cfMX2pswRnY1FD6Jm72akpcXLUZypw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jKVP+q78 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jKVP+q78 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935037AbeCHHKX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:10:23 -0500
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:63552
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755144AbeCHE4N (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 12/78] RDMA/iwpm: Fix uninitialized error
 code in iwpm_send_mapinfo()
Thread-Topic: [PATCH AUTOSEL for 4.15 12/78] RDMA/iwpm: Fix uninitialized
 error code in iwpm_send_mapinfo()
Thread-Index: AQHTtpnEvxnmpXQlmUWrD13DRyZ3sw==
Date: Thu, 8 Mar 2018 04:56:06 +0000
Message-ID: <20180308045525.7662-12-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:jaLiIP+lmgQ0mQRR86FR2Hmd5fkeaPfKEKytBwnZMfC6Wu/r/ceuMJtVNFCSQhAZ9h65BPRCVvuKsj15EVgB7yzvWaS72nD5Nhyc6jMrzmumGhJP2Ezc/MsTReznAgt9Pa8kItTGjQZ86+d7FLZ2fmwnP5yYlAfk+GVZQklhVUYnXak6Z8yQThApJI2Zk5lLp97+ueoqhYohHeCqBpKCxkmnYPsYjjbokk1g6kyk19aGLgOmI0aTPMTqhVvlckec;20:vQl2vRbmWtyd6r/YeWPe4//l0sP/LNiqx2TwlfaaTC/uIp616frkkQfVaRRCGpkUe+Y4KfKLK2F6twt79dX+qfjnmn4Zx5PyVTlF/7irGMotFK+q0sdkhhnm9uEE2yDRQpX7kVou5g+44msCyu382XeA/kHuM1tqD3B3Os+LnV8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c8b04ca-3761-480e-91e2-08d584b0e6d4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09024A24EB22141EEE0CBF8CFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SXBXGjBrUkDGLV2oMfnbWPguHt2zrlpL6QUozpRG4J5XQjyVJO6m8TNaT7FOUA1ldr6uo1owBA1MLpIt0snscruYNiYMSeGEhhEI11bAfMkkEzks6Xyo2FBpTKPhEHHZv5RDTMPptSu6bOs27lv0mRa99QVXbx3rmmq76BVXBQLvUywNYrb3tMabytXirR7fzplgI1+1HDOuz48vxYPJY1WAPKJCsioFqlu4yhTRfDNemHnIQoxFEkQCj0DqLJyYKjLPxriSmxYlFqswNP4emnq0B9vBdJoD8hiu+vuzsEwf56GOGrCAf3sOlqaqtI9lQeDOi4zbGsejTmpxxHf+Qw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <73DE33BBDD243947B76BC56C38BDBD27@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8b04ca-3761-480e-91e2-08d584b0e6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:06.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgMzAyZDY0MjRlNGEyOTNhNTc2MTk5N2U2YzlmYzNkZmIxZTRjMzU1ZiBdDQoN
CldpdGggZ2NjLTQuMS4yOg0KDQogICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvaXdwbV91dGls
LmM6IEluIGZ1bmN0aW9uIOKAmGl3cG1fc2VuZF9tYXBpbmZv4oCZOg0KICAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL2l3cG1fdXRpbC5jOjY0Nzogd2FybmluZzog4oCYcmV04oCZIG1heSBiZSB1
c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbg0KDQpJbmRlZWQsIGlmIG5sX2NsaWVu
dCBpcyBub3QgZm91bmQgaW4gYW55IG9mIHRoZSBzY2FubmVkIGhhcyBidWNrZXRzLCByZXQNCndp
bGwgYmUgdXNlZCB1bmluaXRpYWxpemVkLg0KDQpQcmVpbml0aWFsaXplIHJldCB0byAtRUlOVkFM
IHRvIGZpeCB0aGlzLg0KDQpGaXhlczogMzBkYzVlNjNkNmE1YWQyNCAoIlJETUEvY29yZTogQWRk
IHN1cHBvcnQgZm9yIGlXQVJQIFBvcnQgTWFwcGVyIHVzZXIgc3BhY2Ugc2VydmljZSIpDQpTaWdu
ZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KUmV2
aWV3ZWQtYnk6IFRhdHlhbmEgTmlrb2xvdmEgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRlbC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQot
LS0NCiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYyB8IDEgKw0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvaXdwbV91dGlsLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYw0K
aW5kZXggM2M0ZmFhZGI4Y2RkLi44MTUyOGY2NDA2MWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
aXdwbV91dGlsLmMNCkBAIC02NTQsNiArNjU0LDcgQEAgaW50IGl3cG1fc2VuZF9tYXBpbmZvKHU4
IG5sX2NsaWVudCwgaW50IGl3cG1fcGlkKQ0KIAl9DQogCXNrYl9udW0rKzsNCiAJc3Bpbl9sb2Nr
X2lycXNhdmUoJml3cG1fbWFwaW5mb19sb2NrLCBmbGFncyk7DQorCXJldCA9IC1FSU5WQUw7DQog
CWZvciAoaSA9IDA7IGkgPCBJV1BNX01BUElORk9fSEFTSF9TSVpFOyBpKyspIHsNCiAJCWhsaXN0
X2Zvcl9lYWNoX2VudHJ5KG1hcF9pbmZvLCAmaXdwbV9oYXNoX2J1Y2tldFtpXSwNCiAJCQkJICAg
ICBobGlzdF9ub2RlKSB7DQotLSANCjIuMTQuMQ0K
