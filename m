Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967207AbeE2Vfy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:35:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966952AbeE2Vfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:35:50 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] integrity: Add exe= and tty= before res= to integrity audits
Date: Tue, 29 May 2018 17:35:48 -0400
Message-ID: <4331521.GQBdaJNAj6@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com> <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 29, 2018 5:19:39 PM EDT Paul Moore wrote:
> On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
> 
> <stefanb@linux.vnet.ibm.com> wrote:
> > Use the new public audit functions to add the exe= and tty=
> > parts to the integrity audit records. We place them before
> > res=.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > ---
> > 
> >  security/integrity/integrity_audit.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/security/integrity/integrity_audit.c
> > b/security/integrity/integrity_audit.c index db30763d5525..8d25d3c4dcca
> > 100644
> > --- a/security/integrity/integrity_audit.c
> > +++ b/security/integrity/integrity_audit.c
> > @@ -56,6 +56,8 @@ void integrity_audit_msg(int audit_msgno, struct inode
> > *inode,> 
> >                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
> >                 audit_log_format(ab, " ino=%lu", inode->i_ino);
> >         
> >         }
> > 
> > +       audit_log_d_path_exe(ab, current->mm);
> > +       audit_log_tty(ab, current);
> 
> NACK
> 
> Please add the new fields to the end of the audit record, thank you.

Let's see what an example event looks like before NACK'ing this. Way back in 
2013 the IMA events were good. I think this is repairing the event after some 
drift.

Thanks,
-Steve
 
> >         audit_log_format(ab, " res=%d", !result);
> >         audit_log_end(ab);
> >  
> >  }
