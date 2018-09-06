Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9742B204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ezh4RtCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9742B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeIFUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:06:26 -0400
Received: from mail-sn1nam01on0123.outbound.protection.outlook.com ([104.47.32.123]:54743
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730190AbeIFUGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBbA6+WxiNNcjvo6UovH+fFUhocdPXEcpJiDvW+cOb4=;
 b=Ezh4RtCp02bRTPGxZVWi7zBwZbzdX16DFI39rTfb0H/hy8JSYFlDuqdQ5gdvMsfl+cZ6qYb7kFGi7Pl6tqAO/TPXyn2SDfj7i2lEtywb8xPd05VsSvy0U+3wT6tL6EWX82OjgIPlK8u4/4jleajEtGJPt8rlnqig12eJnldTV30=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Thu, 6 Sep 2018 15:30:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Thu, 6 Sep 2018
 15:30:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/lib/lockdep: fixes for v4.19
Thread-Topic: [PATCH 0/3] tools/lib/lockdep: fixes for v4.19
Thread-Index: AQHUMzie9GcXaVXrLkSu7mr4FMUeBaTV8R0AgA2VfAA=
Date:   Thu, 6 Sep 2018 15:30:21 +0000
Message-ID: <20180906153020.GW16300@sasha-vm>
References: <20180813190527.16853-1-alexander.levin@microsoft.com>
 <20180829000356.GA161312@sasha-vm>
In-Reply-To: <20180829000356.GA161312@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:VxKym1dJYIxtbgXZcBZt2MGHkfvBxd0VLtXEtee9PU6EGJBL/REzgyknD+mrz2W27mj4ew+7mZ62OWebtzyfJPVtSH9N13iA7PG4Z6vDVcqWU8zZuVDsf+rfcAjnf08p9IastLF3OeLGMdzbggmsUTqeHA0keUe2+j5jJwE7N2xO6hzq55VsF5ZPEiVl9nK/3lx2iNw51UH8ht3Q0Jg/9vL+KkMurw340ZSJBYVoYBIjnGm8piDanm7j14VecSnL/OJmDCyJrBDMugLExeVUH5YH/b8y7NR7+//fb+wF/pAEqZMoMRorrnfx/2H+AS0uDt9tzJN2UKXuA7t0aLMDD1qThgwiFgIcSD5+xg8aB4o9ljqLbEYFyQitgMeZmvUQm4CKCSfTZk0Gf6Vq4ueh9BDI3pHfNfxB/GREHlKIBoyA2yuNSvMD1z6olDPwfcK1dZfOtYxx1n9f3p8nQeWISQ==;5:Fgg2EVPDBhALJuOx4W8vWlmbB+lT7mzCYmMLI8BSIyarpFWiPRZaKBrlRvjlJGolfogoY5P3oS5cMznhhiryS89gjVRSLtu61S6tHRszf2Oxqe3r/eI0K8yC//AtEBfc1LR0RVaoT5LTc60ZUO4mQ7YZOqUwcaCiNz2ao+nAM3E=;7:QFRcLkK7P3ZyH1lPYiXLDQ95TwVXt90iyclJEOUlyVuS2RQQ8JNrAw3TNBKDCxbA/2tmoRYsRqkKvsH1vbenAYPfYaX5Gq6g7mxJ7L+fD4lLVlpqC5ZZEHTaL/l9mmyykav2sS2BP1n55pr4DqGRsH9dLKZdOEwf1G9HwLpwN2M/rP4C9fOBh50ZBhqIMnNoHJaHmsAMWcRJXrBhYtNL/RNRdyQfZNYMhc4mb+bwzFuTC9ymkyrYzOxffcGOqchx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bedeb4d6-f740-485d-f85b-08d6140da8b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB01494130C54D48BA75933E2FFB010@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(346002)(136003)(366004)(39860400002)(199004)(189003)(26005)(6346003)(110136005)(86362001)(1076002)(3846002)(6116002)(229853002)(106356001)(105586002)(486006)(186003)(72206003)(4326008)(6246003)(6506007)(22452003)(316002)(25786009)(99286004)(76176011)(5660300001)(11346002)(476003)(86612001)(33896004)(446003)(14444005)(256004)(102836004)(14454004)(68736007)(10290500003)(66066001)(478600001)(8936002)(9686003)(33716001)(53936002)(6512007)(97736004)(81156014)(81166006)(33656002)(10090500001)(6486002)(2906002)(6436002)(2501003)(305945005)(7736002)(5250100002)(8676002)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: owCMtAaPGzXBuw8TZ11HD+wyJJswM5UOrpdNTwRM0tCZoKp1GzJuaasKAcyltECx4p0ojGry9q1/7PI9E83BiCnfJYFjoVU3ZzFrkgSA7Eq6OzO8kmHAPJzOnTHlBQ0rxJKMwZA8tb8DPCDBIchBf+DivBSMwMhPyZeNuJOs+6nf0qmdJpkLFQ9Zr5qbmSV/GFGvzUUQOL7eHVySRhVWCjWNXguxWNZF4VZobvXCye46jnJ5X9ySDIlnN66kimVlzY5HYW2VFnUkz+DKmUwnw8/L5pLHKlj06Fvks0I7YK2YqJLpqGzisExikrlSvSlnxZh6HtU03SZBknHtTEnBHScrMxRPUzrRf6pphjq+Xi4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A09588989B92124BA04CAB38B8803032@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedeb4d6-f740-485d-f85b-08d6140da8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 15:30:21.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Tue, Aug 28, 2018 at 08:03:56PM -0400, Sasha Levin wrote:
>Ping?
>
>On Mon, Aug 13, 2018 at 07:05:36PM +0000, Sasha Levin wrote:
>>Hi Ingo,
>>
>>Please pull the following minor fixes for liblockdep.
>>
>>Also available at:
>>
>>	git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git liblockde=
p-fixes
>>
>>Sasha Levin (3):
>> tools/lib/lockdep: update Sasha Levin email to MSFT
>> tools/lib/lockdep: add empty nmi.h
>> tools/lib/lockdep: add dummy task_struct state member
>>
>>MAINTAINERS                   | 2 +-
>>tools/include/linux/lockdep.h | 3 +++
>>tools/include/linux/nmi.h     | 0
>>3 files changed, 4 insertions(+), 1 deletion(-)
>>create mode 100644 tools/include/linux/nmi.h
>>
>>--=20
>>2.17.1=
