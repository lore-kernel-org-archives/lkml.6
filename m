Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478910-2-1697939296780626760
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
    t=1521478910; b=wlavCf/uQukLpt1QAm7z+29Ux6Qhh+8UNGWkegSGd6j0JxO
    xJpqEV1oGvHJXmqyj+w09TR21OCDfRGg+j5EiC8sLBIHvWRy1cOrIE1ZVMdgTJcZ
    Ao0cKsIRlvvW8KO4aqfIQd2sy6/VlsKN/1J9TAUqQiA0C2KjLK8Iyd71X/f2Zba1
    gbtZUmP6cUz/zDlF3uLp9+R/bNDPgvhFkACImr+LB0uXyIYz5VZKOKl4MLkiz5y1
    WQlfmxqf4bcI3C/pHRy7CmSCtwnTAf+G0lm1VzeKwk3KJVJUIb0uhDTw2UC2isLP
    UCJB8wmtdtKijlQijQriOBcEj8TIKlYCWZwwylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521478910; bh=2kPGV6DCsdrLLYMXURl4FiGmQBcgeJDkgVq9Sr
    mhn2g=; b=we08F8N+GOTUddDfsdJIS4x+Sn/CW/EJk9PnF2r8zqPTLFK3Vv5e5y
    oOPpg3BHiKQWXPUDU96JmlA1Lo55aLM/xoQT49mveP4pg0YdxsIk4WiXhsjnJeXR
    dKwEz7XXmO5NZp96Scgd8ILT4P6BauydCBOu0L2l8XnJmp23CAcunHNoUfFAWC6d
    JRPxIbtlubHqYtIidBqVyIxjZO0jAddhlVqhszEUrgFUWc+/DRROHDAo5RH0R0ks
    EL99OTA1knYAChHgMgA4lJejrYPZ3x38m6+hwHKmCNLUnh0IjGdQYvmH7GTYzwPt
    fjKUj32TkDpoDMC4a1WWEOpXs68/ubNA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G0rCW0wD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieehfeefnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G0rCW0wD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtvdenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepieehfeefnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965301AbeCSRB3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:01:29 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:35956
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933771AbeCSRBY (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 13:01:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Florian Westphal <fw@strlen.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH AUTOSEL for 4.15 070/124] netfilter: core: only allow one
 nat hook per hook point
Thread-Topic: [PATCH AUTOSEL for 4.15 070/124] netfilter: core: only allow one
 nat hook per hook point
Thread-Index: AQHTv5myu58aptvIyEaP7WYFhKi186PXtpSAgAASB4A=
Date: Mon, 19 Mar 2018 17:01:22 +0000
Message-ID: <20180319170121.ms4qjcy6zu3xkdaw@sasha-lappy>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-70-alexander.levin@microsoft.com>
 <20180319155649.GF13873@breakpoint.cc>
In-Reply-To: <20180319155649.GF13873@breakpoint.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:NhaRqDOYkTzMxExBz8IqUzw7B9/32SytANEYA5OB+7k20I31FWs6+RKlkoYNdNOwY9WMSnp90RONngD/lspNzCntklbRTfzRXcuOOhSTOAT0JJX7YT2vyKDCk3lFGPFmFi4oJU+51Nw+795XOwdgeet9kuxJbVR4kJ8aSb5Sf8jUWNhgC+M1znNE/KcgjKn0r4w1MrgS5SabHx1c88iP+4usGM6Y/U0t1ngMl6fzPM3Y552H6fWp5dFLbkAWqp70;20:KsbBpo4pqUhRP9H+1aXCzTTGXpPjPyoPdz1R6zCPYznQ/YBSdE1BWTfyjt8JskUVy3XwHGSKNcFSDNgg4tTmTPXLRhGxK4wrPt3oW0p3DmYRGfI1/ouOfbQBk6o+Tts4teTqBQE39Hn7WTi+KZfgWwtYiVxvTutAVj0DAZNXeAs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d587a816-6269-4fbd-07c7-08d58dbb0b38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09193B8F0362E26B49D79C3BFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39860400002)(39380400002)(376002)(396003)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(8676002)(33716001)(105586002)(305945005)(478600001)(4326008)(7736002)(558084003)(81166006)(3280700002)(6506007)(97736004)(5660300001)(6246003)(8936002)(53936002)(86612001)(14454004)(1076002)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6916009)(54906003)(3660700001)(229853002)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(9686003)(33896004)(6436002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: I3PDqXeecml8Hl3bo7DIELqY+1BPm5/07JV1o6snf9VTPr+VqIPn15mq8EgVA9EWfjqzDx3w958+abb8E0pCNpmHWjDWhlX5BrLfgpB0bFaJGgec35HVnmUgJ4i6q8IgkDeS1+xv89eRzmQQ1YBY/F+6T6dU15XGUpy0cGLYJlFw5fFiDIMOjnJVbg7wMt47gPpWuJBhfxVcRlSxk5wSvlXq91rcO9s6mGZBD9xP4CASTvQyd1rbcEyZpxyi7r4yeROJlnPxYCwaH3/za8IbXpXLZWIgcvtBZbY4J4bYdzFQyXmmXic6TQ6F4D+ynoVmHBn21fizh4HK2GWgrdslQw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82423462ECD49F4591E1803B6959C171@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d587a816-6269-4fbd-07c7-08d58dbb0b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 17:01:22.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 04:56:49PM +0100, Florian Westphal wrote:
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>> From: Florian Westphal <fw@strlen.de>
>>
>> [ Upstream commit f92b40a8b2645af38bd6814651c59c1e690db53d ]
>
>This patch is broken and a fix is not in any tree yet.

Now removed from all branches, thanks Florian!

--=20

Thanks,
Sasha=
