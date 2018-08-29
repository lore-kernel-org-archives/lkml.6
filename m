Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8286C20891
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ep3qrvdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8286C20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeH2D6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:58:06 -0400
Received: from mail-by2nam03on0109.outbound.protection.outlook.com ([104.47.42.109]:6912
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727342AbeH2D6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlvYhuCIwUndtIFBXI7daT496kVxFsv9ooEgFtYXk34=;
 b=ep3qrvdIxs/bFduVTkff27qTLHItAaqjrWWyV6N9LWYmbqELhlVHZnjFCeES91AYlQT7pUi/eIAY8tFoOX52IhiLa/5LVghJszpHETr66wfGSNASW99Lll3bmqYPak8tzWTPN7wbP8YCiq3JHANxwhphGvF/nSWCTysNWQgXeO8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Wed, 29 Aug 2018 00:03:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1122.000; Wed, 29 Aug 2018
 00:03:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/lib/lockdep: fixes for v4.19
Thread-Topic: [PATCH 0/3] tools/lib/lockdep: fixes for v4.19
Thread-Index: AQHUMzie9GcXaVXrLkSu7mr4FMUeBaTV8R0A
Date:   Wed, 29 Aug 2018 00:03:59 +0000
Message-ID: <20180829000356.GA161312@sasha-vm>
References: <20180813190527.16853-1-alexander.levin@microsoft.com>
In-Reply-To: <20180813190527.16853-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:EtgB4TnTHyL+tU6tL+vjCwhj08J0W3Ofrp8zPyw3q7RkPZNzULcndWG2KKe6Y8ENObfdEv9HppMnOc6937bXDqxuW+vI+p+3G+or80sVhLb2kPIIWTj90dirkOca8kKGte2whPBmY/eW+tHjNxtA4W5bBdIvT6iO1CkMyDzz6KEH7LUBUYWYMH8otnQxuPKGa17FRMdvXXYuuPlIt0iNZgrFAMviFVCeO6mxAnWgEBt1aEcpkx+I4GPN/sbBs4yFNuFDRkg8FW7Lx+5FS+vSFs7AhnxZZEIzzQ3KggiNmACjIV6Dy4C7jAlSRuuHy9KAJVIDw72UijjwD5rS4YnQwwNEE4iztONfgN+AZMrdCSZ2bLPiJOx2VeR77R2qSkIHrB6F7SVM1JvMndZtaWUTdaKfKQGlR4dRdWKoNgt1XGDV9DCTTNhQ2ODGkATiCgQm5fl4ipNnXYyQzB08fmepCQ==;5:IGnGprRnn9ijgS7lcmZnUz1gzYk84bDQ9L7Gq/EduWopWOy9ct4ng03QvG8ARwbZmCFTc4deFt0Q/+pfP6UT01qxwvaHc6pQQ2LxvT0fe7OvbuBF5qABSZeE5BJcHXH/hPW6OYEA3LYNFjz3Gj3IFv6ApQKmh4WzIpdrf6UTxek=;7:IpyTRz3XjdJBHrBDlo3qAxT5W4WBrYZ5mgStpCyisbEaxhnDS1Nq5KDYCGYhbv6S4GeJIxaeN2/SqjoVsTBTcu7wBzeeatPyxYqDvlmQcpTlz/J0CP/QkIgLldHxq35QPF01uK1m78krJXate1GeBTLtDdr2Ion8b2pY6bwVQf8O0iJD+VeqYrDsO18iqyRhQ8G1uk1HdXGiH8QPJw16sdgJwxX6vq1XFf6UrrpuUJMSt/vC8940ni1Uq1vLERTE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7e9d73a0-3dc7-4f3f-0858-08d60d42ebe3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277C057B0B552DB22DD7234FB090@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(3846002)(6116002)(486006)(106356001)(10290500003)(86362001)(5250100002)(97736004)(105586002)(87496004)(2501003)(72206003)(478600001)(2900100001)(229853002)(33656002)(5660300001)(476003)(6506007)(102836004)(11346002)(86612001)(10090500001)(6346003)(26005)(53936002)(1076002)(68736007)(186003)(446003)(6486002)(33716001)(66066001)(76176011)(2906002)(8676002)(22452003)(305945005)(14444005)(6436002)(256004)(81156014)(6246003)(81166006)(14454004)(8936002)(9686003)(6512007)(25786009)(33896004)(4326008)(99286004)(110136005)(316002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hDYjJXZMnk77WXf2DXUGvm/YkRBFj7f7BgYhIffAeqFPOHETwrEaBuwrJxXrgqLoe55euNEo2lCSzRehd5m2c8gQJZOxMAtwAEx4d8ZMJlW0a67xywbiLXI85LBfpcURXNUlKUhDNq8nwKkwv4Jyza6tC3BMePirzKButNF/11N5PQx/3ETPdKR61ELvwiVleG/75kL/4WD/maQmNqIljtEZG0QCgARZ9sk2Wh3V1J/5Ugl8Y0lv1UOl89/OQFMg0uTxUaUjoBRsYrqkHAifZ8GOvB9QPdhpb0k+5x2SFjoeIBoHirwgsiyaJg9dvUyKHH4RDvQ/X7sdZIne280/k3PzW8Af4ucR2QYbxVJccXc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B16DF97D30668345A4E3196266E1CE27@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9d73a0-3dc7-4f3f-0858-08d60d42ebe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 00:03:59.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Mon, Aug 13, 2018 at 07:05:36PM +0000, Sasha Levin wrote:
>Hi Ingo,
>
>Please pull the following minor fixes for liblockdep.
>
>Also available at:
>
>	git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git liblockdep=
-fixes
>
>Sasha Levin (3):
>  tools/lib/lockdep: update Sasha Levin email to MSFT
>  tools/lib/lockdep: add empty nmi.h
>  tools/lib/lockdep: add dummy task_struct state member
>
> MAINTAINERS                   | 2 +-
> tools/include/linux/lockdep.h | 3 +++
> tools/include/linux/nmi.h     | 0
> 3 files changed, 4 insertions(+), 1 deletion(-)
> create mode 100644 tools/include/linux/nmi.h
>
>--=20
>2.17.1=
