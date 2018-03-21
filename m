Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-702083-1521666137-3-16824671743049791072
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
    t=1521666136; b=r/anmMh7eJQuvwWPvqvZPX0AqrSda4+V3jwxOQcPVvDEagi
    97+1eZcODptDc+pjDcKvL5fBZqVOF7wQdubpqUGsLJ7t4YV/eBIlSpLVWYe9EAKu
    6S6ufvAjAnyHkfaztAw1C5YrVtd9TpBDyZQcEQ2m+8UGj4NULr2oASiloIMJHYHv
    aAn1DhMlVAunzj6KJjRg9hixXBuS29DmWr+6vN//AWmN3mHF+bGld8Bi2fHHSyfT
    z7hbU6p+G9knVF1GX+r9CDL/cfxNlQpYz4PbebmSYhV9Vz84e9H6ShGu9pUXMDYB
    DvnCHfmXxnvRl9HhNVzuZyG37QpDZPrxmJn3BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521666136; bh=K6kHNwDk13Z1lRYbV9iSJtW3M90L0QyP7zmnJ2
    mJVV4=; b=LdZ4Kjze396ECnoDCxBRQoG7L9nJn6JAvNI5wIgeMvNwGuaw9FKkPI
    3d1FTeHfy2iCxEmwm8tXeOtONbIu+nosKj/UpduDr05xVIhwpBgxAUtU/a0Vw3r2
    6Hn4oMUvZA23nTmCEdGPSd6eXPcwVIDW4ld2yXerEokyuuazsvQ8U4WE5r2tagPd
    5HZuKvDR4BVZ6uRn5wVA4z2HPRzgAj6/E6XNesSle5cEodAlp+NJczaTdGpZPCJF
    2BWgEuiHPa/+Suxoq+s4BBE6SBg64qbny4g41pL9+jrcPT1QTrDPKUB9zlegQ1se
    JAlFyKyEmjlt/knvwMCsp1q6OMVkI50w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fPrc45E7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fPrc45E7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeCUVCM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 17:02:12 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:51760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753489AbeCUVCI (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 17:02:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Ido Schimmel <idosch@mellanox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH AUTOSEL for 4.15 058/124] ipv6: Set nexthop flags during
 route creation
Thread-Topic: [PATCH AUTOSEL for 4.15 058/124] ipv6: Set nexthop flags during
 route creation
Thread-Index: AQHTv5mo//FsBdCFtkuOTa0rN5EV2KPX2kUAgANWQQA=
Date: Wed, 21 Mar 2018 21:02:06 +0000
Message-ID: <20180321210204.tyiexrbcxxxuc6ul@sasha-lappy>
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
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:2ZOFburwxFX9vNEtdKFJrSkxCVcwGEUDkhlvof9gK6LMVpgu0xfVG9NJqap8r/+cM7r6stMv3e7POF1/noiWugDQKsl/l5PAET9or0qNmMXNWcRw9Epv9e7FzHWLUt2eNRMqT9Xh8HvnI+07H2YKQ08FHN3lNRdvZZsf3oYK0BeMIuzlaEbDc1rcRXhddQU6FGgHs3TTtphHsZAc7rxIvJAJi2qTZIDmLmnxhpZNvZd18xqFkcKXLxcf6YBVKZOJ;20:SVfwsU3+lJqyBdmqzKP3peDSUpbEjrbziBgCxkOYFFchWniHxSgMpUO/lWZ+whe5BdPemFEL+Nzejf/AdbzeXY7LdkztaOxkIEfuRNbgqpPmqWO0xiDjr6ygHSEl7qXWKIwzsKKAwe3v0hh4MZ8IcuXb3nwuvGZMvjqfMJqsuRc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1094836-c665-42e6-503d-08d58f6f010d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
x-microsoft-antispam-prvs: <DM5PR2101MB1048A4EC25CDF8A597116D8CFBAA0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501316)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(14454004)(68736007)(10290500003)(9686003)(6512007)(6246003)(53936002)(54906003)(3660700001)(99286004)(33896004)(76176011)(6436002)(6486002)(2906002)(2900100001)(1076002)(446003)(25786009)(3846002)(478600001)(6116002)(3280700002)(2950100002)(6916009)(4326008)(66066001)(97736004)(105586002)(10090500001)(72206003)(86612001)(22452003)(7736002)(8936002)(26005)(186003)(305945005)(229853002)(5250100002)(316002)(8676002)(106356001)(6346003)(5660300001)(81166006)(86362001)(33716001)(81156014)(102836004)(6506007)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: s3Om6286Wz5ndhSWQ96htNGTLIbq8ABKdOXhA0DUH+oh8Xv2Qjx5IWqNPTU7/JabgdbtwWtqzwwR/RXie19WlSIk+/IbhNHhqdqxQxY3gWsc6WVLkz0B/m9i3s7I6kABMzXEOOUKQYAambZAPWiXdTeo0v33JApOmNTN16CGg0INXMZbSxUfN8zSHvOBGP3CrzsKX6vnaENEr9+ea+orcUC8MC+IJtxU/tJFwjM5VCH97rY4q6KMEzLd6hmLrcpPQybQWnSMvO1sxmlTFdJtkDGWJdrsAvmT2WRYWFwEK3F4LEPYj9utXrFOGx9YNTlU6x+Q026eH/cUQ3um4AzoPw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE9B9131E673544B90D4306F95750040@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1094836-c665-42e6-503d-08d58f6f010d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 21:02:06.2953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
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

Removed from both trees, thanks!

--=20

Thanks,
Sasha=
