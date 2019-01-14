Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BFC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BB220660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w7/OPUXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfANJZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:25:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:25:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0E9OLiV102436;
        Mon, 14 Jan 2019 09:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=PawYpizz0/DfJUnNnFd8yW+6KJqQFIbIu2k7H48az90=;
 b=w7/OPUXY1ibyStKNWDqOPZD700MflDVpfNcZk4sLWlSsffMBXilxCq2c4+Ygx1eVMGoO
 5GNbxzeteDHgw4inPffyFnWk2IetZwal/6MRFh47tHhuxitmuA05Y41m2/9ua31s9eK/
 cWn2jj4wrxVZOE2Q5tQOSbNZoxUTj9ESwwZA2E8ZYTQ63eCoyTAyIQj26N4na6XKRa9I
 fMR4yi7K/rlVLkm1CF9XvP7zOflZlFzo6TVgaLPYfxE/1XCk1tjbPzWYPMIFOyBkBkY6
 vsspUkq1MyPk2WuwyUxYklB+Q2uwHzJRfGcQr1/wIr6MwpCBCetciDemh0zie61gCfC2 Xw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pybkc4a36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 09:25:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0E9PgPV009777
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jan 2019 09:25:42 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0E9Pf2l026452;
        Mon, 14 Jan 2019 09:25:41 GMT
MIME-Version: 1.0
Message-ID: <fa40ea62-5df8-4e18-af57-9ccd5c578e97@default>
Date:   Mon, 14 Jan 2019 01:25:41 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <longman@redhat.com>
Cc:     <srinivas.eeda@oracle.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>
Subject: Re: Question about qspinlock nest
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9135 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901140079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- longman@redhat.com wrote:

> On 01/11/2019 12:06 AM, Zhenzhong Duan wrote:
> >
> >
> > On 2019/1/10 22:43, Waiman Long wrote:
> >> On 01/10/2019 03:02 AM, Zhenzhong Duan wrote:
> >>> Hi Maintainer,
> >>>
> >>>
> >>> There is a question confused me for days. Appreciate an answer.
> >>>
> >>> In below code, the comment says we never have more than 4 nested
> >>> contexts.
> >>>
> >>> What happen if debug and mce exceptions nest with the four, or we
> >>> ensure it never happen?
> >>>
> >>>
> >>> /*
> >>> =C2=A0* Per-CPU queue node structures; we can never have more than 4
> nested
> >>> =C2=A0* contexts: task, softirq, hardirq, nmi.
> >>> =C2=A0*
> >>> =C2=A0* Exactly fits one 64-byte cacheline on a 64-bit architecture.
> >>> =C2=A0*
> >>> =C2=A0* PV doubles the storage and uses the second cacheline for PV
> state.
> >>> =C2=A0*/
> >>> static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
> >>>
> >> Yes, both debug and mce exceptions are some kind of NMIs. So
> >> theoretically, it is possible to have more than four. Are you aware
> of
> >> any debug and MCE exception handlers that need to take a spinlock
> for
> >> synchronization?
> > Not for debug exception, for MCE exception handler I found below
> two:
> >
> > do_machine_check->mce_report_event->schedule_work
> > do_machine_check->force_sig->force_sig_info
> >
> > schedule_work() and force_sig_info() take spinlocks.
> > --=20
> > Thanks
> > Zhenzhong
>=20
> The comment for do_machine_scheck() has already state that:
>=20
> =C2=A0* This is executed in NMI context not subject to normal locking
> rules. This
> =C2=A0* implies that most kernel services cannot be safely used. Don't
> even
> =C2=A0* think about putting a printk in there!
>=20
> So even if it doesn't exceed the MAX_NODES limit, it could hit
> deadlock
> and other kind of locking hazards. So supporting MCE is not a reason
> strong enough to extend MAX_NODES.

Agree.

>=20
> In hindsight, we should have added a "BUG_ON(idx >=3D MAX_NODES);"
> check
> to avoid silent corruption because of that issue.

Looks a good idea if it's hard to avoid using spinlock in MCE handler.

Thanks
Zhenzhong
