Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948EECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274C0208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f4sZ3kEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274C0208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeIOG5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:57:09 -0400
Received: from mail-by2nam03on0092.outbound.protection.outlook.com ([104.47.42.92]:52376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeIOG5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACCxMO5nccboY96dBfX0lUNQzdl3Vg6khEa8IMq2pNo=;
 b=f4sZ3kEQ9681n6slWdQTqvTYDD0vPq3fEI/7ydpr2IPq1OfY4fj3Mj9QtAeFc+HxFQFTK33uoU4yhgqhPSBpBtEQegPVm76PnZD2utg75RZYhsCqVTZ/wgvZdKVvONHtMYG6wnJX+AxPX7dSPeAlTqWyQriaZOaoqXIR+yLyrIw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Sat, 15 Sep 2018 01:40:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:40:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.18 51/92] tools/testing/nvdimm: Fix support for
 emulating controller temperature
Thread-Topic: [PATCH AUTOSEL 4.18 51/92] tools/testing/nvdimm: Fix support for
 emulating controller temperature
Thread-Index: AQHUTJOtWQsfJbJRN0uisMsAICSYr6Twj2aAgAABgIA=
Date:   Sat, 15 Sep 2018 01:40:06 +0000
Message-ID: <20180915014005.GI3821@sasha-vm>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
 <20180915012944.179481-50-alexander.levin@microsoft.com>
 <CAPcyv4jbHivBtLMD0uQ6TMMhObPQ_5287Lirus=RRD5O2GjB2w@mail.gmail.com>
