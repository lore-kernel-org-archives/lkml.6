Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63EBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778A1222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="lLNy/bXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404053AbfBMMVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:21:22 -0500
Received: from mx08-00287e01.pphosted.com ([62.209.51.156]:42734 "EHLO
        mx07-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727958AbfBMMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:21:22 -0500
Received: from pps.filterd (m0111316.ppops.net [127.0.0.1])
        by mx07-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DCA2vr031542;
        Wed, 13 Feb 2019 13:20:00 +0100
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58])
        by mx07-00287e01.pphosted.com with ESMTP id 2qhnxyw3e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 13:20:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7HslcWTJ94QHAPWA/SjhTjlUfrI3uIw8f7+W6Jx0+4=;
 b=lLNy/bXSU72bpO5DAbekWTNyDIRBXNnxgkB5ncGaNpVD5dRx928HvYDKuLY3FC7MEYraKLrHfbu3Rbkvr4tMuZXDN7UisG3urXgAmPLPcvq2YqmjCQKf5sl/ZU39ihBQuVLuBFno3ix22yKcfXPtbyPFJfYcmsA5YaIUh7BDtaw=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB3279.eurprd04.prod.outlook.com (10.170.231.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 12:19:58 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::9851:8b8c:f61c:6045%4]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 12:19:58 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Erwan Velu <erwanaliasr1@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Topic: [PATCH v4] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Thread-Index: AQHUwqHbuIj7d8IoTUinA77lsmPW9qXcyHUAgAC1TQCAAAxYgIAAHX4A
Date:   Wed, 13 Feb 2019 12:19:58 +0000
Message-ID: <b62cd57c-e348-60a4-f99b-e3a6562f6ef8@criteo.com>
References: <20190212070839.25981-1-e.velu@criteo.com>
 <CAJZ5v0i4PFWQ5fMZ8Rh3jgu22=Me1+ArOwVW333BWa4z54Lqbg@mail.gmail.com>
 <a2f4128c-54cc-44b3-d615-977e9ed37d07@criteo.com>
 <CAJZ5v0jq4RGkSoO7+_uO3yDZ6g3a=Jm3YGck8Maptqff2RCkZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jq4RGkSoO7+_uO3yDZ6g3a=Jm3YGck8Maptqff2RCkZQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR03CA0017.eurprd03.prod.outlook.com (2603:10a6:20b::30)
 To VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5345ec49-3bff-4f4c-cf38-08d691ad91b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3279;
