Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B62C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AFB20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="faQ46i56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AFB20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJaCQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:16:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43062 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJaCQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:16:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id k9so11845322otl.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIPd0EzG2gMU/qDGJDwuN+fIAgsmdZiWLpuxUpyLet4=;
        b=faQ46i56CpNV+hvDRXtIoRhOuTUFH+vbtEIZKHnJYZd9P0uf32OdqysFfCRl4PqZ9+
         ohFpmrqvsqEoUhrvlhHffcOX9YNglp9oYe6VxbHxTQcLL/y7ErBmwvUz1vB4y+Neu4zv
         ZhmS6V4Eq+XwmNma3sP/lwPJ6kHWWrq5hsCIVvxztnsa+QNMyYoWFOzzEkoFCDQqrxsC
         alCPGOeiDSzgJ0Z7hX+nExd94kkxWbVfGN0hwW1OcZg7hXpXzgX/f7cyURcoYDgBLxMG
         I4FM3PRth51VG6SoI+Svgjblr2qMwc6f9u4HyPEMkT1PoLrXC6VTUnC/yrfOCxrqK5h6
         bNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIPd0EzG2gMU/qDGJDwuN+fIAgsmdZiWLpuxUpyLet4=;
        b=XLNYfpd/Ox/ZuXIULh9B+/zYnwL1rWu07LuuwO4Ylhnt/yaXVde2LeqIw2xvwtyzJb
         RmGBziIB7ydKbM+YCBmYj7lX597nQxsl9M4M2GOO1zNoTuEZhL8A8gZkauyYIZ2F6/BM
         GzKj0WdwafNOu2E+n0siG3h3cMT3IWJ6heg5QWVzfZwyh6xsfzEN2R9yo0S3teDsmSNO
         RvqAML2MHDlYpJSfkbon3n4XzOOw0pCKL0Fqe2x3B4Js7RMgWweHaabuzFZnjsXB98As
         Yj2ZyFn9P6OPxiCoFXDpl+fyeSBqMGCntM7YlUK0GPpMvRp2i5a/ubiuVGLncrdYlFaZ
         Wlsw==
X-Gm-Message-State: AGRZ1gL12rcXAXYIwZygc/61TM6vz3559IUtjhf/SOPOv+0QNrPZhu4O
        UfhGRtCPIHpVvbxYQ5CsVNpWhg==
X-Google-Smtp-Source: AJdET5eOvYcFFuYR0Bvse5JccbtcXLxZNWPiLSpoXF8apQIr6Ed0AStqcgERoSvb/kg+H68WHSXysA==
X-Received: by 2002:a9d:437d:: with SMTP id y58mr5322448oti.287.1540920124529;
        Tue, 30 Oct 2018 10:22:04 -0700 (PDT)
Received: from cisco ([128.107.241.170])
        by smtp.gmail.com with ESMTPSA id 30sm8129708otr.52.2018.10.30.10.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 10:21:59 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:21:43 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181030172143.GD7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181030150254.GB3385@redhat.com>
 <20181030155403.GC7343@cisco>
 <20181030162752.GB7643@redhat.com>
 <20181030163926.GC7643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030163926.GC7643@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 05:39:26PM +0100, Oleg Nesterov wrote:
> On 10/30, Oleg Nesterov wrote:
> >
> > On 10/30, Tycho Andersen wrote:
> > >
> > > @@ -828,6 +823,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
> > >  	 */
> > >  	rmb();
> > >
> > > +	if (!sd) {
> > > +		populate_seccomp_data(&sd_local);
> > > +		sd = &sd_local;
> > > +	}
> > > +
> >
> > To me it would be more clean to remove the "if (!sd)" check, case(SECCOMP_RET_TRACE)
> > in __seccomp_filter() can simply do populate_seccomp_data(&sd_local) unconditionally
> > and pass &sd_local to __seccomp_filter().
> 
> Ah, please ignore, emulate_vsyscall() does secure_computing(NULL).
> 
> Btw. why __seccomp_filter() doesn't return a boolean?
> 
> Or at least, why can't case(SECCOMP_RET_TRACE) simply do
> 
> 	return __seccomp_filter(this_syscall, NULL, true);
> 
> ?

Yeah, at least the second one definitely makes sense. I can add that
as a patch in the next version of this series unless Kees does it
before.

Thanks for your help, Oleg!

Tycho
