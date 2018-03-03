Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120573-2-11304292379444847511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120572; b=kDZc38xNMzeTg2pDXbKaFlmkJNDugjDZlfyEYXC0pXWVyIq
    XuuLrdA3KgVWShcmJ8ZW5wHs4Lit+qj7PAnAIpUVZDVxvGTw7Jz9Dk78EEHL3Ndr
    qMkPZSX2ma3pHpxu3IWM+Qc6TmQhkMRQ427lnvNp3ryftb3IFagjEQi2BZPdhCqJ
    ehYqjgCDLVj0aY7dk/LMMNmKAGCO/qzSuxzI0cErEaGIDdVvuUeYk6D2Kn9M6zq9
    hbdF+HUoQqD6zJ4XoruRb5U5WndUleviItXuzulcAMpDUT+8NmfT6igwDqdc0ZfZ
    JV98OvSl3f4LVVqI/kYIXx9d37IEuRTxOvdaSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520120572; bh=HAgQ3O4j/2ctsYC5yqmw3eCxCAQPt4pW31L5zU
    c4SPo=; b=BVgqQNP4pWNSmwk5QUA2/Tw23qKUrzh3uKgYFzZrCovCwvUJ6SKNfh
    cM3Tmllzsm3rgtobzx7Z+84aUL4IGgdDGQ9rma0G/TiNXwulYBLl2j0S769Dhhw0
    NA6qBtM2ZCNUWnQDsuGLJv7/87wIRrbOBEYRXnkOHYlq1OBduCK5AP8X6EcrR3oz
    KfTBqPyGbCmzl7Ye7fOnOLHdY/QpKaoQvRGN2/18fIEEfDOc0TGdzRyst/Gc/a3X
    W34ofjoSQuyP3qlwOWi98zDEJjXCo2ugHFRSxR0i1Cco5mHY2AZhEkY2t9uAlXFe
    E+IbilnblArPfvgLFgRn+2+v4+t5QpLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BD6B7w59 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BD6B7w59 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934364AbeCCXmY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:42:24 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:42080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934009AbeCCWew (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jim Mattson <jmattson@google.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 126/219] kvm: nVMX: Disallow
 userspace-injected exceptions in guest mode
Thread-Topic: [PATCH AUTOSEL for 4.9 126/219] kvm: nVMX: Disallow
 userspace-injected exceptions in guest mode
