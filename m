Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DB5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B77D218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="DgELMZWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfBQTZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:25:42 -0500
Received: from cmta17.telus.net ([209.171.16.90]:51021 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfBQTZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:25:42 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id vS4IgKUl8yWYLvS4KgMuTC; Sun, 17 Feb 2019 12:25:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1550431541; bh=nhDHO7mckG1Jk3Ezhc0ys31dsSxz1g5J6L+kUHj/naY=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=DgELMZWEqQKsDxcO8Ask55QCyo25hgAv8YLhnF9HObuMOHlStIcjF6ZscK9Eqlfuv
         szseOfSokMlb++LFAcvDhjM3X0nL6B7f0oB0KUX2WrkG0Wv0NykK04Y3a0uSmRF1r+
         Ya1YSbwFyKqsuN+eNhM9cYPrgl4XSjB1Hw26AEUBUh6AIqhvUx5kvdJasbk+HW1Tnl
         6lInAkyiw/ZihveIITHd3S+gkwZ1JHhXQP5y3T3i+MRHE9cymPBMZC4axERnGC6s0q
         k3IwbkojndCqenki9HiRezcF81VdU8QVeI33axHBRt/Qo2UzsbsMH8LqZ6Bp5ZpXIy
         C9Z7l6keAK51w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=DalpVclW c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=Pq467yvRSnVCxoes1s0A:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2038590.kmssd2ZIyd@aspire.rjw.lan> <16144228.tcT5YVROcV@aspire.rjw.lan>
In-Reply-To: <16144228.tcT5YVROcV@aspire.rjw.lan>
Subject: RE: [PATCH v2] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date:   Sun, 17 Feb 2019 11:25:37 -0800
Message-ID: <000c01d4c6f6$914a7f20$b3df7d60$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdS+25W+eJSwKn6ATzWfd7Ed+z8q9AGnaRjw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfFMnuLyVu3WjYXJBZ6QfFQi4ICUhmPN7xSya1GxtiqEFR0m4Eo1UFrQSb8/6FKyX9Crrdl9lFjF2fGM5ZuANiEzb/535+yfNvbBjmirhm8ByuL6OLScf
 RpiD10qJ3Tmu++JQUg1cjEjm6toLZG+an7zSh1I9pH4XGAiXbMWifBZiDF/VZGmlatgekethBwnf7LYkVUw9D/CBYsh1ZYVgp9eTQZHL3BjSu5HnpDeSdS+4
 8et9nUW40ccqyo/FJqT2ndD1o4Sr0DoEm3v1DtbpYEXEvrDp5LL7i5zkZcMNGLb7eauc+VKILGwKMaGpb+Ve2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019.02.07 03:51 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current iowait boosting mechanism in intel_pstate_update_util()
> is quite aggressive, as it goes to the maximum P-state right away,
> and may cause excessive amounts of energy to be used, which is not
> desirable and arguably isn't necessary too.
>
> Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
> more energy efficient") that reworked the analogous iowait boost
> mechanism in the schedutil governor and make the iowait boosting
> in intel_pstate_update_util() work along the same lines.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> -> v2:
>   * Follow the Doug's suggestion and drop the immediate jump to
>     max P-state if boost is max.  The code is simpler this way and
>     the perf impact should not be noticeable on average.

Hi Rafael,

Something has broken on my incoming e-mail sorting stuff, and I
missed this one (and some others).

This V2 is not actually what I was proposing. I was O.K. with
the immediate jump, but I didn't want the set_pstate step
by-passed if it was already at max because that would also
by-pass the trace sample, if it was enabled.

Anyway, this V2 seems O.K. to me. I tested it compared to V1
and, as you mentioned, wasn't able to detect any energy consumption
or performance differences.

... Doug


