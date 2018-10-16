Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5300EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F149821476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="obSCZNMu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NoTEh7Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F149821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJQDbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:31:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbeJQDbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:31:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GJXCkL023566;
        Tue, 16 Oct 2018 12:39:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FobaqBqj0Re//yhBHBGCmoqtp7Pfv+9lctjZA2XHJvQ=;
 b=obSCZNMupdRgP+ARDK2eh0aBUwYUXUD1soDCrfrDl7K8/qgIYoHHwSjnxMtmC9JUN7rY
 DREf8/14coGuJGEQ4N4sVIsPZXNilxIGG2wx6bGrhAgO3hIH5U2EgcJlYocL8IzbNXqO
 tjp01Ke6T6CJA14xN52IKfhY7D0A8W1CnVQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n5nj4r527-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Oct 2018 12:39:43 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 16 Oct 2018 12:39:14 -0700
Received: from PRN-CHUB13.TheFacebook.com (2620:10d:c081:35::22) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 16 Oct 2018 12:39:14 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 16 Oct 2018 12:39:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FobaqBqj0Re//yhBHBGCmoqtp7Pfv+9lctjZA2XHJvQ=;
 b=NoTEh7WzbVsriSS4xIsfvAZMS7GlEP1vDZU+NYV0zVWjgKYF8PHcTMVHt9P4/E8BrvGP8NWuvqNK/LFW43Qp363W52KztC1A+ZYYtf2BTaMKDgZObkvPXb1j9oeho/8q/PchAqxH4vGtTrixMfmvB5LbwsaM8Bcg5ywQxFFH8Dc=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0710.namprd15.prod.outlook.com (10.164.170.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Tue, 16 Oct 2018 19:39:10 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba%5]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 19:39:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jay Kamat <jgkamat@fb.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 079/135] Add tests for memory.oom.group
Thread-Topic: [PATCH 4.18 079/135] Add tests for memory.oom.group
Thread-Index: AQHUZXQF1K58ZznRcUqGYX7TAm1c2qUiROOA
Date:   Tue, 16 Oct 2018 19:39:10 +0000
Message-ID: <20181016193903.GA25938@castle.DHCP.thefacebook.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170520.617155900@linuxfoundation.org>
In-Reply-To: <20181016170520.617155900@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0075.namprd22.prod.outlook.com
 (2603:10b6:301:5e::28) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:e448]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0710;20:5jJXVUWI2ERpMQ0ee80CEEo4rAZ4MwgxFLobrD9sYMx8DTS8DJJuWykh4roRgUJg55nFn0XQDg9Ub1ugMyXqPXUTgsJWZ1YwBm5J0s+PfH3ZTtn84Iz4yx+IK+n70UU5TgmH0BAlqcFifz5eIWAosBBcbY6f+JffGhxKvJf4pJc=
x-ms-office365-filtering-correlation-id: 7b069b11-1b87-4303-61a0-08d6339f0abc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0710;
x-ms-traffictypediagnostic: BY2PR15MB0710:
x-microsoft-antispam-prvs: <BY2PR15MB0710507D9AD8367F8C717978BEFE0@BY2PR15MB0710.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0710;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0710;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(136003)(366004)(396003)(199004)(189003)(102836004)(81166006)(81156014)(256004)(33656002)(6436002)(6916009)(68736007)(5660300001)(86362001)(8676002)(316002)(6486002)(14454004)(33896004)(76176011)(8936002)(6512007)(9686003)(486006)(2900100001)(386003)(476003)(6506007)(478600001)(52116002)(4326008)(99286004)(2906002)(446003)(11346002)(5250100002)(53936002)(97736004)(6116002)(6246003)(25786009)(229853002)(186003)(1076002)(106356001)(558084003)(105586002)(71200400001)(54906003)(71190400001)(7736002)(46003)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0710;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sDiMSMsmJZKfXRdD0ykR49VWxvg5+ITj62zNLZSV6M48f6JXcyX1yJhjSs8AdpYFh67JRSDjgsdrvAZ04MMoDjBUDQGcHmCxFf4jkAqy/h1B2J4VU/SjlCo6GdHo3kFo6rVCbEaENLi/VKchBOGj+5dWWCu49g6yvxz9p31P3PsKyLkGkywKqJTTkqGYGmNL+7xqKtawz6KdZvrgnEJU/bsdYUcEajpqjvh3+pj7AwvOp/RYMreZnCL0avuMenGPYNusbJDIGoC6ZAVzg5ifzx1jr7DFBwrtIwU/03TxnM+2uy28hr01FL+RRxJQ344d/W23x+IaatvEZAX3gMYXYCu9SBNVm6LuXkDiAp3RtB0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8101D88BC544148B720C4E119CC332F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b069b11-1b87-4303-61a0-08d6339f0abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 19:39:10.5410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:05:09PM +0200, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me kn=
ow.

Memory.oom.group has been merged into 4.19, so the test will fail on 4.18.
I see no reasons to backport this patch, let's drop it.

Thanks!
