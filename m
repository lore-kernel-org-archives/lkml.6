Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B93C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C9A21A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyy7Ec0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C9A21A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbeHFR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbeHFR1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:27:08 -0400
Received: from jouet.infradead.org (unknown [177.79.84.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FA421A51;
        Mon,  6 Aug 2018 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568654;
        bh=umnMVcLdJfCmIx+bs5Zb8Bv4Hj3lSnTXoJn705fIuA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyy7Ec0QrHn1bozd9P7u0S62z4PhMfxNX8/DMtDjkJPIxZxbYsh0C0fRhk69Sil3x
         /5jN90n3xbPdJkMDs24sRvbWTGGcFtL6/GAAgjnNzQ8EK7k1omefZ7D71DVGz6KpNg
         SRkWLb9I+TSIGRaOp8CSoEX4ow1cZHhlPgQLw5cs=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A6F3A140A1C; Mon,  6 Aug 2018 12:17:30 -0300 (-03)
Date:   Mon, 6 Aug 2018 12:17:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 12/20] perf annotate: Add percent_type to struct
 annotation_options
Message-ID: <20180806151730.GT7996@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-13-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-13-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 04, 2018 at 03:05:13PM +0200, Jiri Olsa escreveu:
> It will be used to carry user selection of percent
> type for annotation output.
> 
> Passing the percent_type to the annotation_line__print
> function as the first step and making it default to
> current percentage type (PERCENT_HITS_LOCAL) value.

Applied.
