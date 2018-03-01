Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1446298-1519865839-2-15793346388809557953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='SG'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519865838; b=e42fv1Fy0HNT6jjVS9VbvF/ndloHxomL+r6frSEAmrBONTu
    O8idVZbG6cuReoZzVFGrMmQ1EH3AfO/48vbz2A/h8tTrB6MCiPZazB40OAfS5Z+c
    nDuhQUnGhUV/FHH+ZQJ6MNjbsDQ4meqfx8MCyy54judNAHYuvSCsX7PXxSgRk590
    +nEDWznIll0D5GZUCyahMFJnfNCC+qv5l6RZ7w3W4J3r1VuXCo0lHrkf7ICwPNb4
    hnelCJuCj/5dHl0ddKYvCAXcgEMW5l6sCBEOk3a0ckANyY0K09J7tEhLte3Mf+4A
    FK9Vq1FlnqdN0qr5Htqhs734zpeatlK5f74v4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1519865838; bh=LNiq+n
    XjVPLdSjUNNVjulLRifIIx5pQcMyQxWEVjz0I=; b=p+4zgkpi988oeleT5OzFlz
    fVe6BhjYLMvedeDXp2LIAFuQ9+ggmFniOdLqCdBldo8OCgNVyeoHJPcDP39k2rw1
    aWPzThnuMbjYnxMk1Vqt2eIs90WO/OxDNNwBBPBh/ptKPCtqibKoDmYdmBWupWZI
    nyXQsNjb4ha+sfs7HLp0niMZzpFj1xgm2MEB3Z6ghPAXw4epS2f8p/1OnT9NKD9J
    MfAIzsF1sLGp0pkHiYJZivENMALWH/gr0GeYQpt2VDHR6MoA2XCsTt9MSQf3HTlZ
    qDpUaopKSVD8jEn7dJlyFv55TSdXtETS3D/alKDDhvT/hja3VMA2nO6Lb58SlBUw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=bniSumeM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=bniSumeM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965428AbeCAA5E (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 19:57:04 -0500
Received: from mail-ve1eur01on0084.outbound.protection.outlook.com ([104.47.1.84]:41312
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965421AbeCAA5C (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 28 Feb 2018 19:57:02 -0500
From: Jun Li <jun.li@nxp.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
CC: "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v5 01/12] drivers: base: Unified device connection lookup
Thread-Topic: [PATCH v5 01/12] drivers: base: Unified device connection lookup
Thread-Index: AQHTsKaevzsoXOOu8U6iPxtAGBj3OqO6jcMA
Date: Thu, 1 Mar 2018 00:56:57 +0000
Message-ID: <VI1PR0402MB3917DD93F114873CC736117389C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
References: <20180228150749.26831-1-hdegoede@redhat.com>
 <20180228150749.26831-2-hdegoede@redhat.com>
In-Reply-To: <20180228150749.26831-2-hdegoede@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3630;6:BYU6+fEzocPYCrSCXaxKQlCnQs9Y/UkDkZsBrhvm6HK7TD5W7tzeEWDmvOnh+0qQvZkiewe4uhy9HdnQSsKXpeI4L+B/sWKYAYeH0kw6aV8LwrjV304En1xirKe/RpvJjku2tpSHHXLAEJKEalw2RPYe2S0sDlu4C93FKOaIscxuShQoZB7ZZqp52W/doDPnO601N1bJmOa0muCyLhRUlq5zIvm6EEX4M3erQZiVr6pf6qwuWyxEWJ82tjpn0QOIArquQCxUDlmrhPfX9JEUNkwtV0kPr2kArZZyiJPGyCysF05poMIyB/yj3x0tgqSaRbgdwvKgpbWCKGRHj+iz4aF5F6Mh5RiZHdz6I1+kEpF5A0KCKK5LOS06lW9rS4DQ;5:Sc7etgxNoQr8W+EIvjZzam2myLKYIU5g4x0/arRUY0N7iMLF3nzo7kcPAVJAxlpI3O3kyaAJVd4QABCH8kTAi1OOSnLvMx+6/Nz+Dmp4XKiebRz5a2f+BxVaEknkOaPAXvfxGhiozXPkwPdEcdTv1LxcDmTvrmsbormMnL62Oas=;24:F5upzZPOdxdZnPJGPQERUrc7iYGPHsQ+dxU/g2d+dePVpC2B746ohj7dNzlQ4OXjfrcLCLTHukjW6SLIQwBUzx7J2eT+4Z+4CEWQv150Bcc=;7:s+8M7wto05OBzclxJv9f8xsoGQhqY3YGs8JtB0awHhFsSULMowoDCdFKL42VfS45x0CroeGCTqM3haZ49fGahUdYm83Z5tMCflpcw5j59WC4K0bHqU+IVpSxD7S8V5qf55K5DcwGm2iadRwpC9dCW5bn/tYgiMBWrlt27S5DHN+zvEp1YCOjb8bJHg+mp+5Dl5vS7Gd81Jn+gOESAssEyG7bcigknGcBJt+p5lIn0rCbf9GSehO4ZMbI7wZUq4G0
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d138903a-94a9-4abf-2cbc-08d57f0f555e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3630;
x-ms-traffictypediagnostic: VI1PR0402MB3630:
x-microsoft-antispam-prvs: <VI1PR0402MB36302188E590BF87623B1FB389C60@VI1PR0402MB3630.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501221)(52105095)(6055026)(6041288)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0402MB3630;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3630;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(13464003)(74316002)(54906003)(110136005)(66066001)(68736007)(33656002)(2900100001)(7416002)(14454004)(97736004)(105586002)(106356001)(76176011)(186003)(316002)(5250100002)(305945005)(26005)(6506007)(3660700001)(102836004)(2950100002)(7736002)(3280700002)(5660300001)(7696005)(99286004)(4326008)(53936002)(6246003)(478600001)(3846002)(25786009)(55016002)(81166006)(6436002)(81156014)(229853002)(8676002)(6116002)(9686003)(2906002)(86362001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3630;H:VI1PR0402MB3917.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: AGEi+kcQVAOgWSczP/JomJA9ko/TC2oyfDdX4Ksf6IOXvzpIGS22pISaQ8tz7zmZsIBO6T6XrBbZ0Npz5rgVXf/acMUYvxos5fdYO+s8Vea8SG6wbpEMknOTlPp2Oe0/VhNd88wThgrkh9KjgNZ2B4lIyoKnhuVaSs0hQhFIA+M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d138903a-94a9-4abf-2cbc-08d57f0f555e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 00:56:57.3921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3630
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
> -----Original Message-----

> +struct device *device_find_connection(struct device *dev, const char
> +*con_id) {
> +	return __device_find_connection(dev, con_id, generic_match, NULL); }

-       return __device_find_connection(dev, con_id, generic_match, NULL);
+       return __device_find_connection(dev, con_id, NULL, generic_match);

Jun Li
> +EXPORT_SYMBOL_GPL(device_find_connection);

