Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F020C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE3B2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I563oHNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBYODT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:03:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46706 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfBYODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:03:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id z25so10475447qti.13;
        Mon, 25 Feb 2019 06:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4PMom+5B+99AFf2KZtRA/ApLtBwjIqlKCdUJeB+nRU=;
        b=I563oHNuT8NRUOd8NW5hiJarTAYWseyGsa+v5vaYjj/h5lyU6l5bG9HoQ51PQ157YK
         rpgQmYg8ZNdAXEqsnRIN1MjFr6itmd9IlFRTtBgtGasDXjp9a/f/oDY2BgUfjCTDxZCF
         NdtxLbSDTXQ0C0H7p0z+SR3JVUSPI/2ze0guuw8Lg4dpitn5IGtbTb5cBS982Hp2urXf
         RFSA2mDnW0q6unPcUALauPW1n64I2uEu2VqxzyJGApqbyTwmBG+k6htoQ3RvjwPmTuYs
         gN52ZMAh98Aeuw6QEA5FhEqqE33tjByFoOi5qRd/sCdIqHUuWufLjFoBgZvRraNF5d+V
         8ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4PMom+5B+99AFf2KZtRA/ApLtBwjIqlKCdUJeB+nRU=;
        b=XMdflsv8x5/QcKzgh3qVZ8LKzE/VN50WC+zHhZy0iCbTLEmDBijIaV4k9x8l52WRfL
         NiiFewv4/7gBuNm8kzFNmvWvwwifVKU6yqWe8kq2Xb354Z3cWMPPtGkdlBHtgbrUP9Sd
         wVIvemM+tGEWoL1cpiItC6d6AzpYQxF+yIPojD9X/IbALpRQPp6H1l80Ed4g29vfHqvg
         rNAeYTF0AH59De4vOjUwPbfs40e9plfH4z8/26uijc+5ecOnqPP7tfu8sC940GHAHod6
         PozKxTNXlcv50/2OBHwdgwzDPXHRuWUq1r9QZKdyFtq+6iYJyVJD35GLoZWnBT82B5Xh
         RUYA==
X-Gm-Message-State: AHQUAuaqcF1/BqJK+cXzDvICB9LVbDT06tRjz2PXUeJvWJCmObPtnx5U
        N4TYNKDXyxe090Gdj+OPNd8=
X-Google-Smtp-Source: AHgI3IYyb9xGIcq9lPXQy4NPLkA25Kr+hcXidMmkP++EF9gc02KipH1LJ1SimAQWxL0f7pJvpn2GgQ==
X-Received: by 2002:ac8:2c51:: with SMTP id e17mr13396121qta.254.1551103397011;
        Mon, 25 Feb 2019 06:03:17 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id i33sm7003487qti.74.2019.02.25.06.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:03:15 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 022D54039C; Mon, 25 Feb 2019 11:03:12 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:03:12 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>, Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH 06/15] perf script python: add Python3 support to
 intel-pt-events.py
Message-ID: <20190225140312.GD31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-7-tonyj@suse.de>
 <1cc3561f-604f-6f01-147c-89deb07d3410@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc3561f-604f-6f01-147c-89deb07d3410@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 25, 2019 at 09:07:03AM +0200, Adrian Hunter escreveu:
> On 23/02/19 1:06 AM, Tony Jones wrote:
> > Support both Python2 and Python3 in the intel-pt-events.py script
> > 
> > There may be differences in the ordering of output lines due to
> > differences in dictionary ordering etc.  However the format within lines
> > should be unchanged.
> > 
> > Fix space/tab inconsistency as python3 enforces consistency.
> 
> It would be better for the white space changes to be a separate patch.
> 
> But I am not in favour of using spaces instead of tabs because it is the
> opposite of what we tend to do with C.
> 
> Arnaldo, can you provide a guideline on this?

Yeah, please separate things, this would help me now to pick the
uncontroversial part while we discuss the other.

And I'm in favour of being consistent with what we do for C code, i.e.
use TABs.

I'm now processing the other patches.

- Arnaldo
 
