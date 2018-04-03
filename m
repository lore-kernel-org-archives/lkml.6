Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-361680-1522726067-2-18267320920698938225
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
    1522726067; b=uiVAV2N2tqqiNsdCUbJX4tteUbb5CrH+NvRZCx60h1ElibvYC9
    CVamV8bhxwTdMJAeWCjwWnLb3zbp++zv/mu9792H4bUPWW/LqNcnOJPwVhURTNCX
    Wwm1ZjztCYVTINcca8gbz3XSZLz5DsLM72hxkiBlKwrFf9/ucZPar2QtG7hXFTYM
    V0o4ErcUToyeSp5YPgjUFIXX7Uj492FdRbJkuS4zXj7Llh0EL8DZuQ9YolS9b7wb
    9wnktnEEl5pAaokX62QoAyp28LFlneqAZqyUqTBYjVIUP7J6mnRRcmP2Rd+uCb0v
    5X8PcAJcGUIT3FKISpF+Zu5LfkOqJq6OZ4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522726067; bh=btBEmaVYbq6Hi9tEt8dPrNVwfUeabuabHtg3C+xccgE=; b=
    vsI7UeH+RU5K69OF4bex7ol+aHQ11CkEM21RGVP+ToeojaNH1wzAgYHnBHL9YJ3A
    10qWE8OozqZnGvZ213SJBQ+i1zcxw/t+wuXXnX5Htm32Dy7JpRnsEdgRpCYWpvxG
    yeRoquIZ25QgFT1XeRtdxGSbtf2SybbWn6xwLL6cTX54rO/wuYaDTNUQ1PPznSTJ
    xpSABGw9e+1VvHgxT0osGjZqZwqN1nXMBNdK12h98Va3TFRMwrjqW/GXjTnNEug1
    mgo4XJAOkPNCncK+75P423Kg5VBJopoSCPHIRuNXelIdKvmo0INC5NZOs/VN8IwY
    pFd2ru7y8MEhWzu0d6+XnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kaaoRkv4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kaaoRkv4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCKgVdtE68nBcY00jRJV+U3GPHDoD2E0TEDwT1Hm1T6kGgOcvRX/iPJS++ksgI5Ftl3KI/TeIxKHmnTbA0OFjiiZtfBBUy32oMPyd6AYfbpGcP7aEW9U
    qe2ZMvrVadJa/o9kB/DNuqGeE9Fh7hdtsvrhGkx8JN5bVrwFqrZOtqJg9l7oH7BI584u8T/gcDNxyCpYqNbe18vqkTJU3cdG6WF7oMyJvyBBuzrc3vERW+QK
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=WZHNqt2aAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=jomPsVQQmNTdp3PCdkMA:9 a=CjuIK1q_8ugA:10 a=PrHl9onO2p7xFKlKy1af:22
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeDCD1p (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 23:27:45 -0400
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:59840
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752935AbeDCD1o (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 23:27:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: David Lechner <david@lechnology.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH AUTOSEL for 4.15 104/124] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Topic: [PATCH AUTOSEL for 4.15 104/124] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Index: AQHTv5nJGUwlmQMprEeYWg0XJMUef6PXtiQAgBbCGAA=
Date: Tue, 3 Apr 2018 03:27:41 +0000
Message-ID: <20180403032740.GL7561@sasha-vm>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-104-alexander.levin@microsoft.com>
 <6a944b80-c86c-ca23-5ada-f088d84c9a80@lechnology.com>
In-Reply-To: <6a944b80-c86c-ca23-5ada-f088d84c9a80@lechnology.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:hd2uCxGEIgOnEZtzrkyqNq/70z2u7pqgAEs3gY2bPrqjQRaC1W3F0vH5aGY/tClY5tO6gojCBjiKJVW1LUEzeiRTNZMvY4CA076kBtBvZcc7hffnESxxg+W5RW+GJZnEgVwjhuJv3zki3TZr3fYBBbNHwAQdHzksPfs1Nh0oJdD8wX0jZVTPKhy9+b73HzYSsa3x5tMeB3aglN99HNy01nP/BkPLgAKSqNg+60upVwC9XeojVv/QfZfa7KHnKnPI;20:YlYzhOaczLhhCGG1azMEz9ZIA46RZ7hW2XCfF14GVtOAkfa/Gekf3YC6WzZbHHayM9gbzq36C7JmdIIdjjn/pli0N6FzC3gHphKQBevxBpR2tnZL3D7ZntzXckgkz66ZS3PyQpsiBs5DSsaEtBkeXBocadDvC7TtH3StX2pkCPw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 67ea6c22-8fe4-4fd7-e151-08d59912db87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032B7EFAEE3DA4E78046F0AFBA50@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(81166006)(8676002)(81156014)(3660700001)(2900100001)(97736004)(8936002)(6916009)(305945005)(105586002)(33656002)(5250100002)(7736002)(1076002)(3280700002)(2906002)(99286004)(54906003)(86612001)(6116002)(3846002)(186003)(33716001)(68736007)(26005)(10090500001)(86362001)(575784001)(76176011)(33896004)(102836004)(6506007)(59450400001)(25786009)(66066001)(478600001)(10290500003)(14454004)(106356001)(72206003)(316002)(5660300001)(9686003)(6512007)(6436002)(22452003)(53936002)(229853002)(4326008)(486005)(6246003)(6486002)(476003)(486005)(446003)(11346002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DleqKo0OUwLlT6e8kEVgJ1K3W7lQCyL6Br/phZ631tHgcmOlyI3PIf4DRwXTGMbNh5O3JIFyGnAweBqZ1JyMADmZrWbyTQUujqc857EtcJqJpB2GoQ7lBFQNDavrIypL7Sj1rMMlCqO6UKXyXrToUpQd/86IbgKth/DON0XFESyo9eG2G58vNIALKbHuxDYTYYBX+idJSFyN5UAJK+BeGweuh1xLO0xDCzuM+2dOxg2CO40FOGm6gNRx8Eg5RkChLCxU46SruSY5xQSejEtt/KgZFh9W5SQKO8+V5mfmJf+GwEuGBTE69qkcXtvjpE2iM4DzAxJ7uFJk8x7LhITFtEBDqfFDT23IdvYqH64DBkoX8tPulWJ3oyycFECfcJtjn779nSdDe7jILp5s55avkF6dix3yi2CBLfHZISePjkk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBD93F8FCADCBD4F811AA3789CA23D82@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ea6c22-8fe4-4fd7-e151-08d59912db87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 03:27:41.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 10:55:16AM -0500, David Lechner wrote:
>On 03/19/2018 10:48 AM, Sasha Levin wrote:
>>From: David Lechner <david@lechnology.com>
>>
>>[ Upstream commit a12aa8a68dfef5de181f2e555aa950a0ab05411f ]
>>
>>Reentrant calls to clk_enable() are not working on UP systems. This is
>>caused by the fact spin_trylock_irqsave() always returns true when
>>CONFIG_SMP=3Dn (and CONFIG_DEBUG_SPINLOCK=3Dn) which causes the reference
>>counting to not work correctly when clk_enable_lock() is called twice
>>before clk_enable_unlock() is called (this happens when clk_enable()
>>is called from within another clk_enable()).
>>
>>This fixes the problem by skipping the call to spin_trylock_irqsave() on =
UP
>>systems and relying solely on reference counting. We also make sure to se=
t
>>flags in this case so that we are not returning an uninitialized value.
>>
>>Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
>>Signed-off-by: David Lechner <david@lechnology.com>
>>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>---
>
>I don't know of any existing bugs in v4.15 that this fixes, so I don't
>think this really fits the criteria for stable.
>

Now removed, thanks!=