In-Reply-To: <CAPcyv4jbHivBtLMD0uQ6TMMhObPQ_5287Lirus=RRD5O2GjB2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:CwrMDhkM8PzWRkhc0mNrMhBflPS+vuLzZ6chx2+Psx3TM9O17/l2BbRDPPP6jEPMIBKkDptSBhNR75KFq+4NiEWegZhpiqU7uqoHVAKjGU64nFzZjW/o0sJgP0MGITv3VCratohDWvHpbcC+BzGnQJZ4tUp09/vaP6ITBD6GCrZDqW3gWC3ZUd3G8bYi4thnk2CQmIxWUVrpnEb65LCc1xmCAY5ay4KTENgg2VeUWjJLZNzCOKeLchcOaCRZrfYsa8DI5Y/hHYoCYkH6gQecJ6NCWM37NJLx6j8sLGL8CLdF9J2gKDyTgI35VnaG1NyUBNbCxSZY/iuGdIsK/6saPO3qHFzbcB47jItiwpA5G/Tf4r7HTgWeqVIVuuGaHpxC9oXju6vX0ZxpGFc1bwgGfQN7QzuV9dvSfWhf/ATAVD2J7xP2ZT58p9bJKKqQ7vE8V5XvLSXqLo6eIfxOTwx4Mg==;5:7lX7DJjE4iWo60uivj+Mssj6enAv6ao/zXDzxVJE9E1yxvO1QpyzI3+/J9vn3T96aYiuoeXjGdJjmsJ3gFkWoF79vqdSyvZPT/52Lq3rZeg33VYmCJa54YrIeUJBnEqv9DPbntK31XVaeH3T2SMchRJxOzC6S6IxGM+Fqi0maao=;7:+x7Gws0zkjxBUMgUJMqJ+c9pJ8hVgYm5qmwN/U2pHMMfxen0lgVt7DrYz+06A7cqYSRUoIGGDZDxKxv6fUhRtDoW/gY2PDolfZSBx52tL8kEAOkstQQg5DYkryCqY+VzWllc7D8CXtoQtdsEN9UVrcJdMMEGwNDjjNi4Rpv1F6rdjL+sr8x++HfOjt4HvG/aNSctl7aGHNpPCAOumh3nTTg4BU6v8OCxmojNAZI9w7EXZ8/vNElLhvFHQqdViKbq
x-ms-office365-filtering-correlation-id: 853a73e8-de1c-4f59-97e5-08d61aac2a60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757FF50AA21AA3A0505F097FB180@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(6116002)(8936002)(22452003)(10090500001)(99286004)(54906003)(316002)(476003)(256004)(14444005)(3846002)(486006)(97736004)(186003)(229853002)(2900100001)(446003)(11346002)(81166006)(76176011)(5660300001)(217873002)(2906002)(33896004)(6916009)(81156014)(26005)(53936002)(6346003)(7736002)(478600001)(8676002)(6506007)(102836004)(6512007)(9686003)(105586002)(305945005)(66066001)(10290500003)(106356001)(575784001)(86362001)(6486002)(6436002)(5250100002)(25786009)(14454004)(4326008)(86612001)(6246003)(33656002)(1076002)(72206003)(68736007)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: I/NodvdIb01HQoIB1nEih8ZM3hIQCuXrteuiX+/lNhsgZ5ZpgF5+QabSuLY+4y+B//uBjUDWO2tevhWiiWXt+NSk5hmeunjeUy6I6p4AGPJjXRFj4JRFwQ5Q5rCjp//erPSisJR4vHFc4CHm8YQ0Pw7ZH+J9M5Tow9unEOazeXI+b5HsCDQVehCYl5QMCw+O4cheMjyYcIpZ6ggQOJ16+0SmviU+jLuCpqYjCZqxpPOQJpU25z49co8yuBMZyX1RKBfILaI6sYMIQ9DcCfr17rv8LERYbHJVXb8ts66iPjAJHD4d0BLF83de/EUWMSy+s808aD2gnOn+3hGZ8ywVwxCHDgD9zVOuwDT8M9wqXQA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17D49E1094AE184D8CC4075624ED790C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853a73e8-de1c-4f59-97e5-08d61aac2a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:40:06.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 06:34:43PM -0700, Dan Williams wrote:
>On Fri, Sep 14, 2018 at 6:30 PM, Sasha Levin
><Alexander.Levin@microsoft.com> wrote:
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> [ Upstream commit e5d772fbe7685aae0dff99f3b54158a0ec32155e ]
>>
>> In addition to populating the value the payload also needs to set the
>> "controller temperature valid" flag.
>>
>> Fixes: cdd77d3e1930 ("nfit, libnvdimm: deprecate the generic SMART ioctl=
")
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  tools/testing/nvdimm/test/nfit.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/tes=
t/nfit.c
>> index e2926f72a821..94c3bdf82ff7 100644
>> --- a/tools/testing/nvdimm/test/nfit.c
>> +++ b/tools/testing/nvdimm/test/nfit.c
>> @@ -1308,7 +1308,8 @@ static void smart_init(struct nfit_test *t)
>>                         | ND_INTEL_SMART_ALARM_VALID
>>                         | ND_INTEL_SMART_USED_VALID
>>                         | ND_INTEL_SMART_SHUTDOWN_VALID
>> -                       | ND_INTEL_SMART_MTEMP_VALID,
>> +                       | ND_INTEL_SMART_MTEMP_VALID
>> +                       | ND_INTEL_SMART_CTEMP_VALID,
>>                 .health =3D ND_INTEL_SMART_NON_CRITICAL_HEALTH,
>>                 .media_temperature =3D 23 * 16,
>>                 .ctrl_temperature =3D 25 * 16,
>
>Does no harm, but also does no benefit since this is just unit test
>infrastructure. You may want to blacklist this directory for stable
>checking in the future.

We backport selftests back to stable trees. People run selftests on
stable kernels as well, so it's both important to make sure that a
backport didn't brake anything, and to locate possible missing stable
patches.

It is also the case that backporting selftests can't "break" the kernel.
They are disconnected from the kernel's build process so we can be less
conservative about backporting them.


--
Thanks,
Sasha=
