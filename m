Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478853-2-2881422175061182148
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
    t=1521478853; b=U+XAXvfHbAE9tl2igFnCnFuV48Re/Zc/+IdXu+LonbZzRCh
    UhsClvZ9/VsRywQt582bej7xo95rEw1Qn6Ah4OUSaSSJ7QfFx8w15n8YKKuDV6jc
    hF3FDye/YjsAZXGJpVVDaRPgOJTMup92E59vr751xlhikW3s/2a7adS1Ob7F2xBR
    z44k56UupotH8vWtlPLpYrxsnjFMbXR1vTYoaMqRxGqMChwHDsOvKoCQT/wAnI3H
    X4MBlGXxsV7bIux80ZArAFIaJjzmw6lrtupj58mC4wmeyJmbPWrHbsCJiC9O4K/s
    oLKLlSPMkexXPH80FkBqtlt4V4N2wkrAKkBadjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521478853; bh=usbxFQd5I79bUTTcyd0icIB9+wlJXq5h3555v/
    VOWjk=; b=KPkas4RIAyElv3TLfKAHrOOeeDEDLgva6KVHq0f8U+46RLRu0Nrt2p
    UPJrwwSlwB1OTtVeCffM0TBOh9dzySGGDSAL91xlpwm5suZRcogxqzDtfkV99eyd
    8xNf59k8aGF/SEh8mGEWSuAq0Zittz/Nwtlu1aTxQLXKeb4TZaEHFmwIqQHSYh11
    pp2i9qtPCL4KuPg9oftq0tSsQYnX7GC25fHFpYguLTnc/R0oMu1W4rw/D4+QVrWV
    iKCx7UDeQOPf2MlrNmlvfbtUYWV8GZ4lfDXs44A65b7om9/oyVqiGI0xYUW9GcdC
    WQsithbcJxMn5LMK3q4NEE2xZ/cUJXGQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NsbYCcr1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehuddunecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NsbYCcr1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehuddunecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeCSRAh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:00:37 -0400
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:8497
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935117AbeCSQ6Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:58:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: David Lechner <david@lechnology.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH AUTOSEL for 4.15 104/124] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Topic: [PATCH AUTOSEL for 4.15 104/124] clk: fix reentrancy of
 clk_enable() on UP systems
Thread-Index: AQHTv5nJGUwlmQMprEeYWg0XJMUef6PXtiQAgAARnQA=
Date: Mon, 19 Mar 2018 16:58:20 +0000
Message-ID: <20180319165818.7bxduuoaeptjsvoh@sasha-lappy>
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
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;7:+JgpksIil24mxJ2e54x48pkagzEgzNcAS8qHyRgucgplyJQZbCSOgUhAGfAcQJoWi8Dq1a2RgAZj7cWS1SVFCBDQuaaQe1/pdRuISUls5/k0oV5JCXbXerDx/0ru1Qe2xxmtMscX55BCVODvvAuDzS1HXHTf4YrUSJzpGlycPpqaZ4VdJGMyRJyxXILoxyy6fE9iRVD+igPrDtb95le8rJlhG1MXlVYzDuOV4E9ZewKBBexq54H/s5cwQHkwXudZ;20:Km4N27z/R06GFhIBfvCyQYwwSPYFv9P79bPaee/W567JjXZk5ZKNMAiNlB7XHJSQyBi2v3dqIY6PdrB9+8hLyTUNPSVkL9Z5XapjG5c3Kr/X9GymtMLkO1omfPDtqt4iRO2dJv2mOISyEIhJEnKRVdtq1styMrjX8KcAAKAUT0A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8b3e310-c27c-42c0-4d6b-08d58dba9e77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808E287B999CC2DDE003B6BFBD40@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(199004)(189003)(575784001)(7736002)(2950100002)(229853002)(305945005)(186003)(86362001)(6506007)(3660700001)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(6486002)(2900100001)(6436002)(6916009)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(33896004)(59450400001)(8676002)(14454004)(105586002)(6246003)(25786009)(478600001)(5250100002)(53936002)(3280700002)(316002)(54906003)(33716001)(4326008)(6512007)(72206003)(9686003)(22452003)(10290500003)(66066001)(99286004)(76176011)(97736004)(106356001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Se4V0rk3WLSnW1GhmaLx27j+9KR7WxGXLr8TVM0XwnirpsEYzRaSAheK4MHG5y0kTO5OP/QjB0eScrQbwHJXdy9/ckwLIB25yzwvNarn3I5y3WFwpAty+JvdJfTkMofwhSEguqdQZysTNiYaVzFgtW1dL866v2XC/j9hcnu/KVOWLjD0yVEDOW3AUaJ34paOLZLf87S2I6/Zr6tJaMOSBC1gz3hDwUkt56U9n5ZSICgjwysBK3vonpYgQXKOJsD0eBXRUMNP9ILfSDk5EHokrd0rFTGKn79erMz8BPzA+4FM5ePF5tKQQwiDcZuTX6Ytfbk8aplFqTzoVFZdKec63Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56BD72410A817A4EB4418314CD7419D5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b3e310-c27c-42c0-4d6b-08d58dba9e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:58:20.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
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

I'll remove it, thanks David!

--=20

Thanks,
Sasha=
