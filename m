Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6583EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2864E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QSnb3rsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2864E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLGREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:04:37 -0500
Received: from mail-eopbgr50107.outbound.protection.outlook.com ([40.107.5.107]:46138
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbeLGREh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQwPH/09OQSZKTdAcMnLHHG5Pp+af9JPDt0wVYIfSwg=;
 b=QSnb3rsBBzixLu9zgUklQWYXf6VL8G411fgJ6BEhgcAr4oWd+JPxvbeDRNPBb/jpVGjNx/pHFSzkyBPtCw99Dc9fq2d6RWsp2AFsPQ0P6sqyiSU3iF5M5Iv12wJaN+xFHHakAK4BsifEC3KZYXd0a/aGxeoUwGQI1KSbKcA02Fg=
Received: from AM0PR08MB3921.eurprd08.prod.outlook.com (20.178.118.138) by
 AM0PR08MB3009.eurprd08.prod.outlook.com (52.134.92.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 17:04:33 +0000
Received: from AM0PR08MB3921.eurprd08.prod.outlook.com
 ([fe80::ed3a:fb15:56a8:adae]) by AM0PR08MB3921.eurprd08.prod.outlook.com
 ([fe80::ed3a:fb15:56a8:adae%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 17:04:33 +0000
From:   Kirill Gorkunov <gorcunov@virtuozzo.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Remove useless check in pagecache_get_page()
Thread-Topic: [PATCH] mm: Remove useless check in pagecache_get_page()
Thread-Index: AQHUjkQD7VXcITErnkG6hNWEdHZ0HaVzgU0A
Date:   Fri, 7 Dec 2018 17:04:33 +0000
Message-ID: <20181207170430.GE11603@uranus.lan>
References: <154419752044.18559.2452963074922917720.stgit@localhost.localdomain>
In-Reply-To: <154419752044.18559.2452963074922917720.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [5.18.102.224]
user-agent: Mutt/1.10.1 (2018-07-13)
x-clientproxiedby: HE1PR05CA0306.eurprd05.prod.outlook.com
 (2603:10a6:7:93::37) To AM0PR08MB3921.eurprd08.prod.outlook.com
 (2603:10a6:208:129::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3009;20:0FpH42arXyNY0rQslJcseKbMkWtF9q1WHdgFRvyfGT4RVHC1fVH17xNcfDfqNHPU9VhrP0zBHdi17ZXHgy3vrjjC5XqwTYyAGhfnvw4f15blgyh46Se39+AHXAn4X/fAOlgUgm7mMu+raR7GreyB4hAmwy72duB95kgwIN4lNmk=
x-ms-office365-filtering-correlation-id: 62081622-3eef-4bc4-a9dc-08d65c660eee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3009;
x-ms-traffictypediagnostic: AM0PR08MB3009:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gorcunov@virtuozzo.com; 
x-microsoft-antispam-prvs: <AM0PR08MB300962556F88F672614BD4B9C2AA0@AM0PR08MB3009.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230011)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231466)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3009;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3009;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39850400004)(199004)(189003)(7736002)(386003)(6512007)(305945005)(9686003)(486006)(476003)(6506007)(71190400001)(71200400001)(256004)(5660300001)(106356001)(6436002)(68736007)(6486002)(33896004)(52116002)(6862004)(4326008)(6246003)(2906002)(26005)(53936002)(11346002)(446003)(76176011)(102836004)(186003)(8936002)(8676002)(81156014)(81166006)(14454004)(1076002)(25786009)(316002)(6116002)(54906003)(71446004)(66066001)(3846002)(6636002)(478600001)(36756003)(86362001)(105586002)(58126008)(99286004)(33656002)(97736004)(558084003)(229853002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3009;H:AM0PR08MB3921.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +Is5HEtD80sbYHagMHKdW2TphSWWVjACllhM3lWtTE15S4bTa69ZwRi0SKN9OHSxvN4gP65CQgZfutVhecrzHPdD/qAErKIcw8zY+CnvzVH6aF+Bbgg/i22PJfDq186ZAqV4VmlZ5kLMF25XaiZwmT8s0mFnwWg2VSloqK4xKZNkK9KLoCfhwef2xMtt2x4+TyPmh1YdS5Dx+nSd2oM9Plm7OjS5m/FJGt8NedjYNPAr5DZ6ZTbVOskpjYHknKMZfppAyRVFznhazr0q2WylsQzPNuvz82Bjr9dnb92P52X+nXPklbsLtqbXp44fgVWdn+X0dygmFc6KAaonNwACm8uNSW/CwOVU9IyRXDsqLmk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D62E4F1CFF946346BDC1B0E6304014A9@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62081622-3eef-4bc4-a9dc-08d65c660eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 17:04:33.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 06:46:24PM +0300, Kirill Tkhai wrote:
> page always is not NULL, so we may remove this useless check.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
