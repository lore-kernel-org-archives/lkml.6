Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZqXHzPnYa8PBSRGvvUa78d4NQjRofJbv8ORnjqn8+MxVrmZ6ycvDg4FGN2g0DJGPIrqTcOx
ARC-Seal: i=1; a=rsa-sha256; t=1525111113; cv=none;
        d=google.com; s=arc-20160816;
        b=Ghsec1uHsXPW0LN7BiTx+2bm05G7YwdJBSMjQAd4UwRP9Ia+2dgCJdvO9iSFLYA80u
         XOkGKkixJOUiM5h9xU7c2Zjg0ZIszftb/aYL/aEIvhD+IR60NtkTvpzGcpiOjyqCmyNC
         lEdFqgvPxjdzjgE/XF1oxX7sc9OuMrsPxk5hnk65Vny30TN2SitC7b/55n9e0+BsnvZ1
         5vXUmtdE0tra2KU9lQMnJ4OTv4YSsFAPM2goG8dnDJPbKFQvl3AdQvJu5j2znBR7pS8I
         tC0iIO99WMs6l4fE+dkXTdZ4MTuUeNvBoeXi8YkREqL+qeKoKsieKLC8WEVVrA/a6aTr
         jGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:dkim-signature:arc-authentication-results;
        bh=4o2sb1vOAODkImDM5U5fqFkvqHxFw5auSSx3ld4nJvs=;
        b=lEePz5L/5PzONRJ6G89l3Hd5nMOdpQzR23paDhByCfdEcdwR41lWqVLWnWyVZDmxRl
         FQK6WfLi7whzhRGm4GZZr3u5YGjIcI3phIR6DPwSNI2sKONi8eXr9FaAV/uULo0VIjYz
         a+kPdBpCEOvw6Krhkua2NdOjlLg/0kC5gf8AWtwQ6gr+ECayUihTcxIDLl2KMc422zOV
         JirFJVfcMTu6QIjpn7dRcXaPx8/1h58TKMgqiR0eFOoSPf6SqK01Zbe+517Dy7l6FOhb
         +hw5KFQKXX2ug3FDMOi87YoenT9+3wsCgsE5IC/VFeLETFwvZydA8tcVOq0HTsDvbaDM
         W+xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Tu5lKXpa;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.101 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Tu5lKXpa;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.101 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>, "julia.lawall@lip6.fr"
	<julia.lawall@lip6.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: bug-introducing patches (or: -rc cycles suck)
