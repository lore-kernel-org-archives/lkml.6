Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FAFC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8233720665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfAHV4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:56:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbfAHV4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:56:45 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08Li21O127626
        for <linux-kernel@vger.kernel.org>; Tue, 8 Jan 2019 16:56:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvyxjbt9q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 16:56:43 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 8 Jan 2019 21:56:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 21:56:37 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08LuaZp64094332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 21:56:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E29A3A405C;
        Tue,  8 Jan 2019 21:56:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C5D8A405B;
        Tue,  8 Jan 2019 21:56:36 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 21:56:35 +0000 (GMT)
Subject: Re: [GIT PULL] security: general updates for v4.21
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue, 08 Jan 2019 16:56:35 -0500
In-Reply-To: <alpine.LRH.2.21.1901080840080.2451@namei.org>
References: <alpine.LRH.2.21.1812250652420.2714@namei.org>
          <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
          <alpine.LRH.2.21.1812291406530.29722@namei.org>
          <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
          <alpine.LRH.2.21.1812291505480.31477@namei.org>
          <CAHk-=wh+6WrC_W7ZCjMDPaZm9SuuRjoTe8Buq123CfRvTyu0wA@mail.gmail.com>
          <45d180c5-a174-7eef-9e23-83b819f8abd6@schaufler-ca.com>
         <1546137859.4069.59.camel@linux.ibm.com>
         <alpine.LRH.2.21.1901080840080.2451@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010821-0016-0000-0000-000002422A2E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010821-0017-0000-0000-0000329C402E
Message-Id: <1546984595.19931.158.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=767 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 08:45 +1100, James Morris wrote:

> > Included in this open window are a number of LSM changes, which were
> > not posted on the LSM mailing list and are not being upstreamed via
> > the LSMs.
> 
> If you see changes doing this, please call them out. Any changes to LSM 
> need to be cc'd at least to the LSM mailing list.

Sure.  I'm referring to Al's match_token() and other changes, which I
only learned about when Linus reviewed Eric Bigger's patch "KEYS: fix
parsing invalid pkey info string".

169d68efb03b selinux: switch away from match_token()
c3300aaf95fb smack: get rid of match_token()

Mimi

