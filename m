Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E6FECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE2720831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCjD9jRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE2720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYIoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:44:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56224 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:44:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id s10-v6so5026759wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=47RrKDB4zFMI4INzNx6YpCT36gtE0J0srRr14NFIQI8=;
        b=eCjD9jRAxKnmzdGP+peurHcqESadvg1TeNFm+//UYbELdhBMMynaUenUUwwT3lIMFS
         udMR3GMyTSnyseN/wLbcBr8tzpGlFZoyKoVSdqxTXcFonnNoZjbPJ5G1l6mHWf6QhckI
         9RAI1b4QKPvE1q7camalHH2MMoxrUbfYQMxMIOJfl2hEBul6Xk8Wa3IgsIHjh5EOQPRC
         4usXR9bsgT77/Qs8r3ELpshz15hpSZgu5jiqJ6J7mlUfsljChNL2g0KtcTSMwlaTE19b
         AMNbEDyHdr0Im3IKCi5a1KChKwfjHPGiXHAT4k0vO9hUNQLk9M6l2pWGAkgCt+UV/qCG
         fsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=47RrKDB4zFMI4INzNx6YpCT36gtE0J0srRr14NFIQI8=;
        b=VVZGC1oI6OMwrdE+fOEbH0CFcB3vGXvVbGE7n8wTjQomcLG3e2XxGM8MI9NshqTEkI
         qmGwQr3b6NzWN/bcsxiVwsASXqMN6eE7m+e6mNHXEtrNgsZaQTUlc3ieDmp4LepNRxgi
         p6TyWCFQaGz6lrJaCsavWZYNt6ZfyVsiXwG/ge1PPj3ROESmrLKt4uh5XZju0qBnRVJ/
         Vx4HDo6fXtldIHmF+GegSBHTJPSl0Ji2pAusL/bIQCFKfj7F9w/o2ysKcZ+NCGZnnNLr
         C0R3M6inaEkc4IC4G8ZCJCvd7+NFzr2t4qNT529DCjFj3ofi9v11XkWH2MAu+0rpMR2F
         cEYg==
X-Gm-Message-State: AGRZ1gIu+2h5bkA+6Xnb+cOEc+u2OCYmRKQZprjjDmcBbfYTjVeYsP9k
        zfqg3fSv82EjoU6XJcMBxls=
X-Google-Smtp-Source: AJdET5dcewW41mFjJ3RvZ3DhM6xQodn/4OXXPCZ4yYAGmjXVEtpj9UhTEjrlBABun6Kyai6D18sfWQ==
X-Received: by 2002:a1c:92d3:: with SMTP id u202-v6mr5078128wmd.39.1540426467639;
        Wed, 24 Oct 2018 17:14:27 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x17-v6sm3519893wrs.84.2018.10.24.17.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:14:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] perf tools: Make find_vdso_map() more modular
To:     linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk, l.stach@pengutronix.de
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-2-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <86f8ae1e-b50b-559c-11a4-e0c5f311f92a@gmail.com>
Date:   Wed, 24 Oct 2018 17:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025000905.6095-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 5:09 PM, Florian Fainelli wrote:
> In preparation for checking that the vectors page on the ARM
> architecture, refactor the find_vdso_map() function to accept finding an
> arbitrary string and create a dedicated helper function for that under
> util/find-map.c and update find_vdso_map() to use it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  tools/perf/util/find-map.c      | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/find-vdso-map.c | 30 +++---------------------------
>  2 files changed, 34 insertions(+), 27 deletions(-)
>  create mode 100644 tools/perf/util/find-map.c
> 
> diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
> new file mode 100644
> index 000000000000..42533fc21108
> --- /dev/null
> +++ b/tools/perf/util/find-map.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +static int find_map(void **start, void **end, const char *name)
> +{
> +	FILE *maps;
> +	char line[128];
> +	int found = 0;
> +
> +	maps = fopen("/proc/self/maps", "r");
> +	if (!maps) {
> +		fprintf(stderr, "vdso: cannot open maps\n");
> +		return -1;
> +	}
> +
> +	while (!found && fgets(line, sizeof(line), maps)) {
> +		int m = -1;
> +
> +		/* We care only about private r-x mappings. */
> +		if (2 != sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n",
> +				start, end, &m))
> +			continue;
> +		if (m < 0)
> +			continue;
> +
> +		if (!strncmp(&line[m], name, sizeof(name) - 1))

Meh, this should be strlen() now, but I would like to hear comments
before submitting a v2 of this anyway. Thanks!
-- 
Florian
