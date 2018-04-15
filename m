Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523803063-2-9719329368216470053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523803063; b=iBlqsaWzIANFwv/E1fxGTTPD0CfyqLxd5vC5W6DW7tjTXxTrwq
    Dpe8vAPkVR+mPV/TRnWAx0IwOc4RF3AeKXej7SeLiTFlmvsk/fY3KCSJPdHkTCHh
    plshGNkx6nqZnV/gFOFygM/vOS7kPUt2qSHLxASD6CfJpinltgJNfdjQr0eK+N0g
    SBJ483JqzdRGzFyGdndnBaYjjcJgFRl+bn7exOAqKx5tOkNQQ0lToXKqbhsc0Gl3
    SUq99VFbpzpwFyyAR/OP4aQthJ+lFLrVF78ORWdXR8bsuCgD3UTp9cxbqLiZsxBV
    EKOlRiJllnig3VfXBQWY2cAgq4fy9yTtMfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523803063; bh=Tr3LSW5i0RczfVZRCnVJA6G63/+exOEedM43bHNSyVE=; b=
    HIvMsyENAvtApD17sTRso5VJDgnY4fagdktlphA026vXWgRmVR/GJ1qapIJZM3Au
    Y4xIysSx3A1E8kPa8flCoSaZjD65shWReD7Z3H3CLubp5uXUbVHaGNnHhhL90hNe
    X9cL9Tunq43dLfAwHB4bBGt/fEZxVhcoxyvBwdvC2aNjD90gsAa59qCeSke4EVDY
    cmh9+w9rJpwQWoZ1vrqLKBwQhD5PQxihBQ474G8ypVL/81rpCDQEd2H0Vh+RUK18
    FkhEYl8VeImC9z0b/GPFCIuhpaK/nvVZYUPrtgMJQfxwpuc5gIN2w030mCCalXfZ
    feYEY2UHHVzSz48qyhYcAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GGWCPfme x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GGWCPfme x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPIT7aihGjuhCrUI8cof5m2B3LxV/dIvqh6+4GnLjkilFmlJiomqTJ39jQFr5ZDiSnSYBxOKTOLFBSPvbs2qnaBypsydvV6SUznmK+0SchB/zvRQrz9i
    h9j8UJpEhPyhw4v2ZufhplExyatX9xUUH9i8lW4efXwLOL/etOZpCmfRMIsfW+4/cjD/ckTUCgUvi6kXh++UmwCHzLWm7pMdYReVYy1fiNFpfBIv4pzRZs5t
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=lVYIoIq7iSfgBGw3t6wA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeDOOhl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 10:37:41 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:52096
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751622AbeDOOhk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 10:37:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "J. Bruce Fields" <bfields@redhat.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.15 168/189] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Topic: [PATCH AUTOSEL for 4.15 168/189] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Index: AQHTz5hccPWfIEumc0Gehf5m4O69GqP4j2+AgAlf+YA=
Date: Sun, 15 Apr 2018 14:37:39 +0000
Message-ID: <20180415143737.GN2341@sasha-vm>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-168-alexander.levin@microsoft.com>
 <20180409152746.GA25317@parsley.fieldses.org>
In-Reply-To: <20180409152746.GA25317@parsley.fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:9eaqwUJen1of+ksbbNF+EDsRHkBcn0IOBVCTa5ay5ioqyr6n/N9iZYDNCQwYFbbVvRVvFdA47wxX14TAvl0TJIBihFHsAEw7rJnOCutN4lPlh4hMNVxKDSKbojaJddVpDnxuPp3+9byWiRIkdlOw2lq4+jJxxhkoSIrmR4yKwB/rM8dQTqBoxjfbTJ4qkIY9tSxk7DzK8dqSlq1pn7epliZjfGveZw4y/bAVvg0HXyXktVeJ850SCV5MiBXVAOIT;20:Nf7AsUx8SdMGkVKO2sQvK0dp2XiuZNQTsLZ10IhuUjTMzjGWsadBRixYvXUNf+AMRhOI0SYt5hITjeWmM0EMjdnMxZQIy28mtYPGeqooj9eP/UYIB94yUg5cgeFPjPotuJbgY8LaVLU+Mta54sWIvnGXoOpjr8VMJTGaHokT2jk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047E9C13B6758B6E5915208FBB10@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(199004)(189003)(68736007)(5660300001)(97736004)(25786009)(26005)(2906002)(10090500001)(3846002)(86362001)(6116002)(478600001)(2900100001)(10290500003)(229853002)(14454004)(72206003)(6486002)(105586002)(66066001)(3660700001)(33656002)(3280700002)(8936002)(81166006)(81156014)(53936002)(1076002)(54906003)(9686003)(6512007)(8676002)(99286004)(76176011)(102836004)(59450400001)(86612001)(476003)(33896004)(11346002)(446003)(6506007)(6246003)(305945005)(33716001)(7736002)(4326008)(22452003)(486006)(6436002)(186003)(5250100002)(106356001)(316002)(6916009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FRSCHYJP2KFeioOit5+FfVGGksyZoyvpD5OdYusAGc3KFAtueX76BvD3NtYxkW0Ne/pLaqRUW2j9WL8+RQdSCugz6lMnoWChf1pY3iqXi2abj34h64rITpZzzG/B3BDpdP2IvJyf8xdOG782qF4QJyYkW4HsH1QY+BkuF9lWJ3l3+qEXN6lzBZmRLWKcpZhm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3822E5A2DEAA844B2F10062C18DA84F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e0e9889a-139e-4aad-71ce-08d5a2de7034
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e9889a-139e-4aad-71ce-08d5a2de7034
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:37:39.0547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 11:27:47AM -0400, J. Bruce Fields wrote:
>What's your default on these patches on these AUTOSEL patches if you
>don't get an ACK or NACK?  Do you apply them anyway?

Right now it's opt-out, so it'll get merged unless you NACK it.

In general, these patches get higher visibility as a notice will be sent
a few times for each of these, when:

1. I added it to my queue
2. When Greg sends his review cycle
3. Once a stable kernel is released

>(I'd skip this one as it doesn't meet the "It must fix a real bug that
>bothers people" criterion.  But I don't recall it *causing* any bugs
>either, so the stakes are low, I'm mainly just curious.)

I'll drop it, thanks!
