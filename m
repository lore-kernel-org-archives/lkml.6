Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1704338-1520256478-2-5726417814753512595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520256477; b=N8jM1ojQuCiZCBDo1ZtPKIjMQ+1LHGZbWXYAEltN3uny45s
    B2BOkHnvME5bxpQ2H5jERrXSL6VHoNSblnobcp6UZJA0Fev9lR3zax2AMHF8qYou
    ic7WFxFZj8oXTvbr2gwFp7tlp7fm9UkAXv1UNdKQkcR15OiIxnlsGD5ga7OzqGDM
    TpmpwMaTRFmrDl+owalWgZ5SL4c4mmpHjoL6DgCeXaa6nNUfASmmnnUomOZCh0ge
    1lh0YOAY/qp6eB/lqTXVNHnlmovZ1+DouJmxUx1hrmwUh7xUncKGojPPuX40t/eV
    +c5cjauvhoF1bUCyzwelnO6bJaUvHHJj3RDUYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=arctest; t=1520256477; bh=9g9QZWnY
    IqtIlnI3of/wP+OOD2ReoyOKC0pQYHw44p0=; b=Cw521c8TxBYgpanAxPnjtGo7
    Ja6JAg8UpEyKS35STGQ/TyWk3YsYvPeXPGvU21p6mBPIpmIE45kNLT9C1yNBHFxv
    SBfR/DbO6l8OYo1l99PJD3qd0n8AbUPAwChhejWJYrda1VBLWJgma1ntCPyKtY0R
    pX3kbHPk/9BnFHwZGFoJBZY+qAo7MtPMg/DUxAGlWswdgxquCx7M9gszWqcfo/GT
    var4rmfWLy72YM8u8ofUw88h3EGhOQ866O8WBSCoKIpbJT3jYLAWq0J5jjngXJyF
    4qxCWGh95VhcunDAKLF/V46RCmUjzWNDWXTiG3Z491XoOXLoF7bonLelPOkusg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935106AbeCEN1y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 08:27:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932084AbeCEN1x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 08:27:53 -0500
Subject: Re: [RFC PATCH V1 00/12] audit: implement container id
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, ebiederm@xmission.com,
        simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, luto@kernel.org,
        eparis@parisplace.org, trondmy@primarydata.com, serge@hallyn.com
Date: Mon, 05 Mar 2018 08:27:39 -0500
In-Reply-To: <20180305033128.6sqreoo5olqwq5og@madcap2.tricolour.ca>
References: <cover.1519930146.git.rgb@redhat.com>
         <1520200557.10396.257.camel@linux.vnet.ibm.com>
         <20180305033128.6sqreoo5olqwq5og@madcap2.tricolour.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030513-0040-0000-0000-0000043AE9A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030513-0041-0000-0000-000020DDFB80
Message-Id: <1520256459.10396.283.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050162
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-03-04 at 22:31 -0500, Richard Guy Briggs wrote:
> On 2018-03-04 16:55, Mimi Zohar wrote:
> > On Thu, 2018-03-01 at 14:41 -0500, Richard Guy Briggs wrote:
> > > Implement audit kernel container ID.
> > > 
> > > This patchset is a preliminary RFC based on the proposal document (V3)
> > > posted:
> > > 	https://www.redhat.com/archives/linux-audit/2018-January/msg00014.html
> > > 
> > > The first patch implements the proc fs write to set the audit container
> > > ID of a process, emitting an AUDIT_CONTAINER record.
> > > 
> > > The second implements an auxiliary syscall record AUDIT_CONTAINER_INFO
> > > if a container ID is present on a task.
> > > 
> > > The third adds filtering to the exit, exclude and user lists.
> > > 
> > > The 4th, implements reading the container ID from the proc filesystem
> > > for debugging.  This isn't planned for upstream inclusion.
> > > 
> > > The 5th adds signal and ptrace support.
> > > 
> > > The 6th attempts to create a local audit context to be able to bind a
> > > standalone record with the container ID record.
> > > 
> > > The 7th, 8th, 9th, 10th patches add container ID records to standalone
> > > records.  Some of these may end up being syscall auxiliary records and
> > > won't need this specific support since they'll be supported via
> > > syscalls.
> > > 
> > > The 11th is a temporary workaround due to the AUDIT_CONTAINER records
> > > not showing up as do AUDIT_LOGIN records.  I suspect this is due to its
> > > range (1000 vs 1300), but the intent is to solve it.
> > > 
> > > The 12th adds debug information not intended for upstream for those
> > > brave souls wanting to tinker with it in this early state.
> > > 
> > > Feedback please!
> > 
> > Which tree can this patch set be applied to?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next

Thanks, that worked.  In case anyone else is trying to apply these
patches to a 4.16.0-rc based kernel, commit 4e7e3adbba52 ("Expand
various INIT_* macros and remove") moved .sessionid
to init/init_task.c.

Mimi

