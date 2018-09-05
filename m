Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19436C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFAD2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="CG1SI9KO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFAD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIEXdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:33:51 -0400
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:24374
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbeIEXdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjcHE7SEwczbXORBel7RCoenvUxfTGphcDBdz1Qe+3g=;
 b=CG1SI9KOwtsAtwnUNUlLr7ZgrAL7MRy/0G9DHXHy0CiTHT9SPTFa5EmtU8IqBgRctpA2aYMoYUawuLlKFoBwyxfADYXqcZi+C/NVz8NadvAcz87kpRJT/RGx04pGp00zDAnmfqKB1ZHmaUXrCktCp4KK9mK6ndurwCwEFC4gSl8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4648.namprd05.prod.outlook.com (52.135.233.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 5 Sep 2018 19:02:16 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 19:02:16 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Topic: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Index: AQHUQuMbzkVQDn+XA0OpXaFEC8rBZ6TiDnqAgAABqIA=
Date:   Wed, 5 Sep 2018 19:02:16 +0000
Message-ID: <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180905185617.GC24082@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4648;20:rrV2CC+DHk9NT8AwRdminoO7dyXIUEXptuGMYA7gwuZifnA8YX0Q90wZmapKmXOUEhCR+LJCONqloSeW7enw3HZpYjVYF3jmOB600CcKkx8xkO9IRgTrrndKHxzjNJNalfjzpU3E1R6M1YgZ0JdANUNNywMJTxCvCC+5sVum/E0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 48db186c-edaf-435b-1d35-08d6136218bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4648;
x-ms-traffictypediagnostic: BYAPR05MB4648:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4648C08401C11718BE088C74D0020@BYAPR05MB4648.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231344)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:BYAPR05MB4648;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4648;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(6486002)(229853002)(8676002)(8936002)(106356001)(5660300001)(6246003)(105586002)(5250100002)(6506007)(305945005)(36756003)(6436002)(66066001)(68736007)(26005)(81156014)(81166006)(478600001)(86362001)(7736002)(14454004)(186003)(25786009)(14444005)(256004)(3846002)(82746002)(6346003)(53936002)(6512007)(33656002)(83716003)(2900100001)(97736004)(476003)(446003)(2616005)(11346002)(4326008)(7416002)(99286004)(102836004)(6116002)(6916009)(54906003)(316002)(2906002)(76176011)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4648;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: wue26As6aCUAMWUvyICsv5tcmFDYBsPf0+9pISBzVE6uItde1+/O/YVkgbcf1+TKEyBu3KnlLnWwiIjcG4QhvY14mTDjj8/70izeCdsSW9Ev7IS4gBFdLqD8CGAxagSEIA3LJB4VZu86MIJnJ9VdMHebQfHMvyzB7gvrhYbIAroSAKE8AU6hMqo4zisKrHiyyZgSlqGDu5YKV7evD+54wUfH18+Er8MWbCO1+qB13vn4zaJU7SjYkSsZZVYHUYV9WGWAH3TUxRlHuNzBU9tnVJCJ60vm4hueNG7XW4r06frk4KdHcWTJwgsiPWeutJbEDkrKqD06cW4mIPpZhLKDT5GZwv3lZShzsCytPMe2c/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A01DA3454B22E46A164B6C7B51ED283@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48db186c-edaf-435b-1d35-08d6136218bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 19:02:16.0267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
>> This patch-set addresses some issues that were raised in a recent
>> correspondence and might affect the security and the correctness of code
>> patching. (Note that patching performance is not addressed by this
>> patch-set).
>>=20
>> The main issue that the patches deal with is the fact that the fixmap
>> PTEs that are used for patching are available for access from other
>> cores and might be exploited. They are not even flushed from the TLB in
>> remote cores, so the risk is even higher. Address this issue by
>> introducing a temporary mm that is only used during patching.
>> Unfortunately, due to init ordering, fixmap is still used during
>> boot-time patching. Future patches can eliminate the need for it.
>=20
> Remind me; why are we doing it like this instead of fixing fixmap?
> Because while this fixes the text_poke crud, it does leave fixmap
> broken.

Do you have other fixmap mappings in mind that are modified after boot?

