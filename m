Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0719CC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC383206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VE/XxHYy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dt7sULZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC383206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeKUDPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:15:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59700 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbeKUDPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:15:40 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAKGi8Lq018687;
        Tue, 20 Nov 2018 08:45:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ofVL+ggquv88hnR3uyRp1SYaszN31SFysNi2uYqIwVA=;
 b=VE/XxHYyonmm0hByt8o/fSkfRaa1cM8Jqb92Rds/+FJnfmPIHEhQVMGM/jBfhMHJmK/O
 BVd4YvppRl9ksYRfHCMITfup37DRpK6OQUTicePJ4ch88TbJ0ZjrFWd2JQ8onwqUkbsB
 U4tC0wuckpzm+w5no2BnWCdy0zfzC3/qnIg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nvmyb8ay1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Nov 2018 08:45:31 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 20 Nov 2018 08:43:56 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 20 Nov 2018 08:43:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofVL+ggquv88hnR3uyRp1SYaszN31SFysNi2uYqIwVA=;
 b=dt7sULZfEnlppAKSWl6Wd5TH1yNycNSWopbdmN81z9L+PV9QePm/QonSIc3wJTQAYUfv9rHyHu0KHiEtmHVYYyBd6S8KckD7LnJZydwaV2xzhFUDUdX9nx4y8+YzDpnxuxV7pdN2TEhnitKEGshVyj+3Jzu8Kk+LyvhgWo2Q+f0=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0149.namprd15.prod.outlook.com (10.163.64.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 16:43:53 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6%3]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 16:43:53 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v3 4/7] cgroup: cgroup v2 freezer
Thread-Index: AQHUfg31+N8cXqD8i0C7qWHjcgNkRKVY3zGA//98A4CAAIbyAIAAAiqA
Date:   Tue, 20 Nov 2018 16:43:52 +0000
Message-ID: <20181120164349.GB21462@tower.DHCP.thefacebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-5-guro@fb.com>
 <20181120162529.GU2509588@devbig004.ftw2.facebook.com>
 <20181120163304.GA21462@tower.DHCP.thefacebook.com>
 <20181120163604.GX2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181120163604.GX2509588@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0063.namprd21.prod.outlook.com
 (2603:10b6:300:db::25) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:6c9c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0149;20:dfcJwyz+nfZ0xWC4fjOy14S2KXrDDTwh7dZQj9DR0hMHpRZWS82od1UyzRHMklKogvpZfjEDR1Jx8fAjL7zeT1uQwKC+TL/dbaj0xqy92mXcC8AFjpSZuYjGu2rWSMhFX1oHkVmbhDo5i31zhOBE0e27wv/mB7BE3yUwAsv7id0=
x-ms-office365-filtering-correlation-id: b157a93c-fc35-459b-96d2-08d64f075ac9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0149;
x-ms-traffictypediagnostic: BY2PR15MB0149:
x-microsoft-antispam-prvs: <BY2PR15MB01498BE9BADD04B98BAA3DC1BED90@BY2PR15MB0149.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231442)(11241501184)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0149;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0149;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(25786009)(6486002)(229853002)(386003)(99286004)(186003)(6506007)(33896004)(76176011)(52116002)(14444005)(256004)(102836004)(2906002)(1076002)(6116002)(8676002)(6916009)(71200400001)(105586002)(71190400001)(14454004)(106356001)(8936002)(6436002)(476003)(11346002)(478600001)(5660300001)(486006)(7736002)(33656002)(54906003)(81166006)(9686003)(81156014)(97736004)(68736007)(2900100001)(93886005)(305945005)(6512007)(86362001)(53936002)(39060400002)(4326008)(316002)(46003)(6246003)(446003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0149;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XMKDqAUabn2K6nbg4tfryCfP+d5rS9VdAS0fJOB6G5H4mTwHL0dfgEKEwU/fzDCgbMMdDNCS91SbdCPm2tdufIbK4WfNPnSVuzAizorFmxxFG21mVLfrjV++sXfUfxbblQ5E4OlgtX05lLBHcQxru7AA6myxdzbeJuef2rfHWQ8I+y2W+nVJpAkrNjmncZhU9C+NHdI76eJuMoKW2Aoik2AgADhjgWi99pXELfUysxYbQjIMcAspM4/52WpIV4KFZMJt9Xfnyv8oeo7qdkIw5YnbZaRlpxYic82ptnY1uSdyH8JcP30Om6/N1scC0E47hIW6bk5/jWda0fhsmzxgyFA/A55dLErU6H5IFzQOfkk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BDF97299AA57540AA815ECADEB34026@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b157a93c-fc35-459b-96d2-08d64f075ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 16:43:53.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0149
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:36:04AM -0800, Tejun Heo wrote:
> On Tue, Nov 20, 2018 at 04:33:11PM +0000, Roman Gushchin wrote:
> > > If a non-frozen task is being moved into a frozen cgroup, shouldn't
> > > that also trigger frozen state update?
> >=20
> > It does! Just below these lines:
> >=20
> > 	/*
> > 	 * If the task isn't in the desired state, force it to it.
> > 	 */
> > 	if (task->frozen !=3D test_bit(CGRP_FREEZE, &dst->flags))
> > 		cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));
>=20
> But that wouldn't udpate the cgroup's frozen state and generate
> notifications, right?

Why? The task will be eventually trapped into cgroup_enter_frozen(),
and from there cgroup_update_frozen() will be called.

You are right, that notification will not be issued, because the cgroup
is not changing its state (frozen->frozen). I'm not sure that it makes
sense to change the cgroup state back and forth in this case. Are there
any reasons I'm missing?

Thanks!