x-ms-traffictypediagnostic: VI1PR04MB3279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIzMjc5OzIzOitEamNRNS9GRU9LRWQ1bE9MT0szWCtmbXdz?=
 =?utf-8?B?cXRmYXNtVEhiODdMZ2NRVWtKUW9QYW53YmpTc3JwUGFqREkwTThaYkppWENj?=
 =?utf-8?B?L1Y4WHg5d1Y4dXB6WDY3SHRSbmhSWGFnNmh3TzFYUmFFQ1Vjb252Mjd2SjFC?=
 =?utf-8?B?cWdLaEpQTDJ5V1dxN1c5QzZ0Ly9xNTdkS3d3d1FUL2RPYWErNnFiSU9ZZ1U4?=
 =?utf-8?B?WUJJTFpZRGxpTkhZR1pkSDF2dWlvSElZVlNrSHFObTE1OFdOOFIzZnEzSGJW?=
 =?utf-8?B?UGxpTklVRHQya2Z3Nmdia2tGeG5ndFVaSnN0MURRZkhaTE92TmNSaDRZajJX?=
 =?utf-8?B?UlVYVjQreXZoaHk4UzF5Uzk2K0tzdWFlQjFuMWN5OTY3dnd2WGp1Z2I4ZTVH?=
 =?utf-8?B?YmNLU25rVm5oYXk4Njl5TU5jN29Wc1ZkRGhhRExCUDVZWnVUWmh6eVlmRVVi?=
 =?utf-8?B?cm9qSzMxV0tBbitsbVA4ZTBSWVkxdGFweE5XMVFPNlFXcmQ2UGxuRFFXMlhD?=
 =?utf-8?B?SVlmWmpEdHRQR3ZYTUMzenhJcDZkSGczbSt1TXRLNW1vdDBSVm9vWFozSFQ4?=
 =?utf-8?B?QU1GenBRa25PQ3kwUlp6R3BVOXc0dUpNNnhGb29BY294UnNtOTZZOFJUeTVw?=
 =?utf-8?B?ZFJ0b0k0Z21ZYlZvVkR4YUlMcWJhclhrNnJBWU53ekxtOThCSEpKY0NLZDcw?=
 =?utf-8?B?eTJON1p2d245eW4wYWl6TlRGRjloem41VDJrOWdKRWpkNDVZQkZyWTVCYlVV?=
 =?utf-8?B?TGJjU0VHSS9DRmRDUExwRkxCVHRweS9zVFNaanE4Uy94S0JPWGdxdlp0TXd6?=
 =?utf-8?B?SmRRdVUvc3lxR055QVJiSS9nd2hLYnE2TnZkZHhGcGZBWWE0cW03M2pHazRS?=
 =?utf-8?B?RnNqcEdyTUNnOUNjc05hVlVRQjVKOVQ0QUhlVFlKcDBiaDBvNGtVQTRvek8r?=
 =?utf-8?B?eUI4TVdkaUhwSHNNZ1NuQ2Myb3BUZEo3YmxyeTgrVHVhK3FyMVpzRWYvNGFO?=
 =?utf-8?B?TTZZYlJjTmVVVGVYQlRzS3pucUpPRzAxQWs4eWJodFdKSVllRmJKRDhJaW9G?=
 =?utf-8?B?NzNMOXEyaGN3NFk4cC9qZHh5UitFMy9WQ2J3N3RSNFo0OHc1ZmozRjgwdzBQ?=
 =?utf-8?B?aFV1T1cxOEY3NHNqcjV1Q1VNc2xuclVoV3NYYitkck54MGVvaFFIZS9jSnJP?=
 =?utf-8?B?SkpYVXhxQWdnYlErWWtLQkJoTllqQnJuV2g3V1B2RC85TjE1TitHa21mUG42?=
 =?utf-8?B?Y0VWeXprU0Z6SjRwN2czbWI2Y3M1SEN1TmVZZWIyMzdiK05lb1dSMit2MkZC?=
 =?utf-8?B?QnZSOE1CK05NbU9TZXFRNlltbCt5aGs4MGFFUjMrRFVORkROYjdlc0o0bHJG?=
 =?utf-8?B?SHBUK2VUOElUdGR6ZmRNMUhZb0JRYVBEQktrdU1kVUJZQ2VLNnlwNTRZalRt?=
 =?utf-8?B?aXBBT04rUEpDWFZhQ2JudG1WZGVRRFM4bHZaTEpKTm95amxMejVJYU9YVTZK?=
 =?utf-8?B?QVlqUk5oWXJkWWZFVlhzMndNam9jMzA5aWxVM3V4dzcyekcrUnNwMTVnRTdZ?=
 =?utf-8?B?VktCTXdUOHhjV3daR2s5VzJKRXhhR1ZSQ2hnS1NPNUpwYlVibTJFUGFmOWdm?=
 =?utf-8?B?SnZBSUxUZ05Wa3VTQzlBZ0dUTUY5ODRTOGxlRFBvcHNvKzFybVkxazlpc25C?=
 =?utf-8?B?QTVOaWlTQmowdHpnSEZVcUtaeXR4VzhpR2FKNmpybFFoTnNRQ2VpbTZnV2V2?=
 =?utf-8?B?WlQ4N0tyT2FnN1NxNGgxdz09?=
