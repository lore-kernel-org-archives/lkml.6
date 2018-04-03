Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-376387-1522726066-2-9656651289691326488
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
    1522726065; b=o/kGUpR9aV6wKyvqgUQ14mCxRvlCVavqx0z89LpKWwH2y0biPS
    SmzGp3X+8HYk5SRxHJgTxdtEhz0jJxUSeFuU16lAGqOcul3MfkNm4GY1DwF/E1rl
    6h6tc7l8hcA0t5yOwT/3QOHfApTkPENHZKypwoSWiCAp0Aqvx1hm+dm820J4uiPi
    PAvPUMAiMLlnzxdL0ocrZTNBzg4ZoLotw8fCK0Ggbwj2sQtrsgzZD/jnwEVAGhlE
    0tCjaO/BrcxM2f6b+FjrGgtguDBlzwX3O5wiGNf5Ax4howHUIFKgaJK49L34kK9y
    7L1j1DtHZYiOo4io3EgT6PRRnUfoZftOT70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522726065; bh=WIkoXnsKO8d5bEbhHEU8scVw4QlPbU4xecuS15F9k4o=; b=
    Huwnoyf06aGBcqZKRVLZo0pr7TszORP8J2XSC2jHqW3tEv33jXlySdfHW30LNv2e
    yy9jnW3C/1ZLo7cRdf0vMMzC/RTfAnYn4phWVQYM3h5i9uccxA2NSr44hf2JnBfA
    vromlElnwxIS0zOv6m5pgOwP4MiUCYz0vGoIsI4YNMWxbMsnTrZ3QnC+f7qysIJ5
    et/yTJ7yDuTgYh3txgNegWJWX8IoHazWcMqv2w0KQfhgMlkx0WF8ZJbDcx7eNkku
    KPRr0Pf8Si6OiCflTUlAB5NFrl5JaZxD3pn/C+9F4CLyEg8Xwxmy1WMsAcASM24O
    23Q6Y1CYPu9MBwVM5sX4Sw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fpEPnSxZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fpEPnSxZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPk2mMGWJ0QiqYdvLh96r+JiYH3O7SPcUhqXziwHvF5LUFveLhCJ8LbpAYuQvM96LWwn/EnA8DB5j/5SLmv/C5J0oKr8UYFlM/VaO4FnkeowDtAGREon
    gXRKuECwIijtb4oNxbm2sxkGLLMP2VQCvhRmPHB7Ycuhe3co46tRZ2+GaL8fYmV0daHvk2QLMLIqwWEIgz6S73UmWHrDvYbJBcEsA1z5QPi/fxiCNtTI8k/J
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=d74QOTdPwgsZBVlGJQwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDCD1a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 23:27:30 -0400
Received: from mail-dm3nam03on0135.outbound.protection.outlook.com ([104.47.41.135]:22981
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752611AbeDCD13 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 23:27:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Florian Westphal <fw@strlen.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH AUTOSEL for 4.15 070/124] netfilter: core: only allow one
 nat hook per hook point
Thread-Topic: [PATCH AUTOSEL for 4.15 070/124] netfilter: core: only allow one
 nat hook per hook point
Thread-Index: AQHTv5myu58aptvIyEaP7WYFhKi186PXtpSAgBbBmYA=
Date: Tue, 3 Apr 2018 03:27:28 +0000
Message-ID: <20180403032726.GK7561@sasha-vm>
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
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:HvNcRGVAWdrWR8iWcJv55SHUWCtFgQalTP6V2WuizSzN4ozzXkvLepoHX8iuxnwTxUcSGREjWluEe53iE8c9OfcpByvzGaArwBVTwg8MJYvyLqzizoEJ+JhvKNCZl2oJK2937Fz9VQK6J2JLD57TjrBqMyaGKM9FmeQl7pS0B/Pa85Z3EADLEU2L+6aTblypRerJIjJcrKuoqxXVFD1In4MYisI+GZNYOOM3A1n1kpGhfRkYhCSoAyd4x7RbjSIV;20:JUQaFwsRfWfIpilZQbWoQW1r0JRAvpH7tHYGar0O+DQGiV/q19l/mL30QZZFgSETTUjAm0Q9RVyOAgrAoMhMhRqoKbCk94HB+4Z09NkaXuFzBq8qSuJ/daF/vI0FAm6vREA+mnSIPWGA0QIVf2nI+zILjFfdTCRREVsfohUgOiQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b8c7d3bf-09ff-4ba4-3e6f-08d59912d3b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10328ECBE5E97BDA70E13864FBA50@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(81166006)(8676002)(81156014)(3660700001)(2900100001)(97736004)(8936002)(6916009)(305945005)(105586002)(33656002)(5250100002)(7736002)(1076002)(3280700002)(2906002)(99286004)(54906003)(86612001)(6116002)(3846002)(186003)(558084003)(33716001)(68736007)(26005)(10090500001)(86362001)(76176011)(33896004)(102836004)(6506007)(25786009)(66066001)(478600001)(10290500003)(14454004)(106356001)(72206003)(316002)(5660300001)(9686003)(6512007)(6436002)(22452003)(53936002)(229853002)(4326008)(486005)(6246003)(6486002)(476003)(486005)(446003)(11346002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: av7wrW14o+VfEP2wgR3GvDVmOw+7vLQUfOfqe4f57Bu5x4kGVMQZaovrYWANpg/4tExJAjvcigwY317ziArvaYaM6C6UYd7Wcdc6hhq5L9A0qxMFTNs6W8ShqVSBfM0WPDZlTwC0xgebjfpFkJOAcJw+fqQG7MLCuoG6yrJP3t8VWuoE4oEkE6qwHe/vh6ZHaegC24TY7h5EVDIs7fYKIcDsPPrnj8Tw3HvV1pHdWxex9vk5QQZH3fAoVk9VbDhsZFWrdixGzWjzp/H6n1eZawdUVzy7XCjS/H/TUys12Kr577/mHDB7pOlMgZyfDaS/VltLjuZrUY0QlQkQoBEXjvhCrfCLcTkFfAcV7Ul3pIXFYyKyS/wLGSTFmMQup8oI+MMJXSbWN0rJYX97ofDKFLdAiY4IYTdf6gesMBSkS2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E5535CCC4E8B04F94A14871ACB0DF81@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c7d3bf-09ff-4ba4-3e6f-08d59912d3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 03:27:28.1721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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

Removed for now, thanks!=
