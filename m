Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E20920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuVrju3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfBYPIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:08:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37236 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfBYPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:08:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id a48so10835159qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+1pZay0i3MKPVxK7iPKjk/CsRGNDRDUG9JkO2flt8s=;
        b=BuVrju3X5hvUfUnLQq3gWipBprDwNIJDykux3kiz9ZH1PNmUGG86aXaR67uTY8OuDl
         t/1Qq9NM74PabcE2SZ167Eui7pkpzAFJElkyS3yMERxpefg7wuKZPJuMr5gg+sKYASWd
         bPoh+sGo9iABCm2BM/dgSCS3G2epJNVTRKp/ox4b4Ol/Uia7/wImyeEx2ftIt+MN3PBI
         c03Oc+m5qh2FqfJKatKyhJxIok3PSnGrWUu0qqb5ZhWv8cklJbhcybDVychjW6DpjhM5
         34GpMY+pm3+CIwx4c/3y1eXwjXF3hC1JfKPBZafbHfKUVjPD6aCcwj3LdypW0J/m5b1i
         eWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+1pZay0i3MKPVxK7iPKjk/CsRGNDRDUG9JkO2flt8s=;
        b=Dac0v++QwcRcJEEz6BeQ904BkU0BjEabZJ8P7FKsjQ2AgZbDcfapj1ECwfpAcUG4si
         QDjd6G5bh++hM1+tF///XKclzBlPjsLyluJNj6qpuD1n/kynKsnhDSO4G4qB/SBDd/Ud
         3CNjWtzs+LYhuiM2I+h62JmLEUSYsIl1GzmOv5bd1SnTTHJ8XKbl2T7g1T3/RcdNwzU4
         afupXOHpZ+l5gCe5sdtaJvr/paGjyo518q9ZJL8pCzF3IgYHLZOvDMcxjOudFqRB/ICL
         2Gf5TN12fIrAxPgnAD4SWd+8MD15puqqoQNfEZEZHc1By1M4MnqxrUw4LWDMsfEUG022
         MJjQ==
X-Gm-Message-State: AHQUAuaB2vIsq+ndkpBxzu4ymnrOybxTnfnlF3MubT89bqgJXK9LA36i
        wSsyodEKgL0PkNfHMSk1V9/rTJmj
X-Google-Smtp-Source: AHgI3IabLmzCa/yDgHeJ4w9cBoutWkeF8NFL0GzAVVk8yAnJ6gxIQoWwWGW9h06V8lv54bcuADiPkw==
X-Received: by 2002:a0c:b7a1:: with SMTP id l33mr10824562qve.160.1551107279681;
        Mon, 25 Feb 2019 07:07:59 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id j11sm6717011qtk.26.2019.02.25.07.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 07:07:58 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1EC6D4039C; Mon, 25 Feb 2019 12:07:22 -0300 (-03)
Date:   Mon, 25 Feb 2019 12:07:22 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 10/20] perf data: Add directory support
Message-ID: <20190225150722.GQ31136@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
 <20190224190656.30163-11-jolsa@kernel.org>
 <20190225134548.GA31136@kernel.org>
 <20190225135651.GE14757@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225135651.GE14757@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 25, 2019 at 02:56:51PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 25, 2019 at 10:45:48AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Feb 24, 2019 at 08:06:46PM +0100, Jiri Olsa escreveu:
> > > Adding support to have directory as perf.data.
> > > 
> > > The caller needs to set 'struct perf_data::is_dir flag
> > > and the path will be treated as directory.
> > > 
> > > The 'struct perf_data::file' is initialized and open
> > > as 'path/header' file.
> > > 
> > > Adding check to direcory interface functions to check
> > > on is_dir flag.
> > > 
> > > Link: http://lkml.kernel.org/n/tip-pvot1aywiem9epgqpfi1agaj@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/data.c    | 41 ++++++++++++++++++++++++++++++++++++++-
> > >  tools/perf/util/data.h    |  6 ++++++
> > >  tools/perf/util/session.c |  4 ++++
> > >  3 files changed, 50 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > > index 7bd5ddeb7a41..72ac4dbb5c69 100644
> > > --- a/tools/perf/util/data.c
> > > +++ b/tools/perf/util/data.c
> > > @@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
> > >  	struct perf_data_file *files = NULL;
> > >  	int i, ret = -1;
> > >  
> > > +	if (WARN_ON(!data->is_dir))
> > > +		return -EINVAL;
> > > +
> > >  	files = zalloc(nr * sizeof(*files));
> > >  	if (!files)
> > >  		return -ENOMEM;
> > > @@ -69,6 +72,9 @@ int perf_data__open_dir(struct perf_data *data)
> > >  	DIR *dir;
> > >  	int nr = 0;
> > >  
> > > +	if (WARN_ON(!data->is_dir))
> > > +		return -EINVAL;
> > > +
> > >  	dir = opendir(data->path);
> > >  	if (!dir)
> > >  		return -EINVAL;
> > > @@ -173,6 +179,16 @@ static int check_backup(struct perf_data *data)
> > >  	return 0;
> > >  }
> > >  
> > > +static bool is_dir(struct perf_data *data)
> > > +{
> > > +	struct stat st;
> > > +
> > > +	if (stat(data->path, &st))
> > > +		return false;
> > > +
> > > +	return (st.st_mode & S_IFMT) == S_IFDIR;
> > > +}
> > > +
> > >  static int open_file_read(struct perf_data *data)
> > >  {
> > >  	struct stat st;
> > > @@ -254,6 +270,22 @@ static int open_file_dup(struct perf_data *data)
> > >  	return open_file(data);
> > >  }
> > >  
> > > +static int open_dir(struct perf_data *data)
> > > +{
> > > +	if (perf_data__is_write(data) &&
> > > +	    mkdir(data->path, S_IRWXU) < 0)
> > > +		return -1;
> > > +
> > > +	/*
> > > +	 * So far we open only the header, so we
> > > +	 * can read the data version and layout.
> > > +	 */
> > > +	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
> > > +		return -ENOMEM;
> > 
> > so, if this fails, then we should unwind the mkdir, if it was
> > performed, so that we leave things as they were before calling
> > open_dir(), right?
> 
> I think we need to some global solution on this,

If we don't add more, that would be a good thing :-)

The other parts also need to be investigated to see what is best in that
case, but here, undoing the mkdir() if the asprintf() fails is the right
thing to do :-)

- Arnaldo

> currently we also leve halfway screwed perf.data
> if we fail in the middle
> 
> I think maybe we need to add something on upper (session)
> layer to cleanup if we screw up

B
