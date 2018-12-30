Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D791DC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 02:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB19B2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 02:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbeL3Cok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 21:44:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbeL3Cok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 21:44:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBU2i6Vl013863
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 21:44:38 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pp5t8fc6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 21:44:38 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 30 Dec 2018 02:44:36 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 30 Dec 2018 02:44:33 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBU2iWxL52297974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Dec 2018 02:44:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44EA852051;
        Sun, 30 Dec 2018 02:44:32 +0000 (GMT)
Received: from unknown4C3488A63DDA (unknown [9.80.105.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5E8A45204E;
        Sun, 30 Dec 2018 02:44:30 +0000 (GMT)
Subject: Re: [GIT PULL] security: general updates for v4.21
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 29 Dec 2018 21:44:19 -0500
In-Reply-To: <45d180c5-a174-7eef-9e23-83b819f8abd6@schaufler-ca.com>
References: <alpine.LRH.2.21.1812250652420.2714@namei.org>
         <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
         <alpine.LRH.2.21.1812291406530.29722@namei.org>
         <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
         <alpine.LRH.2.21.1812291505480.31477@namei.org>
         <CAHk-=wh+6WrC_W7ZCjMDPaZm9SuuRjoTe8Buq123CfRvTyu0wA@mail.gmail.com>
         <45d180c5-a174-7eef-9e23-83b819f8abd6@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18123002-4275-0000-0000-000002F6EA29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123002-4276-0000-0000-000038050EAE
Message-Id: <1546137859.4069.59.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812300024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-29 at 10:34 -0800, Casey Schaufler wrote:
> On 12/28/2018 8:15 PM, Linus Torvalds wrote:
> > On Fri, Dec 28, 2018 at 8:09 PM James Morris <jmorris@namei.org> wrote:
> >> Yep, I understand what you mean. I can't find the discussion from several
> >> years ago, but developers asked to be able to work with more current
> >> kernels, and I recall you saying that if you want to do this, merge to a
> >> specific -rc tag at least.
> > If people really want it, maybe the merge can state that explicit
> > thing, as it is I'm trying to push back on empty merges that don't
> > explain why they even exist.
> >
> >                   Linus
> 
> The security tree tends to get changed from multiple directions,
> most of which aren't based out of the security sub-system. The mount
> rework from David is an excellent example. It gets hit just about
> any time there's a significant VFS or networking change. Keeping
> it current has helped find issues much earlier in the process.

Agreed, the security subsystem is different than other subsystems.  In
addition to VFS changes, are key changes.  Changes in other subsystems
do affect the LSMs/integrity.

Included in this open window are a number of LSM changes, which were
not posted on the LSM mailing list and are not being upstreamed via
the LSMs.

Mimi