Thread-Index: AQHTsz8MvvaJm8wQaUm4QeLuVTnS/g==
Date: Sat, 3 Mar 2018 22:29:09 +0000
Message-ID: <20180303222716.26640-126-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;6:XI4DxX9SDtbfLClEkf0BMNclX8mM5rOmk0sNpXwPJZ1QsBHt9ZFBWBqw/rtFGGZoR0yqR73VpdbVh/aAYYBt1QMIOsTnwK5bNk4F91P7BjvpFwWSgv75KslCgK73+CwDHb99yyW8CnOu9FbHT3zXB7q21LSKgePKQfV0+cQE8tgFpb1tGZpPoEEXMK0A14SxrdDqI0nv6WNzLguZdbdDYKpGzHzm3oSKuyz28dqpJItOLsenwRPjucLkkk2r/1lz0kvs8V5/Kj9JunGRbpfm7NfI0BF8GBI6NV4kkICmlRzLj378I9mpe+y+yTaURldO64OOhKDh+l284XNMmejEnORNxi66PMMg2Aq6kGVRq0WsHiL/p90IIJfceO6prmRi;5:9l5pGLSgRKnUAF1zs00qZKe+4RSSUNfuqzsnEx2+1dUgnmZxY5J1TMYW3J/PFb3kbDKJmRjNg9wDtNhEfgX58oAtB7i/3G0VMFEJNZQd9+FznCochotQ3R4+GlEB0ZEYh7yBjCOoAojLmNcJHs1WnX3NtbzNEcTBGYSdisD5300=;24:OMOLh6BhR5px4P0YykQgigi1NtNaMsmwb79C4kG83PndKW/L60UkKV1YsiBZhyC+TNQatIxSuedgVFgaEKn4L/2SK9/ysZu7oxQRpPuJmOo=;7:337zekosz8czbPwZq+R7aiFHBi1Hp5HHT6j95UI+8dMNWEhgereWzzFwdWndrJjAJ54Q0amQTPgY5y8uq3E0ekjcC5Em4vOSDnU8cKN3hQ0Tni4w+ibjnSZ41ytLM2H9iKn/St1nC0sja52HSIS8tDm+QXoneVVslx9mDhJc1oyAS93ufU43DNlgdI/91I9Y/h6aJ9eyzdj6WT/GxyEeWwBJTv3mEj2sTCRP0ekkNgOA8NEyge/5jwI5vNpPIypW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 332bd2d9-793e-42e9-d2d8-08d58156f76a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10687238AF5D3040C9922DC9FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oUKUVg6IYuNTO2AxiXk4XquJ2LP2CmFrQBNj+huH8WP0789w80RAo9hpIr+AUL9C8WU0cCD7OwPQEITPIyEmq5ObiQUoI3Vcebzr6uccDHzBhoAmorNdSQtGxU6ylW9ZHED/m1nXfQSFGO+Ao16nj4HpdtQsWhfniy2rHna0jJw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <36333A87FFD62B419D3AA6242E96E024@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332bd2d9-793e-42e9-d2d8-08d58156f76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:09.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmltIE1hdHRzb24gPGptYXR0c29uQGdvb2dsZS5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDI4ZDA2MzUzODgxOTM5NzAzYzM0ZDgyYTE0NjUxMzZhZjE3NmM2MjAgXQ0KDQpUaGUgdXNl
cnNwYWNlIGV4Y2VwdGlvbiBpbmplY3Rpb24gQVBJIGFuZCBjb2RlIHBhdGggYXJlIGVudGlyZWx5
DQp1bnByZXBhcmVkIGZvciBleGNlcHRpb25zIHRoYXQgbWlnaHQgY2F1c2UgYSBWTS1leGl0IGZy
b20gTDIgdG8gTDEsIHNvDQp0aGUgYmVzdCBjb3Vyc2Ugb2YgYWN0aW9uIG1heSBiZSB0byBzaW1w
bHkgZGlzYWxsb3cgdGhpcyBmb3Igbm93Lg0KDQoxLiBUaGUgQVBJIHByb3ZpZGVzIG5vIG1lY2hh
bmlzbSBmb3IgdXNlcnNwYWNlIHRvIHNwZWNpZnkgdGhlIG5ldyBEUjYNCmJpdHMgZm9yIGEgI0RC
IGV4Y2VwdGlvbiBvciB0aGUgbmV3IENSMiB2YWx1ZSBmb3IgYSAjUEYNCmV4Y2VwdGlvbi4gUHJl
c3VtYWJseSwgdXNlcnNwYWNlIGlzIGV4cGVjdGVkIHRvIG1vZGlmeSB0aGVzZSByZWdpc3RlcnMN
CmRpcmVjdGx5IHdpdGggS1ZNX1NFVF9TUkVHUyBiZWZvcmUgdGhlIG5leHQgS1ZNX1JVTiBpb2N0
bC4gSG93ZXZlciwgaW4NCnRoZSBldmVudCB0aGF0IEwxIGludGVyY2VwdHMgdGhlIGV4Y2VwdGlv
biwgdGhlc2UgcmVnaXN0ZXJzIHNob3VsZCBub3QNCmJlIGNoYW5nZWQuIEluc3RlYWQsIHRoZSBu
ZXcgdmFsdWVzIHNob3VsZCBiZSBwcm92aWRlZCBpbiB0aGUNCmV4aXRfcXVhbGlmaWNhdGlvbiBm
aWVsZCBvZiB2bWNzMTIgKEludGVsIFNETSB2b2wgMywgc2VjdGlvbiAyNy4xKS4NCg0KMi4gSW4g
dGhlIGNhc2Ugb2YgYSB1c2Vyc3BhY2UtaW5qZWN0ZWQgI0RCLCBpbmplY3RfcGVuZGluZ19ldmVu
dCgpDQpjbGVhcnMgRFI3LkdEIGJlZm9yZSBjYWxsaW5nIHZteF9xdWV1ZV9leGNlcHRpb24oKS4g
SG93ZXZlciwgaW4gdGhlDQpldmVudCB0aGF0IEwxIGludGVyY2VwdHMgdGhlIGV4Y2VwdGlvbiwg
dGhpcyBpcyB0b28gZWFybHksIGJlY2F1c2UNCkRSNy5HRCBzaG91bGQgbm90IGJlIG1vZGlmaWVk
IGJ5IGEgI0RCIHRoYXQgY2F1c2VzIGEgVk0tZXhpdCBkaXJlY3RseQ0KKEludGVsIFNETSB2b2wg
Mywgc2VjdGlvbiAyNy4xKS4NCg0KMy4gSWYgdGhlIGluamVjdGVkIGV4Y2VwdGlvbiBpcyBhICNQ
RiwgbmVzdGVkX3ZteF9jaGVja19leGNlcHRpb24oKQ0KZG9lc24ndCBwcm9wZXJseSBjaGVjayB3
aGV0aGVyIG9yIG5vdCBMMSBpcyBpbnRlcmVzdGVkIGluIHRoZQ0KYXNzb2NpYXRlZCBlcnJvciBj
b2RlICh1c2luZyB0aGUgI1BGIGVycm9yIGNvZGUgbWFzayBhbmQgbWF0Y2ggZmllbGRzDQpmcm9t
IHZtY3MxMikuIEl0IG1heSBlaXRoZXIgcmV0dXJuIDAgd2hlbiBpdCBzaG91bGQgY2FsbA0KbmVz
dGVkX3ZteF92bWV4aXQoKSBvciB2aWNlIHZlcnNhLg0KDQo0LiBuZXN0ZWRfdm14X2NoZWNrX2V4
Y2VwdGlvbigpIGFzc3VtZXMgdGhhdCBpdCBpcyBkZWFsaW5nIHdpdGggYQ0KaGFyZHdhcmUtZ2Vu
ZXJhdGVkIGV4Y2VwdGlvbiBpbnRlcmNlcHQgZnJvbSBMMiwgd2l0aCBzb21lIG9mIHRoZQ0KcmVs
ZXZhbnQgZGV0YWlscyAodGhlIFZNLWV4aXQgaW50ZXJydXB0aW9uLWluZm9ybWF0aW9uIGFuZCB0
aGUgZXhpdA0KcXVhbGlmaWNhdGlvbikgbGl2ZSBpbiB2bWNzMDIuIEZvciB1c2Vyc3BhY2UtaW5q
ZWN0ZWQgZXhjZXB0aW9ucywgdGhpcw0KaXMgbm90IHRoZSBjYXNlLg0KDQo1LiBwcmVwYXJlX3Zt
Y3MxMigpIGFzc3VtZXMgdGhhdCB3aGVuIGl0cyBleGl0X2ludHJfaW5mbyBhcmd1bWVudA0Kc3Bl
Y2lmaWVzIHZhbGlkIGluZm9ybWF0aW9uIHdpdGggYSB2YWxpZCBlcnJvciBjb2RlIHRoYXQgaXQg
Y2FuIFZNUkVBRA0KdGhlIFZNLWV4aXQgaW50ZXJydXB0aW9uIGVycm9yIGNvZGUgZnJvbSB2bWNz
MDIuIEZvcg0KdXNlcnNwYWNlLWluamVjdGVkIGV4Y2VwdGlvbnMsIHRoaXMgaXMgbm90IHRoZSBj
YXNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaW0gTWF0dHNvbiA8am1hdHRzb25AZ29vZ2xlLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KU2ln
bmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0K
LS0tDQogYXJjaC94ODYva3ZtL3g4Ni5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2
LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMNCmluZGV4IDRiMTllYzFkYTIyZC4uM2FhYWYzMDU0MjBk
IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jDQorKysgYi9hcmNoL3g4Ni9rdm0veDg2
LmMNCkBAIC0zMDcwLDcgKzMwNzAsOCBAQCBzdGF0aWMgaW50IGt2bV92Y3B1X2lvY3RsX3g4Nl9z
ZXRfdmNwdV9ldmVudHMoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KIAkJcmV0dXJuIC1FSU5WQUw7
DQogDQogCWlmIChldmVudHMtPmV4Y2VwdGlvbi5pbmplY3RlZCAmJg0KLQkgICAgKGV2ZW50cy0+
ZXhjZXB0aW9uLm5yID4gMzEgfHwgZXZlbnRzLT5leGNlcHRpb24ubnIgPT0gTk1JX1ZFQ1RPUikp
DQorCSAgICAoZXZlbnRzLT5leGNlcHRpb24ubnIgPiAzMSB8fCBldmVudHMtPmV4Y2VwdGlvbi5u
ciA9PSBOTUlfVkVDVE9SIHx8DQorCSAgICAgaXNfZ3Vlc3RfbW9kZSh2Y3B1KSkpDQogCQlyZXR1
cm4gLUVJTlZBTDsNCiANCiAJLyogSU5JVHMgYXJlIGxhdGNoZWQgd2hpbGUgaW4gU01NICovDQot
LSANCjIuMTQuMQ0K
