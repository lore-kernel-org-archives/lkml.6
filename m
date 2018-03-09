Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-955397-1520613485-2-6582640146932855659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520613484; b=HZg1a8EA+HYtLjF9wUvNbjTazlNpnPJLQuMohMbJz3MYUQL
    a1bKDEGHA4Us45XfQDauVBBFY9Bx6KThjAi7IWfX4Hg+5IA3V5skVCLzAZ0jDvMf
    LZIWo8wJy2udqgBAXpXaTGqL1gW1WXOE0WWVBJ7TNxfWLHr1PJTJES//fYVk5JRb
    +4wuMq0mRtM+P1rEm7Gme0mqihmTrRHLRQf7D6HAoO4m+b9Q7xnis12biIN1nqmt
    M68yCYdBGv33aT1+j/aXBo22llCh+WspD/obVlwmpwteMHdn/fZ9wGYUCceQNp2h
    dQcENAQq3GvXu+LmyBT1/BGp374RckhYim9Xl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520613484; bh=PwdwPPs4uD55J8d7bNEueO+R07qIaJJFlFe1+1
    cwwSk=; b=f2VE3kI4ORZ0suiWK4h5pA++1fdYnwWctGM9HVk/XZ/B0MKGc2VIjF
    8v24fg9yY5Lo6CiIUpZszMsF3BrbdKcbhXPMRDcom2q5hc/24m49V9gpfh2QFmjx
    phsHHSNcI2XxM8saURhMF9Yd911LgZhm5Kl0kmkiob/P7uf3bAyW280GmZepOxiR
    f22QSLeT0jj9Nxx/wO/5BSDL9Vy4gsPcvWaOb1ziGQJIwwYTqyRfF5S7GNWPNnc0
    Krq3uQ5WbWE88xrYNodQr/mzS86QkCxMnIB0V8Lx9Ho5ZjIShQGxKYFSAkhqTTAf
    QmdZgSiSFv1XLykfXwFVRefP3+uECnvQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gPDoDATR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gPDoDATR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeCIQiD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 11:38:03 -0500
Received: from mail-by2nam01on0134.outbound.protection.outlook.com ([104.47.34.134]:26768
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751147AbeCIQiC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Mar 2018 11:38:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: David Lechner <david@lechnology.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH AUTOSEL for 4.14 04/67] dt-bindings: net: add TI CC2560
 Bluetooth chip
Thread-Topic: [PATCH AUTOSEL for 4.14 04/67] dt-bindings: net: add TI CC2560
 Bluetooth chip
Thread-Index: AQHTtpn3jW0erqkYkUOnCRUgIQMRMKPGgooAgAGaOAA=
Date: Fri, 9 Mar 2018 16:38:00 +0000
Message-ID: <20180309163758.wacoxqp5i2uf74yn@sasha-lappy>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
 <20180308045641.7814-4-alexander.levin@microsoft.com>
 <d3246708-4dd1-2a49-b3e5-7e459adc68d2@lechnology.com>
In-Reply-To: <d3246708-4dd1-2a49-b3e5-7e459adc68d2@lechnology.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;20:KK2pjyOeQy+068mh0rWJqJTFmoUYDeHJe96MXBno1sBx1a3fRr1U824DRMUcbuVrgXUBBzlqjdAnI4iJqwgE4L3ysEmFG44x1BUU5O2wdjOK1K2i4DCKC3eow1f0YnLrTaKcnF6pZUPK43mVILtoiJ2pA40n0Uus93O02woGeKY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d191cf15-bd9f-4105-1c63-08d585dc1f27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
x-microsoft-antispam-prvs: <DM5PR2101MB10455690815D49E19D9855F2FBDE0@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501255)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 0606BBEB39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(6512007)(2900100001)(68736007)(2950100002)(6916009)(26005)(9686003)(3660700001)(6346003)(6486002)(229853002)(5250100002)(6436002)(3280700002)(22452003)(106356001)(10090500001)(7736002)(105586002)(186003)(5660300001)(14454004)(2906002)(305945005)(4326008)(316002)(102836004)(33716001)(86362001)(76176011)(72206003)(66066001)(575784001)(86612001)(6506007)(3846002)(6116002)(33896004)(54906003)(8676002)(6246003)(97736004)(53936002)(25786009)(478600001)(81166006)(1076002)(8936002)(81156014)(99286004)(10290500003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: J6V5gFTm4NYYyK4eDnzscS7sIJ1bFtJN8nbwovIjnPCTx0qVBh2/BRcmBuj8RQ9Eulw4CzTKUCcUfsqa5l0RFTo9Nd6s6ASsS4ZQ9rmzMZi5R2XY0M7tf1CXNksvQOgwE5nbaQz0pb0xHIInp/Wmux/hMgY6BbRnRKUP2q5J8Xx4UC/ULApxfYhWVfL3SnpMVxoevoYMJvVgnKM7sYMkMrbsDq3FGJTXqz9NTUeBYzqwN5xkh05J3wMJfFnnejO0D0hF7K4MpIZ9ZPnTXDees5Y/ztWIMgQt6dYZNTstwhMKxfc2ekXad6YKlPmWZ6ng3biJwh88c930dsYaBi8kZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2D8FF4760286B4FA0434421DFF41B97@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d191cf15-bd9f-4105-1c63-08d585dc1f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2018 16:38:00.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 10:09:44AM -0600, David Lechner wrote:
>On 03/07/2018 10:57 PM, Sasha Levin wrote:
>>From: David Lechner <david@lechnology.com>
>>
>>[ Upstream commit 07c7edd0db441f83eeee087470add5be280cc018 ]
>>
>>This adds a compatible string for the Texas Instruments CC2560 Bluetooth
>>chip to the existing TI WiLink shared transport bindings. These chips are
>>similar enough that the same bindings work for both. The file is renamed
>>to ti-bluetooth.txt to make it more generic.
>>
>>Signed-off-by: David Lechner <david@lechnology.com>
>>Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>---
>
>I don't see how this patch would be useful in older kernels since the
>driver support for this compatible string was not added until v4.16.

I'll drop it, thank you!

--=20

Thanks,
Sasha=
