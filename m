Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeDTSk5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753607AbeDTSk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:40:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA9620C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 14:40:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <songliubraving@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v4] tracing: remove igrab() iput() call from uprobes.c
Message-ID: <20180420144053.1e2b8396@gandalf.local.home>
In-Reply-To: <9BEE77C2-B1BE-4697-919B-06997F05A0B0@fb.com>
References: <20180420180847.418760-1-songliubraving@fb.com>
        <20180420142922.08ad9e64@gandalf.local.home>
        <9BEE77C2-B1BE-4697-919B-06997F05A0B0@fb.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 18:36:38 +0000
Song Liu <songliubraving@fb.com> wrote:

> > On Apr 20, 2018, at 11:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > On Fri, 20 Apr 2018 11:08:47 -0700
> > Song Liu <songliubraving@fb.com> wrote:
> >   
> >> For uprobes.c sisde, igrab() is not necessary. So we removed it and  
> > 
> > You don't need to send another patch, but what is the above sentence
> > suppose to say?
> > 
> > -- Steve
> >   
> 
> Sorry for the typo. I meant "For uprobes.c side". Or "it is not necessary
> to call igrab() in uprobe_register(), as the caller is required to keep
> the inode reference. 
> 

I'll update it to:

"For uprobes.c, it is not necessary to call igrab() in
uprobe_register(), as the caller is required to keep the inode
reference. The igrab() is removed and comments on this requirement is
added to uprobe_register()."

-- Steve
