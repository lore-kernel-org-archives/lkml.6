Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F32C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADA62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK+ZeXi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADA62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeH1XAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:00:43 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46319 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1XAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:00:42 -0400
Received: by mail-qk0-f193.google.com with SMTP id j7-v6so1734172qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrG++dNAmHDZYW8FIp4IhppBHJeFmzrcJhyRZz1Cp3g=;
        b=pK+ZeXi4Vgx+8b+yObennPmslWs4AYWpAzf/BJFKfoKi+csFxBvDn4LbGofRLb8E4Q
         CGW9L7FTeN3K3LDQXoOmcwNWD864HOvw7+A4Fj4HJjapheoEAxdm4c8nvIen3VyF/3lY
         AZLbGFVpBwKymbradg3sUVOusSm1EKuoVXP3+dLV37tkdcEp5C1uW5yRVPqjqN88z7ws
         1a4Eoc6Gm/l6Jy+9t8ahX/Z/usnA5EgOttfGuABide6sEnkGXcW2LNmJ1OIJEHJ1FlH4
         iIhuNOvBA7YDCC9gQZVd9g3N6XCJ84fQX4DtMnAA45FK+s5JiiCiUrrs4EA9UxgV4tnU
         rmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrG++dNAmHDZYW8FIp4IhppBHJeFmzrcJhyRZz1Cp3g=;
        b=oBTZg+vsEAwuff+l+4li5RyKKOplqt3UVLIPh7pAteX0PI40LHAZ4SfrCLJqk13qKl
         ihJUhTCugTUWA/KdhANJCKzVvs4pNvYFn0LZLqNPEt/2syQpowTwmMqnoOcyTavHDsj9
         tcDIsQwb17IS8njy4jicLrRlT9n7wD2EwcgrtOY5lrBRRErBN75fEFzN2kWQYdEptSwx
         T3AZfTTjtO7+fiOHcv7z+8ACmJXF0dp8nbgVy1KOvl68EAGRk9MocnpXaHaSlJw4pVQS
         hvdsuKkVBfUZDZil3tPI4j3YckRNkXv+mGjpoUlAfF+g90p8gfHE2/vgU3VYV+0QyF7M
         9R4g==
X-Gm-Message-State: APzg51AhMjF1PIIscWlZT/jkK5cOasXP1Z2DuSL1d+H7XdWTVx/7VLty
        1rPyXLfqmRNptyzdP4ZY0Zylueb/HtAmHSVGFTA=
X-Google-Smtp-Source: ANB0VdYIf/fkm/DdyAek7H8loBL5Z75NbAwlmGo+EVIw3mHFKMNNYMXGv7kr0IQT9/PBixOTXml4HMsY4g/mnKDgvZg=
X-Received: by 2002:a37:dd56:: with SMTP id n83-v6mr2989136qki.5.1535483261265;
 Tue, 28 Aug 2018 12:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-2-ravi.bangoria@linux.ibm.com> <20180822123943.GD2080@linux.vnet.ibm.com>
In-Reply-To: <20180822123943.GD2080@linux.vnet.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 28 Aug 2018 12:07:30 -0700
Message-ID: <CAPhsuW55gYH2oFg5qEYLW_5hjEOVKvmQvsNPZO4=S=VGdbL6hQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

What's our plan with this work? Will this be routed via Steven's tree?

Thanks,
Song

On Wed, Aug 22, 2018 at 5:39 AM Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-20 10:12:47]:
>
> > Userspace Statically Defined Tracepoints[1] are dtrace style markers
> > inside userspace applications. Applications like PostgreSQL, MySQL,
> > Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> > have these markers embedded in them. These markers are added by developer
> > at important places in the code. Each marker source expands to a single
> > nop instruction in the compiled code but there may be additional
> > overhead for computing the marker arguments which expands to couple of
> > instructions. In case the overhead is more, execution of it can be
> > omitted by runtime if() condition when no one is tracing on the marker:
> >
> >     if (reference_counter > 0) {
> >         Execute marker instructions;
> >     }
> >
> > Default value of reference counter is 0. Tracer has to increment the
> > reference counter before tracing on a marker and decrement it when
> > done with the tracing.
> >
> > Implement the reference counter logic in core uprobe. User will be
> > able to use it from trace_uprobe as well as from kernel module. New
> > trace_uprobe definition with reference counter will now be:
> >
> >     <path>:<offset>[(ref_ctr_offset)]
> >
> > where ref_ctr_offset is an optional field. For kernel module, new
> > variant of uprobe_register() has been introduced:
> >
> >     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> >
> > No new variant for uprobe_unregister() because it's assumed to have
> > only one reference counter for one uprobe.
> >
> > [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> >
> > Note: 'reference counter' is called as 'semaphore' in original Dtrace
> > (or Systemtap, bcc and even in ELF) documentation and code. But the
> > term 'semaphore' is misleading in this context. This is just a counter
> > used to hold number of tracers tracing on a marker. This is not really
> > used for any synchronization. So we are calling it a 'reference counter'
> > in kernel / perf code.
> >
>
>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > [Only trace_uprobe.c]
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > ---
>
