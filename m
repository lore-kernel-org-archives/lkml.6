Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518427953; cv=none;
        d=google.com; s=arc-20160816;
        b=ENvp9PiOz3Jg8W/U21WlysrOcJktFLUtdhMoJBXARi5ppFx7hF83sGSihQ3qtE8sjX
         A/DQfa8mudoClJWs9RTWXrtzHHeyEoNkWchy3O3Jc/xGTnKrX+TYujwCKuzt+L4XfWZC
         l4I9kmvuPwa9YLaMsAH/KvRxKMiUPGn0GO8BGpwZZZgydT+8mfpW+VvitcRiOKpuAggA
         6zwy0E+K9n/32tjhxt6ZIRqJ1OGRHMgIcIehfx4p3CgA2oUub3sVbuglodzK3YNpePZT
         Xwi925AjWu7daVTS3D2inNPnzdEzn5eMtBtbxkJb5JuiEfU3LaNOJXJn9LG+K270xloV
         UcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=GsnwT8Pov+d4FcSQhnhuvjcgROEnuAsalffIDMw1k9Y=;
        b=WwFLxHQLtjMbYXCSGlPFhSxneCoXwzN330HJ67+fBv9nmpQBYein9NONyV71aX6Y+o
         rlcPipRVZXmLNUU0dJWXcCzO7E8r4bH4gwZ2emb842mS/8bTu24+cPGH2ObKIPtntTmb
         g1qXYJk2wI0Q/rUrrl8uMcy56yw8/cDNkKOqlP0Q5SOsvS/JZjQdeelDe8QbOgFzpuNM
         JA99dIC9ad6H2+2yR8YeY8qo3O2GJlfU+ZgsGT6AviW9vYkTznqYYlmOK0YnHG0vGNxA
         5ell2hLbMQFR8wRMr5hTaCpvHZ9LjoQjzWXags9HLEgJoJFHstK6EnR2xzP3zjAjCEME
         RNOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=NXwmzXXq;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=NXwmzXXq;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x225S8fxZkHGwM+1dKqr3yuLgOwTqfvj/4UpQCesURdM82FlcJMRJbbAxpNz/C9d5ad+5oavjjeAj8vFNek6NPtM=
MIME-Version: 1.0
In-Reply-To: <20180212010602.GC44666@jaegeuk-macbookpro.roam.corp.google.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517933183-30892-2-git-send-email-stanislav.nijnikov@wdc.com> <20180212010602.GC44666@jaegeuk-macbookpro.roam.corp.google.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 10:31:52 +0100
Message-ID: <CAOFm3uFHiOm9nfM=PGcynDigJpxg3Ou3_j5kHf4xhbergc6JwQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] scsi: ufs: sysfs: attribute group for existing
 sysfs entries.
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>, linux-scsi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alex.lemberg@wdc.com,
	Russell King <rmk@armlinux.org.uk>, Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668315913733623?=
X-GMAIL-MSGID: =?utf-8?q?1592187109829102281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Stanislav,

On Mon, Feb 12, 2018 at 2:06 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> On 02/06, Stanislav Nijnikov wrote:
>> This patch introduces attribute group to show existing sysfs entries.
>>
>> Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>

<snip>

>> --- /dev/null
>> +++ b/drivers/scsi/ufs/ufs-sysfs.c
>> @@ -0,0 +1,156 @@
>> +// SPDX-License-Identifier: GPL-2.0-only

I commend you for using license ids here. But there is an issue with
your attempt to use the latest and greatest license ids from SPDX:
GPL-2.0-only is not a documented license id in our doc [1]
Until this is updated (help welcomed including patching a few 10K+
files) , this should be GPL-2.0 instead to avoid confusion and keep
things homogeneous and tidy.

FYI, using only the doc as the reference was brought forward by
Russell King and Christoph Hellwig and in particular with this:

On Thu, Nov 9, 2017 at 5:44 PM, Russell King <rmk@armlinux.org.uk> wrote:

> I'd be more comfortable if we could have something in the kernel tree
> that identifies the SPDX tags and their meaning, maybe with the
> _standard_ file header for that license included, so there is no
> argument about what any particular SPDX tag means.

Based on this, Thomas Gleixner updated the doc alright following this
important point. So, in case of doubt the doc should be the reference
for this and nothing else. And if there are issue with the doc, then
we can fix it with a patch ;)

CC: Russell King <rmk@armlinux.org.uk>
CC: Christoph Hellwig <hch@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
