Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-361680-1522726042-2-5600429475558554948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522726042; b=YQN3SSo9sxp07VQXgSOGSAU+6dNqtQs1nlHOqQRaC4TItToK5D
    bTsW/J/LeURxlz6gasq2HsM1HoUF6di2wEz8zPKI2kBY6mHNs2Exs/eUMbAXvz6Z
    ibW1r19V/ofW8Vs+n/req77LU1Gnwm37A5dGMaJTtCUvycS5Il+9rLiEOpSqwvyw
    5uxj06T7J3tLi5z/Q1ihRgqQXihgrqGgIBykrwGdcoUmVRw/Fbje0uB+BO7JUGuJ
    FyxolFMlwEiC5tw+kxs0NVDYCwQyrQTrJN8+EnlLuod2HFwZ3u/KK83wg6AT0Wi8
    B1w1fxteQ8em0BW85tDWUYKxEsREl5RgcfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522726042; bh=uqBHHQFPGMeTZjNgc/a/El0h3YwCgZfefL5bjhViGxU=; b=
    RT+mlxMLXHXlQGQv5p+x6ZXJM2x/2TSYViff2xbqpBHxN5kF1DJZ2bjH6fECjQla
    FW71yCtjlG75/4WHvU8RpRimi1QNJx9RF4fnoFPbtkLUGBf7HNy8kP+EN+hJ5ga9
    ecaOYayi0KGYF+BSPJEaENTW1GF9UvVKelvS4I/89sdkGZeC4098eFiIkieMF0mT
    H5F4BPSA+xjH3JS/k0X//OfBomKtWMXenC3h8elqdAub3AIJujnQecDVrnndu3gO
    5ss6MWZqRmIW9maycX2n/iKRE73DRyxnlXr2PR4tD8122hjEnDVhVU6aXK6A9ad8
    LYS8RaPKelAHj9uiT38Ejw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GZLrNDgK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GZLrNDgK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC1YPnZ2AgZVpgLlWN8uvBuwjBOwcu/teQW9P4hMkvO2Be3f1kAujPv1ydmqdqGB03suJaFf4RGJd4fQfuTiQt6kXyoOzrEqSL+2ia17XQ8flGQaaUAm
    ODkP0B+Vl90asoJwxIgKbUmxC+LxoOsLIU/sosNJlGExwuSBTUbjr9OB5lKXPJEQZTJ9WemhNBpTIHtpz260ECwmLPiIkfVizfitHK3WKD/M23Srt5PqmuW7
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=3do3QvaA9hMJ8n6RsTgA:9 a=CjuIK1q_8ugA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeDCD1T (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 23:27:19 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:32160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750905AbeDCD1S (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 23:27:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Ido Schimmel <idosch@mellanox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH AUTOSEL for 4.15 058/124] ipv6: Set nexthop flags during
 route creation
Thread-Topic: [PATCH AUTOSEL for 4.15 058/124] ipv6: Set nexthop flags during
 route creation
Thread-Index: AQHTv5mo//FsBdCFtkuOTa0rN5EV2KPX2kUAgBad2QA=
Date: Tue, 3 Apr 2018 03:27:16 +0000
Message-ID: <20180403032714.GJ7561@sasha-vm>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-58-alexander.levin@microsoft.com>
 <20180319180434.GA13336@splinter>
In-Reply-To: <20180319180434.GA13336@splinter>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:uhP9VeFAgOmXj6dFYhI3J7KEZdf03DEJ7dFmSLYnvUArADV5k9MuwZ7+aUeZwC3sBcGOffd3dJYvWx0FscvBK36YbUewR3C9yz8mbhsoCE9QCrQlN3Igm5ltgAUFuYJHZME/I0+qqOPoct6oEXfnTeMr8se1auLjOX30OBpoTmWDG42oaLR+VG7XCrmaAHo7080tNubVjOpThnXL1MazahCKFiRUNZGPOzjjmfqvEyQgw/z7Z0gS260ReL47KGcv;20:R/RG8iaWIzIDEAJhOuGfQLgqhkomxLvrIljIAu0xc9tKc9BD/WoA89JKEqCqOH4sS8z7fZZTJqCzvQj2pbnXA+h1MAxDUBgFmesEdfpJD+/ngGNFp2V4y43MJ45fhHxTu/W5qIG9ZubG3XGr6pa7/GOEt8WEJ6E/qHL1wmlbtjI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7fcd3c43-e706-4d8d-c878-08d59912cce9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10326A38B1C39AE42E236EFAFBA50@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(81166006)(8676002)(81156014)(3660700001)(2900100001)(97736004)(8936002)(6916009)(305945005)(105586002)(33656002)(5250100002)(7736002)(1076002)(3280700002)(2906002)(99286004)(54906003)(86612001)(6116002)(3846002)(186003)(33716001)(68736007)(26005)(10090500001)(86362001)(76176011)(33896004)(102836004)(6506007)(25786009)(66066001)(478600001)(10290500003)(14454004)(106356001)(72206003)(316002)(5660300001)(9686003)(6512007)(6436002)(22452003)(53936002)(229853002)(4326008)(486005)(6246003)(6486002)(476003)(486005)(446003)(11346002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DNYnu7KC/x10Re/lvNws8HdRI6bVdfauDjEqDYJ7lIzYJsMUQFbwvj7d5hkBiaX1m/RZPe6DqNuj6uhcurtckkuu5mItxRPi3Ecqq+ZVoqEKMFM5/oyAOeMn9RH+eM9XnftjLu3BiO2182OPDy4u53sEV5pwBEkPYsas/hLkF4uuIGUSj1VOaXBncYwTw5ffcdlh5FWQlWMbIOdmnRceVtj91pj4L0erM7+lHbDU6O9tWOnzMzMooLPCk9TmBmrFnUkpLJwQSZ/PXnRibmCbHE5TP/l2BrDscXzsH9+GfXLyhC7828sWVTc+fXLjBkbp4L6rewr8L0xFEob1eSaUO5LHof5ZoebgIJ4nGbrILBrkpgZ/Yqx/ia1UaWEgCEKzIR3+sNjXZyt/jdYX1N1kPnaP7I/iV+HvsZZzH5ydaVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66319DE7808FD7409CBD5B3427E64CE5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcd3c43-e706-4d8d-c878-08d59912cce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 03:27:16.7386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 08:04:34PM +0200, Ido Schimmel wrote:
>On Mon, Mar 19, 2018 at 03:48:00PM +0000, Sasha Levin wrote:
>> From: Ido Schimmel <idosch@mellanox.com>
>>
>> [ Upstream commit 5609b80a37f69f796548339e675256188b29c17d ]
>>
>> It is valid to install routes with a nexthop device that does not have a
>> carrier, so we need to make sure they're marked accordingly.
>>
>> As explained in the previous patch, host and anycast routes are never
>> marked with the 'linkdown' flag.
>>
>> Note that reject routes are unaffected, as these use the loopback device
>> which always has a carrier.
>>
>> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
>> Acked-by: David Ahern <dsahern@gmail.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>Hi Sasha,
>
>It doesn't really make sense to take this patch to 4.15 (and 4.14 from
>your other mail). The flag is never used there.
>
>In these kernels the flag is dumped to user space based on a carrier
>check. See commit 44c9f2f206f8 ("ipv6: Check nexthop flags in route dump
>instead of carrier").
>
>Similarly, during route lookup the carrier is checked and not the flag.
>See commit 14c5206c2d02 ("ipv6: Check nexthop flags during route lookup
>instead of carrier").
>
>Thanks

Now removed, thanks!=
