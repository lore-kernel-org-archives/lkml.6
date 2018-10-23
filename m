Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21FBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0352080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0352080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeJWQoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:44:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:23803 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbeJWQob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:44:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 01:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="80866563"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2018 01:22:10 -0700
Subject: Re: [PATCH 17/19] perf scripts python: exported-sql-viewer.py: Add
 All branches report
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181001062853.28285-1-adrian.hunter@intel.com>
 <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181022185012.GN3849@kernel.org> <20181022185049.GO3849@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <03696b24-b580-dfca-b991-f82dcc7a0176@intel.com>
Date:   Tue, 23 Oct 2018 11:20:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022185049.GO3849@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/18 9:50 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 22, 2018 at 03:50:12PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Oct 01, 2018 at 09:28:51AM +0300, Adrian Hunter escreveu:
>>> Add a report to display branches in a similar fashion to perf script. The
>>> main purpose of this report is to display disassembly, however, presently,
>>> the only supported disassembler is Intel XED, and additionally the object
>>> code must be present in perf build ID cache.
>>>
>>> To use Intel XED, libxed.so must be present. To build and install
>>> libxed.so:
>>> 	git clone https://github.com/intelxed/mbuild.git mbuild
>>> 	git clone https://github.com/intelxed/xed
>>> 	cd xed
>>> 	./mfile.py --share
>>> 	sudo ./mfile.py --prefix=/usr/local install
>>> 	sudo ldconfig
>>
>> The above set of instructions went further than when I tried following
>> Andi's instructions for testing the xed support in 'perf script', so I
>> tried to test this following committer notes I had added to:
>>
>>   4b715d24f4f1 perf tools: Add example call-graph script
>>
>> But now I'm getting this, what am I missing? I suggest you catch this
>> exception and provide hints about what is missing :-)
>>
>> - Arnaldo
>>
>> [acme@jouet perf]$ perf script -i ~acme/perf.data.intel_pt -s ~/libexec/perf-core/scripts/python/export-to-postgresql.py pt_example branches calls
>> 2018-10-22 15:46:29.964938 Creating database...
>> QSqlDatabase: QPSQL driver not loaded
>> QSqlDatabase: available drivers: QSQLITE
>> QSqlDatabase: an instance of QCoreApplication is required for loading driver plugins
>> QSqlQuery::exec: database not open
>> Traceback (most recent call last):
>>   File "/home/acme/libexec/perf-core/scripts/python/export-to-postgresql.py", line 283, in <module>
>>     do_query(query, 'CREATE DATABASE ' + dbname)
>>   File "/home/acme/libexec/perf-core/scripts/python/export-to-postgresql.py", line 274, in do_query
>>     raise Exception("Query failed: " + q.lastError().text())
>> Exception: Query failed: Driver not loaded Driver not loaded
>> Error running python script /home/acme/libexec/perf-core/scripts/python/export-to-postgresql.py
>> [acme@jouet perf]$
>>
>> [root@jouet perf]# rpm -qa | grep -i sqlite
>> sqlite-debuginfo-3.14.2-1.fc25.x86_64
>> sqlite2-2.8.17-20.fc26.x86_64
>> sqlite-3.20.1-3.fc27.x86_64
>> sqlite-libs-3.20.1-3.fc27.x86_64
>> [root@jouet perf]#
> 
> Installed:
> 
> python-sqlite3dbm-0.1.4-10.fc27.noarch
> 
> didn't help
> 

The sqlite export script is a different script to the postgresql export
script.  The sqlite export script is called "export-to-sqlite.py".  From the
output above "QSqlDatabase: available drivers: QSQLITE", it looks like
sqlite should work. i.e.

   $ perf script -i ~acme/perf.data.intel_pt -s
~/libexec/perf-core/scripts/python/export-to-sqlite.py pt_example branches calls

Working with postgresql requires more setup (although it becomes
increasingly more efficient than sqlite as the data size increases).

For postgresql, according to the "export-to-postgresql.py" script comments,
the packages needed are:

fedora:
   $ sudo yum install postgresql postgresql-server python-pyside \
   qt-postgresql

ubuntu:
   $ sudo apt-get install postgresql python-pyside.qtsql libqt4-sql-psql

But a postgresql server must be configured and running also.  According to
"export-to-postgresql.py" comments:

fedora:
   $ sudo su - postgres -c initdb
   $ sudo service postgresql start
   $ sudo su - postgres
   $ createuser <your user id here>
   Shall the new role be a superuser? (y/n) y

ubuntu:
   $ sudo su - postgres
   $ createuser -s <your user id here>


Please also note that I have sent a V2 of this patch with a minor fix.
