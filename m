Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4735D20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="XG7ZcQDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4735D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbeKFHbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:31:49 -0500
Received: from cmta18.telus.net ([209.171.16.91]:51134 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388059AbeKFHbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:31:49 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Jn4Fgnr6GiBO5Jn4GgBwLF; Mon, 05 Nov 2018 15:09:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1541455798; bh=7FJdCBfzpieDAI6AXFj7hrpXN/S9yqhwbIaH8//4oNA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=XG7ZcQDSOZyxI4yVBSrkhxOL1rKbgCMQ73CgHkEOhd46+F4PgrT/I1KixzbgG1xvR
         QsWSMGxIGJwAcYT1/COb6xG9O+KlOs5xkdqfUkyirJeWDdQwIKYKhl1smCl8Sl5PoB
         lrtbQAk60zjW3o2b6zPVMN/HhBz11fE0C2xOuykuMkgqORTbMAwsg/XRR5bfVXsOMB
         dj04z/S6uelDHClI7G+Jib0apfbi84zQXxIWxLjnNpoAZfLzrKzsiE4lXWbOFhfWOI
         2zJ/ZR5mHJN1i4vRJCR3R6iFKZ3Z35rNg+WriraE/niZQw4RxXu/wTxMZX7pue1uSH
         Fy6s0rlO7pS0A==
X-Authority-Analysis: v=2.3 cv=d5AkNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=gu6fZOg2AAAA:8
 a=mzxy_aZs6R2gog5EZfMA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "Doug Smythies" <dsmythies@telus.net>
References: <1899281.leNo2RexrE@aspire.rjw.lan>  <1541010981.3423.2.camel@suse.cz> <4168371.zz0pVZtGOY@aspire.rjw.lan> JkGTgcRwED1yAJkGYggSqP
In-Reply-To: JkGTgcRwED1yAJkGYggSqP
Subject: RE: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date:   Mon, 5 Nov 2018 14:09:54 -0800
Message-ID: <002601d47554$4a150060$de3f0120$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdR1OzhhJxr/TCKWQY2PUjvg4U2ZWQAE07EQ
X-CMAE-Envelope: MS4wfEMdxQlthZwyBDxYiyvPv+nfbhRlfTV49OtNM86vQBQ0tO/PA3yXjq6Wz/BjKEU2hCNcdWpbHbH9psFAIuWMwGrYvnZLvr7BupYM3RKnJCYAsXBmsUt8
 B1/z13cVNvbQHAETTFRF3ONEXO3PrSW7o7vDeu6qwi8g/RDiC8HhGmi0Qc1QV0o6cO8T1Ds4eTpVPNHgyfKdRbM2qs6Len9lZleE6oH7bAkxcAmW0anajPEr
 4ewgG98ZIjDxNX3IIcxijZzTVqBiUMge20T3qj6K2tusX9MLYR0Ua9LWlsTSoig5lAa7owehE3EkWcDJAKtAAYOgS7XrlmYVQG7TZc0JU0PAnvX1nlkKmEE3
 uwihFfSHLnh0EfwN2PHOZ1gw31NnastKPFaQ4i4Mp2/y+loP+sxL4eE8oAAJYEn0qVb46EjuKaxBhAHMAF2AxlZK/thGeX3r1H9k0QROczkjS1w7R1kFkoyg
 aLkNt90kNY37Bfsq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.11.05 11:14 Giovanni Gherdovich wrote:
> On Sun, 2018-11-04 at 11:06 +0100, Rafael J. Wysocki wrote:
>>
>> You can use the cpu_idle trace point to correlate the selected state =
index
>> with the observed idle duration (that's what Doug did IIUC).
>
> True, that works; although I ended up slapping a tracepoint right at =
the
> beginning of the teo_update() and capturing the variables
> cpu_data->last_state, dev->last_residency and dev->cpu.
>
> I should have some plots to share soon. I really wanted to do =
in-kernel
> histograms with systemtap as opposed to collecting data with ftrace =
and doing
> post-processing, because I noticed that the latter approach generates =
lots of
> events and wakeups from idle on the cpu that handles the ftrace data. =
It's
> kind of a workload in itself and spoils the results.

I agree that we need to be careful not to influence the system we
are trying to acquire diagnostic data on via the act of acquiring
that data.

I did not find much, if any, effect of acquiring trace data during the
dbench with 12 clients test. Regardless I do the exact same test the =
exact
same way for the baseline reference kernel and the test kernel. To be
clear, I mean no effect while actually acquiring the trace samples.
Obviously there is a significant effect while the samples are eventually
written out to disk, after being acquired. But at that point, I =
don=E2=80=99t care.

For tests where I am also acquiring long term idle statistics, over many
hours, I never run a trace at the same time, and only sample the system =
once
per minute. For those test scenarios, when a trace is required, i.e. for
greater detail, it is done as an independent step. But yes, for my very =
high
idle state 0 entry/exit per unit time type tests, enabling trace has a =
very
significant effect on the system under test. I haven't figured out a way =
around that.
For example the test where ~6 gigabytes of trace data was collected in
2 minutes, at a cost of ~25% performance drop
(https://marc.info/?l=3Dlinux-pm&m=3D153897853630373&w=3D2)
For comparison, the 12 client Phoronix dbench test trace on kernel =
4.20-rc1
(baseline reference for TEO V3 tests) was only 199 Megabytes in 10 =
minutes.

... Doug


