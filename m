Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73329C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A45320651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy66hKJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A45320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeJWDKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeJWDKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:10:33 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BDD20651;
        Mon, 22 Oct 2018 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540234253;
        bh=qSECageZ+KK6cQDkXwfV8CoMC1lo4iAsaP2aozRDN08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qy66hKJc29RWj4s+HXenhcMcDpuPmkgCgdnKAC+EVLkv/x68ZaLAYql0wRyf943tJ
         ktpIR/7WvbAdziGW0XfBucqRkq0VUC2WrCdZ5Hh7qKjW7SXXHQCDgOOfrSB3LRDxDm
         ugIYb+ydnzK2CG4kkT4QDUUsvveuERv6f/+l7jOo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 38167142C5E; Mon, 22 Oct 2018 15:50:49 -0300 (-03)
Date:   Mon, 22 Oct 2018 15:50:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/19] perf scripts python: exported-sql-viewer.py: Add
 All branches report
Message-ID: <20181022185049.GO3849@kernel.org>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
 <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181022185012.GN3849@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022185012.GN3849@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 22, 2018 at 03:50:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 01, 2018 at 09:28:51AM +0300, Adrian Hunter escreveu:
> > Add a report to display branches in a similar fashion to perf script. The
> > main purpose of this report is to display disassembly, however, presently,
> > the only supported disassembler is Intel XED, and additionally the object
> > code must be present in perf build ID cache.
> > 
> > To use Intel XED, libxed.so must be present. To build and install
> > libxed.so:
> > 	git clone https://github.com/intelxed/mbuild.git mbuild
> > 	git clone https://github.com/intelxed/xed
> > 	cd xed
> > 	./mfile.py --share
> > 	sudo ./mfile.py --prefix=/usr/local install
> > 	sudo ldconfig
> 
> The above set of instructions went further than when I tried following
> Andi's instructions for testing the xed support in 'perf script', so I
> tried to test this following committer notes I had added to:
> 
>   4b715d24f4f1 perf tools: Add example call-graph script
> 
> But now I'm getting this, what am I missing? I suggest you catch this
> exception and provide hints about what is missing :-)
> 
> - Arnaldo
> 
> [acme@jouet perf]$ perf script -i ~acme/perf.data.intel_pt -s ~/libexec/perf-core/scripts/python/export-to-postgresql.py pt_example branches calls
> 2018-10-22 15:46:29.964938 Creating database...
> QSqlDatabase: QPSQL driver not loaded
> QSqlDatabase: available drivers: QSQLITE
> QSqlDatabase: an instance of QCoreApplication is required for loading driver plugins
> QSqlQuery::exec: database not open
> Traceback (most recent call last):
>   File "/home/acme/libexec/perf-core/scripts/python/export-to-postgresql.py", line 283, in <module>
>     do_query(query, 'CREATE DATABASE ' + dbname)
>   File "/home/acme/libexec/perf-core/scripts/python/export-to-postgresql.py", line 274, in do_query
>     raise Exception("Query failed: " + q.lastError().text())
> Exception: Query failed: Driver not loaded Driver not loaded
> Error running python script /home/acme/libexec/perf-core/scripts/python/export-to-postgresql.py
> [acme@jouet perf]$
> 
> [root@jouet perf]# rpm -qa | grep -i sqlite
> sqlite-debuginfo-3.14.2-1.fc25.x86_64
> sqlite2-2.8.17-20.fc26.x86_64
> sqlite-3.20.1-3.fc27.x86_64
> sqlite-libs-3.20.1-3.fc27.x86_64
> [root@jouet perf]#

Installed:

python-sqlite3dbm-0.1.4-10.fc27.noarch

didn't help
