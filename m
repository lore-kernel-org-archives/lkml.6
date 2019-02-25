Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F424C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181C720663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKNHPNwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfBYOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:08:27 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:45134 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBYOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:08:24 -0500
Received: by mail-qt1-f178.google.com with SMTP id d18so10491951qtg.12;
        Mon, 25 Feb 2019 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4uhx4PO1EGRdvecdLCpfKtCzQHDmBNvNXluvGsmz+5g=;
        b=CKNHPNwCuSTKLNaDoZ5nkY+GV4AuzBMYIHrSMYiAzeT4Cxx1uro3gs7MI968liM4YI
         1MNpcOVKPGxnH7GoUdcbfTBs61hF6DwibAQLtNsmqVaN1xFMHlAMPBw1BY+1dECFi/0t
         nhdEFctTQltiWohpT+SsHcwx8rJhMJJwfDNG5PbDomYAMF4Y+R6mdIbiCwLuGUvLM4da
         QMSzV/KVldaUtwMnrfois1vY2bP9OWCSNxFj56zgLjvmLh7bzAmjZ9mKM/Y5JYGrwOdV
         EUL6fLrOMVQLwrq0yg8zSalHtR62zX585UL4TgeeuzDGwpoT2MPwGJk1HqGhB+zN5HRs
         hD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4uhx4PO1EGRdvecdLCpfKtCzQHDmBNvNXluvGsmz+5g=;
        b=QR7uhbThgnERW65D6XjM+s+OGDVBEdcVUjbHAOFk/pdONOdRl5MUcS49reVmwY8gFh
         vcHHlDk0UoDNQwKDOTu4fEvWxDf0VzrDgYQ7r3NqhTP+fkVYB/rl23b1utCdmneSd152
         JYapA5qs7SlV7z7ULVr4Nue6PKjCmEhIIgj/Ce2DcU/9E8G0ij90fzZ2pUCHukFcFdBe
         6uug5f+bBjkg6kXJ2NcsCFAAIzHVrq0oDxydG0EZHlLQHTcjHHH9l10KgxZnuYVRcSGf
         oaa/iL6VFpVBXZ06ut3omiukJPJB4yB0whZV1FJRfAZ3w/zBtnZ2CMpYcIPZ/pEcBOd3
         57mA==
X-Gm-Message-State: AHQUAuYsZhdlt1NsqN/+23gcnbJb2XRvKmeMvLrQly10DvI6bub8MD01
        EQ3uHPcF80rLyeOBPR8Nj/YP3+c6
X-Google-Smtp-Source: AHgI3IYbo0jT+E3akzn9aj3a3jiDdYnwLwiVJww7ktrNrpnZGMAxZycr047PHGH8QBZUuq3UJWyaJA==
X-Received: by 2002:a0c:81b4:: with SMTP id 49mr13665823qvd.144.1551103703524;
        Mon, 25 Feb 2019 06:08:23 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id w127sm5366914qka.46.2019.02.25.06.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:08:22 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 588274039C; Mon, 25 Feb 2019 11:08:19 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:08:19 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/15] perf script python: add Python3 support to
 event_analyzing_sample.py
Message-ID: <20190225140819.GF31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-4-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-4-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:07PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the event_analyzing_sample.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6

This also has indentation changes :-\

The first one I processed, as its already TAB based and the changes are
just for the output part.

- Arnaldo
 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> ---
