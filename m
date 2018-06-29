Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A6CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49D62804F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lercrQGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49D62804F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936597AbeF2PWA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936176AbeF2PV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:21:58 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4352804A;
        Fri, 29 Jun 2018 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530285717;
        bh=PNhQIpFgzKIUNaFH2ikIXhYobPNMpy1NpY1MdpdQ6WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lercrQGeXwY/tWMHIl2HkMJA0LWUn8JwqVREbWnp7rq6l0f27VIiaftTcaT4+enul
         m2uzH8LIiAWy0UTl2gtMUOH8EYsGRMlZ8BKdbAkCZjpTWd1/3nusmhBT8F/Hbc35Cl
         ig/Ll1CPoQNJU9jW9SLxTlTUCmtVQrAuxsPKpR1s=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3B7301403D2; Fri, 29 Jun 2018 12:21:55 -0300 (-03)
Date:   Fri, 29 Jun 2018 12:21:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Hendrik =?iso-8859-1?Q?Br=FCckner?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf test shell: make perf inet_pton test more
 portable
Message-ID: <20180629152155.GB3593@kernel.org>
References: <20180619184952.dac6a3a1e39d3b1d255e7119@arm.com>
 <20180620134622.GM20477@kernel.org>
 <20180620194546.364cc109430ac51c5a288739@arm.com>
 <20180621141915.GS20477@kernel.org>
 <20180621151800.GU20477@kernel.org>
 <20180621153250.e29e7fbfbfe14b98341b68f0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621153250.e29e7fbfbfe14b98341b68f0@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 21, 2018 at 03:32:50PM -0500, Kim Phillips escreveu:
> On Thu, 21 Jun 2018 12:18:00 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Would be good if we had some utility that given a two files, one with
> > regexps, could tell if, line by line, those expressions matched, better,
> > one that is present in all these OSes...
> 
> I didn't find any, but given the two-file notion might be acceptable,
> hopefully you might find the following more readable/acceptable?:

Looks better, you build the expected lines in a separate file, then read
both it and the output, then do the matching, cleaner. And I assume it
works with dash, right?

- Arnaldo
 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 263057039693..94e513e62b34 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -14,35 +14,40 @@ libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1
>  nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>  
>  trace_libc_inet_pton_backtrace() {
> -	idx=0
> -	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
> -	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> +
> +	expected=`mktemp -u /tmp/expected.XXX`
> +
> +	echo "ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)" > $expected
> +	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>  	case "$(uname -m)" in
>  	s390x)
>  		eventattr='call-graph=dwarf,max-stack=4'
> -		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
> -		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> +		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> +		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
>  	*)
>  		eventattr='max-stack=3'
> -		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
> -		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> +		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> +		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
>  	esac
>  
> -	file=`mktemp -u /tmp/perf.data.XXX`
> +	perf_data=`mktemp -u /tmp/perf.data.XXX`
> +	perf_script=`mktemp -u /tmp/perf.script.XXX`
> +	perf record -e probe_libc:inet_pton/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
> +	perf script -i $perf_data > $perf_script
>  
> -	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
> -	perf script -i $file | while read line ; do
> +	exec 3<$perf_script
> +	exec 4<$expected
> +	while read line <&3 && read -r pattern <&4; do
> +		[ -z "$pattern" ] && break
>  		echo $line
> -		echo "$line" | egrep -q "${expected[$idx]}"
> +		echo "$line" | egrep -q "$pattern"
>  		if [ $? -ne 0 ] ; then
> -			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
> +			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
>  			exit 1
>  		fi
> -		let idx+=1
> -		[ -z "${expected[$idx]}" ] && break
>  	done
>  
>  	# If any statements are executed from this point onwards,
> @@ -58,6 +63,6 @@ skip_if_no_perf_probe && \
>  perf probe -q $libc inet_pton && \
>  trace_libc_inet_pton_backtrace
>  err=$?
> -rm -f ${file}
> +rm -f ${perf_data} ${perf_script} ${expected}
>  perf probe -q -d probe_libc:inet_pton
>  exit $err
> 
> Thanks,
> 
> Kim