> > 
> > The use of 'from __future__' implies the minimum supported Python2 version
> > is now v2.6
> > 
> > Signed-off-by: Tony Jones <tonyj@suse.de>
> > Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/scripts/python/intel-pt-events.py | 138 ++++++++++---------
> >  1 file changed, 70 insertions(+), 68 deletions(-)
> > 
> > diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> > index b19172d673af..aef54566af61 100644
> > --- a/tools/perf/scripts/python/intel-pt-events.py
> > +++ b/tools/perf/scripts/python/intel-pt-events.py
> > @@ -10,79 +10,81 @@
> >  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >  # more details.
> >  
> > +from __future__ import print_function
> > +
> >  import os
> >  import sys
> >  import struct
> >  
> >  sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> > -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> > +        '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> >  
> >  # These perf imports are not used at present
> >  #from perf_trace_context import *
> >  #from Core import *
> >  
> >  def trace_begin():
> > -	print "Intel PT Power Events and PTWRITE"
> > +        print("Intel PT Power Events and PTWRITE")
> >  
> >  def trace_end():
> > -	print "End"
> > +        print("End")
> >  
> >  def trace_unhandled(event_name, context, event_fields_dict):
> > -		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
> > +        print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
> >  
> >  def print_ptwrite(raw_buf):
> > -	data = struct.unpack_from("<IQ", raw_buf)
> > -	flags = data[0]
> > -	payload = data[1]
> > -	exact_ip = flags & 1
> > -	print "IP: %u payload: %#x" % (exact_ip, payload),
> > +        data = struct.unpack_from("<IQ", raw_buf)
> > +        flags = data[0]
> > +        payload = data[1]
> > +        exact_ip = flags & 1
> > +        print("IP: %u payload: %#x" % (exact_ip, payload), end='')
> >  
> >  def print_cbr(raw_buf):
> > -	data = struct.unpack_from("<BBBBII", raw_buf)
> > -	cbr = data[0]
> > -	f = (data[4] + 500) / 1000
> > -	p = ((cbr * 1000 / data[2]) + 5) / 10
> > -	print "%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p),
> > +        data = struct.unpack_from("<BBBBII", raw_buf)
> > +        cbr = data[0]
> > +        f = (data[4] + 500) / 1000
> > +        p = ((cbr * 1000 / data[2]) + 5) / 10
> > +        print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end='')
> >  
> >  def print_mwait(raw_buf):
> > -	data = struct.unpack_from("<IQ", raw_buf)
> > -	payload = data[1]
> > -	hints = payload & 0xff
> > -	extensions = (payload >> 32) & 0x3
> > -	print "hints: %#x extensions: %#x" % (hints, extensions),
> > +        data = struct.unpack_from("<IQ", raw_buf)
> > +        payload = data[1]
> > +        hints = payload & 0xff
> > +        extensions = (payload >> 32) & 0x3
> > +        print("hints: %#x extensions: %#x" % (hints, extensions), end='')
> >  
> >  def print_pwre(raw_buf):
> > -	data = struct.unpack_from("<IQ", raw_buf)
> > -	payload = data[1]
> > -	hw = (payload >> 7) & 1
> > -	cstate = (payload >> 12) & 0xf
> > -	subcstate = (payload >> 8) & 0xf
> > -	print "hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
> > +        data = struct.unpack_from("<IQ", raw_buf)
> > +        payload = data[1]
> > +        hw = (payload >> 7) & 1
> > +        cstate = (payload >> 12) & 0xf
> > +        subcstate = (payload >> 8) & 0xf
> > +        print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate), end='')
> >  
> >  def print_exstop(raw_buf):
> > -	data = struct.unpack_from("<I", raw_buf)
> > -	flags = data[0]
> > -	exact_ip = flags & 1
> > -	print "IP: %u" % (exact_ip),
> > +        data = struct.unpack_from("<I", raw_buf)
> > +        flags = data[0]
> > +        exact_ip = flags & 1
> > +        print("IP: %u" % (exact_ip), end='')
> >  
> >  def print_pwrx(raw_buf):
> > -	data = struct.unpack_from("<IQ", raw_buf)
> > -	payload = data[1]
> > -	deepest_cstate = payload & 0xf
> > -	last_cstate = (payload >> 4) & 0xf
> > -	wake_reason = (payload >> 8) & 0xf
> > -	print "deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason),
> > +        data = struct.unpack_from("<IQ", raw_buf)
> > +        payload = data[1]
> > +        deepest_cstate = payload & 0xf
> > +        last_cstate = (payload >> 4) & 0xf
> > +        wake_reason = (payload >> 8) & 0xf
> > +        print("deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason), end='')
> >  
> >  def print_common_start(comm, sample, name):
> > -	ts = sample["time"]
> > -	cpu = sample["cpu"]
> > -	pid = sample["pid"]
> > -	tid = sample["tid"]
> > -	print "%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
> > +        ts = sample["time"]
> > +        cpu = sample["cpu"]
> > +        pid = sample["pid"]
> > +        tid = sample["tid"]
> > +        print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name), end='')
> >  
> >  def print_common_ip(sample, symbol, dso):
> > -	ip = sample["ip"]
> > -	print "%16x %s (%s)" % (ip, symbol, dso)
> > +        ip = sample["ip"]
> > +        print("%16x %s (%s)" % (ip, symbol, dso))
> >  
> >  def process_event(param_dict):
> >          event_attr = param_dict["attr"]
> > @@ -92,37 +94,37 @@ def process_event(param_dict):
> >          name       = param_dict["ev_name"]
> >  
> >          # Symbol and dso info are not always resolved
> > -        if (param_dict.has_key("dso")):
> > +        if "dso" in param_dict:
> >                  dso = param_dict["dso"]
> >          else:
> >                  dso = "[unknown]"
> >  
> > -        if (param_dict.has_key("symbol")):
> > +        if "symbol" in param_dict:
> >                  symbol = param_dict["symbol"]
> >          else:
> >                  symbol = "[unknown]"
> >  
> > -	if name == "ptwrite":
> > -		print_common_start(comm, sample, name)
> > -		print_ptwrite(raw_buf)
> > -		print_common_ip(sample, symbol, dso)
> > -	elif name == "cbr":
> > -		print_common_start(comm, sample, name)
> > -		print_cbr(raw_buf)
> > -		print_common_ip(sample, symbol, dso)
> > -	elif name == "mwait":
> > -		print_common_start(comm, sample, name)
> > -		print_mwait(raw_buf)
> > -		print_common_ip(sample, symbol, dso)
> > -	elif name == "pwre":
> > -		print_common_start(comm, sample, name)
> > -		print_pwre(raw_buf)
> > -		print_common_ip(sample, symbol, dso)
> > -	elif name == "exstop":
> > -		print_common_start(comm, sample, name)
> > -		print_exstop(raw_buf)
> > -		print_common_ip(sample, symbol, dso)
> > -	elif name == "pwrx":
> > -		print_common_start(comm, sample, name)
> > -		print_pwrx(raw_buf)
> > -		print_common_ip(sample, symbol, dso)
> > +        if name == "ptwrite":
> > +                print_common_start(comm, sample, name)
> > +                print_ptwrite(raw_buf)
> > +                print_common_ip(sample, symbol, dso)
> > +        elif name == "cbr":
> > +                print_common_start(comm, sample, name)
> > +                print_cbr(raw_buf)
> > +                print_common_ip(sample, symbol, dso)
> > +        elif name == "mwait":
> > +                print_common_start(comm, sample, name)
> > +                print_mwait(raw_buf)
> > +                print_common_ip(sample, symbol, dso)
> > +        elif name == "pwre":
> > +                print_common_start(comm, sample, name)
> > +                print_pwre(raw_buf)
> > +                print_common_ip(sample, symbol, dso)
> > +        elif name == "exstop":
> > +                print_common_start(comm, sample, name)
> > +                print_exstop(raw_buf)
> > +                print_common_ip(sample, symbol, dso)
> > +        elif name == "pwrx":
> > +                print_common_start(comm, sample, name)
> > +                print_pwrx(raw_buf)
> > +                print_common_ip(sample, symbol, dso)
> > 

-- 

- Arnaldo
