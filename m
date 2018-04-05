Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1432864-1522892058-2-16131965579619514799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522892057; b=YTa7jdHBX86ZGyI/EvYGF8PYjjjU1NV4BloUXIA+1tSQbp6Xdi
    iGfPVQ6FNW1cMMd5A1a3J4FRN18dZo22JG/XjYSmY4Z+AlEjFshddAtG2UJCHsFG
    x0Xe9tu4KWwggsXMlNuue2FcuDSjekqJKqJpFOjwI8mH2DfPQ3cxjeQ1aDAojUKi
    1R2EgSqzQQIArGwhYKqwI+njkkKx80uqnjUiwHLZTeMaF1Ra2Co0HlSkZf94x9yG
    06Vz8x/LC4prkRkjcCoG75Mjx3KuFCSCL+7vMUT/fLGVdzMnbnukpufVO/DkReUv
    PGkSBgyhwFBG7nJ5Q1xGSsTPHUMujguugopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1522892057; bh=+URGhiQp7U
    wFH/Arl3P7HxBUeMnRH91xZ9bDinSuMeY=; b=OAwRKj9EpaQDbWLTc9s98c2xsC
    g37/CwRcvJahrIhXiYPS3NutR06XqcxNxSaUd1lMB1v1/sPVdpwxG+S++nec7F+v
    VdjV0CoIFqyrFFig+4wNwFwhZRnBBWwFCD/TTmBcGtGj2BWs7silXDO4sVs90w+u
    ac98uiHOgP2j6Wl6tbrAvVtiTSvoRimTSH3/9UR1HGo1pEDc4xjhNW8aH0MMYa7z
    rSE7R2OfBStYWK1Ax2U0ee+tY8DAkUvRg12IfGoxiYc4i0okCcKkkGNsRhoIkibW
    IFxxrKsyJpoa1pBiNXRfQc/q45fKxSlEux1qXUyIRZ1CYtBnyBwZE1YtZydg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aXtwj9yU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aXtwj9yU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMjwdMFPV2BY2TkHto++Kj0wODx4IpeiQfsPfhJH7l4PgbrqlFXQkHh/0HpmEDmSjDK4s8vnfdR3rYTcU+1nl9YamRdQqYpkRO5fV01zMsKLGwDRdLN2
    +gNyjdHJnfB0lv2Xz47zXtk3ArAUY4oOSgwAUQxyLCRa4Bw43uvuc/ZxO8VhX4bvF92lY1RWXKgHQ8gMJx4xyF7VcgAdLBwW34iMdo1RhVory8+rOLRH/a30
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=ztnmTfeYTcYA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=0dTTINSRTSE6oYq6QsUA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeDEBeK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:34:10 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:19260
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752824AbeDEBeH (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 21:34:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Daniel J Blueman <daniel@quora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel J Blueman <daniel@quora.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Eric Anholt <eric@anholt.net>,
        Dave Airlie <airlied@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vc4: Fix memory leak during BO teardown
Thread-Topic: [PATCH] drm/vc4: Fix memory leak during BO teardown
Thread-Index: AQHTzH4vJ2xD9L9PcUGf4se1YRF97g==
Date: Thu, 5 Apr 2018 01:34:05 +0000
Message-ID: <DM5PR2101MB103240B547AFBEFE48119560FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180402071035.25356-1-daniel@quora.org>
In-Reply-To: <20180402071035.25356-1-daniel@quora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:tXYpMdHcCrRVoF8VhRIsz0tD7McCs9b1OMvocv0LUFDBfmuqx8v1vXtpTLHRen9uAWjcJZEG2nnR0gb2x1S80lt2ZGf0ZcRqcI4sM58MHAgv5PZVJnPJsixF6s0cf8sdaRO7sj3lYGrGqxsdOhrMp1Z99QhN1KjvlsDvuKDR2+6FELTA5KOa+qcSaqKEt/IakUbNRV4BUCNbSlFNyvdmMDBQbaLJxltoVdvj7sysFh6gC1obDPK27/GvqmmCPsOM;20:D6nyAvVPLZsgDUzgKmqz9UCvkhrnaxqUUBcFWuqLQLuR8NUfP1VddIIx6oI3Dtap3ZS7mGimWnryA+RHmLusZZ14sjNnnJ0VNN8dhGRiH+3W4Y5zpIJDx8W9O+mqsOorrPRUEMMKieJQ1ff0/ESOY4CJKgqNl1QAHlAvpW/B9EU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16d727bb-62d7-4ed6-9e9e-08d59a9551f7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093334F5BB0E4E3701049109FBBB0@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(86362001)(97736004)(7696005)(22452003)(55016002)(9686003)(110136005)(11346002)(14454004)(2201001)(53936002)(5660300001)(99286004)(5250100002)(66066001)(8990500004)(6436002)(54906003)(6246003)(26005)(4326008)(68736007)(316002)(10090500001)(2900100001)(446003)(6116002)(72206003)(3660700001)(76176011)(10290500003)(81156014)(86612001)(8676002)(3280700002)(106356001)(33656002)(476003)(2501003)(102836004)(81166006)(478600001)(305945005)(105586002)(229853002)(74316002)(7736002)(25786009)(1511001)(8936002)(3846002)(6506007)(2906002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ItHw6pyVfr9Bo5I83wtCm1yjQQZPfXQBIQF3UOp/DfNYcvZaBhWzpuru1ugflk3TarPYTTM9kNAsqz9U8j8OAI1SOFr5Y2FUV8Et7HOEacAneanvQlmarH41x7k9fP/YfcNz391nLvQ4HIeEJsVxciaHGXiQixKLrEp+sjYzgEfUWcoI8mJGXQWLzvvTXcgZAtwz15tgkFf65miuDxxr+sELJumkpmC9Umj6Lu6dHd56s+XqhPofezXObMZ6KiOb1Z57069JfMGUc0mhSGnPAqyuCFLpXYqkDG5GdVbPlylYJ9UrkZ9xWllUfMLES10H4Sb4/yRXHl1H6zHoZiZJPvSjLcfTeIdgg5Z/lqGzITJJOR5nLsZ2tm3iG3XInBD9gSr8RpPn226LEK/AK8cTQJ/m1MKUJCGdj7ohNJC941c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d727bb-62d7-4ed6-9e9e-08d59a9551f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 01:34:05.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel J Blueman.

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has also determined it's probably a bug fixing patch. (score: 85.07=
20)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Failed to apply! Possible dependencies:
    463873d57014: ("drm/vc4: Add an API for creating GPU shaders in GEM BOs=
.")
    c826a6e10644: ("drm/vc4: Add a BO cache.")
    d5bc60f6ad05: ("drm/vc4: Add create and map BO ioctls.")
    c826a6e10644: ("drm/vc4: Add a BO cache.")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks.
Sasha=
