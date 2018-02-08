Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeBHOEd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:04:33 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:34708 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeBHOEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:04:30 -0500
Date: Thu, 8 Feb 2018 14:02:50 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, ak@linux.intel.com, wcohen@redhat.com,
        will.deacon@arm.com, ganapatrao.kulkarni@cavium.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] perf utils: add support for arch standard events
Message-ID: <20180208140250.43a10b84@alans-desktop>
In-Reply-To: <20180208135423.GC10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
        <1517939104-230881-6-git-send-email-john.garry@huawei.com>
        <20180208135423.GC10234@krava>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 14:54:23 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
> 
> SNIP
> 
> >  static void print_events_table_suffix(FILE *outfp)
> >  {
> >  	fprintf(outfp, "{\n");
> > @@ -407,6 +469,52 @@ static char *real_event(const char *name, char *event)
> >  	return event;
> >  }
> >  
> > +static void fixup_field(char *from, char **to)
> > +{
> > +	*to = malloc(strlen(from));
> > +
> > +	strcpy(*to, from);
> > +}  
> 
> could you just call '*to = strdup(from)' in here?

And check for malloc returning NULL.

Alan
