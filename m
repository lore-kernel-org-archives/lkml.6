Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBIJPj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:15:39 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36994 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeBIJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:15:36 -0500
X-Google-Smtp-Source: AH8x225uJx79iM54+dtLf6dr/EHjXp9l8fDhwZzgmTRfasNlKAbzvMjiNOEANQnm66v56mDJNS0mOg==
Date: Fri, 9 Feb 2018 18:15:31 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dave Young <dyoung@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] printk: move dump stack related code to lib/dump_stack.c
Message-ID: <20180209091531.GG689@jagdpanzerIV>
References: <20180209080624.GA2607@dhcp-128-65.nay.redhat.com>
 <20180209081604.GE689@jagdpanzerIV>
 <20180209082743.GA14845@dhcp-128-65.nay.redhat.com>
 <20180209084235.GF689@jagdpanzerIV>
 <20180209085116.GB5454@dhcp-128-65.nay.redhat.com>
 <20180209090018.GA7129@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209090018.GA7129@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/09/18 17:00), Dave Young wrote:
[..]
> >
> > I'm hesitating to add #ifdef CONFIG_PRINTK in lib/dump_stack.c.

Agreed.

> Maybe conditionally build dump_stack.o only when CONFIG_PRINTK is true,
> but not sure if there are some historic reason this is not done before,
> will do some testing see if it works.
> 

Thanks.

Was thinking about the same thing - dump_stack() without CONFIG_PRINTK
doesn't make that much sense anyway. Well, maybe it does in some weird
case... Need to check. But it seems that we probably can just make the
dependency, which already exists, explicit.

	-ss
