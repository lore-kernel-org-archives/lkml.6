Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653922-2-7435286781130785496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653921; b=tdVEMCYWZXpJKDfxzkalkGYrjS8t2GW2ljdH/SnKaptk6Ec7tl
    hNXESuTyQQJjCrvl91ex8A5OR7UNs4OJTT3OH9vk/z09unLOpsdwHNZWzn/i0Rtw
    hJsFILRmMi6y87Dh6qrst76JNe+iBq9ypDCGQs3xJ+Teo+zwiZywfvv04UKQCFu4
    RDWmSgBElLNOnXN9O65TZYZlhIVJm18h7gWOMNyl97YJX/Mf6TLrAbdrRho12XO0
    94D9jhhYPyPdXeDAx0FuEVwGcQ4zozkKY2ynKDMYTTUIV0m/RJBZz6LnqB/k5Aeq
    oBXoaFCHJTcnkCx3wSwcGl+Xpov0T98erDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653921; bh=PT3NIdFtJAVRo3hSK6TVG8omgL8nP1
    s77qQ2qrduMbQ=; b=BaBK/1mXQ3fcVEeaIlBfVBUiSoSUpxOvfCff1ooMeHTqCY
    /bZJDrMsSaOSW87kv87+DrOT8wrAR/PxLbSXJNaL2Pg24R0jx+kgYRnDQAZoMec4
    XpSShInEDqD1kqxI5XeVlj/4dnWCiCJ8/Py8XJknfuo3sKJEouBkHd8FRGdysWNk
    3+Bq+gUVR53yXI8XvWhCr2Opn0PkdX4CbfJWQufv/ytUHXfCJlX4mckIptcWTqkG
    9QsHQrdjCnsb/CMhX82fw4mYSMhPBT7x+LX0kVPKSoOQxnxxxQMNuxcFEmxfCtrZ
    95ti2SqHk8twAOpIA+Elk67BqCm2lnxbGKgcYBWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBridb3E/1lYp4yQ4FE2WnxSMYf7DznqzgZUQQdaWVRcUtUj4voM14E6hNJbrRg0BgYqVlnMlUu11mja4P/yLvdtCAzHgyxRziujr8ZDvFKwhpLeHjAd
    KuEc3yhYMaxiN24QNAWDvniHJtrYvMT5IY7L0YMkyx6K9M7O1pxT1cEsMsjMSj6UL6lqEpPxU/oHReLhFWl7bWXhMET4RZmSEn2fmiuiiXZAHRmNTTXpEI5p
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=eLQIdrT-S-XZpLnzvJcA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeDYK6Y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:58:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754159AbeDYKm6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:42:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 138/183] perf evsel: Fix period/freq terms setup
Date: Wed, 25 Apr 2018 12:35:58 +0200
Message-Id: <20180425103248.083184263@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit 49c0ae80eb32426fa133246200628e529067c595 ]

Stephane reported that we don't set properly PERIOD sample type for
events with period term defined.

Before:
  $ perf record -e cpu/cpu-cycles,period=1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME|PERIOD, ...

After:
  $ perf record -e cpu/cpu-cycles,period=1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME, ...

Setting PERIOD sample type based on period term setup.

Committer note:

When we use -c or a period=N term in the event definition, then we don't
need to ask the kernel, for this event, via perf_event_attr.sample_type
|= PERF_SAMPLE_PERIOD, to put the event period in each sample for this
event, as we know it already, it is in perf_event_attr.sample_period.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/evsel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -736,12 +736,14 @@ static void apply_config_terms(struct pe
 			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
 				attr->sample_period = term->val.period;
 				attr->freq = 0;
+				perf_evsel__reset_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
 			if (!(term->weak && opts->user_freq != UINT_MAX)) {
 				attr->sample_freq = term->val.freq;
 				attr->freq = 1;
+				perf_evsel__set_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