Thread-Topic: bug-introducing patches (or: -rc cycles suck)
Thread-Index: AQHT4KzY5hZ/zYBxbECTHPKrktWH/g==
Date: Mon, 30 Apr 2018 17:58:30 +0000
Message-ID: <20180430175829.GB1544@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:quHnRgzD9GubLvNSZe7BIBgL5Ua1oS2qNWvAD6YWMDBPM9Iejt9B6D02U4qiuTKtPscOLLu1hJnvW0XsaLRLixAkTeuPXUnxluhO8QVxFAXvnI1RoGbiKYzMf9n3R3MBJeU2mdevCGDPTfdARLoOc4VHJTXLTJtojmGcStvNDbF4lEa8JCqgFxwzs02UBujTiqllUhErOlS5atS2QMweabtOFHupfMbMmZUncNHg2ekFjAH2vfFCeRyxaGNPiAOc;20:sD7opKRa7gWNLFaNnIchI1JtBrHavuMXONwNHzDg90q8FVrszJvpdLcbVOMHASWT7uQhZBRvCW9C+qOVn2JoXjP9eZAt5eUkvEaA+gZK2DysXzp4BJi48ZT2fk2rJyDwMGx2McESNdDWqNQqEWRzcNrKu8bTRZAdVzoVVzY2sW0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
x-microsoft-antispam-prvs: <DM5PR2101MB09847CA41D439B066F1D55AAFB820@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(199004)(189003)(10090500001)(33656002)(53936002)(6346003)(26005)(186003)(486006)(3280700002)(6436002)(106356001)(110136005)(25786009)(4326008)(476003)(3660700001)(2906002)(86612001)(97736004)(105586002)(102836004)(86362001)(33896004)(2900100001)(561944003)(5660300001)(6506007)(99286004)(1076002)(33716001)(6512007)(6486002)(6116002)(3846002)(8936002)(10290500003)(81156014)(316002)(66066001)(14454004)(9686003)(5250100002)(478600001)(8676002)(7736002)(72206003)(22452003)(2501003)(68736007)(305945005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Su4O1KPPAXVprk2edDuDEzjK1EjYwzaA985p8hlcXKugHieDmPmcHazAo9O8Jn5FEUyeM7etJWL/N364S+R61dzCdI9fIdUNCoCy9zHnYwp3C2B3s/tmlBclkSLr5YQolaeumyVRet3Wa59rGs0LniZ+2hzar3ZzaQ7kBsN7AVjSGn3NfbA//omoYoA8k2J5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCC89C330ED1A945955D5303C6764F20@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4d7eb0b3-7194-42a4-0bdd-08d5aec3fbdf
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7eb0b3-7194-42a4-0bdd-08d5aec3fbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 17:58:30.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599194910340136485?=
X-GMAIL-MSGID: =?utf-8?q?1599194910340136485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Working on AUTOSEL, it became even more obvious to me how difficult it is f=
or a patch to get a proper review. Maintainers found it difficult to keep u=
p with the upstream work for their subsystem, and reviewing additional -sta=
ble patches put even more load on them which some suggested would be more t=
han what they can handle.

While AUTOSEL tries to understand if a patch fixes a bug, this was a bit la=
te: the bug was already introduced, folks already have to deal with it, and=
 the kernel is broken. I was wondering if I can do a similar process to AUT=
OSEL, but teach the AI about bug-introducing patches.

When someone fixes a bug, he would describe the patch differently than he w=
ould if he was writing a new feature. This lets AUTOSEL build on different =
commit message constructs, among various inputs, to recognize bug fixes. Ho=
wever, people are unaware that they introduce a bug, so the commit message =
for bug introducing patches is essentially the same as for commits that don=
't introduce a bug. This meant that I had to try and source data out of dif=
ferent sources.

Few of the parameters I ended up using are:
 - -next data (days spent in -next, changes in the patch between -next tree=
s, ...)
 - Mailing list data (was this patch ever sent to a ML? How long before it =
was merged? How many replies did it get? ...)
 - Author/commiter/maintainer chain data. Just like sports, some folks are =
more likely to produce better results than others. This goes beyond just "s=
kill", but also looks at things such as whether the author patches a subsys=
tem he's "familiar with" (=3D=3D subsystem where most of his patches usuall=
y go), or is he modifying a subsystem he never sent a patch for.
 - Patch complexity metrics - various code metrics to indicate how "complex=
" a patch is. Think 100 lines of whitespace fixes vs 100 lines that signifi=
cantly changes a subsystem.
 - Kernel process correctness - I tried using "violations" of the kernel pr=
ocess (patch formatting, correctness of the mailing to lkml, etc) as an ind=
icator of how familiar the author is with the kernel, with the presumption =
that folks who are newer to kernel development are more likely to introduce=
 bugs

Running an initial iteration on a set of commits made two things very obvio=
us to me:

1. -rc releases suck. seriously suck. The quality of commits that went in -=
rc cycles was much worse that merge window commit:
 - All commits had the same chance of introducing a bug whether they came i=
n a merge window or an -rc cycle. This means that -rc commits mostly end up=
 replacing obvious bugs with less obvious ones.
 - While the average merge window commit changes, on average, 3x more lines=
 than an -rc commit, the chances of a bug introduced per patch is the same,=
 which means that bugs-per-line metric of code is much higher with -rc patc=
hes.
 - A merge window commit spent 50% more days, on average, in -next than a -=
rc commit.
 - The number of -rc commits that never saw any mailing list or has never b=
een replied to on a mailing list was **way** higher than merge window commi=
ts.
 - For some reason, the odds of a -rc commit to be targetted for -stable is=
 over 20%, while for merge window commits it's about 3%. I can't quite expl=
ain why that happens, but this would suggest that -rc commits end up hurtin=
g -stable pretty badly.

2. Maintainers need to stop writing patches, commiting them, and pushing th=
em in without reviews.
In -rc cycles there is quite a large number of commits that were either wri=
tten by maintainers, commited, and merged upstream the same day. These patc=
hes are very likely to introduce a new bug.


I don't really have a proposal beyond "tighten up -rc cycles", but I think =
it's a discussion worth having. We have enough data to show what parts of k=
ernel development work, and what parts are just hurting us.=
