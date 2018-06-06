Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E19F601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeFFOwn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:52:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751957AbeFFOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:52:41 -0400
Subject: Re: [PATCH v3 4/4] ima: Differentiate auditing policy rules from
 "audit" actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        sgrubb@redhat.com, linux-kernel@vger.kernel.org
Date: Wed, 06 Jun 2018 10:52:23 -0400
In-Reply-To: <CAHC9VhSbdYOkcszy+emgPNWWtUc0LoWy8pPvov+qjubV7b_EjQ@mail.gmail.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
         <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com>
         <CAHC9VhRkkQ74tvqGrSuNX2RdeHz5N7eU03-yHmVsZg47TxFD0g@mail.gmail.com>
         <1528208105.3237.155.camel@linux.vnet.ibm.com>
         <CAHC9VhSbdYOkcszy+emgPNWWtUc0LoWy8pPvov+qjubV7b_EjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060614-0020-0000-0000-00000297CA60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060614-0021-0000-0000-000020E3DA3F
Message-Id: <1528296743.3255.29.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 18:18 -0400, Paul Moore wrote:
> On Tue, Jun 5, 2018 at 10:15 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Hi Paul,
> >
> > On Mon, 2018-06-04 at 20:21 -0400, Paul Moore wrote:
> >> On Mon, Jun 4, 2018 at 4:54 PM, Stefan Berger
> >> <stefanb@linux.vnet.ibm.com> wrote:
> >> > The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> >> > the IMA "audit" policy action.  This patch defines
> >> > AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
> >> >
> >> > Since we defined a new message type we can now also pass the
> >> > audit_context and get an associated SYSCALL record. This now produces
> >> > the following records when parsing IMA policy's rules:
> >>
> >> Aaand now I see you included the current->audit_context pointer I
> >> mentioned in my comments for 3/4 ;)
> >>
> >> So basically this should be fine, although I should point out that you
> >> do not need to define a new message type to associate records
> >> together.  The fact that we don't associate all connected records is
> >> basically a bug.
> >>
> >> Anyway, patches 3/4 and 4/4 look good to me.  Considering this is
> >> likely going in during the *next* merge window, I would ask that you
> >> convert from "current->audit_context" to "audit_context()" as soon as
> >> this merge window closes.
> >>
> >> Thanks!
> >
> > Thanks, Paul.  I'd like to start queueing patches for the next open
> > window now, instead of scrambling later.  Can I add your Ack now, and
> > remember to make this change when rebasing?
> 
> Sure, go ahead and add my ACK to both 3/4 and 4/4 as long as you
> double pinky swear you'll do the audit_context() fix-up during the
> merge :)
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Sure, it will be really hard to miss.  The next-integrity-queued
branch has:

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

*** Remember replace current->audit_context with call to audit_context() ***
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