>  .../scripts/python/event_analyzing_sample.py  | 48 ++++++++++---------
>  1 file changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
> index 4e843b9864ec..f4c4c7963451 100644
> --- a/tools/perf/scripts/python/event_analyzing_sample.py
> +++ b/tools/perf/scripts/python/event_analyzing_sample.py
> @@ -15,6 +15,8 @@
>  # for a x86 HW PMU event: PEBS with load latency data.
>  #
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  import math
> @@ -37,7 +39,7 @@ con = sqlite3.connect("/dev/shm/perf.db")
>  con.isolation_level = None
>  
>  def trace_begin():
> -	print "In trace_begin:\n"
> +        print("In trace_begin:\n")
>  
>          #
>          # Will create several tables at the start, pebs_ll is for PEBS data with
> @@ -76,12 +78,12 @@ def process_event(param_dict):
>          name       = param_dict["ev_name"]
>  
>          # Symbol and dso info are not always resolved
> -        if (param_dict.has_key("dso")):
> +        if ("dso" in param_dict):
>                  dso = param_dict["dso"]
>          else:
>                  dso = "Unknown_dso"
>  
> -        if (param_dict.has_key("symbol")):
> +        if ("symbol" in param_dict):
>                  symbol = param_dict["symbol"]
>          else:
>                  symbol = "Unknown_symbol"
> @@ -102,7 +104,7 @@ def insert_db(event):
>                                  event.ip, event.status, event.dse, event.dla, event.lat))
>  
>  def trace_end():
> -	print "In trace_end:\n"
> +        print("In trace_end:\n")
>          # We show the basic info for the 2 type of event classes
>          show_general_events()
>          show_pebs_ll()
> @@ -123,29 +125,29 @@ def show_general_events():
>          # Check the total record number in the table
>          count = con.execute("select count(*) from gen_events")
>          for t in count:
> -                print "There is %d records in gen_events table" % t[0]
> +                print("There is %d records in gen_events table" % t[0])
>                  if t[0] == 0:
>                          return
>  
> -        print "Statistics about the general events grouped by thread/symbol/dso: \n"
> +        print("Statistics about the general events grouped by thread/symbol/dso: \n")
>  
>           # Group by thread
>          commq = con.execute("select comm, count(comm) from gen_events group by comm order by -count(comm)")
> -        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
> +        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
>          for row in commq:
> -             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
> +             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
>  
>          # Group by symbol
> -        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
> +        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
>          symbolq = con.execute("select symbol, count(symbol) from gen_events group by symbol order by -count(symbol)")
>          for row in symbolq:
> -             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
> +             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
>  
>          # Group by dso
> -        print "\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74)
> +        print("\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74))
>          dsoq = con.execute("select dso, count(dso) from gen_events group by dso order by -count(dso)")
>          for row in dsoq:
> -             print "%40s %8d     %s" % (row[0], row[1], num2sym(row[1]))
> +             print("%40s %8d     %s" % (row[0], row[1], num2sym(row[1])))
>  
>  #
>  # This function just shows the basic info, and we could do more with the
> @@ -156,35 +158,35 @@ def show_pebs_ll():
>  
>          count = con.execute("select count(*) from pebs_ll")
>          for t in count:
> -                print "There is %d records in pebs_ll table" % t[0]
> +                print("There is %d records in pebs_ll table" % t[0])
>                  if t[0] == 0:
>                          return
>  
> -        print "Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n"
> +        print("Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n")
>  
>          # Group by thread
>          commq = con.execute("select comm, count(comm) from pebs_ll group by comm order by -count(comm)")
> -        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
> +        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
>          for row in commq:
> -             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
> +             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
>  
>          # Group by symbol
> -        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
> +        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
>          symbolq = con.execute("select symbol, count(symbol) from pebs_ll group by symbol order by -count(symbol)")
>          for row in symbolq:
> -             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
> +             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
>  
>          # Group by dse
>          dseq = con.execute("select dse, count(dse) from pebs_ll group by dse order by -count(dse)")
> -        print "\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58)
> +        print("\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58))
>          for row in dseq:
> -             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
> +             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
>  
>          # Group by latency
>          latq = con.execute("select lat, count(lat) from pebs_ll group by lat order by lat")
> -        print "\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58)
> +        print("\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58))
>          for row in latq:
> -             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
> +             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
>  
>  def trace_unhandled(event_name, context, event_fields_dict):
> -		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
> +        print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
> -- 
> 2.20.1

-- 

- Arnaldo