x-microsoft-antispam-prvs: <VI1PR04MB32790A66E8A0EC3DDA015C53F2660@VI1PR04MB3279.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(52314003)(199004)(189003)(6916009)(316002)(6116002)(31686004)(54906003)(486006)(6246003)(2906002)(2616005)(76176011)(53936002)(305945005)(14454004)(476003)(86362001)(105586002)(99286004)(478600001)(52116002)(3846002)(71190400001)(106356001)(71200400001)(256004)(31696002)(36756003)(6486002)(93886005)(66066001)(81166006)(446003)(8676002)(186003)(102836004)(81156014)(6436002)(229853002)(4744005)(4326008)(25786009)(68736007)(6512007)(97736004)(6506007)(26005)(386003)(7736002)(11346002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB3279;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OKnaRlxuj9IN9bRwGoc4J8o+UovFzFiCxMc6WMp82/TIWkjAZmySlJbYCGGYOqE2gS8R6t33uA4ZfSgy3GDXAU8nuzGKN2oP0bdhwimOcCTA9vGONwy1O4r0TgWeAMFPfX04nGD/b/LG1SzOsq52DmHBA0SFfuptcHmk1cZPQaIPr4Na/NwdQZ8NsS8votKvDYrqheC5jMffEc4Ygw37vjv9ZIwBqWyxhA/y3gXvksJcyPVesbADxM8H7m7uRa1XbAcB10bIa5PwfiW/7emAOeJVX2tnAgtUXhbEZA1iJUBQhHjzFhrn51+5eQ4GnT/plOucGXmm60nzO0g40fC8WoR8XcpYWlhJyfFoIggPkgxoDJYfEjdTbxrztRG3cffoTo3Jg3FXZpy+4e/cfYC6mi9aDQcxZP/YROgEl6VSHLw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34905C1B00EEDE4EB83C026582C4A879@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5345ec49-3bff-4f4c-cf38-08d691ad91b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 12:19:57.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAxMy8wMi8yMDE5IMOgIDExOjM0LCBSYWZhZWwgSi4gV3lzb2NraSBhIMOpY3JpdMKgOg0K
PiBTbyBhIHNpbmdsZSAibm8gUENDSCIgbWVzc2FnZSBmb3IgdGhpcyB3aG9sZSBmdW5jdGlvbiBz
aG91bGQgYmUgc3VmZmljaWVudC4NCg0KTGV0J3MgZG8gdGhhdC4NCg0KWy4uLl0NCj4gQW5kIHdo
YXQgZGlkIHR1cm4gb3V0IHRvIGJlIHRoZSBwcm9ibGVtPw0KPg0KPiBBbnl3YXksIHByX2luZm8o
KSBzaG91bGQgYmUgc3VmZmljaWVudCBJTU8uDQoNCllvdSBzaG91bGQgYmUgcHJldHR5IGF3YXJl
IG9mIDk1ZDZjMDg1N2U1NGI3ODg5ODI3NDYwNzExMzBkODIyYTc5NTAyNmIgOykNCg0KRGVwZW5k
aW5nIGlmIHdlIGhhdmUgb3Igbm90IHRoaXMgcGF0Y2gsIGludGVsX3BzdGF0ZSBlbmdhZ2UgaXRz
ZWxmIG9yIG5vdC4NCg0KV2hlbiBlbmdhZ2VkLCB3ZSBoYXZlIHRvIHBlcmZvcm0gc29tZSBjb25m
aWd1cmF0aW9uIHRoYXQgdGhlIG90aGVyIHN0YXRlIA0KZG9lc24ndCBpbXBseS4NCg0KDQpJJ20g
dXBkYXRpbmcgdGhlIHBhdGNoIHRoaXMgd2F5IHRoYW4gc2VuZCBhIHY2Lg0KDQpJIGp1c3QgbGV0
IGludGVsX3BzdGF0ZV9tc3JzX25vdF92YWxpZCgpIGluIHByX3dhcm4oKSBhcyB0aGlzIG9uZSBp
cyBub3QgDQpzdXBwb3NlZCB0byBiZSBhICJub3JtYWwiIGNhc2UuDQoNCg0KVGhhbmtzIGZvciB5
b3VyIHRpbWUgJiByZXZpZXdzLg0KDQoNCj4gTWFueSB0aGFua3MgZm9yIHlvdXIgY29udHJpYnV0
aW9uIQ0KDQpNeSBwbGVhc3VyZSAhDQoNCkVyd2FuLA0KDQo=
