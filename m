Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1EE54C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F3A20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F3A20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934375AbeFLVgM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:36:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933518AbeFLVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:36:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CLToWT074847
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 17:36:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jjjbj0t45-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 17:36:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 12 Jun 2018 22:36:08 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 22:36:04 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5CLa3Wj23724276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 21:36:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2CA5AE045;
        Tue, 12 Jun 2018 22:24:54 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27AD6AE051;
        Tue, 12 Jun 2018 22:24:53 +0100 (BST)
Received: from dhcp-9-2-54-130.watson.ibm.com (unknown [9.2.54.130])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 22:24:53 +0100 (BST)
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>, Joe Perches <joe@perches.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Date:   Tue, 12 Jun 2018 17:36:01 -0400
In-Reply-To: <9ae2397b-ad11-d437-d0f4-4e4f0dff4ce9@canonical.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
         <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
         <alpine.LRH.2.21.1806130631400.13763@namei.org>
         <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
         <9ae2397b-ad11-d437-d0f4-4e4f0dff4ce9@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061221-4275-0000-0000-0000028D1264
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061221-4276-0000-0000-0000379438EF
Message-Id: <1528839361.3874.10.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=846 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 14:29 -0700, John Johansen wrote:
> On 06/12/2018 02:12 PM, Paul Moore wrote:
> > On Tue, Jun 12, 2018 at 4:32 PM, James Morris <jmorris@namei.org> wrote:
> >> On Mon, 11 Jun 2018, Casey Schaufler wrote:
> >>
> >>> If you want to break this up by security module I would take
> >>> the Smack part as soon as James does the tree update. If James
> >>> wants to take the whole thing at once you can add my:
> >>>
> >>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>
> >>> for the Smack changes.
> >>
> >> It's probably simplest for me to take them as one patch.
> > 
> > I would prefer if the SELinux changes were split into a separate
> > patch.  I'm guessing John would probably want the same for the
> > AppArmor patches, but take his work for it, not mine.
> 
> yes that would be preferred

Agreed
> 
> > 
> > Joe, in general I really appreciate the fixes you send, but these
> > patches that cross a lot of subsystem boundaries (this isn't the first
> > one that does this) causes unnecessary conflicts in -next and during
> > the merge window.  Could you split your patches up from now on please?
> > 
> 
> yeah splitting patches at subsystem boundaries is highly recommended.

Agreed

